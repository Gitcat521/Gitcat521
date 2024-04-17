// This mod menu made for GTA5 Latest version
// Author: Hirako Shiniji
// Platform: Unknowncheats
 
#include "pch.h"
#include <Windows.h>
#include <string>
 
using namespace std;
 
//real name
#define Window "GTA5"
 
//Addresses that we use to execute functions.
#define PlayerCashOffset 0x1C72DEA
#define WantedHUD 0x195357
 
HMODULE WindowD = GetModuleHandle(NULL); // NULL == GTA5
 
void ReleaseFunction(long mm) {
    VirtualProtectEx(GetCurrentProcess(), WindowD + mm, 10, PAGE_EXECUTE_WRITECOPY, 0); //to set address rights to full
}
HANDLE CashHandle;
string Data1 = "";
void GetCashEx(char* output) {
    ULONG read = 0;
    int index = 0;
    do {
        ReadFile(CashHandle, output + index++, 1, &read, NULL);
    } while (read > 0 && *(output + index - 1) != 0);
}
 
int AddCash(INT16 count) {
    memset(WindowD + PlayerCashOffset, count, 20); // this is going to add cash to bank (maybe visual)
    return count;
}
 
DWORD WINAPI Base(LPVOID mz1) {
    while (!GetAsyncKeyState(VK_END))
    {
        if (GetAsyncKeyState(VK_F5)) {
            AddCash(15); // 15 means 200k
        }
    }
    return 0;
}
BOOL APIENTRY DllMain( HMODULE hModule,
                       DWORD  ul_reason_for_call,
                       LPVOID lpReserved
                     )
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
        ReleaseFunction(PlayerCashOffset);
        ReleaseFunction(WantedHUD);
        CreateThread(0, 0, Base, 0, 0, 0);
 
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
