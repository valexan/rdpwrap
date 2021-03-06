        ��  ��                  ��  ,   ��
 C O N F I G                     ; RDP Wrapper Library configuration
; Do not modify without special knowledge

[Main]
Updated=2014-12-10
LogFile=\rdpwrap.txt
SLPolicyHookNT60=1
SLPolicyHookNT61=1

[SLPolicy]
; Allow Remote Connections
TerminalServices-RemoteConnectionManager-AllowRemoteConnections=1
; Allow Multiple Sessions
TerminalServices-RemoteConnectionManager-AllowMultipleSessions=1
; Allow Multiple Sessions (Application Server Mode)
TerminalServices-RemoteConnectionManager-AllowAppServerMode=1
; Allow Multiple Monitors
TerminalServices-RemoteConnectionManager-AllowMultimon=1
; Max User Sessions (0 = unlimited)
TerminalServices-RemoteConnectionManager-MaxUserSessions=0
; Max Debug Sessions (Windows 8, 0 = unlimited)
TerminalServices-RemoteConnectionManager-ce0ad219-4670-4988-98fb-89b14c2f072b-MaxSessions=0
; Max Sessions
; 0 - logon not possible even from console
; 1 - only one active user (console or remote)
; 2 - allow concurrent sessions
TerminalServices-RemoteConnectionManager-45344fe7-00e6-4ac6-9f01-d01fd4ffadfb-MaxSessions=2
; Allow Advanced Compression with RDP 7 Protocol
TerminalServices-RDP-7-Advanced-Compression-Allowed=1
; IsTerminalTypeLocalOnly = 0
TerminalServices-RemoteConnectionManager-45344fe7-00e6-4ac6-9f01-d01fd4ffadfb-LocalOnly=0
; Max Sessions (hard limit)
TerminalServices-RemoteConnectionManager-8dc86f1d-9969-4379-91c1-06fe1dc60575-MaxSessions=1000
; EasyPrint
TerminalServices-DeviceRedirection-Licenses-TSEasyPrintAllowed=1

[PatchCodes]
nop=90
Zero=00
jmpshort=EB
nopjmp=90E9
CDefPolicy_Query_edx_ecx=BA000100008991200300005E90
CDefPolicy_Query_eax_rcx_jmp=B80001000089813806000090EB
CDefPolicy_Query_eax_esi=B80001000089862003000090
CDefPolicy_Query_eax_rdi=B80001000089873806000090
CDefPolicy_Query_eax_ecx=B80001000089812003000090
CDefPolicy_Query_eax_rcx=B80001000089813806000090

[6.0.6000.16386]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F320000
; .text:6F3360B9          lea     eax, [ebp+VersionInformation]
; .text:6F3360BF          inc     ebx            <- nop
; .text:6F3360C0          push    eax             ; lpVersionInformation
; .text:6F3360C1          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F3360CB          mov     [esi], ebx
; .text:6F3360CD          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=160BF
SingleUserCode.x86=nop
; Imagebase: 7FF756E0000
; .text:000007FF75745E38          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75745E3D          mov     ebx, 1     <- 0
; .text:000007FF75745E42          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75745E4A          mov     [rdi], ebx
; .text:000007FF75745E4C          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=65E3E
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F335CD8          cmp     edx, [ecx+320h]
; .text:6F335CDE          pop     esi
; .text:6F335CDF          jz      loc_6F3426F1
; Changed
; .text:6F335CD8          mov     edx, 100h
; .text:6F335CDD          mov     [ecx+320h], edx
; .text:6F335CE3          pop     esi
; .text:6F335CE4          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=15CD8
DefPolicyCode.x86=CDefPolicy_Query_edx_ecx
; Original
; .text:000007FF7573C88F          mov     eax, [rcx+638h]
; .text:000007FF7573C895          cmp     [rcx+63Ch], eax
; .text:000007FF7573C89B          jnz     short loc_7FF7573C8B3
; Changed
; .text:000007FF7573C88F          mov     eax, 100h
; .text:000007FF7573C894          mov     [rcx+638h], eax
; .text:000007FF7573C89A          nop
; .text:000007FF7573C89B          jmp     short loc_7FF7573C8B3
DefPolicyPatch.x64=1
DefPolicyOffset.x64=5C88F
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx_jmp

[6.0.6001.18000]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6E800000
; .text:6E8185DE          lea     eax, [ebp+VersionInformation]
; .text:6E8185E4          inc     ebx            <- nop
; .text:6E8185E5          push    eax             ; lpVersionInformation
; .text:6E8185E6          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6E8185F0          mov     [esi], ebx
; .text:6E8185F2          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=185E4
SingleUserCode.x86=nop
; Imagebase: 7FF76220000
; .text:000007FF76290DB4          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF76290DB9          mov     ebx, 1     <- 0
; .text:000007FF76290DBE          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF76290DC6          mov     [rdi], ebx
; .text:000007FF76290DC8          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=70DBA
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6E817FD8          cmp     edx, [ecx+320h]
; .text:6E817FDE          pop     esi
; .text:6E817FDF          jz      loc_6E826F16
; Changed
; .text:6E817FD8          mov     edx, 100h
; .text:6E817FDD          mov     [ecx+320h], edx
; .text:6E817FE3          pop     esi
; .text:6E817FE4          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=17FD8
DefPolicyCode.x86=CDefPolicy_Query_edx_ecx
; Original
; .text:000007FF76285BD7          mov     eax, [rcx+638h]
; .text:000007FF76285BDD          cmp     [rcx+63Ch], eax
; .text:000007FF76285BE3          jnz     short loc_7FF76285BFB
; Changed
; .text:000007FF76285BD7          mov     eax, 100h
; .text:000007FF76285BDC          mov     [rcx+638h], eax
; .text:000007FF76285BE2          nop
; .text:000007FF76285BE3          jmp     short loc_7FF76285BFB
DefPolicyPatch.x64=1
DefPolicyOffset.x64=65BD7
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx_jmp

[6.0.6002.18005]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F580000
; .text:6F597FA2          lea     eax, [ebp+VersionInformation]
; .text:6F597FA8          inc     ebx            <- nop
; .text:6F597FA9          push    eax             ; lpVersionInformation
; .text:6F597FAA          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F597FB4          mov     [esi], ebx
; .text:6F597FB6          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=17FA8
SingleUserCode.x86=nop
; Imagebase: 7FF766C0000
; .text:000007FF76730FF0          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF76730FF5          mov     ebx, 1     <- 0
; .text:000007FF76730FFA          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF76731002          mov     [rdi], ebx
; .text:000007FF76731004          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=70FF6
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F5979C0          cmp     edx, [ecx+320h]
; .text:6F5979C6          pop     esi
; .text:6F5979C7          jz      loc_6F5A6F26
; Changed
; .text:6F5979C0          mov     edx, 100h
; .text:6F5979C5          mov     [ecx+320h], edx
; .text:6F5979CB          pop     esi
; .text:6F5979CC          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=179C0
DefPolicyCode.x86=CDefPolicy_Query_edx_ecx
; Original
; .text:000007FF76725E83          mov     eax, [rcx+638h]
; .text:000007FF76725E89          cmp     [rcx+63Ch], eax
; .text:000007FF76725E8F          jz      short loc_7FF76725EA7
; Changed
; .text:000007FF76725E83          mov     eax, 100h
; .text:000007FF76725E88          mov     [rcx+638h], eax
; .text:000007FF76725E8E          nop
; .text:000007FF76725E8F          jmp     short loc_7FF76725EA7
DefPolicyPatch.x64=1
DefPolicyOffset.x64=65E83
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx_jmp

[6.0.6002.19214]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F580000
; .text:6F597FBE          lea     eax, [ebp+VersionInformation]
; .text:6F597FC4          inc     ebx            <- nop
; .text:6F597FC5          push    eax             ; lpVersionInformation
; .text:6F597FC6          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F597FD0          mov     [esi], ebx
; .text:6F597FD2          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=17FC4
SingleUserCode.x86=nop
; Imagebase: 7FF75AC0000
; .text:000007FF75B312A4          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75B312A9          mov     ebx, 1     <- 0
; .text:000007FF75B312AE          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75B312B6          mov     [rdi], ebx
; .text:000007FF75B312B8          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=712AA
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F5979B8          cmp     edx, [ecx+320h]
; .text:6F5979BE          pop     esi
; .text:6F5979BF          jz      loc_6F5A6F3E
; Changed
; .text:6F5979B8          mov     edx, 100h
; .text:6F5979BD          mov     [ecx+320h], edx
; .text:6F5979C3          pop     esi
; .text:6F5979C4          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=179B8
DefPolicyCode.x86=CDefPolicy_Query_edx_ecx
; Original
; .text:000007FF75B25FF7          mov     eax, [rcx+638h]
; .text:000007FF75B25FFD          cmp     [rcx+63Ch], eax
; .text:000007FF75B26003          jnz     short loc_7FF75B2601B
; Changed
; .text:000007FF75B25FF7          mov     eax, 100h
; .text:000007FF75B25FFC          mov     [rcx+638h], eax
; .text:000007FF75B26002          nop
; .text:000007FF75B26003          jmp     short loc_7FF75B2601B
DefPolicyPatch.x64=1
DefPolicyOffset.x64=65FF7
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx_jmp

[6.0.6002.23521]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F580000
; .text:6F597FAE          lea     eax, [ebp+VersionInformation]
; .text:6F597FB4          inc     ebx            <- nop
; .text:6F597FB5          push    eax             ; lpVersionInformation
; .text:6F597FB6          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F597FC0          mov     [esi], ebx
; .text:6F597FC2          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=17FB4
SingleUserCode.x86=nop
; Imagebase: 7FF75AC0000
; .text:000007FF75B31EA4          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75B31EA9          mov     ebx, 1     <- 0
; .text:000007FF75B31EAE          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75B31EB6          mov     [rdi], ebx
; .text:000007FF75B31EB8          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=71EAA
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F5979CC          cmp     edx, [ecx+320h]
; .text:6F5979D2          pop     esi
; .text:6F5979D3          jz      loc_6F5A6F2E
; Changed
; .text:6F5979CC          mov     edx, 100h
; .text:6F5979D1          mov     [ecx+320h], edx
; .text:6F5979D7          pop     esi
; .text:6F5979D8          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=179CC
DefPolicyCode.x86=CDefPolicy_Query_edx_ecx
; Original
; .text:000007FF75B269CB          mov     eax, [rcx+638h]
; .text:000007FF75B269D1          cmp     [rcx+63Ch], eax
; .text:000007FF75B269D7          jnz     short loc_7FF75B269EF
; Changed
; .text:000007FF75B269CB          mov     eax, 100h
; .text:000007FF75B269D0          mov     [rcx+638h], eax
; .text:000007FF75B269D6          nop
; .text:000007FF75B269D7          jmp     short loc_7FF75B269EF
DefPolicyPatch.x64=1
DefPolicyOffset.x64=669CB
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx_jmp

[6.1.7600.16385]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F2E0000
; .text:6F2F9E1F          lea     eax, [ebp+VersionInformation]
; .text:6F2F9E25          inc     ebx            <- nop
; .text:6F2F9E26          push    eax             ; lpVersionInformation
; .text:6F2F9E27          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F2F9E31          mov     [esi], ebx
; .text:6F2F9E33          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=19E25
SingleUserCode.x86=nop
; Imagebase: 7FF75A80000
; .text:000007FF75A97D90          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75A97D95          mov     ebx, 1     <- 0
; .text:000007FF75A97D9A          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75A97DA2          mov     [rdi], ebx
; .text:000007FF75A97DA4          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=17D96
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F2F96F3          cmp     eax, [esi+320h]
; .text:6F2F96F9          jz      loc_6F30E256
; Changed
; .text:6F2F96F3          mov     eax, 100h
; .text:6F2F96F8          mov     [esi+320h], eax
; .text:6F2F96FE          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=196F3
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000007FF75A97AD2          cmp     [rdi+63Ch], eax
; .text:000007FF75A97AD8          jz      loc_7FF75AA4978
; Changed
; .text:000007FF75A97AD2          mov     eax, 100h
; .text:000007FF75A97AD7          mov     [rdi+638h], eax
; .text:000007FF75A97ADD          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=17AD2
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi

[6.1.7601.17514]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F2E0000
; .text:6F2FA497          lea     eax, [ebp+VersionInformation]
; .text:6F2FA49D          inc     ebx            <- nop
; .text:6F2FA49E          push    eax             ; lpVersionInformation
; .text:6F2FA49F          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F2FA4A9          mov     [esi], ebx
; .text:6F2FA4AB          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=1A49D
SingleUserCode.x86=nop
; Imagebase: 7FF75A80000
; .text:000007FF75A980DC          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75A980E1          mov     ebx, 1     <- 0
; .text:000007FF75A980E6          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75A980EE          mov     [rdi], ebx
; .text:000007FF75A980F0          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=180E2
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F2F9D53          cmp     eax, [esi+320h]
; .text:6F2F9D59          jz      loc_6F30B25E
; Changed
; .text:6F2F9D53          mov     eax, 100h
; .text:6F2F9D58          mov     [esi+320h], eax
; .text:6F2F9D5E          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=19D53
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000007FF75A97D8A          cmp     [rdi+63Ch], eax
; .text:000007FF75A97D90          jz      loc_7FF75AA40F4
; Changed
; .text:000007FF75A97D8A          mov     eax, 100h
; .text:000007FF75A97D8F          mov     [rdi+638h], eax
; .text:000007FF75A97D95          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=17D8A
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi

[6.1.7601.18540]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F2E0000
; .text:6F2FA4DF          lea     eax, [ebp+VersionInformation]
; .text:6F2FA4E5          inc     ebx            <- nop
; .text:6F2FA4E6          push    eax             ; lpVersionInformation
; .text:6F2FA4E7          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F2FA4F1          mov     [esi], ebx
; .text:6F2FA4F3          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=1A4E5
SingleUserCode.x86=nop
; Imagebase: 7FF75A80000
; .text:000007FF75A98000          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75A98005          mov     ebx, 1     <- 0
; .text:000007FF75A9800A          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75A98012          mov     [rdi], ebx
; .text:000007FF75A98014          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=18006
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F2F9D9F          cmp     eax, [esi+320h]
; .text:6F2F9DA5          jz      loc_6F30B2AE
; Changed
; .text:6F2F9D9F          mov     eax, 100h
; .text:6F2F9DA4          mov     [esi+320h], eax
; .text:6F2F9DAA          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=19D9F
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000007FF75A97C82          cmp     [rdi+63Ch], eax
; .text:000007FF75A97C88          jz      loc_7FF75AA3FBD
; Changed
; .text:000007FF75A97C82          mov     eax, 100h
; .text:000007FF75A97C87          mov     [rdi+638h], eax
; .text:000007FF75A97C8D          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=17C82
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi

[6.1.7601.22750]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F2E0000
; .text:6F2FA64F          lea     eax, [ebp+VersionInformation]
; .text:6F2FA655          inc     ebx            <- nop
; .text:6F2FA656          push    eax             ; lpVersionInformation
; .text:6F2FA657          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F2FA661          mov     [esi], ebx
; .text:6F2FA663          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=1A655
SingleUserCode.x86=nop
; Imagebase: 7FF75A80000
; .text:000007FF75A97E88          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75A97E8D          mov     ebx, 1     <- 0
; .text:000007FF75A97E92          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75A97E9A          mov     [rdi], ebx
; .text:000007FF75A97E9C          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=17E8E
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F2F9E21          cmp     eax, [esi+320h]
; .text:6F2F9E27          jz      loc_6F30B6CE
; Changed
; .text:6F2F9E21          mov     eax, 100h
; .text:6F2F9E26          mov     [esi+320h], eax
; .text:6F2F9E2C          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=19E21
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000007FF75A97C92          cmp     [rdi+63Ch], eax
; .text:000007FF75A97C98          jz      loc_7FF75AA40A2
; Changed
; .text:000007FF75A97C92          mov     eax, 100h
; .text:000007FF75A97C97          mov     [rdi+638h], eax
; .text:000007FF75A97C9D          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=17C92
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi

[6.1.7601.18637]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F2E0000
; .text:6F2FA4D7          lea     eax, [ebp+VersionInformation]
; .text:6F2FA4DD          inc     ebx            <- nop
; .text:6F2FA4DE          push    eax             ; lpVersionInformation
; .text:6F2FA4DF          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F2FA4E9          mov     [esi], ebx
; .text:6F2FA4EB          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=1A4DD
SingleUserCode.x86=nop
; Imagebase: 7FF75A80000
; .text:000007FF75A980F4          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75A980F9          mov     ebx, 1     <- 0
; .text:000007FF75A980FE          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75A98106          mov     [rdi], ebx
; .text:000007FF75A98108          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=180FA
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F2F9DBB          cmp     eax, [esi+320h]
; .text:6F2F9DC1          jz      loc_6F30B2A6
; Changed
; .text:6F2F9DBB          mov     eax, 100h
; .text:6F2F9DC0          mov     [esi+320h], eax
; .text:6F2F9DC6          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=19DBB
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000007FF75A97DC6          cmp     [rdi+63Ch], eax
; .text:000007FF75A97DCC          jz      loc_7FF75AA40BD
; Changed
; .text:000007FF75A97DC6          mov     eax, 100h
; .text:000007FF75A97DCB          mov     [rdi+638h], eax
; .text:000007FF75A97DD1          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=17DC6
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi

[6.1.7601.22843]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; Imagebase: 6F2E0000
; .text:6F2FA64F          lea     eax, [ebp+VersionInformation]
; .text:6F2FA655          inc     ebx            <- nop
; .text:6F2FA656          push    eax             ; lpVersionInformation
; .text:6F2FA657          mov     [ebp+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:6F2FA661          mov     [esi], ebx
; .text:6F2FA663          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=1A655
SingleUserCode.x86=nop
; Imagebase: 7FF75A80000
; .text:000007FF75A97F90          lea     rcx, [rsp+198h+VersionInformation] ; lpVersionInformation
; .text:000007FF75A97F95          mov     ebx, 1     <- 0
; .text:000007FF75A97F9A          mov     [rsp+198h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000007FF75A97FA2          mov     [rdi], ebx
; .text:000007FF75A97FA4          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=17F96
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:6F2F9E25          cmp     eax, [esi+320h]
; .text:6F2F9E2B          jz      loc_6F30B6D6
; Changed
; .text:6F2F9E25          mov     eax, 100h
; .text:6F2F9E2A          mov     [esi+320h], eax
; .text:6F2F9E30          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=19E25
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000007FF75A97D6E          cmp     [rdi+63Ch], eax
; .text:000007FF75A97D74          jz      loc_7FF75AA4182
; Changed
; .text:000007FF75A97D6E          mov     eax, 100h
; .text:000007FF75A97D73          mov     [rdi+638h], eax
; .text:000007FF75A97D79          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=17D6E
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi

[6.2.8102.0]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:1000F7E5          lea     eax, [esp+150h+VersionInformation]
; .text:1000F7E9          inc     esi            <- nop
; .text:1000F7EA          push    eax             ; lpVersionInformation
; .text:1000F7EB          mov     [esp+154h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:1000F7F3          mov     [edi], esi
; .text:1000F7F5          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=F7E9
SingleUserCode.x86=nop
; .text:000000018000D83A          lea     rcx, [rsp+180h+VersionInformation] ; lpVersionInformation
; .text:000000018000D83F          mov     ebx, 1     <- 0
; .text:000000018000D844          mov     [rsp+180h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000000018000D84C          mov     [rdi], ebx
; .text:000000018000D84E          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=D840
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1000E47C          cmp     eax, [esi+320h]
; .text:1000E482          jz      loc_1002D775
; Changed
; .text:1000E47C          mov     eax, 100h
; .text:1000E481          mov     [esi+320h], eax
; .text:1000E487          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=E47C
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000000018000D3E6          cmp     [rdi+63Ch], eax
; .text:000000018000D3EC          jz      loc_180027792
; Changed
; .text:000000018000D3E6          mov     eax, 100h
; .text:000000018000D3EB          mov     [rdi+638h], eax
; .text:000000018000D3F1          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=D3E6
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi
; Hook SLGetWindowsInformationDWORDWrapper
SLPolicyInternal.x86=1
SLPolicyOffset.x86=1B909
SLPolicyFunc.x86=New_Win8SL
SLPolicyInternal.x64=1
SLPolicyOffset.x64=1A484
SLPolicyFunc.x64=New_Win8SL

[6.2.8250.0]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:100159C5          lea     eax, [esp+150h+VersionInformation]
; .text:100159C9          inc     esi            <- nop
; .text:100159CA          push    eax             ; lpVersionInformation
; .text:100159CB          mov     [esp+154h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:100159D3          mov     [edi], esi
; .text:100159D5          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=159C9
SingleUserCode.x86=nop
; .text:0000000180011E6E          lea     rcx, [rsp+180h+VersionInformation] ; lpVersionInformation
; .text:0000000180011E73          mov     ebx, 1     <- 0
; .text:0000000180011E78          mov     [rsp+180h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180011E80          mov     [rdi], ebx
; .text:0000000180011E82          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=11E74
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:10013520          cmp     eax, [esi+320h]
; .text:10013526          jz      loc_1002DB85
; Changed
; .text:10013520          mov     eax, 100h
; .text:10013525          mov     [esi+320h], eax
; .text:1001352B          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=13520
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000000018001187A          cmp     [rdi+63Ch], eax
; .text:0000000180011880          jz      loc_1800273A2
; Changed
; .text:000000018001187A          mov     eax, 100h
; .text:000000018001187F          mov     [rdi+638h], eax
; .text:0000000180011885          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=1187A
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi
; Hook SLGetWindowsInformationDWORDWrapper
SLPolicyInternal.x86=1
SLPolicyOffset.x86=1A0A9
SLPolicyFunc.x86=New_Win8SL_CP
SLPolicyInternal.x64=1
SLPolicyOffset.x64=18FAC
SLPolicyFunc.x64=New_Win8SL

[6.2.8400.0]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:1001547E          lea     eax, [esp+150h+VersionInformation]
; .text:10015482          inc     esi            <- nop
; .text:10015483          push    eax             ; lpVersionInformation
; .text:10015484          mov     [esp+154h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:1001548C          mov     [edi], esi
; .text:1001548E          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=15482
SingleUserCode.x86=nop
; .text:000000018002081E          lea     rcx, [rsp+180h+VersionInformation] ; lpVersionInformation
; .text:0000000180020823          mov     ebx, 1     <- 0
; .text:0000000180020828          mov     [rsp+180h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180020830          mov     [rdi], ebx
; .text:0000000180020832          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=20824
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:10013E48          cmp     eax, [esi+320h]
; .text:10013E4E          jz      loc_1002E079
; Changed
; .text:10013E48          mov     eax, 100h
; .text:10013E4D          mov     [esi+320h], eax
; .text:10013E53          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=13E48
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000000018001F102          cmp     [rdi+63Ch], eax
; .text:000000018001F108          jz      loc_18003A02E
; Changed
; .text:000000018001F102          mov     eax, 100h
; .text:000000018001F107          mov     [rdi+638h], eax
; .text:000000018001F10D          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=1F102
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi
; Hook SLGetWindowsInformationDWORDWrapper
SLPolicyInternal.x86=1
SLPolicyOffset.x86=19629
SLPolicyFunc.x86=New_Win8SL
SLPolicyInternal.x64=1
SLPolicyOffset.x64=2492C
SLPolicyFunc.x64=New_Win8SL

[6.2.9200.16384]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:1001554E          lea     eax, [esp+150h+VersionInformation]
; .text:10015552          inc     esi            <- nop
; .text:10015553          push    eax             ; lpVersionInformation
; .text:10015554          mov     [esp+154h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:1001555C          mov     [edi], esi
; .text:1001555E          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=15552
SingleUserCode.x86=nop
; .text:000000018002BAA2          lea     rcx, [rsp+180h+VersionInformation] ; lpVersionInformation
; .text:000000018002BAA7          mov     ebx, 1     <- 0
; .text:000000018002BAAC          mov     [rsp+180h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000000018002BAB4          mov     [rdi], ebx
; .text:000000018002BAB6          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=2BAA8
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:10013F08          cmp     eax, [esi+320h]
; .text:10013F0E          jz      loc_1002E161
; Changed
; .text:10013F08          mov     eax, 100h
; .text:10013F0D          mov     [esi+320h], eax
; .text:10013F13          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=13F08
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000000018002A31A          cmp     [rdi+63Ch], eax
; .text:000000018002A320          jz      loc_18003A0F9
; Changed
; .text:000000018002A31A          mov     eax, 100h
; .text:000000018002A31F          mov     [rdi+638h], eax
; .text:000000018002A325          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=2A31A
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi
; Hook SLGetWindowsInformationDWORDWrapper
SLPolicyInternal.x86=1
SLPolicyOffset.x86=19559
SLPolicyFunc.x86=New_Win8SL
SLPolicyInternal.x64=1
SLPolicyOffset.x64=21FA8
SLPolicyFunc.x64=New_Win8SL

[6.2.9200.17048]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:1002058E          lea     eax, [esp+150h+VersionInformation]
; .text:10020592          inc     esi            <- nop
; .text:10020593          push    eax             ; lpVersionInformation
; .text:10020594          mov     [esp+154h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:1002059C          mov     [edi], esi
; .text:1002059E          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=20592
SingleUserCode.x86=nop
; .text:0000000180020942          lea     rcx, [rsp+180h+VersionInformation] ; lpVersionInformation
; .text:0000000180020947          mov     ebx, 1     <- 0
; .text:000000018002094C          mov     [rsp+180h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180020954          mov     [rdi], ebx
; .text:0000000180020956          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=20948
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1001F408          cmp     eax, [esi+320h]
; .text:1001F40E          jz      loc_1002E201
; Changed
; .text:1001F408          mov     eax, 100h
; .text:1001F40D          mov     [esi+320h], eax
; .text:1001F413          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=1F408
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000000018001F206          cmp     [rdi+63Ch], eax
; .text:000000018001F20C          jz      loc_18003A1B4
; Changed
; .text:000000018001F206          mov     eax, 100h
; .text:000000018001F20B          mov     [rdi+638h], eax
; .text:000000018001F211          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=1F206
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi
; Hook SLGetWindowsInformationDWORDWrapper
SLPolicyInternal.x86=1
SLPolicyOffset.x86=17059
SLPolicyFunc.x86=New_Win8SL
SLPolicyInternal.x64=1
SLPolicyOffset.x64=24570
SLPolicyFunc.x64=New_Win8SL

[6.2.9200.21166]
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10015576          lea     eax, [esp+150h+VersionInformation]
; .text:1001557A          inc     esi            <- nop
; .text:1001557B          push    eax             ; lpVersionInformation
; .text:1001557C          mov     [esp+154h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:10015584          mov     [edi], esi
; .text:10015586          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=1557A
SingleUserCode.x86=nop
; .text:000000018002BAF2          lea     rcx, [rsp+180h+VersionInformation] ; lpVersionInformation
; .text:000000018002BAF7          mov     ebx, 1     <- 0
; .text:000000018002BAFC          mov     [rsp+180h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000000018002BB04          mov     [rdi], ebx
; .text:000000018002BB06          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=2BAF8
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:10013F30          cmp     eax, [esi+320h]
; .text:10013F36          jz      loc_1002E189
; Changed
; .text:10013F30          mov     eax, 100h
; .text:10013F35          mov     [esi+320h], eax
; .text:10013F3B          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=13F30
DefPolicyCode.x86=CDefPolicy_Query_eax_esi
; Original
; .text:000000018002A3B6          cmp     [rdi+63Ch], eax
; .text:000000018002A3BC          jz      loc_18003A174
; Changed
; .text:000000018002A3B6          mov     eax, 100h
; .text:000000018002A3BB          mov     [rdi+638h], eax
; .text:000000018002A3C1          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=2A3B6
DefPolicyCode.x64=CDefPolicy_Query_eax_rdi
; Hook SLGetWindowsInformationDWORDWrapper
SLPolicyInternal.x86=1
SLPolicyOffset.x86=19581
SLPolicyFunc.x86=New_Win8SL
SLPolicyInternal.x64=1
SLPolicyOffset.x64=21FD0
SLPolicyFunc.x64=New_Win8SL

[6.3.9431.0]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:1008A604          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SGJAAU_GUID@@PAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:1008A609          test    eax, eax
; .text:1008A60B          js      short loc_1008A628
; .text:1008A60D          cmp     [ebp+var_8], 0
; .text:1008A611          jz      short loc_1008A628 <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=8A611
LocalOnlyCode.x86=jmpshort
; .text:000000018009F713          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SAJAEAU_GUID@@PEAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:000000018009F718          test    eax, eax
; .text:000000018009F71A          js      short loc_18009F73B
; .text:000000018009F71C          cmp     [rsp+48h+arg_18], 0
; .text:000000018009F721          jz      short loc_18009F73B <- jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=9F721
LocalOnlyCode.x64=jmpshort
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:100306A4          lea     eax, [esp+150h+VersionInformation]
; .text:100306A8          inc     ebx            <- nop
; .text:100306A9          mov     [edi], ebx
; .text:100306AB          push    eax             ; lpVersionInformation
; .text:100306AC          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=306A8
SingleUserCode.x86=nop
; .text:00000001800367F3          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:00000001800367F8          mov     ebx, 1     <- 0
; .text:00000001800367FD          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180036805          mov     [rdi], ebx
; .text:0000000180036807          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=367F9
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1002EA25          cmp     eax, [ecx+320h]
; .text:1002EA2B          jz      loc_100348C1
; Changed
; .text:1002EA25          mov     eax, 100h
; .text:1002EA2A          mov     [ecx+320h], eax
; .text:1002EA30          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=2EA25
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:00000001800350FD          cmp     [rcx+63Ch], eax
; .text:0000000180035103          jz      loc_18004F6AE
; Changed
; .text:00000001800350FD          mov     eax, 100h
; .text:0000000180035102          mov     [rcx+638h], eax
; .text:0000000180035108          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=350FD
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=196B0
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=2F9C0
SLInitFunc.x64=New_CSLQuery_Initialize

[6.3.9600.16384]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:100A271C          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SGJAAU_GUID@@PAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:100A2721          test    eax, eax
; .text:100A2723          js      short loc_100A2740
; .text:100A2725          cmp     [ebp+var_8], 0
; .text:100A2729          jz      short loc_100A2740 <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=A2729
LocalOnlyCode.x86=jmpshort
; .text:000000018008181F          cmp     [rsp+48h+arg_18], 0
; .text:0000000180081824          jz      loc_180031DEF <- nop + jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=81824
LocalOnlyCode.x64=nopjmp
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10018024          lea     eax, [esp+150h+VersionInformation]
; .text:10018028          inc     ebx            <- nop
; .text:10018029          mov     [edi], ebx
; .text:1001802B          push    eax             ; lpVersionInformation
; .text:1001802C          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=18028
SingleUserCode.x86=nop
; .text:000000018002023B          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:0000000180020240          mov     ebx, 1     <- 0
; .text:0000000180020245          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:000000018002024D          mov     [rdi], ebx
; .text:000000018002024F          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=20241
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:10016115          cmp     eax, [ecx+320h]
; .text:1001611B          jz      loc_10034DE1
; Changed
; .text:10016115          mov     eax, 100h
; .text:1001611A          mov     [ecx+320h], eax
; .text:10016120          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=16115
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:0000000180057829          cmp     [rcx+63Ch], eax
; .text:000000018005782F          jz      loc_18005E850
; Changed
; .text:0000000180057829          mov     eax, 100h
; .text:000000018005782E          mov     [rcx+638h], eax
; .text:0000000180057834          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=57829
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=1CEB0
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=554C0
SLInitFunc.x64=New_CSLQuery_Initialize

[6.3.9600.17095]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:100A36C4          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SGJAAU_GUID@@PAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:100A36C9          test    eax, eax
; .text:100A36CB          js      short loc_100A36E8
; .text:100A36CD          cmp     [ebp+var_8], 0
; .text:100A36D1          jz      short loc_100A36E8 <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=A36D1
LocalOnlyCode.x86=jmpshort
; .text:00000001800B914B          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SAJAEAU_GUID@@PEAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:00000001800B9150          test    eax, eax
; .text:00000001800B9152          js      short loc_1800B9173
; .text:00000001800B9154          cmp     [rsp+48h+arg_18], 0
; .text:00000001800B9159          jz      short loc_1800B9173 <- jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=B9159
LocalOnlyCode.x64=jmpshort
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10036BA5          lea     eax, [esp+150h+VersionInformation]
; .text:10036BA9          inc     ebx            <- nop
; .text:10036BAA          mov     [edi], ebx
; .text:10036BAC          push    eax             ; lpVersionInformation
; .text:10036BAD          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=36BA9
SingleUserCode.x86=nop
; .text:0000000180021823          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:0000000180021828          mov     ebx, 1     <- 0
; .text:000000018002182D          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180021835          mov     [rdi], ebx
; .text:0000000180021837          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=21829
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:10037529          cmp     eax, [ecx+320h]
; .text:1003752F          jz      loc_10043662
; Changed
; .text:10037529          mov     eax, 100h
; .text:1003752E          mov     [ecx+320h], eax
; .text:10037534          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=37529
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:000000018001F6A1          cmp     [rcx+63Ch], eax
; .text:000000018001F6A7          jz      loc_18007284B
; Changed
; .text:000000018001F6A1          mov     eax, 100h
; .text:000000018001F6A6          mov     [rcx+638h], eax
; .text:000000018001F6AC          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=1F6A1
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=117F1
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=3B110
SLInitFunc.x64=New_CSLQuery_Initialize

[6.3.9600.17415]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:100B33EB          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SGJAAU_GUID@@PAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:100B33F0          test    eax, eax
; .text:100B33F2          js      short loc_100B340F
; .text:100B33F4          cmp     [ebp+var_C], 0
; .text:100B33F8          jz      short loc_100B340F <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=B33F8
LocalOnlyCode.x86=jmpshort
; .text:000000018008B2D4          cmp     [rsp+58h+arg_18], 0
; .text:000000018008B2D9          jz      loc_180025C39 <- nop + jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=8B2D9
LocalOnlyCode.x64=nopjmp
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10037111          lea     eax, [esp+150h+VersionInformation]
; .text:10037115          inc     ebx            <- nop
; .text:10037116          mov     [edi], ebx
; .text:10037118          push    eax             ; lpVersionInformation
; .text:10037119          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=37115
SingleUserCode.x86=nop
; .text:0000000180033CE3          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:0000000180033CE8          mov     ebx, 1     <- 0
; .text:0000000180033CED          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180033CF5          mov     [rdi], ebx
; .text:0000000180033CF7          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=33CE9
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1003CFF9          cmp     eax, [ecx+320h]
; .text:1003CFFF          jz      loc_1004A52F
; Changed
; .text:1003CFF9          mov     eax, 100h
; .text:1003CFFE          mov     [ecx+320h], eax
; .text:1003D004          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=3CFF9
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:0000000180045825          cmp     [rcx+63Ch], eax
; .text:000000018004582B          jz      loc_180067704
; Changed
; .text:0000000180045825          mov     eax, 100h
; .text:000000018004582A          mov     [rcx+638h], eax
; .text:0000000180045830          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=45825
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=18478
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=5DBC0
SLInitFunc.x64=New_CSLQuery_Initialize

[6.4.9841.0]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:1009569B          call    sub_100B7EE5
; .text:100956A0          test    eax, eax
; .text:100956A2          js      short loc_100956BF
; .text:100956A4          cmp     [ebp+var_C], 0
; .text:100956A8          jz      short loc_100956BF <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=956A8
LocalOnlyCode.x86=jmpshort
; .text:0000000180081133          call    sub_1800A9048
; .text:0000000180081138          test    eax, eax
; .text:000000018008113A          js      short loc_18008115B
; .text:000000018008113C          cmp     [rsp+58h+arg_18], 0
; .text:0000000180081141          jz      short loc_18008115B <- jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=81141
LocalOnlyCode.x64=jmpshort
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10030121          lea     eax, [esp+150h+VersionInformation]
; .text:10030125          inc     ebx            <- nop
; .text:10030126          mov     [edi], ebx
; .text:10030128          push    eax             ; lpVersionInformation
; .text:10030129          call    ds:GetVersionExW
SingleUserPatch.x86=1
SingleUserOffset.x86=30125
SingleUserCode.x86=nop
; .text:0000000180012153          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:0000000180012158          mov     ebx, 1     <- 0
; .text:000000018001215D          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180012165          mov     [rdi], ebx
; .text:0000000180012167          call    cs:GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=12159
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1003B989          cmp     eax, [ecx+320h]
; .text:1003B98F          jz      loc_1005E809
; Changed
; .text:1003B989          mov     eax, 100h
; .text:1003B98E          mov     [ecx+320h], eax
; .text:1003B994          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=3B989
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:000000018000C125          cmp     [rcx+63Ch], eax
; .text:000000018000C12B          jz      sub_18003BABC
; Changed
; .text:000000018000C125          mov     eax, 100h
; .text:000000018000C12A          mov     [rcx+638h], eax
; .text:000000018000C130          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=C125
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=46A68
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=1EA50
SLInitFunc.x64=New_CSLQuery_Initialize

[6.4.9860.0]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:100962BB          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SGJAAU_GUID@@PAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:100962C0          test    eax, eax
; .text:100962C2          js      short loc_100962DF
; .text:100962C4          cmp     [ebp+var_C], 0
; .text:100962C8          jz      short loc_100962DF <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=962C8
LocalOnlyCode.x86=jmpshort
; .text:0000000180081083          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SAJAEAU_GUID@@PEAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:0000000180081088          test    eax, eax
; .text:000000018008108A          js      short loc_1800810AB
; .text:000000018008108C          cmp     [rsp+58h+arg_18], 0
; .text:0000000180081091          jz      short loc_1800810AB <- jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=81091
LocalOnlyCode.x64=jmpshort
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10030841          lea     eax, [esp+150h+VersionInformation]
; .text:10030845          inc     ebx            <- nop
; .text:10030846          mov     [edi], ebx
; .text:10030848          push    eax             ; lpVersionInformation
; .text:10030849          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=30845
SingleUserCode.x86=nop
; .text:0000000180011AA3          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:0000000180011AA8          mov     ebx, 1     <- 0
; .text:0000000180011AAD          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180011AB5          mov     [rdi], ebx
; .text:0000000180011AB7          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=11AA9
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1003BEC9          cmp     eax, [ecx+320h]
; .text:1003BECF          jz      loc_1005EE1A
; Changed
; .text:1003BEC9          mov     eax, 100h
; .text:1003BECE          mov     [ecx+320h], eax
; .text:1003BED4          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=3BEC9
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:000000018000B9F5          cmp     [rcx+63Ch], eax
; .text:000000018000B9FB          jz      sub_18003B9C8
; Changed
; .text:000000018000B9F5          mov     eax, 100h
; .text:000000018000B9FA          mov     [rcx+638h], eax
; .text:000000018000BA00          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=B9F5
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=46F18
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=1EB00
SLInitFunc.x64=New_CSLQuery_Initialize

[6.4.9879.0]
; Patch CEnforcementCore::GetInstanceOfTSLicense
; .text:100A9CBB          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SGJAAU_GUID@@PAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:100A9CC0          test    eax, eax
; .text:100A9CC2          js      short loc_100A9CDF
; .text:100A9CC4          cmp     [ebp+var_C], 0
; .text:100A9CC8          jz      short loc_100A9CDF <- jmp
LocalOnlyPatch.x86=1
LocalOnlyOffset.x86=A9CC8
LocalOnlyCode.x86=jmpshort
; .text:0000000180095603          call    ?IsLicenseTypeLocalOnly@CSLQuery@@SAJAEAU_GUID@@PEAH@Z ; CSLQuery::IsLicenseTypeLocalOnly(_GUID &,int *)
; .text:0000000180095608          test    eax, eax
; .text:000000018009560A          js      short loc_18009562B
; .text:000000018009560C          cmp     [rsp+58h+arg_18], 0
; .text:0000000180095611          jz      short loc_18009562B <- jmp
LocalOnlyPatch.x64=1
LocalOnlyOffset.x64=95611
LocalOnlyCode.x64=jmpshort
; Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
; .text:10030C51          lea     eax, [esp+150h+VersionInformation]
; .text:10030C55          inc     ebx            <- nop
; .text:10030C56          mov     [edi], ebx
; .text:10030C58          push    eax             ; lpVersionInformation
; .text:10030C59          call    ds:__imp__GetVersionExW@4 ; GetVersionExW(x)
SingleUserPatch.x86=1
SingleUserOffset.x86=30C55
SingleUserCode.x86=nop
; .text:0000000180016A2E          call    memset_0
; .text:0000000180016A33          mov     ebx, 1     <- 0
; .text:0000000180016A38          mov     [rsp+190h+VersionInformation.dwOSVersionInfoSize], 11Ch
; .text:0000000180016A40          lea     rcx, [rsp+190h+VersionInformation] ; lpVersionInformation
; .text:0000000180016A45          mov     [rdi], ebx
; .text:0000000180016A47          call    cs:__imp_GetVersionExW
SingleUserPatch.x64=1
SingleUserOffset.x64=16A34
SingleUserCode.x64=Zero
; Patch CDefPolicy::Query
; Original
; .text:1002DAB9          cmp     eax, [ecx+320h]
; .text:1002DABF          jz      loc_1006C38A
; Changed
; .text:1002DAB9          mov     eax, 100h
; .text:1002DABE          mov     [ecx+320h], eax
; .text:1002DAC4          nop
DefPolicyPatch.x86=1
DefPolicyOffset.x86=2DAB9
DefPolicyCode.x86=CDefPolicy_Query_eax_ecx
; Original
; .text:000000018001BDC5          cmp     [rcx+63Ch], eax
; .text:000000018001BDCB          jz      sub_180045540
; Changed
; .text:000000018001BDC5          mov     eax, 100h
; .text:000000018001BDCA          mov     [rcx+638h], eax
; .text:000000018001BDD0          nop
DefPolicyPatch.x64=1
DefPolicyOffset.x64=1BDC5
DefPolicyCode.x64=CDefPolicy_Query_eax_rcx
; Hook CSLQuery::Initialize
SLInitHook.x86=1
SLInitOffset.x86=41132
SLInitFunc.x86=New_CSLQuery_Initialize
SLInitHook.x64=1
SLInitOffset.x64=24750
SLInitFunc.x64=New_CSLQuery_Initialize

[SLInit]
bServerSku=1
bRemoteConnAllowed=1
bFUSEnabled=1
bAppServerAllowed=1
bMultimonAllowed=1
lMaxUserSessions=0
ulMaxDebugSessions=0
bInitialized=1

[6.3.9431.0-SLInit]
bFUSEnabled.x86       =A22A8
lMaxUserSessions.x86  =A22AC
bAppServerAllowed.x86 =A22B0
bInitialized.x86      =A22B4
bMultimonAllowed.x86  =A22B8
bServerSku.x86        =A22BC
ulMaxDebugSessions.x86=A22C0
bRemoteConnAllowed.x86=A22C4

bFUSEnabled.x64       =C4490
lMaxUserSessions.x64  =C4494
bAppServerAllowed.x64 =C4498
bInitialized.x64      =C449C
bMultimonAllowed.x64  =C44A0
bServerSku.x64        =C44A4
ulMaxDebugSessions.x64=C44A8
bRemoteConnAllowed.x64=C44AC

[6.3.9600.16384-SLInit]
bFUSEnabled.x86       =C02A8
lMaxUserSessions.x86  =C02AC
bAppServerAllowed.x86 =C02B0
bInitialized.x86      =C02B4
bMultimonAllowed.x86  =C02B8
bServerSku.x86        =C02BC
ulMaxDebugSessions.x86=C02C0
bRemoteConnAllowed.x86=C02C4

bServerSku.x64        =E6494
ulMaxDebugSessions.x64=E6498
bRemoteConnAllowed.x64=E649C
bFUSEnabled.x64       =E64A0
lMaxUserSessions.x64  =E64A4
bAppServerAllowed.x64 =E64A8
bInitialized.x64      =E64AC
bMultimonAllowed.x64  =E64B0

[6.3.9600.17095-SLInit]
bFUSEnabled.x86       =C12A8
lMaxUserSessions.x86  =C12AC
bAppServerAllowed.x86 =C12B0
bInitialized.x86      =C12B4
bMultimonAllowed.x86  =C12B8
bServerSku.x86        =C12BC
ulMaxDebugSessions.x86=C12C0
bRemoteConnAllowed.x86=C12C4

bServerSku.x64        =E4494
ulMaxDebugSessions.x64=E4498
bRemoteConnAllowed.x64=E449C
bFUSEnabled.x64       =E44A0
lMaxUserSessions.x64  =E44A4
bAppServerAllowed.x64 =E44A8
bInitialized.x64      =E44AC
bMultimonAllowed.x64  =E44B0

[6.3.9600.17415-SLInit]
bFUSEnabled.x86       =D3068
lMaxUserSessions.x86  =D306C
bAppServerAllowed.x86 =D3070
bInitialized.x86      =D3074
bMultimonAllowed.x86  =D3078
bServerSku.x86        =D307C
ulMaxDebugSessions.x86=D3080
bRemoteConnAllowed.x86=D3084

bFUSEnabled.x64       =F9054
lMaxUserSessions.x64  =F9058
bAppServerAllowed.x64 =F905C
bInitialized.x64      =F9060
bMultimonAllowed.x64  =F9064
bServerSku.x64        =F9068
ulMaxDebugSessions.x64=F906C
bRemoteConnAllowed.x64=F9070

[6.4.9841.0-SLInit]
bFUSEnabled.x86       =BF9F0
lMaxUserSessions.x86  =BF9F4
bAppServerAllowed.x86 =BF9F8
bInitialized.x86      =BF9FC
bMultimonAllowed.x86  =BFA00
bServerSku.x86        =BFA04
ulMaxDebugSessions.x86=BFA08
bRemoteConnAllowed.x86=BFA0C

bFUSEnabled.x64       =ECFF8
lMaxUserSessions.x64  =ECFFC
bAppServerAllowed.x64 =ED000
bInitialized.x64      =ED004
bMultimonAllowed.x64  =ED008
bServerSku.x64        =ED00C
ulMaxDebugSessions.x64=ED010
bRemoteConnAllowed.x64=ED014

[6.4.9860.0-SLInit]
bFUSEnabled.x86       =BF7E0
lMaxUserSessions.x86  =BF7E4
bAppServerAllowed.x86 =BF7E8
bInitialized.x86      =BF7EC
bMultimonAllowed.x86  =BF7F0
bServerSku.x86        =BF7F4
ulMaxDebugSessions.x86=BF7F8
bRemoteConnAllowed.x86=BF7FC

bFUSEnabled.x64       =ECBD8
lMaxUserSessions.x64  =ECBDC
bAppServerAllowed.x64 =ECBE0
bInitialized.x64      =ECBE4
bMultimonAllowed.x64  =ECBE8
bServerSku.x64        =ECBEC
ulMaxDebugSessions.x64=ECBF0
bRemoteConnAllowed.x64=ECBF4

[6.4.9879.0-SLInit]
bFUSEnabled.x86       =C27D8
lMaxUserSessions.x86  =C27DC
bAppServerAllowed.x86 =C27E0
bInitialized.x86      =C27E4
bMultimonAllowed.x86  =C27E8
bServerSku.x86        =C27EC
ulMaxDebugSessions.x86=C27F0
bRemoteConnAllowed.x86=C27F4

bFUSEnabled.x64       =EDBF0
lMaxUserSessions.x64  =EDBF4
bAppServerAllowed.x64 =EDBF8
bInitialized.x64      =EDBFC
bMultimonAllowed.x64  =EDC00
bServerSku.x64        =EDC04
ulMaxDebugSessions.x64=EDC08
bRemoteConnAllowed.x64=EDC0C
 0+  ,   ��
 L I C E N S E                                                    Apache License
                        Version 2.0, January 2004
                     http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions.

   "License" shall mean the terms and conditions for use, reproduction,
   and distribution as defined by Sections 1 through 9 of this document.

   "Licensor" shall mean the copyright owner or entity authorized by
   the copyright owner that is granting the License.

   "Legal Entity" shall mean the union of the acting entity and all
   other entities that control, are controlled by, or are under common
   control with that entity. For the purposes of this definition,
   "control" means (i) the power, direct or indirect, to cause the
   direction or management of such entity, whether by contract or
   otherwise, or (ii) ownership of fifty percent (50%) or more of the
   outstanding shares, or (iii) beneficial ownership of such entity.

   "You" (or "Your") shall mean an individual or Legal Entity
   exercising permissions granted by this License.

   "Source" form shall mean the preferred form for making modifications,
   including but not limited to software source code, documentation
   source, and configuration files.

   "Object" form shall mean any form resulting from mechanical
   transformation or translation of a Source form, including but
   not limited to compiled object code, generated documentation,
   and conversions to other media types.

   "Work" shall mean the work of authorship, whether in Source or
   Object form, made available under the License, as indicated by a
   copyright notice that is included in or attached to the work
   (an example is provided in the Appendix below).

   "Derivative Works" shall mean any work, whether in Source or Object
   form, that is based on (or derived from) the Work and for which the
   editorial revisions, annotations, elaborations, or other modifications
   represent, as a whole, an original work of authorship. For the purposes
   of this License, Derivative Works shall not include works that remain
   separable from, or merely link (or bind by name) to the interfaces of,
   the Work and Derivative Works thereof.

   "Contribution" shall mean any work of authorship, including
   the original version of the Work and any modifications or additions
   to that Work or Derivative Works thereof, that is intentionally
   submitted to Licensor for inclusion in the Work by the copyright owner
   or by an individual or Legal Entity authorized to submit on behalf of
   the copyright owner. For the purposes of this definition, "submitted"
   means any form of electronic, verbal, or written communication sent
   to the Licensor or its representatives, including but not limited to
   communication on electronic mailing lists, source code control systems,
   and issue tracking systems that are managed by, or on behalf of, the
   Licensor for the purpose of discussing and improving the Work, but
   excluding communication that is conspicuously marked or otherwise
   designated in writing by the copyright owner as "Not a Contribution."

   "Contributor" shall mean Licensor and any individual or Legal Entity
   on behalf of whom a Contribution has been received by Licensor and
   subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of
   this License, each Contributor hereby grants to You a perpetual,
   worldwide, non-exclusive, no-charge, royalty-free, irrevocable
   copyright license to reproduce, prepare Derivative Works of,
   publicly display, publicly perform, sublicense, and distribute the
   Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of
   this License, each Contributor hereby grants to You a perpetual,
   worldwide, non-exclusive, no-charge, royalty-free, irrevocable
   (except as stated in this section) patent license to make, have made,
   use, offer to sell, sell, import, and otherwise transfer the Work,
   where such license applies only to those patent claims licensable
   by such Contributor that are necessarily infringed by their
   Contribution(s) alone or by combination of their Contribution(s)
   with the Work to which such Contribution(s) was submitted. If You
   institute patent litigation against any entity (including a
   cross-claim or counterclaim in a lawsuit) alleging that the Work
   or a Contribution incorporated within the Work constitutes direct
   or contributory patent infringement, then any patent licenses
   granted to You under this License for that Work shall terminate
   as of the date such litigation is filed.

4. Redistribution. You may reproduce and distribute copies of the
   Work or Derivative Works thereof in any medium, with or without
   modifications, and in Source or Object form, provided that You
   meet the following conditions:

   (a) You must give any other recipients of the Work or
       Derivative Works a copy of this License; and

   (b) You must cause any modified files to carry prominent notices
       stating that You changed the files; and

   (c) You must retain, in the Source form of any Derivative Works
       that You distribute, all copyright, patent, trademark, and
       attribution notices from the Source form of the Work,
       excluding those notices that do not pertain to any part of
       the Derivative Works; and

   (d) If the Work includes a "NOTICE" text file as part of its
       distribution, then any Derivative Works that You distribute must
       include a readable copy of the attribution notices contained
       within such NOTICE file, excluding those notices that do not
       pertain to any part of the Derivative Works, in at least one
       of the following places: within a NOTICE text file distributed
       as part of the Derivative Works; within the Source form or
       documentation, if provided along with the Derivative Works; or,
       within a display generated by the Derivative Works, if and
       wherever such third-party notices normally appear. The contents
       of the NOTICE file are for informational purposes only and
       do not modify the License. You may add Your own attribution
       notices within Derivative Works that You distribute, alongside
       or as an addendum to the NOTICE text from the Work, provided
       that such additional attribution notices cannot be construed
       as modifying the License.

   You may add Your own copyright statement to Your modifications and
   may provide additional or different license terms and conditions
   for use, reproduction, or distribution of Your modifications, or
   for any such Derivative Works as a whole, provided Your use,
   reproduction, and distribution of the Work otherwise complies with
   the conditions stated in this License.

5. Submission of Contributions. Unless You explicitly state otherwise,
   any Contribution intentionally submitted for inclusion in the Work
   by You to the Licensor shall be under the terms and conditions of
   this License, without any additional terms or conditions.
   Notwithstanding the above, nothing herein shall supersede or modify
   the terms of any separate license agreement you may have executed
   with Licensor regarding such Contributions.

6. Trademarks. This License does not grant permission to use the trade
   names, trademarks, service marks, or product names of the Licensor,
   except as required for reasonable and customary use in describing the
   origin of the Work and reproducing the content of the NOTICE file.

7. Disclaimer of Warranty. Unless required by applicable law or
   agreed to in writing, Licensor provides the Work (and each
   Contributor provides its Contributions) on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
   implied, including, without limitation, any warranties or conditions
   of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
   PARTICULAR PURPOSE. You are solely responsible for determining the
   appropriateness of using or redistributing the Work and assume any
   risks associated with Your exercise of permissions under this License.

8. Limitation of Liability. In no event and under no legal theory,
   whether in tort (including negligence), contract, or otherwise,
   unless required by applicable law (such as deliberate and grossly
   negligent acts) or agreed to in writing, shall any Contributor be
   liable to You for damages, including any direct, indirect, special,
   incidental, or consequential damages of any character arising as a
   result of this License or out of the use or inability to use the
   Work (including but not limited to damages for loss of goodwill,
   work stoppage, computer failure or malfunction, or any and all
   other commercial damages or losses), even if such Contributor
   has been advised of the possibility of such damages.

9. Accepting Warranty or Additional Liability. While redistributing
   the Work or Derivative Works thereof, You may choose to offer,
   and charge a fee for, acceptance of support, warranty, indemnity,
   or other liability obligations and/or rights consistent with this
   License. However, in accepting such obligations, You may act only
   on Your own behalf and on Your sole responsibility, not on behalf
   of any other Contributor, and only if You agree to indemnify,
   defend, and hold each Contributor harmless for any liability
   incurred by, or claims asserted against, such Contributor by reason
   of your accepting any such warranty or additional liability.

END OF TERMS AND CONDITIONS

APPENDIX: How to apply the Apache License to your work.

   To apply the Apache License to your work, attach the following
   boilerplate notice, with the fields enclosed by brackets "[]"
   replaced with your own identifying information. (Don't include
   the brackets!)  The text should be enclosed in the appropriate
   comment syntax for the file format. We also recommend that a
   file or class name and description of purpose be included on the
   same "printed page" as the copyright notice for easier
   identification within third-party archives.

Copyright [yyyy] [name of copyright owner]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

  0   ��
 R D P C L I P 3 2         	        MZ�       ��  �       @                                   �   � �	�!�L�!This program cannot be run in DOS mode.
$       � ���a؀�a؀�a؀񧵀�a؀񧥀�a؀n׀�a؀�aـ<a؀n���a؀n���a؀n���a؀n���a؀n���a؀Rich�a؀        PE  L Y��E        � 
 �   >     (n                            `    V�   �                            ��     P �                          @                             x  @   X       ,                          .text   ��      �                    `.data    8       �              @  �.rsrc   �   P     
             @  @�Ex   &
�E�   �
�E�  �
�E�   >
�E�   �
�E�   �
�E�       �   �
�E�   �
�E�   �
�E�   �
�E�   �
�E  �
�E          msvcrt.dll ADVAPI32.dll KERNEL32.dll NTDLL.DLL GDI32.dll USER32.dll WINSTA.dll WSOCK32.dll WS2_32.dll MSACM32.dll WTSAPI32.dll ole32.dll SHELL32.dll urlmon.dll                                                                                                                                                 j�w���w���ws�w���wX��w)?�w�z�w�j�w�l�w�n�w    �Y�wR��wbf�w*h�w���w(G�w�P�w�^�wqS�w�F�w_F�w    ��w�/�w���wax�w���|`��|�ɂ|l�w�'�wTd�wTd�w0��w�"�w<!�w{�wo>�wA?�w	&�w|d�w6Q�w��w�/�wx<�wy��w�C�ww�w�#�w��|$�w�/�w��w6��|<��wC1�w��w��w)U�wK�w�J�w��|���w�:�w*��w#�wZ�w2��w1��wQ�w���w!�w�!�w���w���ww��w��w �wi�w` �w� �wQ��w��wt��w��w�>�w�+�wq8�wz=�w�/�w֟�|    �z�wYr�wVu�w�G�wl"�wSE�w�~�w��w�}�w�|�wHH�w    ��|]&�|    a:wS�=wca:w��9wu#9w��9w��9w�G9w�9wh�9wz9wp$9w��9wƹ8w�9w\�8w��9w��9w��9w�9w��8w�i9wP�9w�;w�;w�;w�;w�;w.J:w�9w��<w    >w�ow    ��q<�q���q)��q      �  �  �
  �  �o  �t  �s  �    N�v��v    	��w)y�w��wko�w���w�}�wg �w,c�w���w���w|F�w��w��w��w�7�wA��ww��w�<�w\��w���w���ws��w лw�лw3λwtl�w�˻wq��w���wލ�w�w    (�iw7'lwqw\pw�jw!�iwT,mw    ��,w        �l                 Y��E       $   �  �  TSSNDD::FATAL -     TSSNDD::ERR -   TSSNDD::WRN -   TSSNDD::INF -   TSSNDD::ALV -   �����( �(     �����0 �0     ����b9 v9     �����: �:     �����H �H     �����K �K �� ��     �h \ �k N] Z] v] �] �] $^ *_ �_ �_ b` �` a *� �� 1� 6� �a �h �� � fb �"H#�����o �o �����o �o GetMessageTime  GetCursorPos    user32.dll  RtlInitUnicodeString    NtOpenFile  NtQuerySystemInformation    n t d l l . d l l   \ D e v i c e \ K s e c D D     SOFTWARE\Microsoft\Cryptography\RNG Seed        ������ �� InterlockedCompareExchange  kernel32.dll    z� :   \ \ t s c l i e n t \                              C B _ S T A T E _ R E C O V E R I N G   C B _ S T A T E _ E X P E C T I N G _ F O R M A T _ D A T A _ R E S P O N S E   C B _ S T A T E _ E X P E C T I N G _ F O R M A T _ L I S T _ R E S P O N S E   C B _ S T A T E _ S H A R E D _ C L I P B O A R D _ O W N E R   C B _ S T A T E _ L O C A L _ C L I P B O A R D _ O W N E R     C B _ S T A T E _ C L I E N T _ I N I T I A T I O N     C B _ S T A T E _ S E R V E R _ I N I T I A T I O N     C B _ E V E N T _ C L I P B O A R D _ T E R M I N A T E D       C B _ E V E N T _ D A T A _ P A T H _ D I S C O N N E C T E D   C B _ E V E N T _ D A T A _ P A T H _ C O N N E C T E D     C B _ E V E N T _ C L I P B O A R D _ I N I T I A L I Z E D     C B _ E V E N T _ R E N D E R _ F O R M A T     C B _ E V E N T _ I N V A L I D _ D A T A _ R E C E I V E D         C B _ E V E N T _ L O C A L _ C L I P B O A R D _ U P D A T E D         C B _ E V E N T _ F O R M A T _ D A T A _ R E S P O N S E _ R E C E I V E D     C B _ E V E N T _ F O R M A T _ D A T A _ R E Q U E S T _ R E C E I V E D       C B _ E V E N T _ F O R M A T _ L I S T _ R E S P O N S E _ R E C E I V E D     C B _ E V E N T _ F O R M A T _ L I S T _ R E C E I V E D   C B _ E V E N T _ C A P A B I L I T I E S _ R E C E I V E D         C B _ E V E N T _ M O N I T O R _ R E A D Y _ R E C E I V E D   C B _ E V E N T _ T E M P _ D I R E C T O R Y _ R E C E I V E D     T e r m i n a l   S e r v i c e s   P r i v a t e   D a t a     P r e f e r r e d   D r o p E f f e c t     F i l e N a m e W   F i l e N a m e     �� ĭ z� z� z� z� z� z� z� z� z� z� l� �� \� *� �� 1� 6� � b� �� � z� R D P C l i p b o a r d W i n d o w C l a s s   _ T S   %� �� �     ������ �� �� �� �� B� �� #� �� V� C� �� �� �� a� �� �� �� o� �� �       �   �   �         �   �   �      S h e l l   O b j e c t   O f f s e t s     S h e l l   I D L i s t   A r r a y     O b j e c t   D e s c r i p t o r   F i l e G r o u p D e s c r i p t o r W     F i l e G r o u p D e s c r i p t o r   F i l e C o n t e n t s     E m b e d d e d   O b j e c t   E m b e d   S o u r c e     L i n k   S o u r c e   D e s c r i p t o r     L i n k   S o u r c e   D a t a O b j e c t     O l e   P r i v a t e   D a t a     O b j e c t L i n k     O w n e r L i n k   L i n k     ~� z� r� z� z� ~� y� r� �� � ~� B� �� �� �       �      F      �      F        �      FH                                                           ��    RSDS����5��B� ~;Y<`   rdpclip.pdb             �p              R d p C l i p A l r e a d y R u n n i n g M u t e x   ������h   j j �� �,�� �,��u��~(%��    ��=�   uQ�� �%, �� ��3������̡,��tP�� �%, 3�������̋�U��V���1;  �EtV�cO  Y��^]� ����̋�U���t
  ��S�]W3��E��������?�������   ��P  ������Phh
  ������Pjj�W�'P  ����   Vh�  � O  ;�Yt���fB  ���3�;���   �����u������|l�4   �����u��8  ��t
�0   9=4t	����P�9=0t(S�|  9=0������t��  9=4t����P�;P  j�������^�����M�������_[�6K  �� �����̋�U��E�MV��W�}� ��t1�E��  � ���S�A��;�~��;�}��f�FF���Mu�[_^]� ����̋�U��E�MV��W�}� ��t1�E��  � ���S�A��;�~��;�}��f�FF���Mu�[_^]� ����̋�U��E�MV��W�}�4�    �щ7tf�1Af�2Af�1BBf�2BB��Hu�_^]� �����̋�U��Ei�@  3ҹ�X ��V�uW����3��ɉMvD�M�N�ʁ��  ~��  � ���;�}��f�D�  3ҹ@  ��GG�M�4F��uM�	�M_�^]� ����̋�U��Ei��.  3ҹ�X ��V�uW����3��ɉMvD�M�N�ʁ��  ~��  � ���;�}��f�D�  3ҹ�.  ��GG�M�4F��uM�	�M_�^]� ����̋�U��Ei��>  3ҹ�X ��V�uW����3��ɉMvD�M�N�ʁ��  ~��  � ���;�}��f�D�  3ҹ�>  ��GG�M�4F��uM�	�M_�^]� ����̋�U��Ei�@  VW3ҿ�X ���M���3����}v)Sf�f�f�QFFf�D�  3һ@  ��FFO�A��u�[�E�M��_�^]� ����̋�U��Ei��.  VW3ҿ�X ���M���3����}v)Sf�f�f�QFFf�D�  3һ�.  ��FFO�A��u�[�E�M��_�^]� ����̋�U��Ei��>  VW3ҿ�X ���M���3����}v)Sf�f�f�QFFf�D�  3һ�>  ��FFO�A��u�[�E�M��_�^]� ����̋�U���$���M�E�3�PPj �U�Rj�QPP�E��� �E�P�` �M��CG  �� ����̋�U���t���E�V�u�E�P�5L  �Ej$�h��E�P�M  �E�P�E�P�N  �E�M���E�F^��F  �� �����̋�U���t��V�u�E�W�}�E�P��K  �Ej$�h��E�P�L  �u�E�WP�L  �E�P�E�P�M  �E�M���E�_�F^�rF  �� �����̋�U���x  ���E�V�u�E�P�`K  �Ej$�h��E�P�8L  �E�P�E�P�;M  �E�Pj������P�6O  V�u������P��M  �M�3�@^��E  �� ����̋�U���� ��+M����  �� �  v3�A��uA�Ģ��u�Ģ�k��I�j
3�Y��Ģ��]� ����̃%Ģ �%�� ��   ��RDPSND ����̡X���uh�' j�P�I  �X�3Ʌ����������̡X���tP�� �%X� �%\� �%`� ������̋�U����X�S�]V3�W�}F���Eu3��`3�;�tZ�E��E�E��E�P�EPWS�u�� ����u&�� =�  uj�EP�E�P�u�� ����t+}]��� ��u�_��^[�� �����jh� �G  �e� �} tm�e� �E�������G  �e�ĉE���E� � 3�=�  �����Ëe��� 3��M����tG�M�u�������ʃ��u���& �E�E��u�u�u�������t�uV�������E�e��4G  � �����̋�U��X�SW3�3�;���   9}��   �\�;�Vuc�Eh�h\�h@  h�Q���=��=��� �5� ����=�  u3��_��u
��!=\��Jj �� �\���t9�];�s�؋5`��}�ˋ�������ȃ��`�)\�j_u�%`� ^�E��t���_[]� ����̡X�V3���tVh\�h�P�� ����u�� ��^������̡X�V3���tP�� ����th�  �� ��^������̋�U��QQW3�9=X��}��}���   SV�u�0u  �F��s$�u�M�SQjY+�Q�P�t�������   �E�F�F9Fs>�N;�Pu�� �Q�� Y����Yu�F��tP�� Y���~t`�F�F3��N;�s �u�U�S+�RP�F�P������t<�E�F�F9F�Y����E�   ^[�E�_�� �� =�  t�~��f ���� =�  tщ~�~������̋�V3�95p�t,95t$�l�;�th0u  P�� =  t=�   tF��^�����̋�V�5l�3�F�� ��u3���^������̋�U���	  ���E������u*j jj�X �����u�h �������   �� ��� ������Q�� ���Qh   h��  Pǅ����   �\ �� ���� �  ;�r������=�   �� ���s	�%� �;�s��������Ph�  �����Pjj�j �kD  ��t-��������������u������P�������t����� �M��@  �������̋�U��V�uW�}��t�� �FOu�_^]� �S O F T W A R E \ M i c r o s o f t \ W i n d o w s   N T \ C u r r e n t V e r s i o n \ D r i v e r s 3 2 \ T e r m i n a l   S e r v e r \ R D P     M a x B a n d w i d t h     M i n B a n d w i d t h     D i s a b l e D G r a m     E n a b l e M P 3 C o d e c     M a x D G r a m     A l l o w C o d e c s   A l l o w C o d e c s   �����̋�U������M��W�E��E�Ph  3�WhN- h  ��}�� ���j  V�5  jX�E�E��E�P�E�P�E�PWh�- �u��օ�u�E����E�P�E�P�E�PWh. �u��օ�u�E�����E�P�E�P�E�PWh. �u��օ�u�E�����E�P�E�P�E�PWh:. �u��օ�u�E�����E�P�E�P�E�PWhZ. �u��օ�u�E�;�s=�   r���E�PW�E�PWhn. �u��}���=�   u}�}�uw���;�S�� tP��Y�E������P�� ;�Y���tH�M������<��E�P�5���E�PWh�. �u��օ�t�5����Y�=���=����E����[^9}�_t	�u��$ �M���<  �������j0h� ��?  3��}������3��E�9E�  �E��   ���@  �e��u܃M���(�E� � 3�=�  �����Ëe��� 3��M���   ����   WV�J����f�F��� ��f�Ff�~WV��������   �=  �e� �e� �u�K�� =�  u4�uԡt��E�h�  j �E�Pj�l =  tl��tg�����V���
�� ��u]�E�VP�0�����t��}�u�f�}�w��uȃ���u������N+�@�E�}� t,�E��@��i��  3��u��F�����V������ ��3��}� t
�u��� Y�ƍe��>  � �����̋�U����ES3�S�u��E�P�]��]��]��]��}?  ���j  V�uWjSSS�u�E�V�u��"V  Pf� f�F �~�F�X f�F f�F f�^�%?  ���  h   jV�u�u���>  ���  f�~��   f�^f��t
f����   �F�@  ;��+  t;�t=�.  t=�>  t;���   f��uG;�t:;�t-=�.  t=�>  t;�uo�E�T" �f�E��# �]�E�p# �T�E��! �K�E��" �B;�t7;�t*=�.  t=�>  t
;�u(�e� �"�E�@% ��E��$ ��E��" ��E�p$ j3�PPP�u�E�V�u�P�>  3ۅ�u�E�   �3�_^9]�t	S�u���=  9]�t	S�u��=  �E��M��E�[�� ����̋�U���   ���E�3�S�]@�E   V�u�E�tE�e� WP�~��E�PS�E�x   �M��=  ��u ��|���P��h���PWS�������t�e� �^_�M��E�^[��8  �� �����̋�U��Q�e� S�������   �EVWf�f9KuPf�K
f;HuF�K;Hu>�K;Hu6f�Kf;Hu,f�Kf;Hu"f�Kf;Hu�ɍx�s3��t҃����t���u��#�{ uj Sh�3 ��<  ��u9Ct�E�   _^�E�[�� �����̋�U��QQ����M���M��W3�;�t\9=��SVvA�E�4���t$;���}�tk�Zjd3�[��9Fv�E�9FvG;=��r������}�u�=�� t�E��E�^[�E�_�� �����̋�U��Q�E� �e� V3���t6SW�8�  3҅���t�X9Yv�ы	��u�҉u�����E�����u�_[�E�0�E��^t�M���� �����̋��3���tHV�5����v<��f�9u.f�yu'�y"V  u�y�X uf�yuf�yuf�y t@;�r�^�����̡����tj P�%;  �%�� �����tj P�;  �%�� �����̋�U���h���S3�;É]��]��]��]�t�MQ�u�u�ЋE�ES�E�P�u�5���';  ��uZ���j�E�P������@P�5����:  ��u2���������H�E���M;�E���  ����9U�w3҉��VW3�;�jY�}��E�E��E� �E�T   �E���   �E��u+�E)E�ȋE��������ʉE�S�E���P�5����}��J:  ���+  j�E�P�5���%:  ��S�E�P�5���:  ;�u�E�E�)E��E��]��]����M;M�s#�u��������ȃ���E�   ��   �E��E�E��E�E�E�S�E�P�5���M��]��9  ����   �M��5j�E�P�5���9  ��uv�E��U��M�E�U�)U�+�U��M��]��]�;M�w�9]��E�   t�u���������ȃ��E�E��E�E��E�E��E�E�S�E�P�5���]��]���8  _^�E��M��E�[�� ������������t�3��A�x����������������j,h� �@7  ���E�E�EЃe� �=�r!�u�����U�QP�������
  �e� ��������X7  �e�܉]���E� � 3�=�  �����Ëe��� 3ۃM������   �=��$�	�f���f�C�� f�C�����M��Cf�E� f�ܢf�E֡��E��f�M�Q��;�s���E�����E̍Hf�K�ȋuЍ{�����ʃ��pj�E�Pj VS�5��d ���t2�5Ȣ�E�)EEЃ} u��E�   �Eȍe��M���2  �"6  � �h ��������jDh� ��5  ���E�u�u��e� �e� ��������6  �e�܉]��M���&�E� � 3�=�  �����Ëe��� 3ۃM���u����N  �=�����}��M��3����Ẻu��u��� �E�f�E� f�ܢf�E֡��E�3�9U�t~�
�E�C�U�vp��}��UȍC�O�Mā��   r�����ɀ�@�EĈ�ϋuЍx�����ȃ��j�E�Pj �u�S�5��d ���t{�E�E��EȋE�;E�r��u��f�Ef�Cf�E�f�Cf���f�C�����M��C+uЋƋȋuЍ{�����ʃ��j�M�Qj ��PS�5��d ���u�h ��M�E̍A�D�Ȣ�E�   �E��e��M���0  �B4  � �����̋�U����E�E�f���V�E�f�E��� f�E��EP�u�Hj�E�Pf�M��������E������Ȣu�� ��^�� ����̋�U���  ���E���l���Ph  �p �M��M0  ������̋�U���,V3�9u�u�u��u�ujWX�   SW�E�PV�E�PVVj�u�u� ��;�uW3�jY�}��E�EԋE�E؋E �E܋E�E�E�E��E�P�u�E�Pj� ��;�uV�u�VVj�u�u� ��9u��=� t�u���9u�t�u���_��[^�� �����̋�U�����SVW�u3ۉE��E�PSSSSSSSjj�E�P3��]�]��]��]��]��E��( ��u�� �$�u�� Sjh   S�u�jV�������u3�G�M���_^[�/  �� �L o c a l \ R D P S o u n d W a i t I n i t   �����̋�Vh,> j j� ���H@��tV� V�� ^�����̋�W3�9=�tw�d�;ǉ=�tP� ��;�V�5� th0u  P�� �5��։=��d�;�t	P�։=d��̢;�t	P�։=̢�Т;�t	P�։=Т^_������̋�U��E��t��v!��v��u�̢��Т��tP� 3�@]� �����̋�U��EV3�HtJHt@��t0��t$-  �u�ut�u�u�� ���������������u�� �V�� ��^]� �R D P S o u n d   w i n d o w   R D P S o u n d   w i n d o w   R D P S o u n d   w i n d o w   �����̋�U���HS�]VWj
Y3��}��3�j�u��E�b? �]��0 �EԍE�P�E��? �� f���=� u��;�t=�  t���TVSVVjdjdVVh  � h�? h@ V�� ��t؋=( ��E�P�� �E�P�� VV�E�VP�ׅ�u��E�   �E�_^[�� ����̋�U���,���e� VWjY�E�j(�EԈM�f�E�$ ���}�P�������M�_^��+  ������̋�U������E��E�f�E� �� ��f�e� ���f�E�tB�ܢ��t8����t/j�E��E�Pj j�E�PRf�E� f�M��d ���u�h �j�E�P�_�����u�� �M��c+  ������̋�U��V�uf�~ t
�~ ��   ���������   ���tZH��   f�~��   �v��f�~ u~�� ���F����  +ȡ����u����Yk��I�j
3�Y�����Cf�~r<�v���P�������N�P*р�w��*P��s���H�5h�� �U���^]� �����̋�U���S�]V3�W�u��u��3�u���Ff�f��U�x�}�tf��au	�=�� t,��P�� ��Yt�ϋ����x�ʃ��` ����uu���	  �ur�3�9��vl����4�N�y�;���EwOf�f=U tf=au	�=�� t,�AP�� ��Yt�ϋ����x�ʃ��` ����E;��r�j�� Y3�;�t3f�@ f�@
 �@"V  �@�X f�@ f�@ f�H�H���9tA�E�PS�������  9}�v$����  H�u��3�# �
�6V�� Y��u�}��E�   ���E�M�_^��E�[�� �����̋�U������SVW3�;ǉ}��!  ���������]f�
f9HuRf�H
f;JuH�H;Ju@�H;Ju8f�Hf;Ju.f�Hf;Ju$f�Hf;Ju�ɍz�p3��tۃ��3�;�t� ;�u���@������;���   WPh���,  ����   �������4�3�Cf9u-f�~u&�~"V  u�~�X uf�~uf�~uf9~tBh���E�PV�5��������t)jWWWV�E�P�5��h���,  ��u�=���]�������Z�������E�_^[������̋�U��� �=����   SV�8�PW3���������E3�WVWW�H�E�P�E�PjhP��5��}��}��P��   �T��@ ;ǉE�u,�M;�t�E;�u*�}�r��P�E��E�P�E�T�����}���{������M��_^[�� ����̋�U����e� �e� �E�Pj �E�Ph8�5��D ��u�h �8�U���r0�M��t�E��t
�P���P�E�E�P�E�T������ ����̋�U��QQ���e� $<u�I����=� �P  ���V�5Ģ;�r	�N�����Ȣ���  i��  W���+�3������E���   3ҹs  ���   ��jY��@@;�w����9E�v�E����9E�s�E��5��S�������t�P����;U�v��+M���M�+ʡ���jd3�_��;�r|�=�2s���u��#��������t];�t���H���<� u�;�u�����t;;�t7�9�������4��2�����t�E��%�� ����=�������E�   [_�%Ģ �%� ^�E��������j@h� ��'  ���E�E�E�3҉U�;��j  �=���]  9ܢ�Q  �����C  9��7  �   ;��E�r�M̉U��Ẽ������'  �e��u���E� � 3�=�  �����Ëe��� 3��M������   �]�SV�!���f�E� f�ܢf�E֡��E���C�f�Ff�F �E�
   �=� ��f�Fj�E�Pj S�d ��   �e� �e� �E�P�E�P�u��*����}� u:�E��E��t��E�h�  j �E�Pj�l ��tE=  tn�E�P�E�P�����EЅ�t��}�u��8u�f�xw��}� t�����M��I+�@�E�3�9E�t�E��@��i��  3��u�@�e��M��#  �u&  � �M�t���f�Fj�E�Pj �u�V�5��Ӄ�������h �����̋�U��VW3������9=��u'�u�������;�t9=��u�=�u(�=��>�u�=��=ܢ�=��������;�t<�=�rj h��c'  ��t#�)��������t;�v�𡬢;�s��3�G��_�5��^]� �����jPh  �J%  3ۉ]؉]̋��;�tB3�9��v��;�tP�� Y���F;5��r�Q�� Y���������3��}������9��uh��h���5���;���  ������D �E��]ܡ����HM�9M�s�H�M܋ ;�u�]��E��������$  �e�̉MԃM���(�E� � 3�=�  �����Ëe��� 3ɉMԃM��3�;��7  ��E����f�Af���f�A��@�Af�A �]�A���9��vef�Jf�f�J
f�H�J�H�J�Hf�Jf�Hf�Jf�Hf�Jf�H�ɍr�x�����˃���E��H�D��M�;��r��M��u�Q�l�����u�� �~  �]�=� �5  �e� �e� �O��=�  u<�]��t��E�h0u  j �E�Pj�l =  ��  ����  �0���S���
�ׅ���  �E�SP�y�����t��}�u��E���MȋP�U��P�U��P�ܢ�@��f�}�&��  ��   t�uS�������u!Eȋ]��C�����P�5� ��Y���=�����3��9����  3�9=��v0�E܃��E��u���Y���������<� �P  G;=��rٍS�E����e� �=�� vI�r�N�M�;��  ;u��  ��=���]�<������˃���+��E�M�;��r�3�3��5����ve����D��f�f��Uu�}� uf��au�E�   �H;�w
u-�P;�v%P�� Y����d�� ������S���   ���}�x��Nu��5���*��������t(��������4�_����=�������@����uȅ�t,������t#��p��M��H��M��H������E�   3�9}�t
�u��� Y9}�uN9=��tF3�9=��v�����;�tP�� YF;5��r��5���� Y�=���=���=���E؍e���   � ����̋�U���u��u�` �/�����u����]� �����̋�U��QSVW3������95�����t&�E�PW�u�E� �  �u�h�������   �]�����]�U�ˋ������ȃ��=����   3�9ܢ��   ��;���   9�t9��tw����s�s;�wf��r9�M������s���PV�O����S��R�PV�������փ���r�C;�vSR�u�����SR�u�����
SR�u�_�����_��^[�� L o c a l \ R D P S o u n d D a t a R e a d y E v e n t         L o c a l \ R D P S o u n d S t r e a m I s E m p t y E v e n t     L o c a l \ R D P S o u n d S t r e a m M u t e x   L o c a l \ R D P S o u n d S t r e a m     R D P S o u n d - D i s c o n n e c t   R D P S o u n d - R e c o n n e c t   �����̋�U����   ��SV3�W�E���h����S���3���T���������K����5 h�P SSS��h6Q jSS�d���hzQ SS�h��� SSjS�l��։�p����L ��t����d�;��S  9h��G  9l��;  9�p����/  9�t����#  P�������  �5h��������  �5l���������  h�Q �$  WSjSj��� ;ãp���  P�V�������  WSSh  �5p��� ;ã��  �4�������  �=3�j	Y�=��$� @  ��H�ɈH����8����� ���P�� P� ���7  �=� j@��|���h�Q P�׃���|���PSSS��;ãt��  j@��|���hR P�׃���|���PSSS�֋�;�h�����  ��������  �t��̢��p�����(����d���0�����t�����8����ТPW��$�����,�����4�����<����������T���P�'�����X�����d�����T���WP�������u�SS��t�������������&  Sh�  S��$���Pj� ��;�uA�D�����$����  ���T���P������X�����d�����T���WP�s�����u���   ����  ����  ��tN��t"����   SS�����SS��t����+����   9|�t�Ԣ�x  9Ԣu9آ�d  ������t_��t���W�����W��T���P�������t��T���P�������X�����d�����u�|���Ԣ�5h��آ� �]�����������  ��u�=3�� @  ��$��H�H��  �ui9x���   �A�Q:�tS��:Ј�{���t/�� -�  %��  P��������{����A��8�{���uъA�A�5h�� �9x���   9t=�A   t4ƅ@���fǅB��� �A��D���j��@���P�)������9x�tC9Yt>�A   t5ƅH���fǅJ��� �A��L���j��H���P�������X��A�Q:��<  *A��;��*  9|�u)9Ԣu!9آu9x�u3�����x�   ��Q��H�ɈH�5h�� ��A:A��l�����   ���l����Q*Q��;���   ��j^���h �  �����D$P��l���������=��3��    �|>$󫊅l���<�u��;�t"����A�:A��l����y����:�|��������������H�H��H�H������آ   9x�t4�A8Au,:Au'����j��P���PƅP���f��R����Q����x��&�����p����+������^�������������u�5|��
�Ԣ   9��������� �����9�p����5� t��p�����9�t���t��t����H 9�\����=� t	��\�����Y9�h���t��h����֡t�;�tP�֡h�;�tP���*�����t��@   ��W��������9t�����tP�T �5�� �p�;�tP�֡l�;�tP�֡��;�t'3�9��v��;�t	Q�ס��YF;5��r�P��Y���;�t�0P��;�Y��u����;�tP��Y�������l �M�_^3�[��  �� �����̋�U��QQSV3�3�C95̢W�= �u���uVVVV��;ƣ̢u�� �695ТuVVVV��;ƣТt�E�PVVh.R VV� ;ƣ�tŉ]��E�_^[������̋�U��3�9Eu�W ��-�UV�uf�f��tf�
BBFF�Mu�} ^uJJ�z �f�" ]� �����̋�U��W�}3���u�W ��4�UV�u�} tf�f��tf�
BBFFO�M��u��^uJJ�z �f�" _]� ����̋�U��V�u3�����t�Uf�: tBBNu���u�W ��U��t��|+Ή
��" ^]� ����̋�V���M  � ��^������̋�V���M  � ��^�������� �� �M  �����̋�V��t  t��E��u����P��u��E��bS���  ���W�=� tP�׃# ���  ���tP�׃# ���   ��|  ���tP�׃# ��x  ���tP�׃# ���:Q  _3�[��t   ^�����̋�SV�5 W3�WWWW����;ǉ��  tWWWW��;ǉ��  u�5� �օ������%��    ��3�_^[�����̋�U��EVW3�HH��t4��t�u�u�u�u�� ��� ����P0���  �6�� �>�W�� ��_^]� �����3�@� �����̋�V���  �6�� �& ^�������3�9��  ���������3������̋�U���  ��S�]VW���E��E��P  Q������Q�������E���������  �������Q��ǅ����  ���|#������P���K  V��������������S�Z  �M�_^[�  �� �����̋�U�����V�u�E�jB�M��, ���E�u*�5� �օ�	�֋��   �֋�����  ��  ��   SWP�( �� �����}�u�Ӆ����>�Ӌ�����  ��  ��.�M�u�����ȃ��M􍁸  P�u�u��u�SY  ���}� t/�u��$ ��u"�Ӆ�t�Ӆ��Ӌ���Ӌ�����  ��  ��u��  _[�M���^�  �� ����̋�U���  ��S�]VW����P  Q������Q�E��E���������  �������Q��ǅ����  ���| ������P����I  V�u��������S�/]  �M�_^[�  �� �����̋�U�썁�  P�u�u�u� ]  ]� CLIPRDR �����̋�U��Q��W����t  �E�t��E��SV���  �> uDh�_ j�j �A  ���u�5� �օ����"��%��    ��j j h+  �w4�� 3�^�M�_��  ������̋�V��t  t��E�^Ë���P����]  3���\  ��`  �F^������̋�U��VW3���G9�t  t��E��E����P��u��E��3�F��� Ht%HHtHt�u���]  jj �΋��L  ���E���_^]� �����̋�U��V��t  t��E��=����P��u��E��+�F��� HtHHtHt�u���g  �
��E��3�@^]� �����̋�U��QQVj ��j j�M�Q�M�Q���PX��|�u���u����P\^������̋�U��VW�}f�?��tW�ai  ��F��tP� W����a  3�_^]� �����̋�U��U��VW��s)�F8����E�tMP�� ��t>�=� �ׅ�"�׋��,�E�p�Q���R��P����a  ��� �׋�����  ��  ��f8 �f< �f@ �fD ��_^]� �����̋�U��S�� VW�����  ��u� ��n���  V�MQ�u�uP�� ��uP��=�  u3j�EPV���  �� ��u0�Ӆ�����Ӌ�����  ��  �������%��    ���3��} t)�u�� ��t�Ӆ��Ӌ���Ӌ�����  ��  �_��^[]� ����̋�U��M�E�������;�w;�wP�uQ�u�������W �]� �����̋�U��} V�ut�}���wV�u�u�������W ���}��t�& ^]� ����̋�VW���zH  ���  � ��������  ����3����  �����3����  �����3���x  ��|  ���  ���  �F���  _��^��R D P C l i p - R e c o n n e c t   R D P C l i p - D i s c o n n e c t   �����̋�U���  ��SV��E����  3�;�u
�@ ��   Whd ���  �  W������P�'���;�|j������PSSS� �Ӆ�u�5� �օ����D��%��    ��6h:d ��|  W������P�����3�;�|������PWWW��;�t���x  3�_�M�^[��  �������̋�U���t  ��SVW3��E��񉽰���ǅ����   ������3�9�����u9�����tZ���  ;ǉ�����t7���  Q������QhH  ������QP�� ;ǉ�������   �� �3�C9�����t;���   h�  j�W��x  Pj�� ;���   3�C;�tq��tI��u}S�� �)��������   ������P�� ������P�� jWW������WP�Ӆ�u��9W������P���  P���  �� �����������P,�����������P09����������������������P���G���;������=�E����������Pjj����F  �����M�jX_^[�U  ���R D P C l i p   -   R e c e i v e   T h r e a d   �����̋�VW3�W��h�f ���  P�G  ��|����P,��|	�����������_^�����̋�U��M����P�0 �����̋�U���  ��V��t  W�}�E�t
��E���   ����P��u
��E��   �F��� H��   HH��   H��   �G��������=  v
��E��   ��r�����QP��W�s�����|�������������Wh  P�����Ѕ�|J������R���������  �R�~HWǅ����  ��Ѕ�}��   3����F   �
��E��3�B�M�_��^�  �� ����̋�V��f W�!W  �������jj �΋���D  ��_^������̋�U��V�uf�>WVt�Z  �����V���� ��_^]� �����̋�V��t   t��E�^Ë���P��u��E�^Ë��\  ��|F��������|;���E�����|0Wh�   ��X  Wjd�v0�� ��uf!3���_u
ǆt     ^�����̋�U��QSV��M3۸�  ;�W�]��  ��   ��HH��   ��t_��t-  �  �u�u�v����E��  9]��  SSj���  �� 90t��������P�(  觶���V  SSj���  �� �v4�� �^4�5  ���  9t
�v4��  ��v(�v4�� �Ή^(��[  S�� ��   �E��t"H��   �v(�v4�� �Ή^(�[  ��   �~4�� ;���   W��X  �� �F(�   ���  +�t��tQ-  t!Ht�u�uQ�u�� ������������w�u����PP;�}i=�E�ub����Pjj���B  �N�F(9Eu�E�;�t=P�� ��t2�u�uh  �����P@�F(;�tP�� ��tSSW�v(�� �E�_^[�� �����̋�U��}S�]VW�}tj�W�� ����3Vj�W�� ��S�u�uWt;~4u	��������;��  u	���H������ _^[]� �R D P C l i p   -   C l i p   T h r e a d   �����̋�U��� SV3�S��]�� ����   hVk ���B  ����   WSh�k �~4W���B  ��|jS�7�  �?���  �� ;�tW��X  �� �F(�E�PSVhJg SS� ��t)�5( ��E�P�� �E�P�� SS�E�SP�օ�u�_� �E�^[������̋�U�������t=@�  uMV�E�P�8 �u�3u��� 3��� 3��� 3��E�P�4 �E�3E�3�%��  ^u�@�  ���У��������;�u	��  ��u��   ����̋�U���   W��#��#��#��#�5�#�=�#f�$f�$f��#f��#f�%�#f�-�#��$�E�M���$� $�H#  �M�I��#���E���3�G�E�j ��#��"	 ��=�"�D hx �@ h	 ��������� P�< _�������jph� �  3ۉ]��E�P�H ����}�f�=   MZu'�<  ��   �8PE  u�H��  t ��  t�]��'���   v�3�9��   ��xtv�3�9��   ���M��E�   j�� Y�=�G�=�G�� � &��� �&��� � ��G�J  9�uh:q �� Y�  h< h8 �   �&�E܍E�P�5&�E�P�E�P�E�P�� �E�h4 h, ��  ��$�� � �E��8"u/@�E��:�t��"u�8"u@�E��:�t�� v��E�t�M���8 v�@�E���j
YQPSh   �.������u�9]�uV�� �� �}��1�E��	�M�PQ�5  YYËe�u؃}� uV�� �� �M�����3�@Ëe�M����   �s   �������%� �������%� �������%� �������%� ��������h�p d�    P�D$�l$�l$+�SVW�E��e�P�E��E������E��E�d�    ËM�d�    Y_^[�Q��������%� ����������������Q�L$+�s�D$Y=   s��ă�� �� P�Q�L$��   -   �=   s�+ȋą���@P�������%� �������%� �������%� �����h   h   �   YY������3��������%� �������%4 �������%8 �������%� �������%x �������%| �������%� �������%� �������%� �������%� �������%� �������%� �������%� �������%� �������%| �������%x �����j �;$  ������j �q$  �����̋�U���u�uj j �e.  ]� ������������̋�U��Q�=$& S��   PSQR3��3���Genu��3ہ�ntel��#�3Ɂ�ineI��#��E��   �3�3һ�   #�����   #؃�p���%   �   3���#�3ɻ   3���ыE�#E�ZY[X�E�����$&�E�@T    �@X    �@@#Eg�@D�����@H�ܺ��@LvT2�@P����[��]� �����������������̋�U���SV�uW�}�OX��΃�?;ΉE��OXs�GT��vO�0��@�M�rD�]�@   +�Q�SP��p  �E����@   +U�W�O@���QډE�$&�u�E�    �E���]��t8��@ra���u��EP��@�   ��P��$&�m@�}��@�muًu�+��@r)�����E��$    S�G@P�$&��@��@�mu�E���tV�SP�:p  ��_^[��]� �����������̋�U���T��3ŉE�S�]V�u�FXW��?�@   +���w��@�O�Q�U�j R��o  �NT�FXɋ�����ʃ���M�j�M��Q�T=��R�E���E��   W�E�PV�p���j�N@QS�   j@j V�o  ��V�a����M�_^3�[�<�����]� ��������������S3�3�V�D$�t$W���\$U��   �늖  ���  ��������   ����   �Ǎ<��|$����xA3����   �Ё��   ��A�Ê3����   3��Ё��   ��A�Ê��3����   3��Ё��   ��A�Ê��3����   3��Ё��   ���Ê����    3��D$+É8M�N����l$����t.�xA��   #�3���#�3ۊ��Ê�2؈GMu�]_��   ^�[�P� S� �   V�t$W���U����ǉj����ǉj��Iu�l$3��
�D$�<(�J3�3�3�$un�1�E �ڊ3�1�3�E�T1�ڊ3�D1�3�E�T1�ڊ3�D1�3�E�T1�ڊ3�D1���3;�u�l$��u�]_^[� ������1�E �Eڊ3�1�3;�u�l$A��   u�]_^[� ��������������������VWSU�T$��@  �   �L$������ȉNu�$T  �L$�    3�3ۋA��Y��1�y3�3ߋq�y3�3ߋq,�y03ƃ���3��ÉA0J�Y4u͋E �]�M�U�}��3�#������4$��3��ˍ�>�y�Z���3����#���ȋl$��3��y�Z���3�#����΋t$��3��ύ��y�Z͋�3�����#���ʋl$��3����y�Z���3�#����Ƌt$��3��ɍ��y�Zŋ�3����#���ˋl$��3�=�y�Z���3�#����֋t$��3��ȍ��y�ZՋ�3����#���ϋl$��3��y�Z���3�#����ދt$ ��3��ʍ��y�Z݋�3�����#���ɋl$$��3����y�Z���3�#������t$(��3��ˍ�>�y�Z���3����#���ȋl$,��3��y�Z���3�#����΋t$0��3��ύ��y�Z͋�3�����#���ʋl$4��3����y�Z���3�#����Ƌt$8��3��ɍ��y�Zŋ�3����#���ˋl$<��3�=�y�Z���3�#����֋t$@��3��ȍ��y�ZՋ�3����#���ϋl$D��3��y�Z���3�#����ދt$H��3��ʍ��y�Z݋�3�����#���ɋl$L��3����y�Z���3�3��������ˋt$P��=���n���3�3��������ȋt$T�����n���3�3��������ϋt$X�����n���3�3��������ʋt$\�����n���3�3��������ɋt$`�����n���3�3��������ˋt$d��=���n���3�3��������ȋt$h�����n���3�3��������ϋt$l�����n���3�3��������ʋt$p�����n���3�3��������ɋt$t�����n���3�3��������ˋt$x��=���n���3�3��������ȋt$|�����n���3�3��������ϋ�$�   �����n���3�3��������ʋ�$�   �����n���3�3��������ɋ�$�   �����n���3�3��������ˋ�$�   ��=���n���3�3��������ȋ�$�   �����n���3�3��������ϋ�$�   �����n���3�3��������ʋ�$�   �����n���3�3��������ɋ�$�   �����n��Ƌ�����#����$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ������#ꋴ$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ������#ꋴ$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ������#ꋴ$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ�3�3��������ˋ�$�   ��=��bʋ��3�3��������ȋ�$�   ����bʋ��3�3��������ϋ�$�   ����bʋ��3�3��������ʋ�$�   ����bʋ��3�3��������ɋ�$   ����bʋ��3�3��������ˋ�$  ��=��bʋ��3�3��������ȋ�$  ����bʋ��3�3��������ϋ�$  ����bʋ��3�3��������ʋ�$  ����bʋ��3�3��������ɋ�$  ����bʋ��3�3��������ˋ�$  ��=��bʋ��3�3��������ȋ�$  ����bʋ��3�3��������ϋ�$   ����bʋ��3�3��������ʋ�$$  ����bʋ��3�3��������ɋ�$(  ����bʋ��3�3��������ˋ�$,  ��=��bʋ��3�3��������ȋ�$0  ����bʋ��3�3��������ϋ�$4  ����bʋ��3�3��������ʋ�$8  ����bʋ��3�3��������ɋ�$<  ��b��Ƌ�$T  ��@  �.ŋn݋n͋nՋn���^�N�V�~][_^� ��$    ��VWSU��@  ��$T  �E �]�M�U�}��$X  �u Ή4$�������7�y�Z��3�#�3�����uΉt$֋�����2�y�Z��3�#�3���֋uΉt$΋�����1�y�Z��3�#�3���΋uΉt$ދ�����3�y�Z��3�#�3���ދuΉt$Ƌ�����0�y�Z��3�#�3���ƋuΉt$�������7�y�Z��3�#�3�����uΉt$֋�����2�y�Z��3�#�3���֋uΉt$΋�����1�y�Z��3�#�3���΋u Ήt$ ދ�����3�y�Z��3�#�3���ދu$Ήt$$Ƌ�����0�y�Z��3�#�3���Ƌu(Ήt$(�������7�y�Z��3�#�3�����u,Ήt$,֋�����2�y�Z��3�#�3���֋u0Ήt$0΋�����1�y�Z��3�#�3���΋u4Ήt$4ދ�����3�y�Z��3�#�3���ދu8Ήt$8Ƌ�����0�y�Z��3�#�3���Ƌu<Ήt$<�������7�y�Z��3�#�3�����4$�l$3��l$ 3��l$43��Ɖt$@������*�y�Z֋�3�#�3���Ջt$�l$3��l$$3��l$83��Ɖt$D������)�y�Z΋�3�#�3���͋t$�l$3��l$(3��l$<3��Ɖt$H������+�y�Zދ�3�#�3���݋t$�l$3��l$,3��l$@3��Ɖt$L������(�y�ZƋ�3�#�3���ŋt$�l$3��l$03��l$D3��Ɖt$P������/���n���3�3�����t$�l$3��l$43��l$H3��Ɖt$T������*���n֋�3�3���Ջt$�l$ 3��l$83��l$L3��Ɖt$X������)���n΋�3�3���͋t$�l$$3��l$<3��l$P3��Ɖt$\������+���nދ�3�3���݋t$ �l$(3��l$@3��l$T3��Ɖt$`������(���nƋ�3�3���ŋt$$�l$,3��l$D3��l$X3��Ɖt$d������/���n���3�3�����t$(�l$03��l$H3��l$\3��Ɖt$h������*���n֋�3�3���Ջt$,�l$43��l$L3��l$`3��Ɖt$l������)���n΋�3�3���͋t$0�l$83��l$P3��l$d3��Ɖt$p������+���nދ�3�3���݋t$4�l$<3��l$T3��l$h3��Ɖt$t������(���nƋ�3�3���ŋt$8�l$@3��l$X3��l$l3��Ɖt$x������/���n���3�3�����t$<�l$D3��l$\3��l$p3��Ɖt$|������*���n֋�3�3���Ջt$@�l$H3��l$`3��l$t3��Ɖ�$�   ������)���n΋�3�3���͋t$D�l$L3��l$d3��l$x3��Ɖ�$�   ������+���nދ�3�3���݋t$H�l$P3��l$h3��l$|3��Ɖ�$�   ������(���nƋ�3�3���ŋt$L�l$T3��l$l3���$�   3��Ɖ�$�   ������/���n���3�3�����t$P�l$X3��l$p3���$�   3��Ɖ�$�   ������*���n֋�3�3���Ջt$T�l$\3��l$t3���$�   3��Ɖ�$�   ������)���n΋�3�3���͋t$X�l$`3��l$x3���$�   3��Ɖ�$�   ������+���nދ�3�3���݋t$\�l$d3��l$|3���$�   3��Ɖ�$�   ������(���nƋ�3�3���ŋt$`�l$h3���$�   3���$�   3��Ɖ�$�   ������/ܼ�����#��#������t$d�l$l3���$�   3���$�   3��Ɖ�$�   ������*ܼ�֋��#��#����Ջt$h�l$p3���$�   3���$�   3��Ɖ�$�   ������)ܼ�΋��#��#����͋t$l�l$t3���$�   3���$�   3��Ɖ�$�   ������+ܼ�ދ��#��#����݋t$p�l$x3���$�   3���$�   3��Ɖ�$�   ������(ܼ�Ƌ��#��#����ŋt$t�l$|3���$�   3���$�   3��Ɖ�$�   ������/ܼ�����#��#������t$x��$�   3���$�   3���$�   3��Ɖ�$�   ������*ܼ�֋��#��#����Ջt$|��$�   3���$�   3���$�   3��Ɖ�$�   ������)ܼ�΋��#��#����͋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������+ܼ�ދ��#��#����݋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������(ܼ�Ƌ��#��#����ŋ�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������/ܼ�����#��#�������$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������*ܼ�֋��#��#����Ջ�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������)ܼ�΋��#��#����͋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������+ܼ�ދ��#��#����݋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������(ܼ�Ƌ��#��#����ŋ�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������/ܼ�����#��#�������$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������*ܼ�֋��#��#����Ջ�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������)ܼ�΋��#��#����͋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������+ܼ�ދ��#��#����݋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������(ܼ�Ƌ��#��#����ŋ�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������/��b����3�3������$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������*��b�֋�3�3���Ջ�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������)��b�΋�3�3���͋�$�   ��$�   3���$�   3���$�   3��Ɖ�$�   ������+��b�ދ�3�3���݋�$�   ��$�   3���$�   3���$�   3��Ɖ�$   ������(��b�Ƌ�3�3���ŋ�$�   ��$�   3���$�   3���$�   3��Ɖ�$  ������/��b����3�3������$�   ��$�   3���$�   3���$�   3��Ɖ�$  ������*��b�֋�3�3���Ջ�$�   ��$�   3���$�   3���$   3��Ɖ�$  ������)��b�΋�3�3���͋�$�   ��$�   3���$�   3���$  3��Ɖ�$  ������+��b�ދ�3�3���݋�$�   ��$�   3���$�   3���$  3��Ɖ�$  ������(��b�Ƌ�3�3���ŋ�$�   ��$�   3���$�   3���$  3��Ɖ�$  ������/��b����3�3������$�   ��$�   3���$�   3���$  3��Ɖ�$  ������*��b�֋�3�3���Ջ�$�   ��$�   3���$   3���$  3��Ɖ�$   ������)��b�΋�3�3���͋�$�   ��$�   3���$  3���$  3��Ɖ�$$  ������+��b�ދ�3�3���݋�$�   ��$�   3���$  3���$  3��Ɖ�$(  ������(��b�Ƌ�3�3���ŋ�$�   ��$�   3���$  3���$   3��Ɖ�$,  ������/��b����3�3������$�   ��$�   3���$  3���$$  3��Ɖ�$0  ������*��b�֋�3�3���Ջ�$�   ��$�   3���$  3���$(  3��Ƌ�����)��b�΋�3�3���͋�$�   ��$   3���$  3���$,  3��Ƌ�����+��b�ދ�3�3���݋�$�   ��$  3���$  3���$0  3��Ƌ�����(��b�Ƌ�3�3���ŋ�$T  ��@  �.ŋn݋n͋nՋn���^�N�V�~][_^� ����������������̋�U��U��v�E�M+�V�4Ή0����u�^]� ����̋�U��=�' V�x&u"j jjV�H  jPh(&�$  ��'   �M��t�E��t� ��t	P�1V�  3�@^]� ����̋�U��QW�}��t:�} t4�EP�E�Phx&�  ��t�M9Mw�M��V�u����ȃ��^3�@_�� ����̋�U��Q�=�' u(�E�P�P  ��tj �u�h�'�  ��t�u���  3�@�� ����̋�V�5� j h�'�օ�tP��  j h�'�օ�^tP�� � ����̋�U���   �=�' ���E���   Wj%Y3���h���󫍅h���Pǅh����   �T ����   3���x���V����� tNh �� ����tn�5h h� W�օ���'t
�� @  h� W��h� W��'�֣�'�1h� �X ����t �5h h� W��h� W��'�֣�'^��'   _�M�� �n���������̋�U���,���������   ��'V3�;ƉE�u~95�'tP��';�tGh �M�Q��j �E�E�j�E�P�E�Ph  �E�P�E�   �u��E�@   �u�u���'��}3��@WV�u�h�'��  ��;�t�u��� �}�_�EVP�0�u�u�uh 9 �u��P ^�� ����̋�U����  ���MV�uQ�E��EP�u��,���V��(���������t3�@��  S�   Sj �\ P�p ����4�����  9]W��  �E��4����ȋ������ʃ����=   ��t  ��4����   �4+��� j_;߉�Q  �+��� ;߉�=  �+��� ;߉�)  +�����"  V�� ���  ����;��  V�4 j_;���  j +�X�;���  V��d ��(��  ��(��(;���  �FP�FP�FPV3�W�` ����  ����9=�'��8�����   ��0����� ;ǉ�<���u�� ;ǉ�<���ǅ0���   ��   ��D���P�oJ  ��<���3���0��� u�t>V�� ����t>V�� ��WV��D���P�tJ  ��uɍ�D���P�K  ��0��� ��<����u���'����u�� ��� ��'   ����  ����8�����'������  ��8���j_�+�������u?����  V��'���x  �����r  ��'���F�Z  ���X  j@X;؉�8����G  ��8���PV�S  ��t��8��������;��  �+ء�'���  j SVj��<����Ѓ���  ��P���P������<�����P���VP�n���V��P���P�q���;���  +����0��  ��<���Pj0Vj��'��|��<��������;���  �+�;���  ��<���PWVj��'��|��<��������;��T  �+ظ8  ;��I  ��<���QPVj��'��|��<��������;��  �+؃��  ��<���PjVj!��'��|��<��������;���   �+؃� ��   ��<���Pj Vj-��'��|��<��������;���   �+؍�<���PSVj��<�����'��|=����   ��P���P�!�����<�����P���VP�����V��P���P����;�rT�+ߍ�<���PSVj��<�����'��|;��r6��P���P�������<�����P���VP����V��P���P����;�s3��+�jY�E�PjP��@����(&�}�P������   ��+�;�v���M�QP��4����  jYj�؍u���\����Y��\���PjP�u��(&�^V��@���P�����V��\���P�  ��\�����_�  @Iu��E�PV��@���P�����E��  @Nu���,�����(����0��@���P������@����  �  @Iu���4����   �  @Iu���4���j �\ P�� ��[�M�^������ ����̋�U���  ��V�uW�6�E��EP�x&W�������  ����   S������P������P�5�'�  ��9�������   ������������P������P�   W��������  ��u3��{������P������P�������������.�����tٍ�����P�������������5�'�  �������  @Ku���+�����9v��������6�������5�'�+  3�@[�M�_^�d����� ����̋�U��QV3�9uv#�E+ƉE��E�P�E�P������tu�;ur�3�@^�� 3�������̋�U��V�u�>t3��i�N3�9SWt�F9t�����3�3�R� �����tASW�@����Ft�EP�uj j �'�����u�uj �Z�������t��t	�3�7�h�����_[^]� ����̋�U���3�VW�}𫫫��E���E�   t'�u��t � �u�E���u�E��E�P�:����M����u�E��uP�$���_^�� ����̋�U��E��t&�M�` �H�M�H�M� #  �@   �H3�@]� ����̋�U��E��t�8#  u�U�H �
�@�M�3�@�3�]� ����̋�U����   ��S�]V�u���E��  �>#  �  �~�F�� ����FW�~ �����uD�E�Pǅ���   ��B  �u�E�SP�0C  �Ft�� ����E�WP�C  �E�P�1D  �E��R��$���Pǅ���   �6����u��$���SP�D  �Ft�� �����$���WP�D  �E�P��$���P�ME  �E�3�9��������������v ;� ���r3�������08@A;����r��F����3��� ���3�@_�V�3��M�^[������ ����̋�U��EP�u3�P�uPPPh8 h  ��  ���@]� ����̋�U��QQ�E�Pj������t/V�EP�u�E�Pj h\ �u�� �u����$ 3�����^�� ����̋�U��Q�E�Pj�n�����t,V�u�ujj h\ �u�� �u����$ 3�����^�� �����jhh ������e� �u�l �M����3�@Ëe�M��2������� ����̋�U��M���'�UH#�'�L����M�]� ����̋�U��E�SI#MV�t�W�~W�t �u�]S�FP�����W�p _^[]� ����̋�U��E�I#MV�t�W�~W�t �u�F�uP������& W�p _^]� ����̋�U��W�}���vSV�w�؋��P�x ��Ku�^[Wj �\ P�� _]� ����̋�U��QVh(	  j �\ P�p ����tG�e� SW�   �F   �~(�^�GP�;������t$���E�����   �}�r܋E�03�@_[^�� �E�V��D���3�������̋�U��=�' u*h� �X ��tht P�h ��'��'   ��'��t]���M�;Eu�U�]� ����̋�U���   ��S�]�ۉE��EV��H�����D�����  ����  �u����  Ɖ�L���W��P���P���]���j_W��D�����P���P��@  V��H�����P���P��@  WS��P���P�@  V��L�����P���P�@  �E�P��P���P�SA  ��P���P�����WS��P���P�y@  V��L�����P���P�f@  W��D�����P���P�S@  V��H�����P���P�@@  �E�P��P���P��@  �C(��H�����L���Ɖ�L�����P���P�}���W�CP��P���P��?  V��L�����P���P��?  W��H�����P���P��?  ��L���V�P��P���P��?  �E�P��P���P�p@  ��P���P����W��H�����P���P�?  ��L���V�P��P���P�{?  W�CP��P���P�j?  V��L�����P���P�W?  �E�P��P���P�@  ��P���P����W�E�P��P���P�*?  W�E�P��P���P�?  ��D�����P���P��?  ��P���P�k���W�E�P��P���P��>  W�E�P��P���P��>  S��P���P�?  ��P���P��.���W�E�P��P���P�>  W�E�P��P���P�>  S��P���P�O?  ��P���P�����W�E�P��P���P�r>  W�E�P��P���P�a>  �S��P���P�?  j\Y��P���_�  @Iu�jP�E�Y�  @Iu�3�@�3��M�^[�{����� �����3�� ����̋��  �` �����̋�U��Vjj@���� ��u� ���M��M�H��H�F�3�^]� ����̋�W�����tV�pP�� ����u�^�' �g 3�_�����̋A�����̋�U���M�! �
�U;t�@��u��]� �@�3�������̋��` � � �����̋�U��E�A3�]� ����̋�U��}���v	�W �]� ]��������̋�U�����9Ew9Ew]�G����W �]� ����̋�U��V�uW�}�EPVW�u�����|�u�E+�V�GP�����_^]� ����̋�U��V�uW�}�EPVW�<�����|�u�E�u+�V�GP�ϰ��_^]� ����̋�U��}���v	�W �]� ]�n�������̋�U��}���v	�W �]� ]��������̋�U��S�]VWjh� S����9  ����up9EuS�H�����	�   ��j\S�A����}Y��Y+���VS�7�u���������   �Ef�$p h� �7P�I�����|{j\S������YYtP�7�Z�� ��aj\S�K9  ����YYu�M!9�� ��E�} �vu����W������Y�DY�M�� �u�6�u� �����|W�6�u�������|3�_^[]� ����̋�U��SVWj:�u�p����؅�YYt`��+u���} u��S�F���Y�M�D0�3��G�}h� �7�u������|1V�u�7�u�~�����|��S�7�u�J�����|���M�! �� �_^[]� ����̋�SV��W�N �  �z����=  3�9�Guh� �ף�G9�Guh� �ף�G9�Guh� �ף�G9�Guhl �ף�G�^�^��\  ��`  f�^,�^0�^�^8�^<�^@�^D�^4�^(��X  ��d  ��h  ��t  ��   3���P  ���j@�~H���Y��X  �_��l  �^�^�^��p  ��^[�����̋�SVW3�3ۍq���t:P�  ��tC����|��)�5� �օ��֋���֋�����  ��  ���@ ���_^[�����̋�U��VhX���| ��   ���E�������7�M���'�F^]� ����̋�VW��f�, t�w0h` � f�g, ��l  ���t�&  ��P�Q�& j�w_���t
P�� �& ��Ou�_3�^�����̋�U���(VWj
��Y3��}��E3��E܋F0h   W�E�   �}��}�E�}�� W�E��0 �E�E�P�}��E�` �� f;�f�F,u�� =�  t;�~%��    ��3�_^�� ����̋�U��VWQ�q03�WWjdh   WWh  � �uh` j�� ;ǋu�u�5� �օ����&��%��    ��9}tj
P�� �6� 3�_^]� ����̋�SV3ۍqj j j j � ��t�C����|�3�^[Ë5� �օ�������%��    �������̋�U��Q�e� V3���l  90t1� ��U�RhH P���|�u�� �����F�E���t�P�Q��^������̋�U��QQVWjjB���, �����u�u*�5� �օ�	�֋���   �֋�����  ��  ��   SV�( ���E����  u �=� �ׅ��׋��N�׋�#��  ��@��w4� ��t�� ���=� tV�5�G� ��uC�ׅ�/�׋�� �}� t=�u��$ ��u0�ׅ�t*�ׅ��׋���׋�#��  ���3����׋�#��  �[��}�}� t	�u��  _��^������̋�U��S�]�# V�u�& W�u�( ���=� �t�u�� ���u�ׅ��׋���׋�����  ��  ��3���}�E�  �; t�u�$ ��u�׃# _��^[]� ����̋�U��V�u3��$ ��u"�5� �օ��֋���֋�����  ��  ���^]� ����̋�U��� VW��j3�Y�}��f��E�E�E�E�E���X  P�@ ��E�   f�E�P�U��� ��u3�_��^�� ����̃y u3�@�V��P  Vj h� ��HQ�h ��u�5� �օ���^���%��    �^�V�L ��t�j V�� ��t�3�^�����̋�U���VW�}�u3��E��E��� ��s
�W ��  S�u�( �=� �����u�  ���   j �H ���E���   �vP�L ��u4�ׅ��׋���׋�����  ��   �׋�����  ��u��P �{�u��P ���E�tYj j P�T ���E�tG��PjB�, ���M�t2P�( ���E�t$���N�H�N�H��P�u��u��T ��u�ׅ��e����׋��3��}� t+�u�$ ��u�ׅ�t�ׅ��׋���׋�����  �}� t%�u��X ��u�ׅ��׋���׋�����  �}� t-�E�0�$ ��u�ׅ�t�ׅ��׋���׋�����  ��[}�}���t
P�  �' _��^�� ����̋�U����EVW3��8�E���}��}�s
��E��z  S�p�VjB�u��, ;ǉEu�� �   P�( �� �����}�tL�u��΋u�u��������ȃ���D �����u�t!jjB�, ���M�tP�( ���E�u�Ӆ��Ӌ��*�Ӌ�����  ��  ���M���Q�P�I�p�H3��}� t/�u�$ ��u"�Ӆ�t�Ӆ��Ӌ���Ӌ�����  ��  ��} �=  t%�u�ׅ�t�Ӆ��Ӌ���Ӌ�����  ��  ��}� t1�E�0�$ ��u"�Ӆ�t�Ӆ��Ӌ���Ӌ�����  ��  ���}�}� t	�u��X �]���tP�׃# [_��^�� ����̋�U��QQ�e� V�u�& W�E�Pj�u�< ��u�E�   �E���PjB�, ���u*�5� �օ�	�֋��   �֋�����  ��  ��   SP�( ���=� �E��  �u�ׅ��׋��1�׋�����  ��#P�E�Pj �u�@ ������������@ ��}� t-�E�0�$ ��u�ׅ�t�ׅ��׋���׋�����  �[��}�}���t
P�  �' _��^�� ����̋�U��Q�E�e� �  �}Vr�u���N�j��Z��3��t
��E���   ����S�� �H;�Wrg��rbQj@�� ���E�t0�M��f�p�u��f�  �x�ʃ�P��4 ���M�u�Ӆ��Ӌ���Ӌ�����  ��  ��	3����E��}� t)�u��� ��t�Ӆ��Ӌ���Ӌ�����  ��  ���}�}���t
P�8 �' _[��^�� ����̋�U���(  ���MSV�uW�}3�SS�E��Ej�P��������������������� ;É�����������������v^h  ������P�������������� �������Q������Qj ����؅��l  �����������������������;�����r��������D PjB�, ���u*�=� �ׅ�	�׋��  �׋؁���  ��  ��  P�( ��3�;�u*�=� �ׅ�	�׋��   �׋؁���  ��  ��   �������H�N�F   ���H�N�H�N09�����vVh  ������PS�������� �������Q������Qj ����������Q������QV���������C;������4Fr��=� 3�f���t4�������0�$ ��u"�ׅ�t�ׅ��׋���׋؁���  ��  ���������}���t
P�  �& �M�_^��[������ ����̋�U��W�}3҃}�s��E��c�E���V�prO;MwJS3��;���C��+�E;�[t+�f9uf9Qu�   AA;�v��8u8Qu�   A;�v�3����E�^_]� ����̋�U����ESVW�u3ۉ�E�P�E�P���]��]�]��]��������;�� ��   �u�E��u���P�(�����3�;���   9E�u
��E��   9�h  �u���   9Ft	�ƉE��P�E�D �Pj@�� �E��E���P�u�P��Pj j �d ��u�Ӆ����X�Ӌ�����  ��  ��H�E��P���R��t)��P  P�u������������|"�u�3�@��h  ��d  �V�u���u�P���E���t^�x u)�u��� ��t�Ӆ��Ӌ���Ӌ�����  ��  ��u�$ ��u"�Ӆ�t�Ӆ��Ӌ���Ӌ�����  ��  ���}�}���t
P�  �' _��^[�� ����̋�U��Q�e� VW�u�}�u�' �E�P��������|�}� u��E���u��u��W�P _^�� ����̋�U���   ��S�]V�u�������MWQ�������E�3�������Q��P�Ή������������������������   ������  v
�z ���   �������������Q������Q���3�9E��@������PjB�, ���u"�5� �օ����q�֋�����  ��  ��a������P������P������P�>�����3�;�|'9Et_�����������������������ȃ��3������� t�3��������������}���t
P�  �# �M���_^[������ PP������������������j�QPP�� ����5� �օ��֋���֋�����  ��  ��y�������̋�V��F8��tP�� �f8 �f< �f@ �fD �v��tV� 3�^�����̋�U��Q�E�P���M�s��E��Y�e f�x V�tW�Pv4�z;�wBf�:u�J;�w5��}�����\  �J��H�E9M|̋E�ǀ`     3�_^�� ��E�������̋�U��V��t  t��E��^����P��u��E��L�F��� Ht;HHt0Ht-�Ny�f �E�@t�~ ujj�jj�������3��
��E��3�@^]� ����̋�U���SVW3��}쫫�3�F��3�9�`  f�u�f�E� �u�t9�\  t	u�jWj�M�Q�M�Q���PX;�| �E�f�p�}����u쥥��u���u����P\_^[������̋�U���S3�V��9�\  W�]��]��]�]�tj ����;�Yt.S�v���v�  �j�ί��;�YtS�v���v��  ���3�;�u4�E� �jj�������9]�t	�u��� ;�t�j����E�_^[�Ë��x!  ;ÉE���   ��M�QS���P;ÉE�|m�u�Sj�M�Q�M�Q���PX;ÉE�|Q��M�Q�M���Q���P;ÉE�}	�E�   �/j�  ��t��������u���u��Ή�h  ��d  �P\�E�9]��8���jj��� ����F�0�������̋�U��QQVWj �u��j�M�Q�M�Q���PX����| �u���u����P\����uf�}ujj�jj���������_^�� ����̋�U��QQSVW3�3ۋ�G9�t  �]��]�t
��E��   ����P��u
��E��   �F��� H��   HHtsHtp�F��tb<t^<tZ�jSj�M�Q�M�Q���PX��;�|W��p  S�u�N ���������|6��M��A�u���u����P\����u$j	j���������@ ����E��	�u��� ��_^[�� ����̋�U���SV3�9u�ىu��u�tUf�}uN�u�E�P�E�P����;�|`�u��jj�M�Q�MQ���PX;�|F�M��u�W�}�������ȃ��3�_��V�u�M�jQ�MQ���PX;�|�u��u���P\9u�t
�u������^[�� ����̋�U��V�u�JJ�@ �t#JtJt��u�V�P4��V�PD��V�P<��V�P8^]� ����̋�U��SV�u�F��Pj@���� ��t)�N��W�������j ��P��h*  ��s4�� _^[]� ����̋�U���ESV��t�uVj@�� ���C8t�C<�s@�sD�{8 u�z ���   � ���   �E9CDs
��E��   �u�ȋ���W�{<�ʃ��C<)CD�E�CDtd��t)�� ��C8��tlP�� ��t]�5� �օ�A�֋��K�s@��r�C8�H����r�P�z;�r;�v��E�뱋P���RL���3���֋�����  ��  ��c8 3��C<�C@�CD_��^[]� ����̋�U��V�uW�}�FPj@��� ���M�u	!� ��f�Uf��f�Uf�P��p3�_^]� ����̋�U��V�u3�����t�U�: tBNu���u�W ��U��t��|+Ή
��" ^]� ����̋�Vj ���� ���F0u�5� �օ���^���%��    �^Ë��U�����|>j0�S�����Yt
V���  �3���l  ���t�P�Q��  ��|	3�^ø �^�����̋�V3��P�����t	V� ����^�����̋�U���SVW�u�E�P3ۍE�P���]��]��]�]�������;�� ��   �u��E��u���P����������   �}� u
��E��   �u��~ u3��x�E������E���PjB�, ���M�t<P�( ���E�t.jY���M�3�VVQ��Q�u��p�E���QVV�� ��u�Ӆ��Ӌ���Ӌ�����  ��  ��}� �=$ t+�u�ׅ�u"�Ӆ�t�Ӆ��Ӌ���Ӌ�����  ��  ��}� t-�E�0�ׅ�u"�Ӆ�t�Ӆ��Ӌ���Ӌ�����  ��  ���}�}���t
P�  �' _��^[�� ����̋�U��Q�e� �} t�}���w�E�P�u�u�x�����W ��M��t��|�U����! �� ����̋�U��Q�E�e� ��} t=���w�M�QP�u�A�����W ��M��t��|	�U�҉��! �� ����̋�U���,  ��S�]V��3ɊKW��l  �E�3������������������N�;ȉ�������  �1  ����  �?�������QhH W�����  3��~9{u��������g  9�\  tj �D���;�Yt2W�v���v�  �j�(���;�YtW�v���v�*  �������������9������  �s���������S�P����   �N �����������h  ������R������R�P����   3�G;���   f������ t������P�  �����������tF������������ �������Wj ������Rf�������������������P�Q�������N S������������h  ������R������R�P���d����'�N ������v������� ���������|3�3�;�}jX�3�@P����������������t�P�Q��������t�j��M�_��^[藢���� ����̋�V��X  � ��t  � t��E�^Ã�u3�^Ë���P��u��E�^��5�G�  ��uڋ�������u��F��� HtHHtHt��^������E�^�3�@^�����̋�U��VW�}������@ �|'��~
��t#��u�F��tP� W���O���3�_^]� �W���PH������̋�U��} V�u�EP�u�   �ut�v�����"�����}�& 3�^]� ����̋�U����ESVW�u3��8�E�P�E�P�M�}��}��}�}������� ��;���   �u�}�M�W�u��E�P�k���������   �}� u
��E��   �} ��   �wVj@�� �����}���   �΋u�����3��ʃ��M�}������ȃ��}샿d   u/�u�����P��t!��P  P�u����!�������|Ǉd     �u��u����u�P$���}� ��   �u�$ ����   �Ӆ���   �Ӆ�j�Ӌ��t�Ӌ�����  ��  �뽍t?Vj@�� �Ѕ҉U�t/3��������΃��E�@PRj��u�j j �d ���+����Ӆ�����i����Ӌ�����  ��  ��}� t)�u��� ��t�Ӆ��Ӌ���Ӌ�����  ��  ���}�}���t
P�  �' _��^[�� ����̋�U��QQ�ESVW�u�}W�u3ۉ�E�P�M��]�������;��<  9]�u
��E��-  9]�� ��   Wj@�� ���E���   �u�ϋ}�����3��ʃ��M�}������ȃ���u�M��u���u�P(���}� ��   �u��� ��t}�Ӆ�g�Ӌ��q�Ӌ�����  ��  ��ˍ4?Vj@�� �Ѕ҉U�t-�u��R��j��u3�����j ��j ��d ���v����Ӆ�����z����Ӌ�����  ��  ���}3�}���t*P�  ��t�Ӆ��Ӌ���Ӌ�����  ��  ��' _��^[�� ����̋�U��QQSV3�W3���F9�t  �}��}�t��E��}����P��u��E��k�C��� HtQHH��  H��  3��Cj��P������C<t<�{  �E�xs0��E�jXPW���������|��}���}� t� _��^[�� �s4�p� ��u*�5� �օ�	�֋��  �֋�����  ��  ��   V�E�   �$ ������   ��	uW�E�P���������   ��uW�E�P���%����   ;5�GuhW�� ��s��� �3��7���W�( ��u�5� �W�    �$ ��uo�5� �օ�tc�օ��֋�3��^�֋�����  ��  ����uW�E�P��������'��G;�t;5�Gu3�;�����PW�E�P����������|��}�3���� ��������3�@������E���������̋�U��Q�e� SV3���F9�t  t
��E��  ����P��u
��E���  �C��� H��  HH��  H��  �u�Fu
�� ��  W��p  ��	u�v��V�E�P���\����`  ��u�v��V�E�P���t����D  ��u`�v��V�E�P�����������+  ����P���  �u��e �EP���"����u����  ��}	�e� ��   �E�E���   ;=�G��G��   ;���   �vj�, ���E���   P�( ��tQ�N���������ȃ���u��$ ����   �5� �օ�tx�օ��֋��n�֋�����  ��  ��\�5� �օ��֋���֋�����  ��  ��u��  �1����5� �3�;�������P�v��E�VP����������|3�_��l  ��t��p  �u��  ���� �jj���+����[��tS� ���E���^[�� ����̃y �� t
��Q�x ������jh� 覜����u�3��E�@ ��}��FP�l �M����E� � �E�3�@Ëe�}��M���u܅�u�F   !}���f �E�艜�������̋�V��F(��t
�P�Q�f( �f$ �f, ^�����̋�U��E�  S�]V�uWjY�h 3��u��S�P�ujY�H 3��u,9Ct'�sV�t �K(�E��{( t���P�QV�p �E� ���_%���^@ �[]� ����̋�U��E�� P�| ]� ����̋�U��V�������EtV�O���Y��^]� ����̋�S� V��W�~W�� ��3�����~W��3�����F$3�;�t�xP�� ;���u�_�^$�^(�^,^[�����̋�U��VW���wV� �}	u�   �3��}��H��@��E�g �G_^]� ����̋�U��U�E�" �x t�@�R�uP��9SV�uWjY�h 3��t�ujY�H 3��u��P�Q3���@ �_^[]� ����̋�U��V�uW�FP�| �~ ��t	�v�V�P��_^]� ����̋�U��V��������EtV�����Y��^]� ����̋�U��V�u�F��u
��� ��   �x, u
�@ ��   S�X$��u
��� ��   �Ef�8W�}u�~ tW�FP�  ��}x��������|m�E� P��������|[j�j �CPj�l ��tj	j�������@ ��5�~ t�^���F�G�F�G�Ef�8u
��VS�  3������3�_[^]� ����̋�U��M�I$�ɸj �t�Uf�f9t	�I��u��3�]� ����̋�U��S�]�{$ VWjj@u#�� ���C$u� ��1�uj��Y�C$��� ��t��ujY���K(�A�C,�C(3�_^[]� ����̸@ �� ����̸@ �� ����̸@ �� ����̋�V��F���� tP�� �f ^�����̋�U��ES�ىC����Pj@�� ���Cu� ��%�E��tV3�W�{�j��Y�@����u�_^3�[]� ����̋�U��E�  V�uWjY�h 3��t�ujY�X 3��u�M�ɉt
�Q�P3���@ �_^]� ����̋�U��E��P�| ]� ����̋�U��V�������EtV�G���Y��^]� ����̋�U��ES3�9Xt^�U;�u�}t	�@ ��M�9]tC�H;Hs;VW�} v'�H�p�}�E���4�jY��@�HC�M;HrӅ�_^t�3��3�@[]� ����̋�U��E�H�U�;Hr3�@��H3�]� ����̋�U��E�` 3�]� ����̋�U����M�H$3�� � �H �H(�@,   �H]� ����̋�U��V��~ t%W�~W�t �N(��t�u�u�9���W�p _^]� ����̋�U��V�uW�F P�` ����u��t	j��������_^]� ����̋�U��U3�W�A�A$�A(�A,�� �Q�y���3��y�����_]� ����̋�U��V�u�~ Wt	�F�P�Q�FP�` ����u	j���c�����_^]� ����̋�3�� � �H�H�H�H�����̋�U��V�uW�FP�` ����u��t	j���������_^]� ����̋�U��QQ�MV3��13��M�@QP�E�� ��}
� ��   S�]�CW�<��E����WP�Q���EtQ�s�ϋ������ȃ�j�軔����Yt���;������3���t�C�F�E�F�V�P�E�   ��e� �E��P�Q�E�0�E����%���_ �[^�� ����̋�V��~ WtG�~W�t �F(��t
�P�Q�f( j0�-�����Yt
V���3����3����F(t�P�QW�p 3�_^ø �������̋�U��EVW�}�' jH�ߓ����Yt���_������3���u� ���V�P�E�p,���p$�y�����|�73�_^]� ����̋�U����M�H�M�H3��  �H�H�H]� ����̋�V��F��� t
�P�Q�f ^�����̋�U��V�q���t	�P�Q�& �E�VjP�Q ^]� ����̃y �@ �t	�A�P�Q�����̋�U����A��U�R�U�RjP�Q��u�M�U�
��M�! �� ����̋�U��U��t�E��t
�A�Q3���W �]� ����̋�U��SW�}3�f9tJ9YVt �`�6W��  ��YYt-�����|��#���6W�  ��YYt�����|��3�C^_��[]� ����̋�U��3�9At�  �U;t&���� |��� �U;t����, |��3�@]� ����̋�U���u���u�u�=����b �  ��]� ����̋�U���\��f�e� �e� S�]V�uW�M�j�E�Y3��}��M�3��m������:  ��ug�]��2f�e� j �E�P�u��, �u����$�����u�E�P��������uG�E���P�9�����t��������=@  ��   �0  ��   �j$Y3����e� �������E�3��ʃ��M��E�P���������   �]����u�j �E�P3�Vf�}��, �M�V������uT�M��E�P������uD�E�;E�}T�E��0�E�9x�E�tWWj Sj�PWW�� ��~�jPS�3������E�$�E���$�M��E�P�S������u����3�3��M�_^[�)����� ����̃a 3������̋�U���u���u�u�x����b �b �4 ��]� ����̋�U���  ��f������ ������ S�]V�u������W�E�3���   ������󫋍����������||����   !�������Vf������ h  ������P�������, ���������5�����u%������P��������u������P�$����D Y��������P�2�����t�3��M�_^[������ �����������3����ʃ���   ������f������ h  ������PV�, ������V������u\������������P������uF������P舎���D Y�H9�����|I�3���ȋ������������ʃ��j�Y+�������������������P�_������Y����$����z ���������̋�U���u�u�l�����|�Q�Q�Q�Q]� ����̋Q�Ҹ@ �t�A�A�Q3������̋�U��Q�e� VW�E�P��� ����|�u����������E���t�P�Q_��^������̋�U��V���C����EtV藍��Y��^]� ����̋�U��SV��W�~���@ ���   �~ ��   �F�����H$;Nw~�8�M��~ tQ�E�]��P�FSj ���D�Pjj �d ��u"�� �Ӆ����4�Ӌ؁���  ��  ��$f�dC� 3���Fj ���D�P�u�u�������F�3�C��|0��t+�u���0������S����E�0���������?�����u�E�  �Ef�  _^��[]� ����̋�U��S�]V��~ W�@ ���   �~ t~�c�F� ��F��v�F�FP�u�u�D������|U�u����Y�L �F;�r3N+����Ft+�u���~�����u�3���������t�~s�3�G���E���|��u
�E�# f�  ��_^[]� �������%� �������%� �������%� �������%� �������%� �������%� �������%$ ���������������̋�U��E3ɉH�H� #Eg�@�����@�ܺ��@vT2]� ����������������̋�U��QS�]�CV�uW��������?��    ;��}�Cs�C����S��vN�7��@�E�rC�M�@   +�PQ�TR�����M����S�@   R+�E���S�M��  �u�E    �}�Et=��@r`���u��I �u�CP���   S��  �@   E)E�m�uًu�}�(��@r#�����E�d$ �EPS�V  �E@��@�mu��t�MVQ�TR�X�����_^[��]� ���������̋�U���L��3ŉE�SV�u�F�N�^X�����?��8W�N\�8   r�x   +�W�U�j R������W�E�PV�E������jSV�|�����V�F��Nj@�V\�F`�Ndj ��V������M���_^3�[�q�����]� ������������������̋�U��E�HXSVW�}��σ�?;ωHXs�@T��vF�>��@�Mr;�]�@   +�Q�SR�K����}�@   +�؋E��P��@P����z  �E3���]��@r$�����M�I S��@P�V  �E��@��@�mu��tW�SV�������_^[]� ��������������̋�U���L��3ŉE�S�]V�u�FXW��?�@   +���w��@�O�Q�U�j R�����FT�NX�����������E��ɉD=�W�E��P�V�L=��.����N@��VD�S�FH�C�NL�K�VPV�S�����M�_^3�[�������]� �������̋D$S�L$VW�PU�p�x�)��3�#�3�݋(�����3i#�3�������3Ëi#�3�������3Ëi#�3�������3Ƌi#�3�������3i#�3�������3Ëi#�3�������3Ëi#�3�������3Ƌi #�3�������3i$#�3�������3Ëi(#�3�������3Ëi,#�3�������3Ƌi0#�3�������3i4#�3�������3Ëi8#�3�������3Ëi<#�3��������#�#�ŋ)ŋ��y�Z؋����#�#�ŋi��y�Z����ǋ��#�#�ŋi ŋ��y�Z�����	�#�#�ŋi0ŋ��y�ZЋ����#�#�ŋiŋ��y�Z؋����#�#�ŋi��y�Z����ǋ��#�#�ŋi$ŋ��y�Z�����	�#�#�ŋi4ŋ��y�ZЋ����#�#�ŋiŋ��y�Z؋����#�#�ŋi��y�Z����ǋ��#�#�ŋi(��y�Z���	�ǋ��#�#�ŋi8ŋ��y�ZЋ����#�#�ŋiŋ��y�Z؋����#�#�ŋi��y�Z����ǋ��#�#�ŋi,ŋ��y�Z�����	�#�#�ŋi<ŋ)�y�ZЋ���3Ƌ)3�Łá��n؋���3i 3�Łǡ��n���	�ǋi3ơ��n3�ŋ������3�Q03�¡��n�����3�A�Ɓš��n3�����i(3Áǡ��n����	�i��3�3Áơ��nŋ������3�Q83�¡��n�����3�A�á��n�����3i$3Áǡ��n����	��3i3Áơ��nŋ������Q43Ɓ¡��n3������3�A�á��n���3i,��3Áǡ��nŋi���	��3�3Áơ��n������3Ëi<3Ɓ¡��n�ЋD$���ًH�ыH�]�H�P��p�x_^[� �������VWSU�t$��@  �   �<$󥋬$T  �L$�    �A��Y��1�y3�3ߋq�y3�3ߋq,�y03ƃ���3��ÉA0J�Y4u͋E �]�M�U�}��3�#������4$��3��ˍ�>�y�Z���3����#���ȋl$��3��y�Z���3�#����΋t$��3��ύ��y�Z͋�3�����#���ʋl$��3����y�Z���3�#����Ƌt$��3��ɍ��y�Zŋ�3����#���ˋl$��3�=�y�Z���3�#����֋t$��3��ȍ��y�ZՋ�3����#���ϋl$��3��y�Z���3�#����ދt$ ��3��ʍ��y�Z݋�3�����#���ɋl$$��3����y�Z���3�#������t$(��3��ˍ�>�y�Z���3����#���ȋl$,��3��y�Z���3�#����΋t$0��3��ύ��y�Z͋�3�����#���ʋl$4��3����y�Z���3�#����Ƌt$8��3��ɍ��y�Zŋ�3����#���ˋl$<��3�=�y�Z���3�#����֋t$@��3��ȍ��y�ZՋ�3����#���ϋl$D��3��y�Z���3�#����ދt$H��3��ʍ��y�Z݋�3�����#���ɋl$L��3����y�Z���3�3��������ˋt$P��=���n���3�3��������ȋt$T�����n���3�3��������ϋt$X�����n���3�3��������ʋt$\�����n���3�3��������ɋt$`�����n���3�3��������ˋt$d��=���n���3�3��������ȋt$h�����n���3�3��������ϋt$l�����n���3�3��������ʋt$p�����n���3�3��������ɋt$t�����n���3�3��������ˋt$x��=���n���3�3��������ȋt$|�����n���3�3��������ϋ�$�   �����n���3�3��������ʋ�$�   �����n���3�3��������ɋ�$�   �����n���3�3��������ˋ�$�   ��=���n���3�3��������ȋ�$�   �����n���3�3��������ϋ�$�   �����n���3�3��������ʋ�$�   �����n���3�3��������ɋ�$�   �����n��Ƌ�����#����$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ������#ꋴ$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ������#ꋴ$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ������#ꋴ$�   ���#��ܼ��������������#鋴$�   ֋�#��ܼ������֋������#담$�   ΋�#���ܼ������΋������#苴$�   ދ�#���ܼ������ދ������#$�   Ƌ�#�ܼ������Ƌ�3�3��������ˋ�$�   ��=��bʋ��3�3��������ȋ�$�   ����bʋ��3�3��������ϋ�$�   ����bʋ��3�3��������ʋ�$�   ����bʋ��3�3��������ɋ�$   ����bʋ��3�3��������ˋ�$  ��=��bʋ��3�3��������ȋ�$  ����bʋ��3�3��������ϋ�$  ����bʋ��3�3��������ʋ�$  ����bʋ��3�3��������ɋ�$  ����bʋ��3�3��������ˋ�$  ��=��bʋ��3�3��������ȋ�$  ����bʋ��3�3��������ϋ�$   ����bʋ��3�3��������ʋ�$$  ����bʋ��3�3��������ɋ�$(  ����bʋ��3�3��������ˋ�$,  ��=��bʋ��3�3��������ȋ�$0  ����bʋ��3�3��������ϋ�$4  ����bʋ��3�3��������ʋ�$8  ����bʋ��3�3��������ɋ�$<  ��b��Ƌ�$T  ��@  �.ŋn݋n͋nՋn���^�N�V�~][_^� ��̔�  ��������n�  �  �  ���������     p�  ��������L `  @�  ��������l 0  ��  ��������� �  D�  ��������" 4  d�          . T  P�  ��������� @  ��  ��������j x  ��  ��������� x  �  ���������   ��  ��������	 �  4�  ���������	 $                      6 H \ �  ��  ��  ��  ��  ��  ��  ��      Z � � � � � � � � r `     H 2  r � � � � � � � � � � *�  @�  N�  `�   ��  ��  ��  ��  � ��  ��  ��  �  �  (�  <�  L�  \�  l�  ��  ��  ��  ��  ��  � ��  ��        8  P  `  p  ~  �  �  �  �  �  �     :  � ~ n ` * > p�  ��  T     � � � � �    , @ Z �     � 	     h ~ � � � � \ N 2 "  � � � � � � � v  * > L \ n � � � � � �     � 
     : H b r       �  �  �
  �  �o  �t  �s  �    � v     ,    
   � z�  \�  N�  >�  .�  �  �  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  p�  `�  P�  F�  <�      � � "	 :	 L	 `	 n	     �	     9wcslen  3wcschr   ??3@YAXPAX@Z   ??2@YAPAXI@Z  �_resetstkoflw � _except_handler3  �free  �realloc �malloc  �rand  <wcsncpy � _c_exit � _exit O _XcptFilter � _cexit  �exit  � _acmdln r __getmainargs B_initterm � __setusermatherr  � _adjust_fdiv  � __p__commode  � __p__fmode  � __set_app_type  msvcrt.dll  � _controlfp   AllocateAndInitializeSid  �RegCloseKey �RegQueryValueExW  �RegOpenKeyExW ?SetSecurityInfo +SetEntriesInAclW  GetSecurityInfo @IsValidSid  ADVAPI32.dll  �WaitForSingleObject 4 CloseHandle rUnmapViewOfFile sGetLocalTime  �GetProcAddress  �GetModuleHandleW  )InterlockedExchange FGetCurrentThreadId  CGetCurrentProcessId hMapViewOfFile U CreateFileMappingW  XLocalAlloc  qGetLastError  \LocalFree BGetCurrentProcess �ReleaseMutex  )SetLastError  a CreateMutexW  �WideCharToMultiByte �GetTickCount  �GetOverlappedResult �WriteFile �ReadFile  * CancelIo  �WaitForMultipleObjects  �ResetEvent  �PulseEvent  ~OpenEventW  SetEvent  �WaitForMultipleObjectsEx  �ProcessIdToSessionId  P CreateEventW  o CreateThread  �GlobalFree  
GlobalUnlock  GlobalLock  �GlobalAlloc � ExitThread  �QueryPerformanceCounter �GetSystemTimeAsFileTime _TerminateProcess  oUnhandledExceptionFilter  KSetUnhandledExceptionFilter �GetStartupInfoA KERNEL32.dll  �GetStockObject  GDI32.dll PostMessageW  � DispatchMessageW  �TranslateMessage  >GetMessageW �ShowWindow  PostQuitMessage � DestroyWindow � DefWindowProcW  a CreateWindowExW RegisterClassW  PeekMessageW  �MsgWaitForMultipleObjects �LoadStringW �IsWindow  KSetClipboardViewer  GetClipboardViewer   ChangeClipboardChain  @SendMessageW  �SetWindowLongW  oGetWindowLongW  USER32.dll  5 WinStationQueryInformationW N WinStationVirtualOpen WINSTA.dll  WSOCK32.dll 6 WSARecvFrom  WSAGetOverlappedResult   WSACloseEvent  WSACreateEvent  WS2_32.dll   acmDriverClose  $ acmStreamClose   acmFormatSuggest  ' acmStreamOpen 	 acmDriverOpen  acmFormatTagDetailsW   acmDriverEnum + acmStreamUnprepareHeader  % acmStreamConvert  ( acmStreamPrepareHeader  * acmStreamSize MSACM32.dll  WTSUnRegisterSessionNotification   WTSRegisterSessionNotification  WTSAPI32.dll  OleUninitialize � OleInitialize ole32.dll �memcpy  �memset  �_purecall >wcsrchr 8_wcsnicmp 4wcscmp  �RegCreateKeyExA �RegQueryValueExA  RegSetValueExA  RLoadLibraryA  �GetVersionExA � DeviceIoControl HeapFree  � FreeEnvironmentStringsA � FreeEnvironmentStringsW �lstrlenA  �lstrlenW  UGetEnvironmentStrings WGetEnvironmentStringsW  MGetDiskFreeSpaceA GlobalMemoryStatus  HeapAlloc �GetProcessHeap  #InitializeCriticalSection QLeaveCriticalSection  � EnterCriticalSection  � DeleteCriticalSection ,InterlockedIncrement  GlobalSize  N CreateDirectoryW  � DeleteFileW �GetTempFileNameW  uMultiByteToWideChar (InterlockedDecrement  � DeleteMetaFile  �GetMetaFileBitsEx  CloseMetaFile �PlayMetaFile  D CreateMetaFileW .SetMetaFileBitsEx �GetPaletteEntries �GetObjectW  � DeleteObject  E CreatePalette RegisterClipboardFormatW  �UnregisterClassW  �LoadCursorW �UpdateWindow  B CloseClipboard  JSetClipboardData  � EmptyClipboard  �OpenClipboard �IsClipboardFormatAvailable  GetClipboardData  GetClipboardFormatNameW � SHFileOperationW  # DragQueryFileW  SHELL32.dll � OleIsCurrentClipboard OleSetClipboard ReleaseStgMedium  . CoGetMalloc � OleGetClipboard  CopyStgMedium urlmon.dll                                                                                                               "V  D�        "V  D�        "V  'W      �      �    � @ �   �0���  "V  �V     �  +  "V        "V  "V        +  "V        "V  "V        @  �>        @  �>        +  ,      �      �    � @ �   �0���  +  �+     �  "V  �+      �      �    � @ �   �0���  "V  \+     �  +  +        +  +        @          �      �    � @ �   �0���  @  �     �  @  @        @  @      U  "V  X          �  qU  �>  X          �  qU  "V  p          �  qU  �>  p          �  q  +        �      �    � @ �   �0���  +  �     �U  "V  �          �  qU  �>  �          �  q1  "V  ~  A    @  @         �      �    � @ �   �0���  @  �     �a "V  �  �  /     �   F6DC9830-BC79-11d2-A9D0-006097926036 U  �>  �          �  qU  �.  �          �  qU  +  �          �  qU  @  �            qU  "V  �          h  qU  �>  �          �  qU  �.  �          �  qU  +  �          �  qU  @  �          �  qU  "V  �          N  qU  �>  �          l  qa "V  �	  u  /      u   F6DC9830-BC79-11d2-A9D0-006097926036 a "V  �	  u  /      u   F6DC9830-BC79-11d2-A9D0-006097926036 U  �.  �	          �  qU  +  �	           qU  @  �	          h qU  �>  �	          �  qU  �.  �	          �  qU  +  �	           qU  �.  �          � qU  +  �          � qU  @  �          � qU  �>  �          D qU  �.  �          � qU  +  �          � q1  +  �  A    @a �>  �  @  /      @   F6DC9830-BC79-11d2-A9D0-006097926036 U  �>  �          H  qU  �.  �          `  qU  +  �          h  qU  @  �          �  q1  @  Y  A    @a @  �  `  /      `   F6DC9830-BC79-11d2-A9D0-006097926036 a +  �  :  /      :   F6DC9830-BC79-11d2-A9D0-006097926036 "  @  +        �                             a +  �  /  /      /   F6DC9830-BC79-11d2-A9D0-006097926036 a @  �  @  /      @   F6DC9830-BC79-11d2-A9D0-006097926036 U  �.  �          0  qU  +  �          4  qU  @  �          H  qB  @        
  Κ2���ެa @  �  0  /      0   F6DC9830-BC79-11d2-A9D0-006097926036 B  @  �     
  Κ2���ެ    
   ����      �����     � � � p \ �D��@�             Pw ��       ( � � h  � x 0 � � | @   � � P  � � 0  ����      � � � � � P 4  � � � l       � � � � � P 4  � � � l � X , � � �                                                                                                                                                                                                                                                                                                                  �   8  �                  P  �                  h  �               	  �                  	  �   (T \           �P �          �4   V S _ V E R S I O N _ I N F O     ���     w�  w�?                        �   S t r i n g F i l e I n f o   �   0 4 0 9 0 4 B 0   L   C o m p a n y N a m e     M i c r o s o f t   C o r p o r a t i o n   J   F i l e D e s c r i p t i o n     R D P   C l i p   M o n i t o r     t *  F i l e V e r s i o n     5 . 2 . 3 7 9 0 . 3 9 5 9   ( s r v 0 3 _ s p 2 _ r t m . 0 7 0 2 1 6 - 1 7 1 0 )   0   I n t e r n a l N a m e   R D P C l i p   � .  L e g a l C o p y r i g h t   �   M i c r o s o f t   C o r p o r a t i o n .   A l l   r i g h t s   r e s e r v e d .   @   O r i g i n a l F i l e n a m e   R D P C l i p . e x e   j %  P r o d u c t N a m e     M i c r o s o f t �   W i n d o w s �   O p e r a t i n g   S y s t e m     @   P r o d u c t V e r s i o n   5 . 2 . 3 7 9 0 . 3 9 5 9   D    V a r F i l e I n f o     $    T r a n s l a t i o n     	�             P r e p a r i n g   p a s t e   i n f o r m a t i o n . . .                                                                                                                                                                                                                                                                                                                                                                                                                    � 0   ��
 R D P C L I P 6 4         	        MZ�       ��  �       @                                   �   � �	�!�L�!This program cannot be run in DOS mode.
$       ]�Ř����������������o-�����o-�����o-�����o-�����ڿ�����o-�����Rich���                        PE  d� œ�E        � #   h  P     ��                             �    �   �                                            �b    � �   � �                  p                                                @                          .text   6g     h                   `.data   �5  �     l             @  �.pdata  �   �     r             @  @.rsrc   �   �     �             @  @                                                                                                                                                                                                                                                                                                                                                                                 s     s     &s     �k     �k     �k     �k     ~k     jk     \k     @k             >o     �u     �u     zu     fu     Ru     @u     0u      u     u     �t             �t     �t     �t     t     *t     <t     Xt     pt     �t     8s     Hs     Xs     js     vs     �k     �k     l     l     �s     :l     Nl     dl     �t     zl     �l     �l     �l     �l     �l     �l     �l     �l     m     $m     4m     Jm     Vm     bm     nm     �s     �m     �m     �m     �m     �m     �m     n     n      n     0n     >n     Ln     Zn     tn     �n     �n     �n     �n     �n     
o     o     �t     �s     �s     t     �s     (l     |m     �s             �q     �q     �q     �q     �q     �q     �q     r     (r     Br     xq             �v     �v             2p     @p     Lp     bp     xp     �p     �p     �p     p     p     �o     �o     �o     �o     �o     �o     �o     ~o     jo     Zo     �u     �u     �u     �u     �u     
v     v     .v     >v     \v     pv             �p     �p             0q     Zq     Jq     "q             
      �      �      �t      �s      �      �      �o      �        ^r     �r             �r     �r     "k     �r     k     �j     �j     �j     �j     �j     �j     �j     �j     �j     �j     �j     �j     zj     pj     hj     Xj     @j     .j     j     j     
j      j     k             �r     �r     �v     �v     �v     �v     w             w                     ��                                         œ�E       $   �#  �      TSSNDD::FATAL -         TSSNDD::ERR -   TSSNDD::WRN -   TSSNDD::INF -   TSSNDD::ALV -   ��      �              �     0y     ��     �z     �z     �z     Д      {     �{      }     �}     ~     �~           �     ��     ��     �     �    ��     Љ     p�     ��     ��     0�    Ў    GetMessageTime  GetCursorPos    user32.dll      RtlInitUnicodeString    NtOpenFile      NtQuerySystemInformation        n t d l l . d l l       \ D e v i c e \ K s e c D D     SOFTWARE\Microsoft\Cryptography\RNG Seed        v"    :       \ \ t s c l i e n t \                                      C B _ S T A T E _ R E C O V E R I N G   C B _ S T A T E _ E X P E C T I N G _ F O R M A T _ D A T A _ R E S P O N S E   C B _ S T A T E _ E X P E C T I N G _ F O R M A T _ L I S T _ R E S P O N S E   C B _ S T A T E _ S H A R E D _ C L I P B O A R D _ O W N E R   C B _ S T A T E _ L O C A L _ C L I P B O A R D _ O W N E R     C B _ S T A T E _ C L I E N T _ I N I T I A T I O N     C B _ S T A T E _ S E R V E R _ I N I T I A T I O N     C B _ E V E N T _ C L I P B O A R D _ T E R M I N A T E D       C B _ E V E N T _ D A T A _ P A T H _ D I S C O N N E C T E D   C B _ E V E N T _ D A T A _ P A T H _ C O N N E C T E D         C B _ E V E N T _ C L I P B O A R D _ I N I T I A L I Z E D     C B _ E V E N T _ R E N D E R _ F O R M A T     C B _ E V E N T _ I N V A L I D _ D A T A _ R E C E I V E D     C B _ E V E N T _ L O C A L _ C L I P B O A R D _ U P D A T E D                 C B _ E V E N T _ F O R M A T _ D A T A _ R E S P O N S E _ R E C E I V E D     C B _ E V E N T _ F O R M A T _ D A T A _ R E Q U E S T _ R E C E I V E D       C B _ E V E N T _ F O R M A T _ L I S T _ R E S P O N S E _ R E C E I V E D     C B _ E V E N T _ F O R M A T _ L I S T _ R E C E I V E D       C B _ E V E N T _ C A P A B I L I T I E S _ R E C E I V E D     C B _ E V E N T _ M O N I T O R _ R E A D Y _ R E C E I V E D   C B _ E V E N T _ T E M P _ D I R E C T O R Y _ R E C E I V E D         T e r m i n a l   S e r v i c e s   P r i v a t e   D a t a     P r e f e r r e d   D r o p E f f e c t         F i l e N a m e W       F i l e N a m e                 P�     ��     v"    v"    v"    v"    v"    v"    v"    v"    v"    v"    ��     �     0�     ��     ��     �     �    p�     ��     p�     ��     v"    R D P C l i p b o a r d W i n d o w C l a s s   _ T S   p    �    `        �    �    �         �	          
    �                       �    �    �    `    �               �   �   �             �   �   �      S h e l l   O b j e c t   O f f s e t s         S h e l l   I D L i s t   A r r a y     O b j e c t   D e s c r i p t o r       F i l e G r o u p D e s c r i p t o r W         F i l e G r o u p D e s c r i p t o r   F i l e C o n t e n t s         E m b e d d e d   O b j e c t   E m b e d   S o u r c e         L i n k   S o u r c e   D e s c r i p t o r     L i n k   S o u r c e   D a t a O b j e c t     O l e   P r i v a t e   D a t a         O b j e c t L i n k     O w n e r L i n k       L i n k              v"    @    v"    v"         P    @    `    �                  �     @          �      F      �      F        �      FRSDS8�+��FA�����   rdpclip.pdb                             H��(H��a H��t�"���H��a     3�H��(���������L��H���
  H�7_ H��$�
  I�s�H��I�{�L�� 3�3�3��Q���H�za ����H�ma H����   ��~��  ����]  H��$�
  ��p  L�\$0L�\$(�   L�L$@�����3�D���D$ h
  �
p  ����   �@  �o  H����   H��H��$�
  �%]  H��H����   ��$�   �uH�H�������   ��$�   �-�` �u5�(S  ��` ��E͉�` �#=�   �B��������H�=�` �   ��` 9=�` tH�H���PH�����t+H����(  Hc��=V`  t�'  �=L`  t	H�H���P��o  H���PS  H���n  H��$�
  H�` H��$�
  H��t�N���H��_     H��$�
  ��H��$�
  H��$�
  �L H���
  �����������������������L��L�эA� tAA� ���ff�ff�ff�A�IA�ȁ��  ~��  �A;�AL�fA�
I��I�����u��  �������������L��L�эA� tAA� ���ff�ff�ff�A�IA�ȁ��  ~��  �A;�AL�fA�
I��I�����u��  �������������L�ɍ�    A� t�I��H�����fA�A��A�fA�A�u��  �������������i�@  �;�7�H�|$ ��L��H��D��A�    A��toH�\$H�t$� ���A��ff�fff�A�IA�ȁ��  ~��  �;�L�A��D�  ��Mbf�H��A����	��M�Qi�����D�H��u�H�t$H�\$H�|$ C�A� ��������������i��.  �;�7�H�|$ ��L��H��D��A�    A��toH�\$H�t$� ���A��ff�fff�A�IA�ȁ��  ~��  �;�L�A��D�  ��vf�H��A������M�Qi� ���D�H��u�H�t$H�\$H�|$ C�A� ��������������iҀ>  �;�7�H�|$ ��L��H��D��A�    A��toH�\$H�t$� ���A��ff�fff�A�IA�ȁ��  ~��  �;�L�A��D�  ��Mbf�H��A����
��M�Qi�����D�H��u�H�t$H�\$H�|$ C�A� ��������������HSi�@  �;�7�L����A�    D��A��tJA��fff�fff�fff��A��D�  I��fA�B��AfA�B���MbA����	��H�Qi�����D�H��u�B��    A� [���������HSi��.  �;�7�L����A�    D��A��tJA��fff�fff�fff��A��D�  I��fA�B��AfA�B���vA������H�Qi� ���D�H��u�B��    A� [���������HSiҀ>  �;�7�L����A�    D��A��tJA��fff�fff�fff��A��D�  I��fA�B��AfA�B���MbA����
��H�Qi�����D�H��u�B��    A� [���������L��H��   H��X H��$�   I�[I�{ H��H�L$ ����j  H��[ H�L$ A�$   ��[ �s|  H��$�   H�L$ �Q}  L��$�   H��$�   L�H��$�   H��$�   � H�Ĩ   ������������������L��H���   H�X H��$�   I�[�I�k�I�s�H��I�{�H�L$ A��I�����2j  H�[ H�L$ A�$   �*[ ��{  H�L$ D��H���{  H��$�   H�L$ �|  L��$�   H��$�   H��$�   H��$�   L�] H��$�   H��$�   �J H���   �������������������HSH�� �������+��ȸ   �� �  w��Dȋ���� ��u��� ��V H�� [Í@k�ȸ����������V �W� H�� [����������H��(H��� H��uL�� ������%h  H��H�u� 3�H����H��(���������H��(H�U� H��t#�B���E3�L�@� D�E� D�:� H��(�E3�D�/� D�$� H��(��������H��H��hH�XH�hH�pH�x L�`�L�%�� M���H��   u3���3�ff�fff���tpH�D$8L�L$0D��H��I��H�l$PH�D$ �l$H�l$L�9�������u*�����=�  uD�KL�D$0H�T$8I�������؅�t�D$0+�H���u���������L�d$`H��$�   H��$�   H�l$xH�\$pH��h�������D�L$ L�D$�T$H�L$UH��   H�l$0H�]xH�upH�}hL�e`L�mXL�uPL�}HH�%U H�E0E��M����L��E3�A��E��tqH�GH���� H+�H�t$0H�u�-����E3�I��L�eD���   L���   ���   L���   ��H����   ��D��I��H���e  E�D�3E�&L����   H�5V� H��uA���n��tjL�e(D�e D�e$H�EH�D$ L�M D��I��H��������؅�u$�d���=�  uD�KL�E H�UH��������؅�t
�E +�L���2�����u���tA��I�������؋�H�M0�� H�]xH�upH�}hL�e`L�mXL�uPL�}HH���   ]��������������HUATH��8H�j0H�E3�8�  �A��A��A��H��8A\]�������HSH�� H�S� H��t+L�O� H��V E3����������u�{�����H�� [�3�H�� [������������H��H��hH�XH�hL�p�L�x�E3�L��A��H��H9-�� �  H�pH�x L�`�L�h�L�)V H�r� f��C����   H��� A�   A��D+�H��L�,A����   H�D$0H���=  ��� ��ufL�D$ L�u� A�@  L�5�U D�=�U D�=�U ������������=�  uA���c��u�~���D�=/� �I3�������� ��t7�� A;�A��B�H��� I��H�D����b  5�� )5�� �   uD�=�� H�D$0H��E���|  k�{9{sKH�KH��uH�������H���H�������H��H��uH�KH��t�����H��H�{�s  �{�{�C;���   H�Y� L��+�LkH��A��E����   H�D$0H���:  �5� ��utH��T L�#� H��� A�@  L�5T D�=pT H�D$ D�=hT ��������6���=�  uA���e��u� ���D�=�� �K3��/������ ��t9��� ;�D��DB�H�O� I��H�E���a  D%�� D)%�� �   uD�=�� H�D$0H��AE��tlk�C9CtwH�� L��S ���������=�  tD�{A��L�d$`H��$�   H��$�   L�l$XL�|$HL�t$PH�l$xH�\$pH��h�D�{���C���=�  t�D�{D�{뭸   �A���������HSH�� 3�H9�� t4H9`S t+H��� H��t�0u  �����=  t�   =�   Eً�H�� [��������������������HSH�� H��� �   �����3Ʌ�Dً�H�� [����������HSH��	  H�hO H��$p	  H�O H���u4�   E3��������H���H��N u�����H��N H����)  H�L$DL�L$@3�H�L$ ���  A�   H�ȉ\$@�D$D   �&����D$@A� �  A;�DB�A���A���   D�\$@s��N ���N D;�ABÉxN 3�H�D$HL�L$PH�D$(D�A������D$ �  ��_  ����   ��$�  ��$�  �7N usH�\$8H��$P	  H�\$0L��$�  A�����3�3��D$(    ��$P	  H�D$ �s���H��$P	  �M������t"��� H��$p	  �� H�Ā	  [�����H��$p	  �� H�Ā	  [���������H��(��H�\$@H�|$H��H��t�����H�Ã���C�u�H�|$HH�\$@H��(����������HSH��0H�D$XH�n
 3�A�  E3�H��  �H�D$ �D$H����H�\$X�������D  H�L$XH�D$@L�L$PH�D$(H�D$HH��	 E3��D$P   �D$@   H�D$ �������L ��H�D$@L�L$PDL$HH�D$(H�D$H��L H�L$XH��	 E3�H�D$ ������#� L�L$P��H�D$@H�D	 DL$HH�D$(H�D$H��� H�L$XE3�H�D$ �\������ ��H�D$@L�L$PDL$HH�D$(H�D$H��� H�L$XH�� E3�H�D$ ������� L�L$P��H�D$@H�� DL$HH�D$(H�D$H��� H�L$XE3�H�D$ �������u�L$H��K ;�s���   C���K H�L$XH�D$@L�L$PH�D$(H�� E3�H�\$ �\$@�����=�   ��   �|$P��   H�� H��t������L$@�������H#������H��H��� tkD�D$@L�L$PH�� A��I��B��H�L$XH�D$@H�D$(H��� E3�H�D$ ������tH��� �Q���H��� ��� �
�D$@�x� H�L$XH��t�����H��0[�������������������H�L$UH��   H�l$ H�]xH���   H���   L�eXL�mPL�uHH��J H�E0H��3�H�E H�EH�EE3�E��H����  �$�   H+�H�t$ �H�u(������E3�I��L�m(H�]pD��H���|  A�   H��fff��R����H��A���u��f�F��x���f�Ff�F �   H���������u�����)  fff�ff�ff�D�mD�mH��H�M ��������   fff������=�  ujH�]H��� H�E A��  E3�H�UA�H����=  tq��tlH�Z� H��t!E3�L�S� H��L �������u�����H��������
�s�����uVH��H�M �������k����} �A���f�}v9�5���H��� H��t�������t��  �D���H���{����(����� H�]H���H�]�7���D���CD+�A��E��t H�E�@H��Hi��  A��3�H��X�A��H�MH��t�������H�M0� H�]xH���   H���   L�eXL�mPL�uHH�e`]������������HUAUH��(H�j H�E3�8�  �A��A��A��H��(A]]�������H��H��XH�XH�hH�pH�x 3�L�`�L��H��I��H�H�E3�I��H�x�H��H�x�I�9�Y  ����  H�T$@�D$8   H�|$0H�L$HM��L��H�|$(f� f�F �F"V  �F�X f�F f�F f�^H�|$ �6Y  ��u�{�9  H�L$@A�   L��I���D$    � Y  ���  f�~�  �Nf��t
f����   �F=@  t =+  t=�.  t=�>  t="V  ��   f��uP=@  t@=+  t0=�.  t =�>  t="V  ukH�����bH������YH�C����PH������GH������>=@  t0=+  t =�.  t=�>  u"H�l����H������H�
����H�Q���H�T$@�D$8   H�|$0H�L$HM��L��H�|$(H�|$ ��W  ���   D�H�L$HL�d$PH�t$pH��t3��W  H�L$@H��t3��W  H�] H�l$hH�\$`��H�|$xH��X����������������������L��H���   H��E H��$�   I�[ A��I�{���H��H�ل�uA��E����   �BH�T$@A�   H��$�   �D$@x   �D$P    �D$H�@W  ��uML�L$ L�D$(H�WH���8�����t3H�_3�H��$�   H��$�   H��$  H��$�   �)  H���   ø   �̸   ���������������������H��8H�\$@H�P� H�t$P3�H��H�|$XH����   H�l$H�)L�d$0D�fff�fff�f9kuU�Gf9CuK�G9CuC�G9Cu;�Gf9Cu1�Gf9Cu'�C f;GuH�WH�K"D��E��D�d$ �U  ��t(H�H��u���H�l$HL�d$0H�|$XH�t$PH�\$@H��8�H9stA����H�K���E3�H����U  ��u�H9sAE���H�|$XH�\$@��H�t$PH��8�����������L�� H�|$ �����M��D��D��tH�\$��� E3���H�t$tX�5�� ff�fff�I�9 t.D;�A��t���QA��k�Z��I���9PwE���I�D9XvA��I��D;�r��	E��A���u��DE�H�\$H�t$H�|$ A���������������H��(H�}� H��t3���T  H�f�     H�W� H��t3��T  H�@�     H��(������������H��H���   H�pH�x L�`�3�L�h�L�p�L�x�H�� I��H��M��D��L��t$$D��t$ �t$(tL�D$,��D�l$,H��� L�D$(E3�A��H��$�   H��$�   �|T  ��t
��5�� �x��� H�� L�D$ H��A�   �QH��� �BT  ��t
��5�� �>H�K� �Q� H���A�L$(�A;�L$(�"  A��-Q� 9l$ F�-D� 3�H�L$0D�B|�R  ��A��D$0|   H�|$XH�SE �\$`��   �t$ ��I�֋�H�+�D�ǋ��R  H�(E H�T$0H�L$@H��� E3�L�D+�t$H�sS  ����  H��� D�@H�T$0�JS  H��� H�T$0E3����(S  ��u0D�d$dH�|$X�\$`3�I�A+܉\$`�t$LH�|$X�t$dH��D ��\$`H�|$X3�H��D D;l$ sE��I��H��D�-=� ��Q  �   ��   H�� H�T$0E3�L�t$@D�l$H�t$4�R  ����   �D$H�L$ ;�v\H��� H�T$0A�   �{R  ����   �L$d�T$L�D$HL�L$@HL$X)L$`D�L$ +�L�;��t$L�D$H�t$dL�L$@w��L�L$@�ɾ   tH��C D��I�щ{� �Q  H�_� 3�H�T$0E3�L�t$@H�|$XD�l$H�D$L�\$`�D$d��Q  ��t$$�A��� L��$�   L��$�   H��$�   H��$�   H��$�   E�'L��$�   L��$�   ��H��$�   H���   ��������������������H��(H�=|�  tTH�=�B  tJH�a� H��t>�0u  �!���=  t,=�   t%H��B 3ɉH�I� �K� H�$� �f���H��(����������D�D$�L$UH��   H�l$0H��  H���  H���  L���  L���  L���  L���  H��> H���  A��H��D��H�UE3�=�> rl�O� �����H�M0��P  �B E�D$$H��A H�M0�b  H���  H�M0�oc  L���  A�T$H���   �We  L�Ƌ�H���   ���  ��> H��H����R�  H+�L�l$0L�m�!�V���E3�M��L�e��  D��   H�uM����   �   �	   9�= C�A�E � � fA�E�)���fA�E�j� ��A���A�Mf�E �D� f�E�>� �E����   M�Mff��ߋX= H�CH;�r�Y�CfA�ED��D��H��I���AN  D�{�D$(   H�EH�D$ E3�E��I��H�= ��������tD�=�� I�+�M�Mu��������A�   A��H���  ���  H��  H���  H���  L���  L���  L���  L���  H���  ]���������HUATH��8H�j0H�E3�8�  �A��A��A��H��8A\]�������D�D$�L$UH��   H�l$0H���   H�uhH�}`L�eXL�mPL�uHL�}@H�\< H�E0E��H��H�U3�D���< H�AH����N�  H+�H�t$0H�u�#�R���3�H��H�]D��H�}��; D���   H����  D�a�3�A��A��D��A��H�H�E�-����Ef�E  �]� f�M"�W� �M$E����   �
���   �NE����   H�FA�T$�U E��fff�ff�ff�H��D����   r������H���A����H��M��H���-L  �D$(   H�E H�D$ E3�E��H��H��: ��������tI���A;�H�F�U r�D���   �E��p����   �fD�vf�F�� f�F��� �����   ȉNH�]+�D��H�NH���K  D�C�D$(   H�E H�D$ E3�H��H�`: ��������u������C�nA�L��� A�   A��H�M0�T�  H���   H�uhH�}`L�eXL�mPL�uHL�}@H�ep]����������������HSUH��8H�j0H�3ہ8�  ��ËË�H��8][�������������H��8�� H�\$PH�|$XA��H���D$ f�D$&�L$(�)���f�D$$�CH�L$ D��L�Ǻ   f�D$"�O����L$"H�|$X������ ��u�������H�\$PH��8���������������������H��H��   H�h�H�p�H�x�L�`�L�h�E3�H��A��M��L�h�L�hL�h���H��u�AW��   H�D$HE3�H��$�   H�D$8H�D$@L�l$0H�D$(E�AL�l$ �����������   L�D$@H�D$PH�D$XH�D$hH�D$xH�D$`H�D$p��$�   L��$�   �D$P��$�   H�T$P�D$T��$�   �K�l$lL�d$x�D$X�C�������u+H��$�   L�l$0D�CH�D$(E3ɋ�H��L�l$ ������H�L$HH��t�r���H��$�   H��t�_�����H��$�   L��$�   L��$�   H��$�   H��$�   H��$�   H�ĸ   ��������������L��H��   H��7 H�D$pI�[3�I�C�I�Cȉ\$H�\$@�\$8I�{ H���\$0D�CI�K�E3ɲ�\$(�\$h�\$i�\$j�\$ �\$k�\$l�D$m�a�����u������HH�L$`H��$�   �
���L�D$`�   �\$0�VE3�H�ωt$(�D$    �������D�H��$�   H��$�   ��H��$�   H�L$p��  H�Ĉ   ����������HSH�� 3�L���  �J�����H�Y: �I   @H��H��tH���Y���H�������H�� [�����������HSH�� H�K� H����   H�s� 3�H�ɉ<6 t� ���H�!� H�R� H��t)�0u  H������H� � ����H�+� H��� H��t����H�� H��� H��t�����H��� H��� H��t�����H��� H�� [�����������H��(H��tH��v'H��vH��uH�M� �H�L� H��t�Y���H�       H��(�����������H��(������   ��tw��te��tT=  tH��(H�%����I��tI��v'I��vI��uH�ӿ �H�ҿ H��t�����H�       H��(��{���3�H��(��~���3�H��(�3��w���3�H��(���������L��H���   3�I�[I�sI�C�I�C�I�{ I�C�I�C�I�C�I�C�I�C�I�C�I�C�H��I�K�H����3��OI�C������H�5`�  H��$�   H��$�   H��$�   �����f��u�������t=�  t��������   H�|$XH�\$PH�|$HH�|$@�D$8d   �D$0d   A�  � L��H��3ɉ|$(�|$ �o���H��t�H�L$`E3�E3�3�������t0ff�H�L$`�u���H�L$`�r���H�L$`E3�E3�3��O�����uӸ   H��$  H��$   H��$�   H���   ���������������L��H��   H��3 H��$�   H��6 H��6 I�[�D$Xf�D$Z$ I�kH�-.� I�S�I�sI�{ M�c�E3�H��E�c�H�H��6 A�\$I�s�H�BH�JH��6 H�J�{'u	A���|fff���trH�D$8L�L$0D��H��H��L�d$PH�D$ D�d$HD�d$L�G�������u*�����=�  uD�KL�D$0H�T$8H�������؅�t�D$0+�H���u���������L��$�   H��$�   H��$�   H��$�   H��$�   H��$�   �S�  H�Ę   ������������H��xH�M2 H�D$`H��$�   �D$0f�D$2 �~���H��1 f�D$6  H���f�D$4t\��� ��tR��� ��tHE3�f�D$B�T$DH�D$@H�T$0E�A�D$(   f�D$@ H�D$ �%��������   �&�����   H��$�   H��$�   H�-j� H��H��$�   �   L�d$pH�t$0�{tE3��ttH�D$@L�L$8D��H��H��L�d$XH�D$ D�d$PD�d$T���������u*�[���=�  uD�KL�D$8H�T$@H���}����؅�t�D$8+�H���u���"������u����H��$�   H��$�   H��$�   L�d$pH��$�   H�L$`��  H��x�������������������HSH�� f�y H��tH�y �(  H�=��  �  H�=�3  �  H�b� H����   �0u  ����=  ��   =�   ��   ���t}����   f�{��   H�[f9K��   �q������ ���+ȅ�u�u� H�� H�� [H�%&���k��IH�ѹ и���������C� H�� [H�%����f�{rBH�[��p���H�!3 D�[�AA*�<wA��*A<sA��D�YH�h� �
���H�c� �����H�� [��������H�T$H��H��XH�XL�`�L�h�L�p�L�x�E3�H�h H�p�L��E��L�9A��L�5�, H�x�f�fff�fff�fff���I��O�f=U �itf=au	D9-R� t/��(����H��H��tH�HD��H���?  L�~I�$H�I�4$݁�  r��� L�t$hA����tq���H�� �S�j�;�wZ�f��Utf��au	D9-׸ t=�J(�����H��H��t&H�HD��H���/?  L�~I�$H�I�4$��� ���� ;�r��(   �E���H�|$HH�t$PH��H�l$xL��t:f�@ f�@ �@"V  �@�X f�@ f�@ fD�h L�xI�$I�M�$M9,$��   I�$E��I��H��tLfff�ff�fff�H��L�H��L�9M��tD�ID9HvL��H� H��u�M��H�uH���I�A��M��I��u�H�D$hI�$H��t;A����  E��v/���  ���H�u�H�L�:H��tH�H���a���H��u�A���  E�.�   �
M�<$A��E�>L�|$(L�t$0L�l$8L�d$@H�\$pH��X���������������������H��H��hH�XH�pH�5� L�`�E3�H����  H�� H�hH�x H�ۋƶ H�<���   �/f�ff�f9ku[�Gf9CuQ�G9CuI�G9CuA�Gf9Cu7�Gf9Cu-�C f;Gu#H�WH�K"D��A�   �D$    �Y=  ��tH�H��u�H�H� �H�SH�;� �H�2� H��H��$�   H�l$x��   H�� E3��=  ����   ��� H�5� H��f�;u.f�{u'�{"V  u�{�X uf�{uf�{ufD9ctmH��� L�ʵ L�D$@H���M�����tGH��� �D$8   L�d$0L�D$@H��� L��L�d$(L�d$ ��<  ��uD�%�� �   �   H�5C� H�\� H��t3��<  H�5)� L�%B� H�3� H��t3��y<  H�5� L�%� H��A��tR��� ��tHff�fff�H�f�9u.f�yu'�y"V  u�y�X uf�yuf�yufD9at
��H��;�r���� A��L�d$`H��$�   H�\$pH��h����������������H��8�* H�t$P3���$<u������ * �� ��  ��� D��� A;�r
A�A���� D��� E���  ��Ei��  3�A��H�|$X+�A��������V  H�l$H�-�� A���   ���RXL�d$0L�%س �����   ��;�GЋd) ;��`) G��� ;�B�I94�t	I��P���� ;�vD��D+��D��D+�D�) ���QA��������D;���   A��2sA��D��( ��H�\$@�.����������   ;�L�t$(A�   t4;ź����AG�LcD ;�Hc�tI��I��ff�H91u	�I�;�u�؃��t:;�t6����H�� D��J��������t�=Ų �Ӳ �5� �����A��L�t$(H�\$@H�l$HL�d$0H�|$X���     �8(     ��H�t$PH��8���������HUH���   H�l$PH���   H���   H���   L�exL�mpL�uhL�}`H�.( H�EPL��H�M3�D��H����  H�=�' ���  95�� ��  ��' ����  95z� ��  A�   A;�DB�D�} A��H��H������  H+�H�\$PH�]��۹��3�H��H�uD��D�} L�mH���>  A��H������f�E@ �� f�EB� � �ED�A�G�f�Cf�C �E
   �����f�C�D$(   H�E@H�D$ E3�E��H��H��& �x��������  H��) H��) H��) fff�ff�ff�H��D��H�=�& ���   fff�fff�fff�3�H�W) H�X) H�Y) H�Z) L�-S) �u �u�[� �   H�\� H�t$@H�T$8H�t$0H�t$(H�EH�D$ L�M A�   H�&� H�'& ������؅�u5H�EH��t	H�EH��u;�} r��( �EH��( H�E H�M�n������t*H��( H��( �6���H��( H��D�e H��( �H��( H��( H����   L�m0H�ͯ H�E8A��  E3�H�U0�O�������f  =  ��   �u�u H�EH�D$ E3�L�E H�( H�C% �������u�۶��H�( �O�E ��r@H�MH��tH�MH��tH��' H��D���&��' �EH�] H�M�s���H��' �H��' H��H��' ����A��H��' �����?H�x' �����f�vtH�d' �����D�eA���D�et^����H�Mf�A�D$(   H�E@H�D$ E3�E��H��H�Z$ �������H�2' H�' ������H�}�ٵ���#D�eE��t�����D���GD+�A���H�}E��t�GH��Hi��  A��3�H�������H�MP�	�  H���   H���   H���   L�exL�mpL�uhL�}`H���   ]������������HUVH��XH�jPH�3��8�  �@�ƋƋ�H��X^]������������H�T$H�L$UH���   H�l$0H���   H���   H���   L���   L�mxL�upL�}hH�r# H�EXL��E3�A��D�u A��D�uH9c� tbA���`� ��t3I��ff�ff�ff�H�A� H94tH��I����3� ��H��;�r�H�� �,���L�5� D�5� L�5� 3�H�EH�E H�E(H�"� H��u"H�� H�� �Z������   H��� ��� ���\	�]A��D�uH��t�B �;�s�J H�H��u�]�M��H��H�����  H+�H�t$0H�u0������E3�I��L�u0L���   �Ɖu�]H����  ��C�f�F�u� f�FH��% �H�Nf�F E��H�~L�-G� �=H�  vcA�Ef�A�Ef�GA�E�GA�E�GA�Ef�GA�Ef�GA�E f�GL��I�U"H�O�2  A���GH�|M�m D;=� r�A�   A��L�-K� M��uA���n���tiL�uPD�uHD�uLH�E8H�D$ L�MD��H��I�����������u#�X���=�  uE��L�EH�U8I���}�������t
�E+�H���'�����u���u�����u �_  �D�uD�u,I��H�M��������   fff�����=�  ujL�e8H��� H�E@A�0u  E3�H�U8A�H����=  tfA;�taH�Z� H��t!E3�L�S� H��# �ή����u�����I���ۮ���
�s�����uQI��H�M�������k����}tE�@���H��� H��t�������t��  �O���I��������u �l  �����u �^  L�m A�u �uA�E�EA�E�EA�E�d� A�E�a� D�}fA��&�  �ƃ�����   A��A���)���D�� E��uH���   �!�����D�ة ��tE��u�=� u/A��D�50 �)D�5� D�5� D�5 I���]����؅�tE� ��r�    H�p" �[1  ��t%�r����� ���t;�G؋X� ;�Bؿ   ��� ��AD��uA�E��� H��H������H�ܨ D�ݨ I��3�H���/  H�=��  �  A���=��  v;�uI��H�N�����H��� H�H��� H�< ��  ��H��;=|� r�I�uA����E��=e�  vbM��D�}fff�fff�fff��F�X;��x  A;��j  L�@H��H�"� I���.  D��H�[FI�+�A��I��D;-� r�A��E��Hc=�� ��tvH������fff�fff�H�ѧ H��f=U u	�U��u(��Uf=a�   DЉU�Q;�w;�u�AD;�v�����L��� N�4�D�a��H�����u������D��H�c� H��tJA�փ=\�  v.D�C� ff�H�9 tD��H�D9Hv��H��;2� r������u�= �  AE������   D��H�� J�<�H�.� H����   D�'�fD9cuY�Gf9CuO�G9CuG�G9Cu?�Gf9Cu5�Gf9Cu+�C f;Gu!D��H�WH�K"�   �D$ D���-  ��t
H�H��u��H�{ uE3�H��H�b����.  �5k� H�X� J��A�C� �}��twA��H�=�  t5H�=�  t+H��� H��t�0u  �����=  t=�   �   E؅�t1H�W �xH�M �M�HH�@ �M�HH��� ������   ��u ��u ��u ��u ��u ��u H�M H��t�������ugH�=��  t]A��95�� v0I��ff�fff�H�q� H�< t
H��x�����H��;=\� r�H�K� �]���L�5>� D�5?� L�5@� ��H�MX���  H���   H���   H���   L���   L�mxL�upL�}hH���   ]�������������HUAVH��8H�j0H�E3��8�  �A��A��A��H��8A^]�������HSH�� H� 3ۉX�������u%H�N� H��t�;���H�<� �>� �<� H�� [�����������H��HH�\$XH�t$`H�|$hH��A���������H�=_�  t3L�L$ L�Ѥ ��H���D$  �  ��������  �\$ H�=�� �H��� L��H���*  H�=� ��$  �=c�  �  D�� E���  �=J�  ��   �=��  ��   �5� ��s-��H��I;�v"D��H��@��H�|$hH�t$`H�\$XH��H�c�����rY��s ��� @��H�=�� ��H��������$�ף L��@����H�=ң D���H������D�� ��� ����r0��A��H��H;�v"D��H��@��H�|$hH�t$`H�\$XH��H�@���D��H��@��H�|$hH�t$`H�\$XH��H�����ˢ �D$(@�t$0f�D$.����H�L$(f�D$,�CD��L�Ǻ   f�D$*�����L$*�����؉ڢ u�v�����H�|$hH�t$`H�\$XH��H�H�|$hH�t$`H�\$X3�H��H�����������L��H��8  H� H��$   I�[I�kI�{�M�c�M�k�M�s�E3�M���T���3�H��$�   f�H�\$`H�\$hH�\$p����L���  E3�3�3��e���L�V�  E�F3�3�H�w� �I���L���  3�3�H�g� ������SE3�E3�3�H�W� ����L���p���H�1� H��H����	  H9&� ��	  H9!� ��	  M����	  H����	  �$�������	  H��� ��������	  H�� ���������	  H��  H�K�E�FH�D$(E3�3��D$ (  �ͤ��H��H��� u�ˤ���L	  H���������<	  H��� E3�E3��  H�D$ (  �}���H��H�� u������	  �Y�������  H�� 3�3�H�H�HH�HH�HH�H H�� H��(A�   ��&  L�� A�C��A�CH�� �����[��������H��$�   ���������u������|  H���  H��$�  A�@   �ç��L��$�  E3�3�3��^���H��H��� u������5  H�h�  H��$�  A�@   �|���L��$�  E3�3�3�����H��L��u�q�����  �w�������  H�8� H��I��H��$�   H�� L��$�   H��$�   H��� L��$�   H��$�   H�}� H��$�   H��$�   �@���H�L$`I��������t%H�L$`����H�L$`I��D�t$dD�t$t�n�����u�H�=j �H��$X  L��$  L�=? H�54 H�= ��   ff�fff�H�1 3�L�t$@H� H�|$8H�� H�� H�� H�D$TL�t$0L�L$PH�� A�   L�t$(H�-� H�D$ D�t$PD�t$T��� �   H�5�� ������u2�|$P�t����� H��$�   L��$�   ��$�   �����M�������D�������9] �4  ff�E3�H��$�   A��  A�HD�t$ �(�������uT����H��$�   ����H�L$`I���������%  f�H�L$`����H�L$`I��D�t$dD�t$t������u���  ���T  ���K  ���w  ���C  ����  H�� H�D$XL�D$PE3�H��H�D$ D�t$XD�t$P�ݣ����u�3����)�|$Pr"�d H��$�   L��$�   ��$�   �����H�=X ��]  fff�ff�ff�H�A 3�L�t$@H� H�|$8H�� H�� H�� H�D$XL�t$0L�L$PH��� A�   L�t$(H�-� H�D$ D�t$PD�t$X�Л �   H�5ћ �+�����u2�|$P�t����� H��$�   L��$�   ��$�   �"����M�������D����   D95ě tD�5?� �  D953� uD95.� �	  迺����t^H��I�������H�L$`I���3�����tH�L$`����D�t$dD�t$t��u	D�5[� �D�5֛ H�'� D�5̛ ����-����(�������  ��u1H�� 3�A�   H��(��!  L�t A�CA�CH�d �x��  uiD95� �  H�F �A�Y:�tP��:�t&����-�  ���i���H� ���A��:�u��A�AH�p� ����H�� �H�� D95s� ��   D91tI�A����t?Ƅ$�   fǄ$�    �AH��$�   �   ��$�   ����L�� E�3H�� D95� tMD9qtG�A����t=�D$xf�D$z �AH�L$x�   �D$|蜹��L�M E�sH�B �H�9 �A�Q:���  *A��;e ��  D95�� u3D95� u*D95� u!D95�� u?����H�� �m�    �'�QH�� �A�ȈAH�1� �ӝ��H�� �y@:y�
  f�fff�fff�fff��A*A��;� ��   @��A� �  ���3�+���Hc�H�T(@������H�U 3�H�L(A� �  ���  @���u�a� ��t/H�* @��@�xH� @:y�z���H�=# H�5< �}������0�������L�� H�=� H�5 A�CA�CH�� �A�AH�� D�5�� D�5�� ��    ���    �H�=� �H�=� H�5� D95� t4�A8Au+:Au&����H�L$T�   �D$TfD�t$V藷��D�5ؗ �+����>�4����o����*�����D�5(� D�5� �c    u��� �
��    D958 �����H�\$h�������H�\$hH��$X  L��$  H�#� H��t����L�5� M��D�5� D�5� t	I������H��L��$(  t	H���/���H��H��$P  t	H���)���M��t	I�������H�� L��$   H��t�����H��� H��t�����L95�� ��   L95# ��   H��� H��tn�0u  �N���=  t\=�   tUH�� �@   �H�[� �����3�L���  �J����H�� �I   @H��H��tH���Ě��H������L95� t H�� H���t�W���H�� �ҙ��H�� H��t�����H�ٕ H��t�����H�� H��t?�� A����t,I��f�L94tH������H��� �Õ ��H��;�r��Ý��H�ܕ H��$0  H��tH��tH������H��H��u�H�ʕ H��$H  H��t����L�5�� D�5�� �����L��$  3�H��$   ��  H��8  �������������H��8H�=��  ��
    u)E3�E3�3�3������H��H�^� u�����3�H��8�H�=O�  uE3�E3�3�3��m���H��H�3� t�H�D$@L�}���E3�H�D$(3�3��D$     �C���H��H�!� t��   H��8��������������H����H��0H�A��\K  ������������H��(���  H�\$@H�|$HH��t3���E����  H�|$HH�\$@H��(�H��P(��u	3���E��wH���  3�H��t�����H���  H��   H��t�����H��   H���  H���  H��t�q���H���  H���  H��t�X���H���  H���R  �ǉ��  H�|$HH�\$@H��(�����������HSH�� H��E3�E3�3�3������H��H���  u�U�����~:�K�����  �H�� [�E3�E3�3�3��ŗ��H��H��   u�������H�� [H�%���3�H�� [�������������������̸   �����������HSH�� H��H��  �r���Hǃ      H�� [����������3�H9�  ����������������������L��H��  H�g H��$P  I�[�I�k�I�s�H��  I�{�M�c�H�M��I��H��L���  H��L�D$0H�T$@H��H�D$0  ���x#H�T$@H����I  M��L��H��H��H�\$ �_  L��$`  H��$h  H��$p  H��$x  H��$�  H��$P  ��  H�Ĉ  �����������H��HH�\$PH�l$XH�|$hL�d$@L��L�l$8L��B   I��I��I���I���H��H��u(�{������q�����   �f�����  ��   H��H�t$`����H��H��u%�=�����
�3������?�)����؁�  ��.L��H��H����  M��$   L��L��I��I��L�\$ �^  ��H��H�t$`t:H���������u-�Ӕ����t#�ɔ����
��������������؁�  �H���K�����L�l$8L�d$@H�|$hH�l$XH�\$PH��H��������������������L��H��  H�G H��$P  I�[�I�k�I�s�H��  I�{�M�c�H�A��M��H��L���  H��L�D$0H�T$@H��H�D$0  ���x#H�T$@H���G  D��M��H��H��H�\$ �7d  L��$`  H��$h  H��$p  H��$x  H��$�  H��$P  ��  H�Ĉ  �����������H��8H��   H�D$ ��c  H��8�������HSH�� ���  H��t��E�H�� [�H��   u^L�r�  �����3��  H��H��  u*�4�����H�� [H�%$���������  �H�� [�H�KXE3�E3��+  �k���3�H�� [��������������������HSH�� ���  H��t��E�H�� [�H��P H����e  3����  ���  �C$H�� [���������������H��(���  H�\$@H�|$HH��H��t��E�H�|$HH�\$@H��(�H��P(��u��E�H�|$HH�\$@H��(��G H��������tH��t/��t+H��H���e  A�3�H�ϋ��L  ��H�|$HH�\$@H��(ø�E�H�|$HH�\$@H��(�H�|$HH�\$@�   H��(�������������������H��(���  H�\$@H�|$HH��H��t��E�H�|$HH�\$@H��(�H��P(��u��E�H�|$HH�\$@H��(��C H�˘�����t6��t��tH��H��H�|$HH�\$@H��(��u  ��E�H�|$HH�\$@H��(�H�|$HH�\$@�   H��(���������������������H��(f�:H�\$@H�|$HH��H��tH�|$HH�\$@H��(�x  H�IH��t�D���H��H���n  H�|$HH�\$@3�H��(���������H��HH�\$PH�t$`H��H��  H�|$hH��H��u
� ��   H�l$XH���  L�L$0H�l$ �������ub�K���=�  ��uDH��  L�D$0A�   H���g�����u4������
�������"�	����؁�  ����~�؁�  ��3�H�l$XH��H�t$`tJH���ݏ��H��t<�ʏ���������H�|$hH�\$PH��H��������  �H�|$hH�\$PH��H�H�|$h��H�\$PH��H��������������������H��(H�\$@H�|$HH���H  L�Ô��H��  L���B  L�����H��   L��  �B  H�\$@3�L�|���L��   H���  H���  H���  H���  H���  H���  H���  H��   H���  H���  H���  H��  �G ��8  H��H�|$HH��(������������H��H  H�z  H��$0  H���  H��$h  H��H��u
�@ ��1  H���  L���  H�L$ H��$`  �  E3�L+�H�D$ H��A�f��tf�H��H��u��H��u
H��A�z �E��f�   ��   L�L$ E3�3�3������H��u(�������ߍ���   �ԍ����  ��   L��  H�L$ H���  3�H�D$ L+�A� f��tf�H��H��u��H��u	H���z ���f�   x9L�L$ E3�3�3�����H��u�^�������T����H���  3��A�����H��$`  H��$h  H��$0  ��  H��H  ������������L��H���  H���  H��$�  I�[I�kI�s M�c�E3�H��A�l$A��D�d$0I�{���A��u��tTH��  A��H��t4H���  L�L$0H�T$pA�H  H�D$ ���������  �������   ��t����   E3�H���  A�����A�H�D$ �  �g�������   ��tN��t?��t+����   H��  H���  L�D$0E3��U������~   H�H���PX�   �nH�H���P`�cH�L$8E3�E3�3��D$    �������tDfff��|$@��   H�L$8����H�L$8����H�L$8E3�E3�3��D$    �������u���������|$0s-H�K`��E�H��tY�u���H��tJ�b�����1�X������6D�D$0�D$tD�L$pH�T$xA���H�ˉD$ �i  ����'�������  �L�c`L�chD�cpD�ct���6������E��*���H�H���P A��H���E  ����L��$�  H��$�  H��$  H��$   H��$�  �   H��$�  �u�  H���  ��������������H��(H�\$@H��0  L�	�  E3�H�|$HH��3���F  ��xH�H���PX��x
H���>�����������H�|$HH�\$@����������L��H��X  H��  H��$@  ���  I�[I�s I�{�H��H��t
��E��_  H��P(��u
��E��K  �G H�#�������/  ���  ���  �KH��H��  v
��E��
  H��r�L�KM��t�H�����w�3�H��I��D��H��tf�ff�f9tH��H��u��H��uA�W �E��x�H�����wZL�D$0H�D$0�  M+�f�ff�H��t)E�fE��tfD� H��H��H��u�H���z �f��H��u	H���z �f�   ��W ���xQH��   L�L$0L�D$ H�H�WxH�D$   �����yH�Ox3�A�  �\  ��G$   ���E���   H��$P  H��$x  ��H��$p  H��$@  �<�  H��X  ���������������������H��8H�\$PH�|$X3��y,H���]  L�L�D$@H�T$HfA� H�ˉ|$(f�|$ A���   ����xH�D�D$@H�T$HH�����   ��A�3�H���B  H�\$P��H�|$XH��8���������������������H��(f�:H�\$@H�|$HH��t�d  ��m���H�ˋ������H�\$@��H�|$HH��(������������������H��(���   H�\$@H��t��E�H�\$@H��(�H��P(��u��E�H�\$@H��(�H����f  ��x^H��������xRH���r�����xFH�KPA��   L���  A�Q�H�|$H�ƈ����uf���  H�|$H3�ǃ�     H�\$@H��(Å�u
ǃ�     H�\$@H��(�����������������H��8H�\$0H�t$(3�A���  H�|$ E��L��H��I���K  A���  ��   A����   A��tmA��t"A��  �9  H�T$`I���%���H����  M����  H��0  E3�E3�A�Q����95g�  t�0���H�H���P�
  �]����  H��0  E3�E3�A�Q�ч��H�KX����H�sX�q  9�8  tH�IX�	  ��8  H�S@H�KX�����H��H�s@�mf  3��͇���3  H��t(H���$  H�Q@H�IX�[���H��H�s@�7f  �  H�yX�8���H;���   H�ω��  ����H�C@��   A��-  ��   ��td-  t*��tL�L$`L��A��I���-���H���   �����   H�I�����   ����   =�E�u{H�H���P A��H���b?  �cH�I@L;�uH�D$`H�C@�OH��tJ�q�����t@L�L$`L�Ǻ  �'H����   H�K@H��t�F�����tE3ɺ  E3�H�K@�����H�|$ H�\$0H��H�t$(H��8�������H��H��H�\$PH�l$XH�|$hL�d$@L�l$8M��M���H��t���������H���I������L������H����   H;{XuM��D��H��H��L�d$ �����H;�0  ueH�t$`3���tG��tM��M�ŋ�H���ȅ��H��H�t$`�JH�H���P`H��0  �����H��0  H��H�t$`�#3������H��H�t$`�M��M�ŋ�H���t���L�l$8L�d$@H�|$hH�l$XH�\$PH��H���������������H��hH��$�   H��3�H�D$@    �P�������   H�����H���y>  ����   L���  H�SXE3�H��H��$�   �C?  ����   H�KX3��  H�{X��8  �����H;�tH��ǃ�      �`���H�C@H�D$xL�����L��H�D$(3�3��D$     ����H��tFH�L$0E3�E3�3��������t/f�H�L$0�����H�L$0�����H�L$0E3�E3�3��_�����u�H��$�   �]���H�D$@H��$�   H��h��������������������H��(H���  H�|$HH�2��-�+  H��tH;�tH��H���  H�|$HH��(�H�L$0H�\$@�`���H�\$0�U���D��I3��A���D��I3������H�L$8D��I3��$���L�\$8L3�H�\$@H�������  L#�IE�H�=�  H��H�=�  H�|$HH��(������������                H��H��hH�XH�pH�x H��H�5#� H������H�� H�T$pH��E3����H��t>H�T$pH�D$8    H�L$@H�L$0H�L$HL��H�L$(3�L��H�t$ �����L��� �L�\$hH�D$hH��L��� H�;� H�D�  L�� H�=� ��� 	 ����    H�D$PH��  3�H�D$P����H�J�������������	 �H�������H��$�   H��$�   H�\$xH��h�������H��H���   H�XH�x H�H��Ԁ���f�=*n��MZt3ۉ�$�   H�=n���   HcHn��H�=n��Hǁ8PE  t3ۉ�$�   �j�H��  t;��  t3ۉ�$�   �K���   w3ۉ�$�   �73�9��   �É�$�   �#�xtw3ۉ�$�   �3�9��   �É�$�   �   �����H�# ����H�# ����H�=���� �H�v�����  ��  �=��   uH�  �[���H�����H�u�����  D��  D��$�   H��$�   H�D$ D��  L�D$@H�T$HH�L$<� ���H�)���H�����  L����M�L�D$0A�8"u.fff�fff�I��L�D$0A� ��t<"t��A�8"uI��L�D$0�A�8 v
I��L�D$0��A� ��t< w
I��L�D$0����$�   tD��$�   �A�
   3�H���o������D$8��u���}������������$�    u	���q�����r���������   H��$�   H��$�   H���   ���������HUH��0H��H�H�ы�x   H��0]��������%�����������%|����������%h����������%T����������%@����������%,���������������      �%����������%Ѐ���������%�����������%x�������������������3����������%����������%|���������%H~���������%�}���������%�}���������%�}���������%�}���������%�}���������%�}���������%�}���������%�}���������%�}���������%�}���������%t���������%p����������3��I  ���������3��  ���������D��L��3�3��#  �����������������3��A@#Eg�AD�����AH�ܺ��ALvT2�AP���ÉAT�AX���������������������H�L$H��H��xD�D�AD�QH�XH�h H�p�H�x��:L�`�D�aL�h�L�p�L�x�H�ڋQ�s�kD�kD�sA��A��A3����A#��A��A3�E�������D��9�y�ZA��A�3�A���t$8A#���A�A3���A��E��
�y�Z��A3�A��A#���3���A��E���y�ZD�cA��A3�A��A�A#���A3�A��A����
�y�ZA��A3ʋ���A#�A�A3��A��E���y�ZA����D�{A�A��A3�A�#�A3����E��	�y�ZA��3�A��A#���A3�A�ȋCA��E��
�y�Zȋ�A3ȉD$A�t$A#���3�Ƌs �A���E���y�Z�t$0A��A3�A��A#����A3�ȋC$A����
�y�Z�A��A3ʉ$�4$A#���Ƌs(A3��A���E���y�Z�t$A��A3�A��#���Ƌs,A3�����E��	�y�ZA�ˉt$,A����3�A#�Ƌs0A3���A���t$E��
�y�Z��A3�A��A#���3�Ƌs4�A���E���y�ZA�ɉt$A3�A��A#���A3��ȋC8�[<��
�y�ZA��ȉ�$�   A��ˋ�$�   A3ʋ�A#����\$A3�Ƌt$0�A��E���y�ZA��A3�A��#���A3�����A��	�y�ZD�L$A��D3΋t$83�D3�A#ȋ�D3ϋ�$�   A3�3<$A����A�A3�D�L$�A��3�E��
�y�Z�t$�ǋ�3t$A3ȉ|$$#�A3�A��3���3��l$,������E���y�Z�ˉt$ A3�A��A#���A3���A��D��
�y�Z�ˋ�A3�A3�A��A#�A3�3T$3�����T$(�A��A���y�ZD�D$A��A3�E3ǋ�A3�E3�D3ǋ|$A����A�D�D$4�A��D�����n�\$A��3�A3�A��A3�3�3���$�   ����ǉ|$8�|$0�3���A3�E��	���n3t$(D�t$D�|$4��A��A�ȉt$,A3���Ƌ4$3��D3�A��D3�\$E��
���nE3�A��A��A3�A����A�3�D�t$�A��D��E�����nD3��|$8D3�A��A��D3t$A3�A3�A����A��A����3Ƌt$,��
���n3�A��3D$$A3���A3ˉD$��D�d$��A�D�d$�A��A��3Ë\$E�����n3�A��3D$ A3���3ʉD$A��D�l$��A�D�l$�A����E��	���n3ŋl$(A��A3�A3�3�3����$A���,$��ŋ�$�   �A3�D�d$E��
���nA��A3�A3�A��A��A3������3ʉl$8ȋD$A��A3�E�����nA��3D$A3�3�A3����D$A��D�l$��A�ȋ�$�   A��3$��
���nA��3�A3�3D$A3�����$�   ��D��$�   ��A�D�|$�D3�A��D3�E�����nA��D3|$$A3�A��A����3�A�A��D�|$���A3�E��	���nD�l$ A��A��A3�A3�3l$3�����ŉl$ �l$(ȋ�$�   A��A3�E��
���nA��3�A3�3D$$3����D$A��D�d$��A�E��D�|$4D3d$�A��E�����nE3�A��A3�E3�D�,$A3�A��A����D�d$,A��A��A��3Ǎ�
���nA��3�A3�3D$ A3����$�,$��ŋl$8�A����3�E�����nA��A3�A3�3D$3����D$A��D�|$��A����E��	���nD�|$A��A3�A��3�3�3ǋ�$�   A3�A3���3��t$ 3<$�D$(A��D�d$(��A�D�d$�A����E��
���n�|$0A��A3�A��3���ǋ|$�A3�A��E�����n3�A��3|$A3�A��A3�����ǉ|$�|$�A����A3�D�t$(��
���nA3�A�ʋ�3�A���A#����D$ A��A#��A��L$ A3�D�d$3D$0A�A��D��ܼ�A3�A����A�����A#ʉD$A��#�ȋ�L$3ǋ|$,3D$A���D��ܼ�3�A�����A��A#ˉD$$��A��#��A��L$$A3�D�,$3D$ A�A��D��ܼ�A3�A����A�A��#ˉD$��A��A#�ȋ�$�   L$3ŋl$3D$A�A��D��ܼ�3�A����A�A��A#ȉD$��A��A#�ȋD$L$A3�3D$$�A����ܼ�A3�A����AˋӉ$A#�A��D�4$A#����A�A�D3t$ D��ܼ�D��$�   D3|$A��D3�D3|$0D3�A���D3�A��A#�#�A��ȋD$D��$�   3D$A�D3|$3D$A�E3�A3�E3�A��������D��ܼ��D$A���A��A��A#�#����L$A�A��A��D��ܼ�D�t$A��A�A��A��#�A#����A�D�t$D3t$$A�A��D��ܼ�A��D3�D3�A��A��A�A#�A��A#���D�|$4�A��A��A�ƍ�ܼ�D�t$<A�ʋ���A�D�d$(�|$A#ɋ4$A3�3t$D�d$A3�3|$3t$(D�l$0E3�A3�A��A#�D3勬$�   �3l$ E3�A�A3�A�A����D��ܼ�A��A���#�A��A#���3��A���|$�A���A��D��ܼ�#�A���A��D�d$,A#����A�A�A����D��ܼ�A��A��A�A#�A��#����t$0��A�A����D��ܼ�A��A��A�A#�A��A#����l$(��ˍ�ܼ�D�l$A��D3l$A��A��D3l$A�A#�A#�E3���A����A�D�l$8A�D�D$$A��D3D$ ��ܼ�A���D3Ƌt$D3D$3t$A#�A��3�A��#�A3�D�|$D3|$$ȋ�A���E3�A�����D��ܼ�E3�D�4$D3t$�ˋ��#�A��A#���E3�D3t$�D�D$Ήt$A���A��D��ܼ��ˋ�A�A#�A��#���D�|$$�A�A�A��A��D��ܼ�D�t$A����A��A��A#�A�#��A��A�ϋ�$�   A��A3�D��ܼ���3l$A3�A3�3|$(3�A��A3�D�d$D3$$�����E3�l$D3d$0Ë\$����b�A��A��3�A��A3���D�$$A3�A�A�A����D����bʉ�$�   ��A3�A��A3���ǋ|$A�3���A3�D����bʋ�3|$4A3�E��D3l$��A3�ǉ|$�|$<A�D3�A����D3�A��D����b�A��A��D�l$��D3d$8��$�   ��A3�3ދt$3\$A3�A3�3\$43t$,A�A�D�|$(A��D����b���3�A3�A��A��3l$,A3���A3�3�A���D�t$0�\$4�A���ƍ���b�A3�A��3|$A3�E3�A3�A3������D3�A�A����D����bʋ|$<A3�A��A3����A�����D����bʋl$,A3�A��A3����A�A��A��D����bʋ�D�d$A3�A��A3���A�A�A������b�D�D$D��$�   A��A3�E3���A3�E3�D�|$D3|$D3�D3|$8A����A�D3��A��A�Ǎ���b�A��A3Ë�3���A�A�D�L$$������b�A�ы�A3�A3Ћ�3�A3�A3������A�D�T$��D����b�E��D3D$3�A��3�E3�D3D$4A����A�A�D�\$��E3�D�$D����b�E3�E3ʋ�3�D3�D3�D3L$<A3�A��A�A�����A������b�A���ŋ���A3�D��$�   D3T$A3�A�E3�D3T$,�A������b�A��A��A3ŋ�3���A�ŋl$������bʋ�A3�3$A3�L�|$H3l$4A3Ӌ�3T$A3ŋ�3������$�   A�L�d$`A3�L��$�   D����b�A3�3T$L�t$P����A�ȋ�3���3��A�L�l$X������b�A�	�ŋ�����3�A3�ƍ�(��b��A�A�A��A�	EAA�AA�A�E�AA�AA�A�A�AH�|$hH�t$pH��$�   H��$�   H��x������������������H��8�AXH�\$@H�l$HH�|$XL�d$0D��A�A��?A��A;�H��H��AXs�ATE��H�t$Pt6C�4��@r-�@   A��A+�H�D�����j���H�M@H��H��^�����E3��@r/��L�l$(H��ff�fff�H�M@H�������H��@���H��u�L�l$(��H�t$PtA��D��H��H�����L�d$0H�|$XH�l$HH�\$@H��8�����������������L��H��   H���  H��$�   �AXI�[I�k ��?I�{�@   ��M�s�L��+�H����w�D�C�H�L$03�H��$�   L��$�   �m����WX�OTA�   �����D$0���ȍ�    H�T$ �L$ H�L(�D$$�2  �GXH�t$0D���A��?;ÉGXs�GTE��L��$�   t9E�d D;�r/A+�A��H�T$0H�D�������H�O@H��H�t,0A�\$�����E3��@r$��H��ff�ff�H�O@H������H��@���H��u��L��$�   H��$�   tA��D��H��H�����H�W@A�   I���q  L��$�   L��$�   H��$�   H��$�   E3�L�L�_L�_L�_L�_ L�_(L�_0L�_8D�_TD�_X�G@#Eg�GD�����GH�ܺ��GLvT2�GP����H��$�   H��$�   ��  H�ĸ   ��������                H�t$L��L��H�|$ ��H� H�A�    I���I�I��H�I��u�H�\$E2�H�l$3�E��   E��  M�˻   fff�fff�fff�A�A��A���8I���D�A��B�A�A�A��E��;�B�DD�H��u�H�|$ H�t$H�l$H�\$�����������������E��tH+�E��f�ff��
H��I��ȉA�u��  ������������H��8H��H�\$PH�|$XH����t7��t3L�D$@H�T$ H�c� �~  ��t�D$@H�T$ H��;�G�D������H�|$XH�\$P�   H��8��������������H��(H�=L�  u/H�L$8�8  ��uH��(�H�L$83��H�'� t
H�L$8�  �   H��(����������HSH�� 3�H��H��� H��t�t  H�� H��t	H����d��H�� [����������HSH���   H���  H��$�   �=��  �  H�L$ 3�A��   ����H�L$ �D$ �   �Vd������   3��|$0�������  twH�kk���ud��H��H����   H�2k��H����e�����  � @  H��H�<� E�H��j���l�  H����e��H��j��H��H�� ��e��H�� �CH��j����c��H��H��t.H�wj��H���^e��H�Wj��H��H��� �Ge��H��� ���    ���  H��$�   賐  H���   [�����������H��H��   H�hH�pH�x L�`�I��I��L����������  H��$�   H�g� L��$�   E3�H��H�\$@��   L9-7� tzH�6� H��tnH�*j��H�L$H��H�D$HL�L$XL�D$hH�L$@�  �D$(    H�D$x�D$h0   L�l$pǄ$�   @   L��$�   L��$�   �D$    ��� ��y3��UH�L$@3��H��� H��tH�L$@�wb��H�\$@�H�\$@�L�l$8H�|$0�D$(D��M�ĺ 9 H��H�t$ �"b��H��$�   L��$�   L��$�   H��$�   H��$�   H��$�   H�ĸ   �������������������L��H���  H�'�  H��$x  I�[�I�k�I�s�M�c�L�L$0I��M��L�D$8��H���=�����t
�   �  L��$�  L��$�  �9a��A�   3�H��M���a��H��L���Y  A;�H��$�  A���"  L��H��H���e���D�[A���E;���  A��A+�I��_a�������  ����Ca�����C��  �����a�����C��  �������  H�K��`������  ������  H�K0��a�����z  �����8�u  H�K@�C@8   �'b����@�T  ������O  H���   L���   L���   H���   3�H�D$ �	b�����  ���=6�  ��   L��$�  E3���a��H��L��u��a��A�   H��L����   H��$   �q  I��3�E��u��H�l(H���ha��������H�l(H����`����H��$   D��H���w  ��u�H��$   �lx  E��H��$X  H�H��� H�AH��� uI����_��H�l$8�I���i_��H�l$8L�d$0L��$�  �E�    ���  ��H�:� H���   H�4� H���   ��  H�ð   ����X�����uA����  H���� ����  �������  ��� ���C��  ����  ��@�D$8@   ��  H�T$8H���U�����t�L$8�����;��e  ��H�+�H��� H���U  E3�D��H��A�I�|$0�Ѓ��9  H��$�   �����D�D$0H��$�   H������H��$�   H���z�������  ���H����0��  A�0   L�L$0H��A�H��)� ��x�L$0�����;���  ��H�+�����  A�   L�L$0H��A�H���� ��x�L$0�����;��{  ��H�+���8  �o  L�L$0A�8  H�ӹ   ��� ��x�L$0�����;��9  ��H�+����0  A�   L�L$0H��A�H�k� ��x�L$0�����;���   ��H�+��� ��   A�    L�L$0H��A�H�-� ��x�L$0�����;���   ��H�+�L�L$0D��H�ӹ   �|$0��� ��x>����   H�L$@�_���D�D$0H�L$@H�������H�L$@H���������raH�����L�L$0D��H�ӹ   �|$0��� ��xC��r>H��$   ����D�D$0H��$   H������H��$   H��������s3�����H�L$@H��� A�P   �:���L�D$@H��$p  �P   �E���A��L�D$@+�I��A;�AG���
  H��$�   H�T$@A�P   �������H�K� H�T$@A�P   �����L��$�   H��$p  �P   �a�  H��$�   �P   �  3�H��$�   �P   L�D$@�PP�H��$p  ����A�$3�H�|$@�P   L���H��$p  ��  3�H��$p  �  �I��I�����Z��M��H��3��
[��H��$�  ��L��$�  L��$�  L��$�  H��$�  H��$�  H��$�  H��$x  ��  H���  ������������L��H��x  H���  H��$@  I�[ I�k�I�s�I�{�M�c�3�M��M�k�M��L����   H��fff�ff�fff�J�,(A��H�2� +�H��D���u  ���  H�N� L�D$ H�T$$�  �T$ ���  ;�r|L�D$,H�T$0H��� �D$(   �D$ ��  ����   �T$,H�L$0L�L$(L�D$@���������   D�D$(�T$$H��� L�L$@��  �T$ 3�H�|$@�   ��  H��� +T$$;�L��G�D���   ��I;������   L��$P  L��$X  H��$`  H��$h  H��$p  H��$�  H��$@  �q�  H��x  �3�����������������������D�D$H��H�9H�l$@H�t$8H��H��t3�H�t$8H�l$@H��H�H�y H�\$hH�YH�|$0t
�y H�yu3�H��H�=��  u.H�L$P�  ����   H�L$P3��H��� t
H�L$P�%  �=��  u2E3�H�R� A�QE�A�%  H��� �P   �$  ���    H��tH��tD�E��tH�H�� �Y  �FtL�L$`L��3�3��2������3��'D�D$`H��3��K�����H��tH��t
�H��5�����H�\$hH�|$0H�t$8H�l$@H��H�����������HSH��@3�H��M��H�D$ �D$    H��H�D$(H�D$0t/H��t*H�H�L$ E��H�D$(�I�҉D$0�c����L$0�H��@[�H�L$ E��I���G���H��@[������������������H��u3���#  �A   D�I�Q�A    D�A�   ��������������������H��t�9#  uH�A H��AA� �   �3���������������L��H��H  H��  H��$  H��I�[ I�k�M�c�A��H��L���-  �9#  �!  �yI�s�I�{�yM�k�M�s�LcquHH�L$ A�   ��g  H�L$ D��I���m  �CtH�S H�L$ D���m  H�L$ ��n  L�\$x�]H��$�   A�   �����H��$�   D��I���R�  �CtH�S H��$�   D���8�  H��$�   H��$�   �o  L��$�   E��A��I��t E��;�r3�3�A�H����0DI��I��u�CL��$   H��$8  A�L��$  3���H��$0  �   �S�3�L��$(  H��$@  H��$h  H��$  腂  H��H  �������������̉T$L��H��hI�C�I�[I�{ I�C�I�C�3�I�C�I�{�H��H�]\��E3�E3�H��  ��D$(   �|$ ��S����t3��>H�L$XH�D$xL�L$TH�D$(H�?\��E3�H�\$ ��S��H�L$X����S����@�ǋ�H��$�   H��$�   H��h��������������������L��H��hI�[I�C�I�sI�C�I�C�I�{ I�CЋ�3�I�{�H��H��[��E3�E3�H��  ��D$(   �|$ ��R����t3��9H�L$XH��[��A�   E3��\$(H�t$ ��R��H�L$X���S����@�ǋ�H��$�   H��$�   H�\$xH��h������������������H��(�nS����2�H��(������������D�	��� ��A��D#ȉ�� J�L�D�
�A� ������������H��(D�H�\$0H�l$8��A���H�t$@L#�H�|$HI��J�\�A��H�K��R��H�K0L�Ƌ���  +H�KH�|$HH�t$@H�l$8H�\$0H��(H�%�R����������������������H��(D�H�\$0H�l$8��A���H�t$@L#�H�|$HI��J�\�A��H�K�R��H�K0L�Ƌ������H�K�    H�|$HH�t$@H�l$8H�\$0H��(H�%@R������������������H��(�H�t$@H���t1H�\$8H�|$HH��H�YH�H���R��H��H��u�H�|$HH�\$8��Q��L��3�H��H�t$@H��(H�%�Q�����������������H��8L�d$0L�l$(L����Q��3�A�
  H����Q��H��L��uL�l$(L�d$0H��8�H�\$@H�l$HH�t$PH�XH�|$X�    �@   H�pH3�H��ff�H�NH�u �������tD�������H��H��8  ��r�M�e �   H�t$PH�l$HH�\$@H�|$XL�l$(L�d$0H��8Å�A�<$tff�H�H����P��H��H��u���P��M��3�H����P��3��������������������L��H��  H�'�  H��$�   M��I�{�M�s�M�{�D��H��M���,  H���#  A���  I�[ I�k�I�s�I�M�c�H�L$ M�k��$���H�L$ A�   I���|  H�L$ E��H���|  I�WH�L$ A�   �|  H�L$ E��H���}|  H��$�   H�L$ ��i  H�L$ �����I�WH�L$ A�   �M|  H�L$ E��H���=|  H�L$ A�   I���*|  H�L$ E��H���|  H��$�   H�L$ �xi  I�,H�L$ I�.�V���I�W(H�L$ A�   ��{  H�L$ E��H����{  I�W<H�L$ A�   �{  H�L$ E��H���{  H��$�   H�L$ �i  H�L$ �����I�W<H�L$ A�   �~{  H�L$ E��H���n{  I�W(H�L$ A�   �Z{  H�L$ E��H���J{  H��$�   H�L$ �h  H�L$ ����H��$�   H�L$ A�   �{  H��$�   H�L$ A�   ��z  H�L$ I���ah  H�L$ �G���H��$�   H�L$ A�   ��z  H��$�   H�L$ A�   �z  I�WH�L$ �h  H�L$ �����H��$�   H�L$ A�   �z  H��$�   H�L$ A�   �oz  I�W(H�L$ ��g  H�L$ ����H��$�   H�L$ A�   �?z  H��$�   H�L$ A�   �'z  I�W<H�L$ �g  L��$�   L��$�   H��$  H��$  H��$8  3�H�|$ �`   �H��$�   �P   �   �3�L��$�   L��$�   H��$   H��$�   �z  H��  ���������������3�H��AH�����������������������H��(H�\$8H�t$@��   H��H�|$H�J0A���_M��H��L��u� �H�|$HH�t$@H�\$8H��(É0H�t$@�xH�H�|$HI�C�CL�H�\$83�H��(���������������H��(H�|$HH��H�	H��t#H�\$@ff�fff�H�Y��L��H��H��u�H�\$@3�H��GH�|$HH��(�������̋A�������������H�A�     H��t�;tH�@H��u��ËH3�A����������������������H��S��H�A    H�H�������������H�Q3�����������H�����M��L��v�W ��E3�H��H��H��tfD9 tH��H��u��H��u'A�W �E3�E��xdI+�K�SA�    uA�W �A���L��L+���L+�f�ff�A�f��tf�H��H��u�H��A�z �f�A���H��u
H��A�z �f�   A��������������������HSL��I��M��I�����H��v�W �[�E3�M��H��I��tfff�fD9tH��H��u��H��u+A�W �E3�E��xjI��J�BA�    I+�uA�W �A��[�M��L+���H��I+�I�H�L+�H��tE�fE��tfD� H��H��H��u��H��u
H��A�z �f�   A��[��������������H��(H�\$0H�l$8H��H�t$@I��H��H��Q��I��A�   H�|$HI���u[  ���  H��uH������f�H��H��
H�M �  H�wf�\ H���
���H�} L��L+�I��H�����wlI�����wc3�H��H��u�W ��WM��L��L+�L+�fff�I�8H��t$A�f��tf�H��H��u�H���z �f�:�H��u	H���z �f�  ��W ����   fB�[  H�U L��P��H���W���������   f�\ H���K���H��tH�U L��H���-����ȅ���   �� ���   f�\ H���@Z  H��L��u�� �H�E �   H��u1H�~3�H������f�I��H��H�Q�H������f�H��H�
H�E �oL�E I�����v�W ��BH�V3�M��H��u�W ��-�:f��tf�8H��H��I��u��M��u	H���z �f�   ��xH�U M��H���Y����ȅ�x3�H�|$HH�t$@H�l$8H�\$0��H��(�������H��HH�\$@H�l$8H�t$0H��I��f�: L�d$ I��M������H��H����   L��H�|$(M+�I��H��u"H�x3�H������f�H��J�D	H�3��   H�H�����v�W ��J3�H��H��u�W ��9L�O��L+�fff�A�< f��tf�8H��H��u��H��u	H���z �f�   ��x7H�M��H��������x'H�L�EH���@�����x3��H�    �� ����H�|$(L�d$ H�t$0H�l$8H�\$@H��H�����������H��(H��T��H�\$@H��H�H��0�q����=
�  uH��T����I����� �=��  uH�mT���gI����� �=��  uH�!T���KI����� �=��  uH��S���/I����� H�|$H3�H���  3�A�  �{$�{(���  ���  f�{HH�{P�{,H�{`H�{h�{p�{tH�{XH�{@���  ���  ���  ���  �����H�Kx3�A�  �����H���  3�A�   �����H���  H�{H�{H�{���  H�|$HH��H�\$@H��(������������H��(H�\$@H�|$HH�y3�H�H��td�.F����tH��H��H��|�3�H�|$HH�\$@H��(���E����H�|$HH�\$@H��(H�%�E����E����  �H�|$HH�\$@H��(�H�|$HH�\$@�@ �H��(�������������D�ʸ   ����  ��L��3������  �%�  +�Hc�A��E����� A����� D�I �����������H��(f�yH H�\$8H��tH�QPH�RS���\G��f�CH  H���  H�t$@3�H��t��:  H���  H��PH���  H�|$HH���   H�H��t	�6D��H�3H��H��u�H�|$HH�t$@H�\$83�H��(�������������L��H��x3�I�[I�{ I�C�I�C�I�C�I�C�I�C�I�C�I�C�I�C�I�C�H�AP�D$    I�S�3�H�ٺ   �|$0�|$43�I�C�I�{���F��3�H�D$H��B��H�L$ H�|$XH�D$PH�FR��H�D$`��E��f��f�CHH��$�   u&��C��=�  t��~��  �H��$�   H��xË�H��$�   H��x����������������������L��H��hH�API�K�I�[I�C�I�s3�I�s�I�s��D$8d   I�{ H��A���D$0   �NH��Q��A�  � �t$(�t$ �CE��H��H�u"�C������B���-��B����  ����t�
   H���'E��H��^E����H��$�   H��$�   H�\$xH��h�������������������HSH�� 3�H9��  H�\$0t<H���  L�D$0H�wT��H����xH�L$0��F������H�L$0H��tH��R��H�� [�������H��(�   H�\$8H�ٍJ>H�|$H��B��H��H��u+�B�����	B�����b  ��A���؁�  ��N  H��H�t$@��B��H��H��u%��A����
��A�����K��A���؁�  ��:� ��  H�KX�SD������   �=D����uq��A����V��A�����D��H��H�t$@��   H���B������   �TA������   �FA������   �8A�����   �+A���؁�  �롋� H����C��H��u+�A������@�����v�����@���؁�  ��b���3��[�����@������@�����J�����@���؁�  ��6�����@���؁�  ���yH��t	H���6A��H�|$H��H�\$8H��(��������������HSL��H��`3��@ �I�C�I�C�I�C�I�C�I�C�I�C�I�C�H���  I�S�M�C��D$(   f�D$@PI�K�I�C���A��3Ʌ�Dً�H��`[����������HSH�� �y$ u�   H�� [�H���  H�{N��E3�L��H��x�?����u��?����~:��?����  �H�� [�H����>����t3�H����@����u��?�����H�� [H�%w?��3�H�� [����������������H��XH�\$xH�l$PH�t$HL�l$03�I��L�t$(H�2M��H��E3��?��H��s
�W ���  I��L�d$8��?��H��L��u+� ?������>������  ��>���؁�  ���  3�H�|$@��=��H��H��u+��>������>�����  ��>���؁�  ��  I�T$H����=����u=��>�����y>��H�ϋ��~=���d  �c>��H���؁�  ��a=���G  H���S=��H��H��u+�5>�����+>�����  �>���؁�  ��  E3�3�H���=������u+��=������=������   ��=���؁�  ���   H�S�B   ��>��H��H�E u+��=������=�����   ��=���؁�  ��   H���=>��H��L��u%�w=����
�m=�����d�c=���؁�  ��SA�$M�F��A�A�D$H��A�FA�D$A�F�H<����u%�&=����
�=������=���؁�  ��3�H�|$@M��L�d$8t:I����=����u-��<����t#��<����
��<�������<���؁�  �H��t0H����;����u#��<����
��<�������<���؁�  �M��t;H�M �(=����u-�n<����t#�d<����
�Z<������P<���؁�  ���yH�M H��t��<��H�E     L�t$(L�l$0H�t$HH�l$P��H�\$xH��X�������������H��hH�\$`H�t$PH�|$H3�L�|$(E3�A��I��H��H�:s
��E��^  H�l$XL�d$@E�a��B   A��L�l$8E���f<��H��H��u+��;������;�����n  ��;���؁�  ��Z  H��L�t$0�<��H��L��u+�W;�����M;������   �@;���؁�  ���   H�SM��H������I��A���:��H��L��u+�	;������:�����   ��:���؁�  ��   �   �J*��;��H��H�u%��:����
��:�����]��:���؁�  ��LH���X;��H��H��u%��:����
��:�����'�~:���؁�  �����C�G�CL��G3�M��L�t$0t:H����:����u-�@:����t#�6:����
�,:������":���؁�  �H��L�l$8L�d$@t1H����:��H��t#��9����
��9�������9���؁�  �H��H�l$Xt:H��v:����u-��9����t#��9����
��9�������9���؁�  ���y#M��t	I����8��H�H��t�:��H�    ��L�|$(H�|$HH�t$PH�\$`H��h��������������������H��8H�\$XI��H�    L�D$HH�t$0H��H�˺   f�D$H  ��7���L$H�   ��fD���f�L$H�B   ����9��H��H�u+��8������8�����   ��8���؁�  ��   H��H�|$(�\9��H��H��u%��8����
��8�����1��8���؁�  �� D�D$HL��3�H���S7��3۹@ ���D�H��H�|$(t:H���8����u-�:8����t#�08����
�&8������8���؁�  ���yH�H��t��8��H�    H�t$0��H�\$XH��8����������H��HA��H�\$@H�t$0L�d$ A��H��M��H�    s��E�L�d$ H�t$0H�\$@H��H�H�l$8��H�    �������M�H��H��t
��E���   H�QH;�r�H��r�@   H�|$(�M7��H��H��tRH�HL��I��f�  f�h����H���6��H��H�u%�7����
�7�����8�
7���؁�  ��'3��#��6����
��6�������6���؁�  �H��t1H����6��H��t#��6����
��6�������6���؁�  ���H�|$(yH�H��t�k5��H�    ��H�l$8L�d$ H�t$0H�\$@H��H����������L��H��  H�7�  H��$@  I�[�I�k�I�s�I�{�M�c�L��$�  M�k�M�s�M�{�M��M��L��H�    I��E3�E3��������7��3�3�����tB�L�D$0A�  ��I����7��M�$L�L$0L�D$ 3�I��A������W  Ht$ ��;�r�H�T6�B   �_6��H��I�E u+��5������5�����  �y5���؁�  ��  H���6��H��H��u+�T5�����J5�����   �=5���؁�  ��   A�F�G   3ۉGA��I�FH�GA�H���tZfff�fff�L�D$0A�  ��I����6��M�$L�L$0L�D$ 3�I��A�M�$L�L$0L�D$ H��I��A�L�\$ ��;�J�<_r�f�  3�H��t;I�M �H5����u-��4����t#��4����
�z4������p4���؁�  ���yI�M H��t��4��I�E     L��$X  L��$`  L��$h  L��$p  H��$x  H��$�  H��$�  ��H��$�  H��$@  ��`  H�Ę  ����������������������H��H��XH�XH�hH�pH�x L�`�L�h�H��L�p�E3�I��M��3�L�"L���[4��H��H��uf��3����K��3���؅�y3�H��tI���%4����u�k3��3����W  3�H��L�|$8D�zsX��E���   �@3���؁�  ��I���3��H��H��u(�3����
�3������
3���؁�  ��s���3�돋D�O��rgH;�H��w_3�H�E����L��H��H�L+�L�E��t"I;�w7�fD9!u	fD9aAD�H��I;�v�3��#I;�wD8!uD8aAD�H��I;�v�3����E���xn��u��E��cD9��  uFD9g��   D�'L�H�I��H���P��t&L���  I��H�����������x"D���  D���  H�L��M��I��H���P8��L�|$8H��H�t$pH�l$h��   � ��   I����1��H����   ��1����n��1�����sH�T-ع@   ��1��D�D�M�D�L$(L�3�3�L��H�D$ ��0�����5�����1�����~1�����h����q1���؁�  ��T����]1���؁�  �I����1����u-�A1����t#�71����
�-1������#1���؁�  ���L�l$HL�d$PH�|$xyI�H��t��1��I�    L�t$@��H�\$`H��X������������������H��(H�\$8E3�A��H��H�t$@H�|$HM��H��H��L�E��sA��E��A�E�@��rmH;�H��weI�E��I����H��H��H�H+�I�E��t$H;�wF�   fD9u	fD9QDD�H��H;�v��'H;�w"�   D8uD8QDD�H��H;�v��A��E�E��xDE��u��E�H�|$HH�t$@H�\$8H��(�H�L��M��H��H��H�|$HH�t$@H�\$8H��(H�`@H�|$HH�t$@H�\$8A��H��(������������L��H��  H���  H��$`  I�[�I�s�I�{�H��$�  M�c�M�k�M�s�E3�E��L�2H�I��M��L��L�D$@H��3�L�t$@�������  H�|$@  v
�z ���  H�L�D$@H�T$PL��H��H��$�  �I��E���¹B   H��H�T$@��/��H��H��I�$u+��.������.�����  ��.���؁�  ��k  H��I���m/��H��H����   ��.������   ��.���؅�yH��I��tH���./����u�t.��I����xE����   H�T$PL��H������A��H����   I�$A����.������   �-.������   �.������   �.���؁�  ��q���H����-��H��H��u+��-������-�����I�����-���؁�  ��5���A���O���L�t$8L�t$0L�D$PA�����3�3ɉt$(H�|$ ��-�����<�����-������-�����(����s-���؁�  ������_-���؁�  ���H��$�  yI�$H��t
��-��M�4$L��$p  L��$x  L��$�  H��$�  H��$�  ��H��$�  H��$`  ��Y  H�Ĩ  �����������������H��(H�\$@H��H�I`H�|$H3�H��t
��,��H�{`H�KH�{h�{pH�ɉ{tH�|$HH�\$@t�-��3�H��(����������������̋BL��L�Ƀ�s��E��E3�L�DH��fE9Zv@H�JI;�w�f�:uH�BI;�wϋ��A���  �JH�IBA�BA��H�D;�|�Aǁ�     3�������������H��(���  H�\$@H�|$HH��H��t��E�H�|$HH�\$@H��(�H��P(��u��E�H�|$HH�\$@H��(��C L���B�� �  ����   ����   ����   �K,y�C,    �GtY�{, ��   �   ���  ������  �%�  +�Hc�3�AǄ���    AǄ���    �C H�|$HH�\$@H��(ø   ��ĝ  ������  �%�  +�Hc�AǄ���    AǄ���    �C 3�H�|$HH�\$@H��(ø�E�H�|$HH�\$@H��(�H�|$HH�\$@�   H��(�������������������HSH��@3�H��9��  �D$0�D$4f�D$0 f�D$2 �D$4   �D$8t9��  t���D$8H�L�D$PH�T$XfA� �D$(   f�D$   ���   ��x8H�D$XH�T$0f�@ H�H�L$XH�A�B�AH�D�D$PH�T$XH�����   H��@[��������������������H��H��HH�XH�h3�9��  H�pH�x H��H�h��h�h���   �M8�x���H����   D�F(�V$E3�H���0  H��H����   � ��   ���  ������  �%�  +�Hc�H����Ǆ���    Ǆ���    �F H�t$`��H�l$XtH�L$8�)��H��tH��   H���H�\$P��H�|$hH��H�H���t����0   軫��H��tD�F(�V$E3�H���R+  H���B���H���C���H���4  ������   H�L�D$03�H���P������   �D$0L�L�D$4�D$(H�T$8fA� H��f�l$ A���   ����x_H�T$8H�L�D$0H��H���P����y�   �;�   ��*����tH������H�D�D$4H�T$8H�Ή��  ���  ���   ����������   ����  ������  �%�  +�Hc�H�7��Ǆ���    Ǆ���    �F,�F �~������������������������H��HH�H�\$`�D$(    f�T$ H�|$h��H�T$0L�D$PfA� H�����   ��D��xH�D�D$PH�T$0H�����   D��E��u[f��uU�   ��י  ������  �%�  +�Hc�H�s��Ǆ���    Ǆ���    �C A��H�|$hH�\$`H��Hø   ����  H�|$h������  �%�  +�Hc�H���Ǆ���    Ǆ���    �C H�\$`A��H��H�������������������H��H3����  H�\$PH�l$XH�|$hH�D$8H���D$0��t
��E��E  H��P(��u
��E��1  �W L�d$@L�%���B��"  ����   ����   ����   ����   ����   ����   H�L�D$0H�T$8fA� H���D$(   f�D$   ���   ������   H�O0L���  ��H�t$`���������xH�D$8���  �HH�D�D$0H�T$8H�����   ����u`�   ��
�  ������  �%�  +�Hc�AǄ���    AǄ��� 	   �G � �@ ����E���   �H�L$8�%��H�t$`L�d$@H�|$hH�l$X��H�\$PH��H����������������H��XH�\$`H�l$hH�t$pH�|$x3�H��L�d$PL�l$HH��L��L����   fA����   H��H���;%��H��H����   �q$����y�g$���؅�yH��H��tI��� %����u�F$��H������   I�E L�D$0H�T$8fA� I�͉l$(f�D$  ���   ������   H�L$8L��H��H��账���}��#���؁�  ��{���I����#��H��H��u+��#������#�����S�����#���؁�  ��?������Z���H��|$(fD�D$ L�D$0H�T$8fA� ���   ��xTI�E D�D$0H�T$8I�����   ��H��t4I��� $����u#�F#����
�<#������2#������  ������L�l$HL�d$PH�|$xH�t$pH�l$hH�\$`H��X�����������������D�A��t(A��tA��tA��uH�H�`hH�H���   H�H�`xH�H�`p�@ �������������������H��(H�\$8H�ڋRH�t$@H��H���@   H�|$H�m"��H��H��t(D�CH��H��I������H�NXE3�L�Ǻ*  ��$��H�|$HH�t$@H�\$8H��(������������������H��H�D$pH�\$@H�t$8H�|$0L�d$(A��L��A��H��t!H�ӹ@   ��!��H��H�G`tH�Gh�_p�_tH�` u�z ���   � ���   9wts
��E���   H�OhL��I���Y���Hwh)wt�D$p��   �t t3�� �H�O`3�H����   �q!��H��tr�^!����Y�T!�����^�Wp��s��E���L�G`A�@D�HA��r�ȃ�;�rD;�v��E��H�I��H�����   ���3������ ���؁�  �H�w`H�wh�wp�wt��L�d$(H�|$0H�t$8H�\$@H��H����������H��HH�\$@H�l$8H�t$0�t$xH�|$(H���F�@   A���I��A� � ��H��H�u	�� ��f�(H��D$pf�AH��p3�H�|$(H�t$0H�l$8H�\$@H��H�������H��(H�t$@H��3�����H��H�FPu2� ����H�t$@H��(H�%	 ��� ����  �H�t$@H��(�H�\$8H�|$HH�~3ېE3�E3�3�3��h ��H��t<H��H�H��H��|�3���H�|$HH�\$8xv�P   胢��H��t/H��H���  �$������������w����  ��3�H��H���  t%H�H���RH���  ��  ��x3�H�t$@H��(ø �H�t$@H��(������������HSH�� 3�H�D$0    H9��  tNH���  L�D$0H��0��H����xH�L$0�O#������H�L$0H��tH��P��t3�H�� [H�%0#��3�H�� [�����������������H��H��xH�X H�h�H�p�H�x�L�`�L�h�L�p�E3�I��M��H��M��I�����H��H��u`�W����E�M���؅�yH��I��tI��������u�,��I������  H��A��sY��E���   ����؁�  ��I������H��H��u(������
������������؁�  ��y���A��떋D�O��rsH;�H��wkH�E��I����L��H��H�L+�L�E��t(I;�wA�   f�fD9)ufD9iD�H��I;�v�A���(I;�w�   D8)uD8iD�H��I;�v�A�����E����  ��u
��E���   D9ouA����   H�^�B   H��H�S����H��H�E u+�������������   �����؁�  ��   H���}��H��L��u(�������������}   �����؁�  ��lH�L�t$8L�t$0I�E H�G�\$(I�EA�M E�uD�I�D��H�L$ 3�L�3�������u%�K����
�A������7���؁�  ��A��H�t$hH��H�|$`t:I��������u-�����t#������
������������؁�  �L�d$XM��L�l$Pt;H�M �w����u-������t#������
������������؁�  ���yH�M H��t
�+��L�u L�t$HH�l$p��H��$�   H��x�������L��H��  H�7�  H��$`  �BI�[I�k I�s���I�{���H��M�c�E3�A(H���  H��H��I��D�d$ L�d$(t>�  ��x5H���  L�D$(H��,��H����xD�f,9{uH���������i  f� �d  9��  t&�8   莝��H��t�D�F(�V$E3�H����!  H���$�0   �h���H��t�D�F(�V$E3�H����  H��H��t�H�D�CH�SH���P��x�H�N0�9���L�L�D$PH�T$ A�  H��A�S���`���ff�fff�����   fD9d$PtH�L$P�|������tU��\$ ��tKH�L$(f�\$0�D$@   L�d$8�D$D�����D$H   H�H�T$0A�   E3��P8D�D$ H�N0������H�L�D$PH�T$ A�  H���P���h���f� �(H�N0��������   H�L$(�����������f� H�������H�L$(L��$p  H��H��$�  H��$�  ��tL�A�PH��tL��   H��A�H��$x  ��H��$�  H��$`  ��E  H�Ĉ  �H�������������z�����������HSH�� ���  ���  H��t��E�H�� [Ã��  u3�H�� [�H��P(��u��E�H�� [Ë}� �3����u�H���������u��C H�������t!��t��tH��H�� [�r�����E�H�� [ø   H�� [�������������H��(D�H�\$8H�|$HA��H��H��|A��~8A��tA��t,�@ �H�|$HH�\$8H��(�H�H�|$HH�\$8H��(H���   H�IH��t�5���W�@   H�t$@H������H��H��t(D�GH��H��I���A���H�KXE3�L�ƺ*  ����H�t$@H�|$HH�\$83�H��(���������H��H��XH�XH�hH�pH�x L�`�L�h�L�p�L��L�x�3�I��L��E��M��3�H�*����H��H����   ������v�����؅�y3�H��tI��������u����3�����  E����   H��H��H����   H=�����   3�H��H��tqf9tgH��H��u�W ��   �{���؁�  ��I���G��H��H��u+�Y�����O�����Y����B���؁�  ��E���3��^���H��uM�W ��F�W ��?H��t5H�����w,3�H��H��H��t8tH��H��u��W ��H��u�W ���W ���y
��E��   E���  H�W�@   ����H��H��u(�������������   �����؁�  ��rL�G3�H���)���L��H��H���'���A��$�   u6I�$H��I���P��t%M��$�  H��I�����������x!AǄ$�     I�$E��L��I��I���PH��L�l$HL�d$PH�|$xH��H�t$p��   I����������   ��������   ��������   �������   H�\?�@   H������H��H��u+�������������w��������؁�  ��c���L��3�H������D�_A�����D�\$(L��3�3�H�l$ �x����������:�����0���������#���؁�  ���������؁�  �H��L�t$@t1H������H��t#������
������������؁�  ���H�l$hyI�H��t�\��I�    L�|$8��H�\$`H��X�������������H��h��$�    H�\$`H�l$XH�t$PL�l$@L�t$8L��E��I��H��H�    A��tKH��H��M��t9H=���w13�H��I��t ff�ff�f9tH��H��u�W ��RH��uM�W ��F�W ��?M��t5H�����w,3�E��I��H��t8tH��H��u��W ��H��u�W ���W ���y
��E��  ��$�    H�|$H��   H�ӹ@   ����H��H��u%������
�������E�x���؁�  ��4L��3�H������L��H��H������I�D��$�   L��H��I���PP��H����   H���/��H����   �������   �
�����   H۹@   H������H��H��u%������
������������؁�  ��L��3�H���j���A�����L��3�3�D�l$(H�|$ �������A����������������C����v���؁�  ��/����b���؁�  ���H�|$Hy?H�M H��t6����H��t#�6����
�,������"���؁�  �H�E     ��L�t$8L�l$@H�t$PH�l$XH�\$`H��h������������������H��8H�l$HH�t$PH�|$X3�L�d$0E3䃹�  H��H��H�|$ t
��E���   H��P(��u
��E��   D�E L�����H�\$@C��  ����  ����  ����  �   �����  ������  �%�  +�A��Hc�E����� AǄ���    D�E tA��uw�~sJ��E�fA� H��H���+�����x��y��E��t������H�\$@L�d$0H�|$XH�t$PH�l$HH��8�H�MX�v�i����u.�����������؅�x�fA� ������؁�  ����D���<��H��H����  ��	u+H�T$ L��H����������xH�|$ 3�fA� �>���3�띃�u.H�T$ L��H�����������xH�|$ 3�fA� ����3��j���;5�� ��   H������H��s��� �3������H������H��u/����������3������������؁�  �3�����H�ω�N������   ��������   �������x��3���������i���؁�  �3�������u.H�T$ L��H���d�������xH�|$ 3�fA� �'���3������� ;�t;5
� u$E3�;�H�T$ L��H��A����������xH�|$ 3�fA� �����3��:����� ��������E�������   ��������������������L��H��HI�[I�s3����  I�{ H��I�s�H��t��E�I�{ I�sI�[H��H�H��P(��u��E�H�|$hH�t$`H�\$PH��H��G H�l$XH�-������(
  ����  ����  ����  �Cu
�� ��  ���  ��	u$D�KL�CH�T$0H������������  ��  ��u$D�KL�CH�T$0H�������������  �  ��u|D�KL�CH�T$0H�������������  H�H���P0���|  L�D$0H�T$8H��H�t$8���������yH�L$0���H�t$0�L  H�L$0����L�\$8L�\$0�0  ;#� �� ��   ;���   �S�   ����H��H�D$0��   H������H��t\D�CH�SH��蟎��H�L$0��������   ��������   �������������   �����؁�  ��   ����������H�L$0��� ��H�t$0�n�k��H�L$0�؁�  �����H�t$0�M�J����
�@�����9�6���؁�  ��(D�K;ʋ���L�CH�T$0H�ωD$ �{�������x��H���  H��tD���  H�T$0�  ���� ��   ���}  ������  �%�  +�Hc�Ǆ���    Ǆ���    H�OH���G t�����H�l$XH�|$hH�t$`H�\$PH��Hø�E���   �������������H�L$H��8H�\$HH�t$PH�|$XH��3��@ ��|$ H����	�����H�\$@�|$ ��u�C0   3���C0    ��H�\$HH�t$PH�|$XH��8��������HSH�� H��H�I@H��tH��PE3�L�[@L�[8D�[HH�� [�E3�D�[HL�[8H�� [������������������̸   ��A4����������������������HSH�� E3�M��M�L9ItH�IH�H�� [H� L�H�����L;��#  uL�RL;��#  uA���������t&L�L;��#  uL�BL;��#  t����D��E��uI�H��P3�H�� [ø@ �H�� [�������������HSH�� �   ��YH�y t
H�IH��R�CH�� [�������H��(H�\$0H�l$8H�t$@H�|$HH�yI��H��H��H��u
��� ��   �H tmH�8H��t�f�:uH�y8 tH��0I���^  ����   H���T�����x|�H���������xmE3�H�WA�����A�H�b	����tA�	�H�������@ ��>H�{  t�C�E H�C(H�EH�C H�Ef�>uH�S0H�K��  3�H�CH�C H�C(H�|$HH�t$@H�l$8H�\$0H��(������������L�AHM��t�
fff�fA9tM�@ M��u�j ��3����������H��8H�yH H�\$0H�|$(H��H��uh�(   �J�?��H��L��H�CHu� �H�|$(H�\$0H��8�H�I�H�GI�CH�GI�CH�GI�CH�CH�CXH�CP3�H�|$(H�\$0H��8ú(   �J����H��L��t�H�I�H�GI�CH�GI�CH�GH�|$(I�CH�CPL�X �CXL�[PH�\$03�H��8���������̸@ ������������HSH�� E3�I��M�L�L�����M;��#  uL�ZM;��#  uA���������t&I���#  L�L; u
L�BL;@t����D��E��uH��H�tH��P3�H�� [ø@ �H�� [������������̸   ��A����������������������HS3�D��L��H9YtyM��u��t
�@ �[�A�M��t`�A9AsXE��tGI�KA�SI�� H����A���H�
I�@�H�D
I�@�H�D
I�@�H�D
I�@�A�CA�CA9Cr�M��tA�3�[ø   [����������������̋AD�D;Ar�   �D�A3���������A    3��������H����H�Q8�AH   H�3��A4H�A@�A0H��������������H��(�y0 H�\$0H�l$8L�d$ H��H��E��tlH�|$HH�yH�����H�[@H��tCH�KH�t$@�	��A��	u	�C   ��   �    A��D��CH�t$@H�k H�C(    H������H�|$HL�d$ H�l$8H�\$0H��(���������������H��(H�\$0H�l$8H�t$@H�|$H3�H��I�8H�L�d$ L�%a���I��H��I;�$�#  uH�VI;�$�#  u���������u	I�H��PH�I��$�#  L�d$ H;uH�NH;Hu���������u09{0t+H�K����H�C@H�E H9{@t	H�H���RH�K����H9} H�t$@H�\$0H�l$8�@ �D���H�|$HH��(�����������H��(H�\$@H�|$H�����H����y4��u&H��t!9y0H����H�t
H���c��H�������H�\$@��H�|$HH��(�����������H��(H�y H�|$HH��t
H�IH��PH�t$@�������w��u|H�Y��H�OH�\$8H����E3�L�_L�_ H�O0L�_(����E3�L�_0L�_8L�_@H�OHH��tff�ff�H�Y �N��H��H��u�3�H��H�GHH�GP�GX�����H�\$8H�|$H��H�t$@H��(��������������������H��(H�\$@H�|$HH���������Y��u.H��t)H����H�H�IH��t����H�G    H��艄��H�|$H��H�\$@H��(�������������������H��HH�\$PH�t$`H�|$hL�l$8L��H��L�t$0E3��   L�2H�T$ ��I��������y
� ��   H�L$ H�l$X�nH���L�d$@���PH��L��tVH�VLc�H���΃���    ����H��H��t/D�sL�sD�sD�sH���H��H��FL�c�CH��P�I��A��H�L$ H��PL�d$@H�l$X� ���I�] AE�L�t$0L�l$8H�|$hH�t$`H�\$PH��H��������H��(H�\$8H�t$@3�9q0H�|$HH����   H�������H�K@H��t
H��PH�s@�`   ����H��H��t8H�����qH�YH�3�H�qHH�qP�qXH�AH�A H�A(H�A0H�A8H�A@�H��H��H�K@t&H��PH�K�<�����H�|$HH�t$@H�\$8H��(�H�|$HH�t$@H�\$8� �H��(��������������H��(H�\$0H�l$8H�t$@L�d$ E3���I��H��M� t.A�L$ �P���H��H��tMH���D�cL�cD�cD�cH��,�    �"���H��H��tH�Q��D�cL�cD�cD�cH�H��u
� ��   H�H��H�|$H�P�EXH�}HH�й@   �CH�������H��H�Cu� ��LH��tDI�Ԑfff�fff�fff�H�H�KH�� H�D�H�GH�D�H�GH�D�H�GH�D�H� H��u�A�ą�H�|$HxH�A��L�d$ H�t$@H�l$8H�\$0H��(������������������H��tE��tH�QD�A 3�øW �����������������������f�: L��tK�y tHL��p  H�+q  ff�M�I��M+�ff�fff�D�B�D+�uH����u�E��tYI��L;�|�3��L��p  L��q  fff�ff�fff�M�I��M+�ff�fff��B�+�uH����u��tI��M;�|�3�ø   �������H����Q3�H�H��D�AH�Q�Q H�Q�Q(������������L��H��  H�o  H��$�   3�f�D$p  I�s�H�D$rH�D$zI�{�M�c�3�I��z���H9yM�k�I�C�I�C�I�C�I�C�I�C�I��L��L��H�L$@�@ �t
H�IH��P(����  M��H��$(  H��$   L��$�   L��$�   ��  H�-���L�%��L�5�o  L�=?p  ff�fff�I�ML�L$HL�D$PH��   �P����   �\$PD�@ H�T$p��f�D$p�����E�]E��tH�|��fff�;t�H��H;�|��H�z��;t�H��I;�|�f�|$p ��   E��tHL��n  f�ff�M�H�D$pL+�f�ff��B� +�uH����u���D���I��M;�|����4���L��n  �fff�fff�fff�M�H�D$pL+�f�ff��B� +�uH����u�������I��M;�|�������������H��H��@  v�0  L��$�   H��$   H��$(  L��$�   3�L��$�   L��$�   H��$�   H��$�   H��$�   �'  H��  ËD�H���8��8��3�H��H��3�I��H���o}��H�T$@Lc�I��L�5�m  L�=ln  fff�H�JL�L$HL�D$PH��   �P���F����\$PD�@ H�T$p��f�D$p�,���H�T$@D�ZE��tH��	��H��	��;t�H��H;�|��H��	��H��	��;t�H��H;�|�f�|$p ��   E��tIL��l  ff�ff�M�H�D$pL+�f�ff��B� +�uH����u��H�T$@�/���I��M;�|��NL��l  �fff�fff�fff�M�H�D$pL+�f�ff��B� +�uH����u��H�T$@�����I��M;�|�I;��4�����z tQHc�L�D$p3�H��I�D�3�H�L$8H�L$0D�I��D$(    H�D$ �_�����H�T$@�������H��H��$�t���Hc�H�T$pA�   H��I�L��
|��H�T$@��H��H��$�E�������������������������A(    3��������H��
���Q3�H�H��D�AH�Q�Q H�QH�Q(H�Q0�������L��H��  H�gj  H��$`  I�[ I�k�M�c�L��H�L$(I��H��H�L$R3�A�  f�D$P  ��z��I�|$ �@ �tI�L$H��P(���f  H��H��$�  H��$�  L��$�  L��$x  L��$p  �V  �+L�=V��H�5k��H�-�j  L�-�j  L�5�k  f�fff�fff�fff�I�L$L�L$ L�D$0H��   �P����  �|$0H�T$PA�  ��f�D$P�I���E�\$E��tH����;8t�H��I;�|��H����;8t�H��H;�|�f�|$P ��   E��tBL��ff�ff�ff�I�8H�D$PH+�f�ff���8+�uH����u���E���I��M;�|��>L�#j  ff�I�8H�D$PH+�f�ff���8+�uH����u������I��M;�|�3�H�|$PH������f�H�эD	�����D�#3�H��M���?y��H�\$(L�=���H�=��L�-�i  L�54j  fff�fff�fff�H�KL�L$ L�D$0H��   �P���W  �t$0H�T$PA�  ��f�D$P������S��tH�l��fff�;0t�H��I;�|��H�j��;0t�H��H;�|�f�|$P ��   ��tJL��h  ff�ff�I�8H�D$PH+�f�ff���8+�uH����u��H�=,���>���I��M;�|��NL��h  fff�fff�fff�I�8H�D$PH+�f�ff���8+�uH����u��H�=��������I��M;�|�3�H�|$PH������f�H�э	�CD;�|7�u H��H�T$PD��H�͋���w��H�����+�H�\$(H�=��D������z ��3�L��$x  L��$�  H��$�  H��$�  L��$p  L��$�  H��$�  H��$�  H��$`  �i!  H�Ĩ  ������������������H��H��tE��tH�QD�A H�Q(A��H�H03�øW ���������H�AH��tH�A(�A H�A03�ø@ ���������������������H��8H�\$HH�|$XH��H�L$ H�D$     ���������x:H�OH�t$PH�t$ H��tH��PH�G    H�L�G�   H���P@H�t$P��H�L$ H�|$XH��tH��P��H�\$HH��8�����������H��(H�\$@H���H��H�H�IH�|$HH�ɋ�tH��PH�C    @��H�|$HtH���v��H��H�\$@H��(�������������H��H��XH�XH�hH�pH�x L�`�L�aM��L�h�L�p�L�x�M��I��H��H���@ ���  �y  �w  L�5F��L�=[��ff�D�G(A�@H���G H��H;���  K��A���E � tk�G(I��H��H���T$(�   M�D�D�J3�H�t$ �������u+�m������c������   �V����؁�  ��   H�3�f�DF�  �   I��H��H�����wq�G(3�H��H��L��M�L�u�W ��Y�   H+�fff�H�H��t)A�f��t fA� I��I��H��u�I���z �fA��H��u	I���z �fA�   ��W ��G(��xB��t=H��H���|����������9G�M t]H�� ��f�ff�;�����H��I;�|��u�E     f�  L�|$8L�t$@L�l$HL�d$PH�|$xH�t$pH�l$h��H�\$`H��X�H�� ��;�P���H��I;�|�릻   ���������������H��H��HH�y H�XH�hH�pH�x L�`�L�h�L�p�I��L�x�M��L��H�پ@ ��/  �y  �%  H�y0�y  H��L�5
 ��L�= ��ff�fff�H�C(�A�M H�C0�H�C(L�C0H�{(I��H�����wlI�����wc3�H��I��H��u�W ��TL+�fff�fff�I�H��t&�f��tf�H��H��H��u�H���z �f��H��u	H���z �f�  ��W ���xe3�H������I��f�H�э	H�K0H;���   HS(H+ʃ�H�K0t3I��H��������ux9CA�M tYH�����f�;tbH��I;�|��uA�E     fA�$  L�|$(L�t$0L�l$8L�d$@H�|$hH�l$XH�\$P��H�t$`H��H�H�����;tH��I;�|��H�{0������   뚾�E����������%�����������%�����������%t����������%��������������������3��#Eg�A�����A�ܺ��AvT2�A�A�������������H�L$H��H��hD�YD�AD�IH�XH�h H�p�H�x�L�ҋA�
A�zL�`�L�h�L�p�L�xЉL$xA���|$A3�A#�A3��A�R��T$A��A3���#�A3��A��A�E�B3���D�D$#�A3�A�D��A�E�JD3���D�$D#�D3�E�D��D3�E�E�ZA��D�\$E#�D3�D�Dȋ�A3�A��A#�3�A�E�Z�A��D�\$A3���#�A3�A�E�Zʋ�D�\$A3���#�A�Z$E�b E�j(A�r0E�r4A�j8E�z<A3щ\$ A�E�Z,A�D��D�\$D3���D#�D3�E�E�D��D3�A��E#�D3�D�Dȋ�A3�A��A#�3�A��A��A3���#�A3�A��A����3�#�A3��A�D��D3���D#�D3�E�E�D��D3�A��E#�E��D3�D3�D�D�A��E#�A��D3�E�D�A��A��A�A#�A#��L$x���y�ZA�����A#�A��#���F���y�ZA��A��A���#�A#��A��A�F��	�y�ZA��A��	A�A#�#��A���F���y�ZA��A��A�A#�A#��A��L$D���y�ZA��A��A�A#�A#��L$B���y�Z���ʋ�A�A#�A#�ȋ��F��	�y�Z��A��	A�A#�A#��A��A�F���y�ZA��A��A�A#�#��A��L$F���y�ZA��A��A�A#�A#��L$D���y�ZA��A��A�A#�A��A#��A��A�B���y�ZA����	�#�A#�ȋ��B��	�y�Z�����#�A#�ȋ�$B���y�Z����#��#��L$F���y�ZA��A��A��#��#��A��L$D���y�ZA��A��	A#�A�#��A��A3�A�D��9�y�ZA��A3�D$x�����nA��A3���3�A�F�� ���nA��	A��A��A3�3�D$F�����nA��A3ɋ�3��F�����nA��A3�L$D�����nA��L�d$PA��A3�A3�A�L�l$HB�� ���n��	��A3�A3�D$F�����nA��A3ȋ�A3��F�����nA��A��A3�A3�L$F�����nA��A3�D$ �����n��	��A3�A3�D$B�� ���n��3ˋ�A3�A�L�t$@F�����n��A��A3�A3�$F�����nA��A3�D$D�����nA��	A��A3�A3�D$�����nA����3�A3�A�L�|$8B�����nL�T$pA���A�A�A�B�A�BA�B�A�BA�BA�A�BH�|$XH�t$`H��$�   H��$�   H��h����������H��8�AH�\$@H�t$PF��H�|$XL�d$0D��B��    A��A��H��H��A��?D;�D�Is�A��H�l$H��AE��t5C�,��@r,�@   I�LA+�D�����Uk��H�VH��H��]������E3�@��tz��@��   L�l$(D��I��ff�fff�H�H�VH��H�FH�GH�F H�GH�F(H�GH�F0H�G H�F8H�G(H�F@H�G0H�FHH�G8H�FP�e���H��@���I��u�L�l$(�)��@r$��H��ff�fff�H��H���5���H��@���H��u��H�l$HtI�L4D��H���~j��L�d$0H�|$XH�t$PH�\$@H��8��������L��H��   H�wY  H�D$p�Q�AI�[�QX��I�s��?I�{ �A\��8H��s�8   ��x   +�H�L$ 3�D����i��H�T$ D��H���D$ ��"���H�WXA�   H�������GD�H��$�   H��$�   �G\�GD�_X�G`�G�Gd3�H�GH�G H�G(H�G0H�G8H�G@H�GHH�GPH��$�   H�L$p�  H�Ĉ   ������������L��H��   H��X  H��$�   �AXI�[I�s ��?�@   I�{�+�H��H����w��@D�C�H�L$03��i���WX�OT�����D$0���D��ȍ�    H�T$0�L$ �D$$H�D$ H��H�D(�|��H�G@H��H�H�GHH�F�GP�F�Ej��H��$�   H��$�   H��$�   H��$�   �  H�Ę   ���������H�L$H��H���   D�D�ID�AL�P�H�X�YH�h H�p�H�x�L�`�L�h�L�p�L�x�H�I�H�BI�BH�BI�BH�BI�BH�B I�B H�B(I�B(H�B0I�B0H�B8�QI�B8�t$P�l$XA��A��3���A#��A3��A��D��1�y�ZH�L$PA3�H�� A#�A����3�A��D��
�y�ZA��L�\$X��I�� A��3�A��L�\$HA#���A3���A�����y�ZA��3ʋ�A#���A�3��A��E���y�ZA��A����A3�D�d$`D�l$h#�D�t$pD�|$tA3�A������
�y�ZH�T$`A��3�H�� ��A#���H�T$@A3��H�T$h�A��H�� E��
�y�Z��H�T$8A3�A��#���3�A����E��	�y�ZA��3�A��A#���A3���A�����y�ZA��3ˋ�A#���3�A��A��E���y�ZA��A3�A��#���A3�A����D���y�Z�\$xA��3�A��A#����A3��A��E��
�y�Z��A����A3ȋ\$|��$�   A#�Ë�$�   3��A��E���y�ZA��A3�A��A#���A3�Ë�$�   �A����
�y�ZA��A3ɋ�A#���A3���A��E���y�ZA��A3�A��#���A3�ǋ�$�   ���E��	�y�ZA��3�A��A#���A3���A��A��
�y�ZD�Ӌ�E3�A3ȋ�D3�A#�D3�3�A����A�D��$�   L�T$HD3�$�   �A��E3�A���y�ZA��D3T$TA3ɋ�A��#���A3�A�L�T$Hȋt$x��D��
�y�Z��$�   ��A3�3�A��#�A3�A3�3Ջl$|����$H�T$@���3�3T$\E���y�ZD��$�   3�$�   E3ŋ�3���E3�D3D$HA#�H�T$@3�A������A��A��A��	�y�ZL�L$8��A3ʋ�D�D$,A3���A��A��D�����n��$�   A��D3�A3�A��D3L$d3�D3$A����A�L�L$8���D�����n��$�   A��A3�A3�A��A3�3�3\$@����É\$0�D�l$,D��$�   E��
���nE3�A��A��D3d$lA��A3�E3�3�A����A�D�d$,D���E3�A��D3d$8E�����nA��D3�$�   A3�A��A3�A����A�D���E3�D�<$��
���nA��D3�D3t$H��$�   ��A����A��A�A3�A3��A����3Ƌt$,E�����n3�A��A3�A3���3ʉD$A���|$��ǋ�$�   �����3�E��	���nA��A3�A3�3D$@3����D$A���l$����E��
���n��$�   A��3�A��A3�A3�A3�3����D$A�\$��Ë�$�   �3ߋ|$E�����nA��3�3\$8A��A��A3������A3ʉ\$ ȋ�$�   �\$03ŋ�$�   ��
���n3�A��A��3�A3���A3ˉ�$�   ��D��$�   ��A�D��$�   D3|$�A��E�����nD3�A��D3|$HA3�A��A����3�A�D�|$D�<$ȋD$ ��A3�E��	���nA��A3�A3�3�3����$A���,$���ȋ�$�   E��
���nA��A3�A��A��3l$@A3�3l$H3�����ŉl$�l$�3�A��E�����nA3�A��A3�A3�A��A3�����ŉl$�l$�A��D��D3|$8��
���nA��D3|$@A3ʋ�D3<$A3�A����A�D�|$D�|$�A��A��3�E�����nA��A3�A3�3D$3����D$A��D�l$��A�ȋD$ ��3�E��	���nA��3D$8A3�3D$3����D$A��D�l$��A��A��E��
���nD��$�   A��A��A3�E3�3�D3�\$D3l$A3�A����3�3\$�4$A��A����E�����nD�l$8�\$(A��A��A3���A3���A���Ǎ�
���nA3�D�d$3D$��A��A�3�A#������D$$A��A#�ȋ�L$$A3�A�A3�A��D��ܼ�A3�A�����E��A#�D3�|$D3l$(�D$A��D�t$#�D3��A��A���A���A��D��ܼ�A��D�,$A�����A#�A��#��A�D�l$ A�A��A��D��ܼ�3ŋl$3D$$A��A��A�3�#������D$A��A#�ȋ�$�   L$A3�D�|$A�A3�D�t$D��ܼ�A3�A����E3�D�l$D34$�D$ A����E3�A��A�A��A#�A#��L$ �A��A�ƍ�ܼ�A��A��A�A#Ë�A#���D�t$ȋ�$�   3D$A�3D$8A�A��D��ܼ�3�A�����A�Љ�$�   A#�A��#�����$�   A�D3t$$D��ܼ��D$3D$ D3���3D$(D3���$�   3t$A3�A�����3�A#ˉD$A3�A��A��#����L$A�A��A��D��ܼ�D�t$A��A�A��A��#�A#����A�D�t$D34$A�A��D��ܼ���E3�D3��|$A����A3�A��A�3�A��3|$A#�A#�ȉt$��A��A�ƍ�ܼ�A��A��A�A#Ë�A#���D�t$@�A�A�A����D��ܼ��|$A����D�d$ ��$�   A��D3d$8�3l$$A#�3l$8E3�D�|$(D3�t$A3�3�A��#�A3�D�l$�D3l$A3��E3�A��A���A��D��ܼ�#�A���A��E3�A#���D�d$0�A�A�A����D��ܼ�A��A��A�A#�A��#����t$(��A�A����D��ܼ�A��A��A�A#�A��A#����l$8���A��A�ō�ܼ�A��A��A�A#Ë�A#���D�l$,�A�A�D�$��ܼ�D�|$ D3D$$D3<$A��D3Ƌt$E3�D3D$3t$E3�D�t$A��3�3t$D3t$A���E3�A��D3t$A#�#�ȋӋ�A���D�D$$A�����D��ܼ�#ǋ��A�щt$A#�����A���A��D��ܼ��ˋ�A�A#�A��#���D�|$H�A�A�A��A��D��ܼ�A��A��A�A#�A��#���D�t$�A�ϋ�$�   A����D��ܼ�3l$ 3�A3��ŉ,$D�d$A3�A��D3d$3|$8A3�A3�E3�A��D3d$(���Ë\$A������b�3�A��A��D�d$A3���A3�A�A�A����D����bʉ�$�   ��A3�A��A3���ǋ|$A�3���D����b�A3���3|$A3�A��A3������E��|$D3l$$�|$@A�D����b�A��D3�D3닜$�   ��A3�A��3�3\$A3�A��3\$A���A�A����D����b�A���\$A��A3�D�l$��A3��D3d$,�t$�A3�D�|$83t$0����b�A��3�A3�A��3l$0D�t$(��A3�E3�D��$�   3|$3�D3�A3�A��A3���A3��A�A����D����bʋ|$@A3�A��A3����A�����D����bʋl$0A3�A��A3����A�A��A��D����bʋ�D�d$A3�A��A3���A�A�D�D$$A������b�E3�A��E3�D�|$A3�D3|$D3�A3�A�Ƌ�A����A��D3|$,����b�D3�A��A3�A����3�A�A�D�L$H������b�A�ы�A3�A3Ћ�3�A3�A3������A�D�T$��D����b�E��D3D$3�A��3�E3�D3D$A����A�A�D�$��D����b�E3�D�L$E3�D��$�   E3�D3$D3�D3�D3L$@A��E3�D3T$0��A��3���A3�A��A��A������bʋ�A3ċ�A3���A��A��A����b�A��A3ŋ�3���A�ŋl$����b�����A3��3T$A3�A3�3l$L��$�   3�A3Ӌ�3T$�����$�   A�L��$�   A3�L��$�   D����b���A3�L��$�   A��3T$��3�����3��A�L��$�   ������b�A�	�ŋ�����3�A3��H��$�   ��(��b�H��$�   �A�A�A��A�	EAA�AA�A�H��$�   E�AA�AA�A�H��$�   A�AH���   ���������������H��8�AXH�\$@H�l$HH�|$XL�d$0D��A�A��?A��A;�H��H��AXs�ATE��H�t$Pt6C�4��@r-�@   A��A+�H�D�����zV��H�M@H��H��^������E3��@r/��L�l$(H��ff�fff�H�M@H������H��@���H��u�L�l$(��H�t$PtA��D��H��H��V��L�d$0H�|$XH�l$HH�\$@H��8�������fff�fff�f�H;E  uH��f����u�H���R����������fff�fff�f�H��L�$L�\$M3�L�T$L+�MB�eL�%   M;�sfA�� �M�� ���A� M;�u�L�$L�\$H�����������fff�fff�f��tPL��   L��  L�H��E3�ff�A��A�
D�E�E�
D�A�B�	B0H��u�D��   D��  ������������R d p C l i p A l r e a d y R u n n i n g M u t e x   ����������RDPSND ���������A l l o w C o d e c s   ��������M a x D G r a m   ��������������E n a b l e M P 3 C o d e c   ��D i s a b l e D G r a m   ������M i n B a n d w i d t h   ������M a x B a n d w i d t h   ������S O F T W A R E \ M i c r o s o f t \ W i n d o w s   N T \ C u r r e n t V e r s i o n \ D r i v e r s 3 2 \ T e r m i n a l   S e r v e r \ R D P   ����������L o c a l \ R D P S o u n d W a i t I n i t   ��R D P S o u n d   w i n d o w   R D P S o u n d - R e c o n n e c t   ����������R D P S o u n d - D i s c o n n e c t   ��������L o c a l \ R D P S o u n d S t r e a m   ������L o c a l \ R D P S o u n d S t r e a m M u t e x   ������������L o c a l \ R D P S o u n d S t r e a m I s E m p t y E v e n t   ��������������L o c a l \ R D P S o u n d D a t a R e a d y E v e n t   ������CLIPRDR ��������R D P C l i p - D i s c o n n e c t   ����������R D P C l i p - R e c o n n e c t   ������������R D P C l i p   -   R e c e i v e   T h r e a d   ��������������R D P C l i p   -   C l i p   T h r e a d   ���� B  !   0$  �$  �C !   T[0$  �$  �C !   T[ 4\0$  �$  �C !   0$  �$  �C !^ ^4\T[0$  �$  �C $ $tYdZ
]!   0'  W'  4D !
 
d 4 0'  W'  4D  t !   �'  (  dD !
 
d 4 �'  (  dD  t !   �(  �(  �D !
 
d 4 �(  �(  �D  t  0   0   0  ! !t 4 
 ,
 ,t %d !T 4 
  20 B   B   � t d T 4 �   b�P  	G5<� 8� 4� 0� ,t (d $4  3 P~�     m.  �.  �/  �.   20!   00  `0  �E !   �  �  t  d 00  `0  �E !   00  `0  �E ! � � t d 00  `0  �E 	 �	 �
 T 4 �   20 20 	00   t	 4 B   R0 B�P  	;%0� ,� (� $t d 4 #�P  ~�     �8  9  ;  9  !   t @;  O;  �F ! �
 t d @;  O;  �F  T 4 �  !   �=  �=  �F !   d �=  �=  �F !   �=  �=  �F ! d �=  �=  �F $ $t 4! 
 !   `>  �>  0G !   �  T	 `>  �>  0G ! � T	 `>  �>  0G  t d
 	4 b  !   p?  w?  �G !   w?  �?  |G ! d 4 w?  �?  |G ! t p?  w?  �G     B  y yT q4 $�  � � � t d 
  B   b�P  	U5G�> @�? 9�@ 2�A +tB $dC 4I 3D 
P~�     +E  LE  �F  LE   bP0  	@55� 1� -� )� %t !d 4 3 
P~�     /G  PG  @I  PG  !   pI  �I  �H ! t pI  �I  �H  4
 b  !    J  MJ  �H ! 4  J  MJ  �H  � � t d T 
 !   �K  �K   I !   �K   L  I ! d �K   L  I ! t 4 �K  �K   I  
  20 20 B   B     t! d  4 
 R R� Nt Jd ;T +4 
 !    Q  �Q  �I !, ,� "d T 4  Q  �Q  �I  t �   20!   T  3T  �I ! t	 d
 T T  3T  �I    � � � � 4 �  !   �V  �V  ,J ! t T �V  �V  ,J  � d 4 �  !   Y  wY  �J !   wY  �Y  �J !   �Y  8Z  �J !   8Z  OZ  �J ! � 8Z  OZ  �J ! 4 �Y  8Z  �J ! � T	 wY  �Y  �J ! t Y  wY  �J  d
 b   �`P  	>U3� /� +� '� #t d 4 S	 P~�     �[  �[  �_  �[   b�P  	J5?� ;� 7� 3� ,t %d 4 3 P~�     �`  a  �h  a   20!    i  $i  �K ! t 
d 4  i  $i  �K  �  !   �c Pk  ik  �L !   �c ik  mk  �L !   �c  tf ik  mk  �L !   �c  �d  tf ik  mk  �L !   �c  �d mk  uk  �L !   uk  �n  xL !   �b  dk uk  �n  xL !   uk  �n  xL ! �b dk uk  �n  xL ! �c �d �e mk  uk  �L ! tf Tj ik  mk  �L ! 4i Pk  ik  �L  
g  b  !   0y  ;y  �L !
 
t	 4 0y  ;y  �L  B   20 204 4�L 0tM %dN !TO 4P 
Q !   �{  :|  PM ! d �{  :|  PM    � � t T 	4
 �  4 4�L 0tM %dN !TO 4P 
Q  b   20 20!        �M !
 
t	 4      �M  B  !   �  �  �M !
 
t	 4 �  �  �M  B   t	 4 B  !   t ��  ��  `N !   ��  �  HN ! T ��  �  HN ! t d ��  ��  `N 	 	4
 �   t	 	4 B  !   ��  :�  �N ! 4L ��  :�  �N % %tM I !   ��  ��  �N !'
 't� �� d� T� 4� ��  ��  �N  
�  t	 	4 B  , ,tJ (dO $4N 
K  t 	4
 b   t	 4 B  !    �  ��  PO ! t	  �  ��  PO  4 B   t d 	4 b  !   `�  ލ  �O !   d `�  ލ  �O !   d `�  ލ  �O ! d `�  ލ  �O    � � t T 4
 �  !   ��  Ў  �O ! t ��  Ў  �O  4 �  B B4 t	 B   t d 4 �   RP	 t 4 
 ~�       ͑     ��  {�  ۓ   �  ۓ         = =�	 9�
 5� -� 't #d T 4 �  !   ��  ��  �P !   ��   �  �P ! � ��   �  �P ! d
 ��  ��  �P 	 � t T	 4 b  !   �  �  t  d p�  ��  HQ !� �� @� 8d � t T p�  ��  HQ    4 
 L LT D4 t d  t 4
 b   B   20 	 0  !   ��  �  �Q ! � 4 ��  �  �Q 
 � t d T 
 !   @�  ��  DR !   ��  ʯ  ,R !   ʯ  �  R ! �R ʯ  �  R ! tU ��  ʯ  ,R ! �Q �S @�  ��  DR )
 )�T %dV !TW 4X 
Y 6 6�* -�+ )t, %d- !T. 43 
/ B	 Bt 94 d T 	�   r0!   P�  ��  �R ! �# �$ t& d' P�  ��  �R ( (�% $T(  4- 
)  t 4 �   t d 4 �  	 B  ~�     t�  ~�     ~�  $	 $t	 d T 4 B  $	 $t	 d T 4 B  !   ��  Ҿ  |S !
 
t	 4 ��  Ҿ  |S  d B  !   t  d
  T	  4 0�  o�  �S ! t d
 
T	 4 0�  o�  �S  � 	� b  !   @�  ��  T !
 � � d! T" 4' @�  ��  T ( (� $�  t  
# !    �  	�  HT ! t	 d  �  	�  HT 	 	4 B  !   ��  ��  xT ! 4 ��  ��  xT 	 	t	 B   0  1	 1t	 d T 	4 B  !    �  \�  �T !   t  �  \�  �T !    �  \�  �T ! t  �  \�  �T "	 "� d T 	4 �  � �t	 4 B  !   ��  ��  <U !
 
t	 4 ��  ��  <U  B  [ [t	 6d 4 B  !   t 0�  9�  �U ! t 4 0�  9�  �U  �  1 1t d 4 �   20!   P�  ��  �U !   d P�  ��  �U !   P�  ��  �U ! d P�  ��  �U  t	 4 B  	 	�0 20!   0�  w�  XV !   w�  ��  DV ! t w�  ��  DV ! � 0�  w�  XV " "� � d	 T
 	4 �  !   ��  ��  �V !   ��  ��  �V !   ��   �  �V ! � ��   �  �V ! � � ��  ��  �V ! T ��  ��  �V 	 � t	 d
 	4 �  !   P�  ��   W ! t P�  ��   W  d 	4 b  !   ��  0�  TW ! t ��  0�  TW G	 GT � d 4 �  A A�K =�L 9�M -�N )tO %dP !TQ 4R 
S !   � ��  ��  �X !   �  �	  �
  t ��  ��  �X !   �  �  �	  �
  t  d  T ��  ��  �X !   �  �	  �
  t ��  ��  �X !   ��  5�  \X !   � ��  5�  \X !   ��  5�  \X ! � ��  5�  \X ! � �	 �
 t d T ��  ��  �X  4 �  !   ��  ��  �X ! t	 d 4 ��  ��  �X  B  !   ��  q�  �X ! TS ��  q�  �X 9 9�N 5�O 1�P %tQ !dR 4T 
U !   ��  ��  0Y ! t	 4 ��  ��  0Y  B  !   ��  ��  `Y !
 
t	 4 ��  ��  `Y  B   r0!   t  d  T  4
 ��  ��  �Y !   t ��  ��  �Y ! t d T ��  ��  �Y ! 4
 ��  ��  �Y  �   t 4 �  !    �  n�  XZ !   n�  ��  DZ !   d n�  ��  DZ !   n�  ��  DZ ! d n�  ��  DZ ! �  �  n�  XZ  t T 4
 �  ' '�	 "�
 t d T 	4 �  % %t	 d 	4 B  	 � t d 4 �  	 t d T 	4 �  !   P�  ��   [ !   t	  4 P�  ��   [ !   P�  ��   [ !
 
t	 4 P�  ��   [ 	 	d B   20!   �	 ��  ��  �[ !   �	  �
  � ��  ��  �[ !
 �	 �
 � t d ��  ��  �[  T 4 �  !   �N  tO  dP  TU 0�  P�  �[ !   tO 0�  P�  �[ ! �N tO dP TU 0�  P�  �[    4T 
Q  20x xd t	 4 B  !   � @�  K�  �\ !   � K�  O�  �\ !   �  � K�  O�  �\ !   �  �  �	  �
  t  d K�  O�  �\ !   �  � K�  O�  �\ ! � � �	 �
 t d K�  O�  �\ ! T @�  K�  �\  4 �  !    �  ��   ] ! t	  �  ��   ] % %�  � d
 T 4 �  !   4 �   T] !   �   T] ! 4 �   T] 	 � t d
 	T	 b  !   t  d  T  4
 � � �] !   � � �] !c cT t d 4
 � � �]  �  	 t d
 4	 	b  ~�     V b    b  20 20 20	 t	 d T 	4 B   t 4 b   20 0  !   � � �^ !   �  t^ ! d �  t^ ! t	 � � �^  � T 4 B  !   p � �^ ! � p � �^ 	 t	 d T 	4 B   t	 	4 B  !   � � _ ! 4 � � _ " "d t	 B   t	 	4 B  !     Q T_ ! � T   Q T_ # #� � t d 	4
 �  !   t	  d  4   �_ ! t	 
d 4   �_  B  !   � � �_ ! t	 � � �_ 	 � d T 	4 B  !   �  �  T   4% P � <` !   P � <` !   � � T  4% P � <` I
 I� 8� 4t &d 
! !     o �` !(
 (�N  �O �P tR dS   o �` % %�Q !TT 4Y 
U !   p y �` !   y � �` ! d
 y � �` ! t p y �` 	 	4	 b  !      a ! t	    a 	 	4 B  . .� *� &�	 �
 t d T 4 �  / /� (� $�  � t d T 4
 �  D D� @� <�	 8�
 (t $d  T 4 �  !   �( �( �a !   �( ) �a ! � �( ) �a ! T	 �( �( �a 	 � t d
 4 b  1 1t *d  4 
 0 0t $d  4 
 A A� =� 9� 5� 1t -d )T "4  !   p= �= �b !   �= �= |b ! � �= �= |b ! d
 p= �= �b 	 � t T	 4 b  �h         4k   �c         �k    �d         0o �   d         Po `  (g         �p h  (h         
q h  hh         q �  @h         lq �  �f         Rr �  �h         �r �  �i         �r �  g         �v P  �i         *w 0                       s     s     &s     �k     �k     �k     �k     ~k     jk     \k     @k             >o     �u     �u     zu     fu     Ru     @u     0u      u     u     �t             �t     �t     �t     t     *t     <t     Xt     pt     �t     8s     Hs     Xs     js     vs     �k     �k     l     l     �s     :l     Nl     dl     �t     zl     �l     �l     �l     �l     �l     �l     �l     �l     m     $m     4m     Jm     Vm     bm     nm     �s     �m     �m     �m     �m     �m     �m     n     n      n     0n     >n     Ln     Zn     tn     �n     �n     �n     �n     �n     
o     o     �t     �s     �s     t     �s     (l     |m     �s             �q     �q     �q     �q     �q     �q     �q     r     (r     Br     xq             �v     �v             2p     @p     Lp     bp     xp     �p     �p     �p     p     p     �o     �o     �o     �o     �o     �o     �o     ~o     jo     Zo     �u     �u     �u     �u     �u     
v     v     .v     >v     \v     pv             �p     �p             0q     Zq     Jq     "q             
      �      �      �t      �s      �      �      �o      �        ^r     �r             �r     �r     "k     �r     k     �j     �j     �j     �j     �j     �j     �j     �j     �j     �j     �j     �j     zj     pj     hj     Xj     @j     .j     j     j     
j      j     k             �r     �r     �v     �v     �v     �v     w             w             �memset  �memcpy  �wcschr   ??3@YAXPEAX@Z  ??2@YAPEAX_K@Z  7 __C_specific_handler  �_resetstkoflw dfree  �realloc �malloc  �rand  �memcmp  �wcsncpy 6 _XcptFilter  _c_exit � _exit � _cexit  Lexit  p _acmdln Q __getmainargs � _initterm b __setusermatherr  � _commode  � _fmode  ` __set_app_type  msvcrt.dll   AllocateAndInitializeSid  �RegCloseKey �RegQueryValueExW  �RegOpenKeyExW ?SetSecurityInfo +SetEntriesInAclW  GetSecurityInfo @IsValidSid  ADVAPI32.dll  �WaitForSingleObject 6 CloseHandle xUnmapViewOfFile uGetLocalTime  �GetProcAddress  �GetModuleHandleW  IGetCurrentThreadId  FGetCurrentProcessId dMapViewOfFile X CreateFileMappingW  TLocalAlloc  sGetLastError  XLocalFree EGetCurrentProcess �ReleaseMutex  /SetLastError  d CreateMutexW  �WideCharToMultiByte �GetTickCount  �GetOverlappedResult �WriteFile �ReadFile  , CancelIo  �ResetEvent  �WaitForMultipleObjects  �PulseEvent  zOpenEventW  SetEvent  �WaitForMultipleObjectsEx  �ProcessIdToSessionId  S CreateEventW  q CreateThread  GlobalFree  GlobalUnlock  GlobalLock  �GlobalAlloc � ExitThread  �QueryPerformanceCounter �GetSystemTimeAsFileTime eTerminateProcess  uUnhandledExceptionFilter  QSetUnhandledExceptionFilter �RtlVirtualUnwind  �RtlLookupFunctionEntry  �RtlCaptureContext �GetStartupInfoA KERNEL32.dll  �GetStockObject  GDI32.dll PostMessageW  � DispatchMessageW  �TranslateMessage  @GetMessageW �ShowWindow  PostQuitMessage � DestroyWindow � DefWindowProcW  a CreateWindowExW RegisterClassW  PeekMessageW  �MsgWaitForMultipleObjects �LoadStringW �IsWindow  PSetClipboardViewer  GetClipboardViewer   ChangeClipboardChain  CSendMessageW  �SetWindowLongPtrW rGetWindowLongPtrW USER32.dll  5 WinStationQueryInformationW N WinStationVirtualOpen WINSTA.dll  WSOCK32.dll 6 WSARecvFrom  WSAGetOverlappedResult   WSACloseEvent  WSACreateEvent  WS2_32.dll   acmDriverClose  " acmStreamClose   acmFormatSuggest  % acmStreamOpen  acmDriverOpen  acmFormatTagDetailsW   acmDriverEnum ) acmStreamUnprepareHeader  # acmStreamConvert  & acmStreamPrepareHeader  ( acmStreamSize MSACM32.dll  WTSUnRegisterSessionNotification   WTSRegisterSessionNotification  WTSAPI32.dll  9OleUninitialize "OleInitialize ole32.dll x_purecall �wcsrchr �_wcsnicmp �RegCreateKeyExA �RegQueryValueExA  RegSetValueExA  NLoadLibraryA  �GetVersionExA � DeviceIoControl HeapFree  � FreeEnvironmentStringsA � FreeEnvironmentStringsW �lstrlenA  �lstrlenW  XGetEnvironmentStrings ZGetEnvironmentStringsW  PGetDiskFreeSpaceA GlobalMemoryStatus  HeapAlloc �GetProcessHeap  %InitializeCriticalSection MLeaveCriticalSection  � EnterCriticalSection  � DeleteCriticalSection 	GlobalSize  Q CreateDirectoryW  � DeleteFileW �GetTempFileNameW  qMultiByteToWideChar � DeleteMetaFile  �GetMetaFileBitsEx  CloseMetaFile �PlayMetaFile  D CreateMetaFileW .SetMetaFileBitsEx �GetPaletteEntries �GetObjectW  � DeleteObject  E CreatePalette RegisterClipboardFormatW  �UnregisterClassW  �LoadCursorW �UpdateWindow  OSetClipboardData  B CloseClipboard  � EmptyClipboard  �OpenClipboard �IsClipboardFormatAvailable  GetClipboardData  GetClipboardFormatNameW � SHFileOperationW  # DragQueryFileW  SHELL32.dll $OleIsCurrentClipboard 5OleSetClipboard HReleaseStgMedium  2 CoGetMalloc OleGetClipboard  CopyStgMedium urlmon.dll                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            "V  'W      �      �    � @ �   �0���  "V  �V     �  +  ,      �      �    � @ �   �0���  +  �+     �  "V  �+      �      �    � @ �   �0���  "V  \+     �  @          �      �    � @ �   �0���  @  �     �  +        �      �    � @ �   �0���  +  �     �1  "V  ~  A    @  @         �      �    � @ �   �0���  @  �     �1  +  �  A    @1  @  Y  A    @"  @  +        �                                  
   ����      ���������     �     �     �     �     �     �] �f���2��-�+                               P          �     �     @     �     �     P          �     �     `           �     �     p     0     �     �     P     (     ����    #     �"     �"     �"     �"     �"     P"     0"     "     �!     �!     �!     �             #     �"     �"     �"     �"     �"     P"     0"     "     �!     �!     �!     �     p!     H!     !     �                                                                                                                                                                                         $  ($  �C 0$  �$  �C �$  K%  �C K%  h%  �C h%  �%  �C �%  �%  �C �%  &  �C 0'  W'  4D W'  �'  D �'  �'  D �'  (  dD (  v(  LD v(  �(  <D �(  �(  �D �(  &)  |D &)  3)  lD @)  �)  �D �)  8*  �D @*  �*  �D �*  O+  �D `+  ,  �D 0,  �,  �D �,  �,  �D �,  )-  �D 0-  
.  �D .  �/  E �/  �/  E �/  %0  \E 00  `0  �E `0  (3  �E (3  A3  �E A3  e3  tE e3  j3  dE p3  �3  �E �3  �3  �E  4  �5  �E �5  �5  �E �5  ~8  F �8  ;  F ;  :;  F @;  O;  �F O;  9=  lF 9=  k=  XF �=  �=  �F �=  >  �F >  ?>  �F ?>  F>  �F F>  M>  �F `>  �>  0G �>  #?  G #?  P?   G P?  f?  �F p?  w?  �G w?  �?  |G �?  @  dG @  @  TG @  @  DG  @  e@  �G p@  �C  �G �C  GD  �G PD  �F  �G �F  �F  �G �F  1I  $H @I  dI  H pI  �I  �H �I  �I  tH �I  �I  dH  J  MJ  �H MJ  CK  �H CK  sK  �H �K  �K   I �K   L  I  L  CL  �H CL  UL  �H UL  gL  �H pL  �L  (I �L  vM  0I �M  �M  8I �M  hN  @I pN  �O  HI �O  Q  \I  Q  �Q  �I �Q  �R  �I �R  �R  xI �R  	T  �I T  3T  �I 3T  bU  �I bU  |V  �I �V  �V  ,J �V  |W  J |W  Y  J Y  wY  �J wY  �Y  �J �Y  8Z  �J 8Z  OZ  �J OZ  �Z  �J �Z  �Z  pJ �Z  �Z  `J �Z  �Z  PJ �Z  [  @J [  �_  �J �_  �_  �J �_  �h  8K �h  �h  ,K �h  i  xK  i  $i  �K $i  Ak  �K Ak  Fk  �K Pk  ik  �L ik  mk  �L mk  uk  �L uk  �n  xL �n  �u  `L �u  v  PL v  v  8L v  Xv  (L Xv  nv  L nv  �v  �K �v  �w  �K �w  x  �K x  Tx  �K `x  y  �L 0y  ;y  �L ;y  z  �L z  z  �L z  �z   M �z  �z  M  {  �{  M �{  :|  PM :|  �|  <M �|  }  ,M  }  �}  lM �}  
~  �M ~  �~  �M �~  �~  �M      �M   �  �M �  �  �M �  �  �M �  w�  �M w�  |�  �M ��  �   N ��  ��  `N ��  �  HN �  ��  4N ��  ��  $N ��  �  N  �  �  lN ��  :�  �N :�  X�  �N X�  u�  |N ��  ��  �N ��  ކ  �N ކ  �  �N  �  V�  �N `�  ,�  �N @�  ��  O Љ  �  O  �  ��  PO ��  Ȋ  <O Ȋ  ��  ,O ��  Z�  \O `�  ލ  �O ލ  
�  �O 
�  1�  �O 1�  C�  �O C�  r�  pO ��  Ў  �O Ў  ��  �O ��  ��  �O ��  u�  P ��  ��  P ��  �  4P  �  <�  ,P �  o�  xP ��  ��  �P ��   �  �P  �  -�  �P -�  6�  �P 6�  `�  �P p�  ��  HQ ��  ��   Q ��  Y�   Q p�  0�  TQ p�  ӫ  hQ �  '�  xQ 0�  g�  �Q p�  ��  �Q ��  �  �Q �  �  �Q �  .�  �Q @�  ��  DR ��  ʯ  ,R ʯ  �  R �  ۱  R ۱   �  �Q  �  0�  �Q 0�  e�  �Q p�  ��  \R �  V�  |R `�  Ϲ  �R P�  ��  �R ��  ��  �R ��  �  �R �  ��  �R ��  _�  �R p�  ��  S ��  ,�  $S @�  ��  <S ��  Ҿ  |S Ҿ  �  dS �  !�  TS 0�  o�  �S o�  ��  �S ��  .�  �S @�  ��  T ��  ��  �S ��  ��  �S  �  	�  HT 	�  \�  0T \�  r�   T ��  ��  xT ��  ��  dT ��  ��  TT �  ��  �T ��  �  �T  �  \�  �T \�  �  �T �  &�  �T &�  -�  �T -�  F�  �T P�  ��  U ��  ��  <U ��  /�  $U /�  4�  U ��  $�  DU 0�  9�  �U 9�  ��  lU ��  �  XU  �  ��  �U ��  J�  �U P�  ��  �U ��  %�  �U %�  _�  �U _�  ��  �U ��  �  �U  �  ��   V ��  !�  V 0�  w�  XV w�  ��  DV ��  ��  0V ��  ��   V ��  ��  V ��  ��  �V ��  ��  �V ��   �  �V  �  =�  �V =�  ��  �V ��  ��  �V ��  =�  tV P�  ��   W ��  C�  W C�  ��  �V ��  0�  TW 0�  ��  @W ��  '�  0W 0�  ��  lW ��  ��  �X ��  5�  \X 5�  J�  HX J�  ��  8X ��  ��  $X ��  ��  X ��  ��  �W ��  -�  �W -�  ��  �W ��  ��  �W ��  ��  �X ��  ��  �X ��  ��  �X ��  q�  �X q�  F�  �X F�  ��  �X ��  ��  0Y ��  ��  Y ��   �  Y ��  ��  `Y ��  ��  HY ��  ��  8Y  �  ��  hY ��  ��  �Y ��  ��  �Y ��  w�  �Y w�  ��  �Y ��  ��  pY  �  �  �Y  �  n�  XZ n�  ��  DZ ��  q�  0Z q�  ��   Z ��  ��  Z ��  ��  �Y ��  ��  �Y ��  ��  lZ ��  _�  �Z p�  ��  �Z ��  J�  �Z P�  ��   [ ��  ��  [ ��  �  �Z �  #�  �Z #�  e�  �Z p�  ��  ,[ ��  ��  �[ ��  v�  d[ v�  ��  H[ ��  *�  4[ 0�  P�  �[ P�  b�  �[ b�  ��  �[ ��  ��  �[ ��  d�  �[ p�  8�   \ @�  K�  �\ K�  O�  �\ O�  ��  �\ ��  ��  |\ ��  {�  T\ {�  ��  <\ ��  ��  (\ ��  ��  \  �  ��   ] ��  @  �\ @  �  �\ �   T]  � @] � � 0] � � ] � � �] �  �]   �]  % l] 0 � �] � � �]  � �] � �  ^ � �	 ^  
 �
  ^  � 0^ � P 8^ � � �^ �  t^  @ `^ @ N P^ N b @^ p � �^ � � �^ � V �^ ` � �^ � � _ � l �^ l } �^ � � _   Q T_ Q � <_ � 	 ,_   �_  � �_ � � p_ � � �_ �  �_  / �_ P � <` � y ` y � ` � � �_   o �` o � d` � � T` p y �` y � �` � � �` � � �` � � �`    a  ?  a ? T �` ` �   a �  o" Ha �" w( pa �( �( �a �( ) �a ) �) �a �) �) �a �) �) �a �) �* �a �* �+ b �+ b=  b p= �= �b �= �= |b �= > hb > &> Xb &> P> Hb �> �> pP                                                                                                                                                                                                                                                                                                      �   8  �                  P  �                  h  �               	  �                  	  �   (� \           �� �          �4   V S _ V E R S I O N _ I N F O     ���     w�  w�?                        �   S t r i n g F i l e I n f o   �   0 4 0 9 0 4 B 0   L   C o m p a n y N a m e     M i c r o s o f t   C o r p o r a t i o n   J   F i l e D e s c r i p t i o n     R D P   C l i p   M o n i t o r     t *  F i l e V e r s i o n     5 . 2 . 3 7 9 0 . 3 9 5 9   ( s r v 0 3 _ s p 2 _ r t m . 0 7 0 2 1 6 - 1 7 1 0 )   0   I n t e r n a l N a m e   R D P C l i p   � .  L e g a l C o p y r i g h t   �   M i c r o s o f t   C o r p o r a t i o n .   A l l   r i g h t s   r e s e r v e d .   @   O r i g i n a l F i l e n a m e   R D P C l i p . e x e   j %  P r o d u c t N a m e     M i c r o s o f t �   W i n d o w s �   O p e r a t i n g   S y s t e m     @   P r o d u c t V e r s i o n   5 . 2 . 3 7 9 0 . 3 9 5 9   D    V a r F i l e I n f o     $    T r a n s l a t i o n     	�             P r e p a r i n g   p a s t e   i n f o r m a t i o n . . .                                                                                                                                                                                                                                                                                                                                                                                                                    . ,   ��
 R D P W 3 2                     MZP      ��  �       @                                     � �	�!�L�!��This program must be run under Win32
$7                                                                                                                                        PE  L  ��T        � �� �   D      `        @                      �                                 � n    p z   � ,                   � L                                                  lr �                          .text   ��      �                    `.itext  �         �                 `.data   <        �              @  �.bss    �N          �                 �.idata  z   p     �              @  �.edata  n    �                  @  @.reloc  L   �                  @  B.rsrc       �                   @  @             P      �             @  @                                                                                                                                                                @ Boolean        @ FalseTrueSystem ��4@ AnsiChar    �    �@ P@ Integer   ���� h@ Byte    �    �@ �@ Pointer     ��@ Cardinal    ���� �@ �@ ShortString� �@ 	PAnsiChar0@  �@ �@ string ���@ PShortString�@  @ 
TTypeTable������|@      �(@ 
PTypeTable @  ��@@ PPackageTypeInfoX@  \@ TPackageTypeInfo           L@     	TypeCount $@    	TypeTable L@    	UnitCount �@    	UnitNames  �@ �@ 
PLibModule�@  ���@ 
TLibModule           �@     Next �@    Instance �@    CodeInstance �@    DataInstance �@    ResInstance <@    TypeInfo L@    Reserved  ���%TsA ���%PsA ���%LsA ���%HsA ���%DsA ���%@sA ���%<sA ���%8sA ���%4sA ���%0sA ���%,sA ���%(sA ���%$sA ���% sA ���%sA ���%sA ���%�rA ���%sA ���%�rA ���%sA ���%sA ���%sA ���%sA ���% sA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%�rA ���%|rA ���%�rA ���%�rA ���%trA ���%prA ���%lrA ���%�rA ���%�rA ���%�rA ��S�ļ�
   �$D   T�R����D$,t�\$0�Ã�D[Í@ �%�rA ���%�rA ���%�rA ��� ����Z   FastMM Borland Edition (c) 2004 - 2008 Pierre le Riche / Professional Software Development  An unexpected memory leak has occurred.     The unexpected small block leaks are:
 The sizes of unexpected leaked medium and large blocks are:      bytes:     Unknown AnsiString  UnicodeString   
  Unexpected Memory Leak  ��Í@ ��
�H�@�J�BÍ@ ��
�H�J�H�J�H�@�J�BÍ@ ��
�H�J�H�J�H�J�H�J�H�@�J�BÍ@ �(�h�h�h�H �J �z�z�z�:Í@ �(�h�h�h�h �H(�J(�z �z�z�z�:Ð�(�h�h�h�h �h(�H0�J0�z(�z �z�z�z�:Í@ �(�h�h�h�h �h(�h0�H8�J8�z0�z(�z �z�z�z�:Ð�(�h�h�h�h �h(�h0�h8�H@�J@�z8�z0�z(�z �z�z�z�:Í@ ������y�,�l�|�<��x��,�<�D�DÍ@ �������,�<��x���Ð�H�9щ�JtÐ��*A �����ָ������!�,*A u���������!(*A Ë���0  �����  �!ʁ��  �լ*A �Q9ʉ�P��AtÐ���*A �����ָ   ��	�,*A �   ����	(*A Ã=$*A  uÐ�� *A �@�u%�H��$*A )ЍJ�H��T���0  �g���Ð������#P���0  r����� *A �����#P��$*A )���ÐS������jh   h�� j �������tM�*A ���*A �*A �Q��Ё��� �ʃ��   ��� +ˉ$*A +Ӌ£ *A ���Ѓ��[�3��$*A 3�[Ð�=5 A  t=�)�=�(A  u j ������JA �3��������tj
�l�����JA �3�������u�ÐSVWU�荵  N����  ��jh  Vj �#����؅�t0���o���w�}�����JA ��JA ��JA �G���JA  ����]_^[Ë�SVWU��܋����C����Ƌ�$�P�T$�P��uh �  j V������t3��?����:�ދ���3�j�D$PS�)���h �  j S������u�����t$;�v+���υ�u�D$�$��$�T$�P��JA  �ǃ�$]_^[ÐSVWU�������ǃ�� �؃����;���   �����;�v�����׃����Љ$j�D$P�D$P�����|$   up�d$  ����+ӋD$;�s\��+Ӂ�   J��  ����;�s��jh    S�D$P������t-jh   S�D$P������t�ǃ��p��Z���Z���w���z   �؅�tj��,
 v�Ã��p�ǃ��@�Ӌϑ���������  �?��;�r
�߃��w�/���2   �؅�t"��,
 v�ǃ��p�Ӌǋ���������  �Ã� ]_^[ÍP��=,
  S�5 A �H  �����(A ��XA uV�S�B�����9�t�B#H��J�P�t(� [Ð���S�K�;Cwv�B�K� �P�[Ð���J�Y�K� [Ð��   ��#t��� �   ��#t��� �   ��#t���@�=�(A  u�j �H����   ��#�_���j
�2����VW�=5 A  t9�   ��%*A t*�=�(A  u�j �����   ��%*A t	j
��������s#5(*A tp�ƍ4�    ��,*A �ɍ��<ͬ*A �w�V�W�:9�u�������!�,*A u�(*A �����#~���`
 rl���{)��7�J�H��T������U�K�=$*A 9�r&�5 *A �K��0  9�r��)�)=$*A �5 *A �!�C�������ƅ�u�*A �_^[Àd7���O�N�1��*A ��F�F   �s�F �K��S�)ω{� �p�_^[Ð�   ��%*A tK�=�(A  u�j �����   ��%*A t*j
�����ǐ��=,
 �  ���   �� �����0��u��������������������#�,*A t�����	��^�����������#(*A t�Ћ�,*A �ȉ���	��5��$*A )�r� *A )أ *A �$*A ���X����������*A  [�VW�<ͬ*A �w�F�G�89�u�������!�,*A u�(*A �����#~���)�t�3�J�H��T���0  r����������d7���K�N��*A  ��_^[�[���+���1�ËP�����S�5 A ��   �ۋua�j�Bt,���J�@�A�t1��[Ð�K�Z�J�Q�S� 1�[Ð���t�B�J�H�A1�9Su�C��ЋR��5 A �   �   ��#t��=�(A  u�QRj �����ZY�   ��#�o���QRj
�����ZY�Ð���   ��%*A tB�=�(A  u�j �����   ��%*A t!j
�����ǐ������   ����ۉ�V��u��D3�   �L3�u5���L3��F�u@���� tP�C�F��\3������Y����*A  1�^[Ð�3���ˁ�0  r������뻐�N�)�ˁ�0  r��������먁=$*A �� u,����V�P��*A  h �  j V��������^[Ð������ �9����C�   �$*A �� � *A �*A  1�^[Ð�[������������ËH���SV����   ��K��9�r7��@   9�r^[Ð�Ӊ��O�����t�ىÉ�������������^[Ð��L	 W��1�)у��!��������t$��,
 v�x��K���ǉ��S���w�����_^[Ð���g  �˃��W�<����9�U�  �,9�r]_^[Ð����,  s���  ��   �,  9�vۍ��   �� �����0��)�=5 A  tF�   ��%*A t/�=�(A  u�Qj �d���Y�   ��%*A tQj
�L���Y�Ð�   #^�	�^��ˋW���u	���W���������ׁ�0  r������_��C�D.���0  r
�.�������*A  ��]_^[É׉��������t�ŉ����������G�����]_^[ËG����   ����,9���   �=5 A  t[�   ��%*A t3�=�(A  u�QRj �{���ZY�   ��%*A tQRj
�a���ZY뿐�   #^��G��t~����,9�wt=0  r��QR����ZY�����1�)Ѓ��!����   % �����0�U)�w�$.�������T.��z�|0��Ł�0  r�� ���	݉n��*A  ��]_^[Ð��*A  �����1�)Ѓ��!�Љŉ�R����Z��tс�,
 v�P��ŉ���������������]_^[Ð^[���%���1�Ë�S�X�����`�����ɍ	ˁ�,
 s�������x��
����[Ë��ȋу�����ыЃ�������u3�Í@ �=$*A  t� *A ;�r�Ё��� ; *A s��Á=$*A �� t� *A �3�Í@ SV�؃� ��;Bu�Z;Zv���ރ�������B+؉^[ËBH�^[Ë�W�׃��A_p������с��������ȃ�0��Ѓ�����������	���0�����������������	���0�����������������	���0�����������������	���0����������������� 	���0���������������� 	���0����������������? 	���0���������������� 	���0������������0��G_Í@ SV��ڋӋ��y  ���^[Ë�S�څ�t��ȋ �@�������[áDA ��!  �ȋӡDA ����[ÐU��S�Ё���  vh��uc�U�R��;�w�]�]S���;�s�U3ɉJ�j�U���RP�z����E�x�r�E�x�   u�E�@��t	�E�@�t3���[]�3�[]ÐU��SVW���؁��  }e�EP�Ã���d���Y��tR�EP�Ã���Q���Y��t?�Ã�Ћ0�Ã��;u'��t'�EP���-���Y��t�EP�W�����Y��u3����3�_^[]Ë�U����S�3��E�U3ҋ��h���Y��u3ۋ�[��]Ë��=5 A  t=�)�=�(A  u j �������JA �3��7�����tj
�������JA �3�������uŃ=�JA  ujh   h   j ������JA �=�JA  ��Ë�S��������t)��JA �8�?  }��JA � ��JA �\���JA � ��3���JA  [�SVW���JA 3ۃ? t?�6�����t6��J��|&B3��;t�u�������T���
��@Ju���JA  ��_^[Ë�U����SVW�E��E�� ��XA �����U��� H���M؍U܋E�������s  �E܃�� �X  �E��W������H  �Eƀ�G�� 3ۋE��_���������   �E܁x   �  �E܋@�E�E��@�E�}�t
�}���   �E�@�m���E��}� ��   �E�� �@��;E���   �E��}�uK�E܃��E�E��~"�EԀ}� t�E�8 s3����E��E��M�u�}� ��   �E�8 uy�   �r�E܃��E�E��~$�EԀ}� t	�E�f�8 s3����E�E��M�u߀}� t8�E�f�8 u/�   �(�   ;<�t�<� t	C���   ~���   �<��3��D��E�� �@E܋E�;E������_^[��]�U��P�'   �����PHu��E�������SVW�� H��3ɺ � �?  �����3ɺ @  �-  3����G��ƅ�G���=*A �   ��������؅�tr�Ã��0��   uV��   tU������Y�C���G��   }7��������G�����=�����u ƅ�G�� ���G�����G�����������G�����2����؅�u����*A �r�����JA �7�Ã��������u&ƅ�G�� �s����������G�����������G���[���JA t���G��   |����G�� ��  ƅ�G�� 3����G���4A �  �ȍ�܇���4A �N�����ǅ�G��7   ǅ�G��ZA ���O�����G�����G��� �����G��ƅ�G�� ��   ���G����������;��,  �> �  ���G�� u!�8A �   �ȋӡ8A �������ƅ�G�����G�� uV�C�
C���G��@��������� C�-C� C�Ӌ��G���o����ء@A �  �ȋӡ@A �q�����ƅ�G����,C� C�ǃ�rt!Ht:�T�DA �j  �ȋӡDA �8������D�HA �N  �ȋӡHA �������(�LA �2  �ȋӡLA � �������F����
������ C�xC� C���������O�������������G�����G�����G��   ���G�� ���G���w������G�� ~���G�� t�C�
C�C�
C�<A �  �ȋӡ<A �i����؋��G��N��rAF3���������G����t�,C� C���G��� �������؍�����;�wG���G��NuΡPA �5  �ȋӡPA ����h   �TA P��܇��Pj �>���_^[��]Í@ VW3�3��ZA �=
*A  t�u�:������;�v���(A @;�w���F�� ��7u�_^Ë�SVW�7   �tA �; u��@ �C�C��C�C�3��C��C�   �C����@�   % �����0=0  s�0  �  ����v�   �Ȳ���S���f0f�C��{��ǋ����I���   �� �����0��0s  s�0s  ��0�  v�0�  ���� �׋�3���f��f� f% �f��0f�C��� N�0���������*A *A �*A *A �   ��*A � �@��Nu���JA �JA ��JA �JA _^[Í@ SVWU�*A ��JA �{��oh �  j W�������;�u�7   �XA �ȉH�ȉH�@   3ɉH�� Ju��[�   ��*A ��� �@��Ju�^��{h �  j S�l�����;�u�6�v]_^[Ã=�JA  t��JA P����3���JA �=�(A  t������=�JA  th �  j ��JA P����3���JA � ���Í@ ��~�8A ��t�ð��   1��Ð��t
�<A ��u�ð�   Ë��t2��tP���@A Y	�t�ð�   ����<A 	�u�ð�p   ��tP���8A Y	�t�Í@ �A �I  �SV��؀��= A  t
�֋�� A ��u��G  ��   ���w
����PA �Ë�����^[Í@ ���$�����PRQ��G  ��    YZXu�1������Í@ S���G  ��   [�9�t1�� w|���$��1@ �,�(��~�h��~�h�z�z�:�<Ð��1@ 2@  2@ '2@ 42@ 92@ D2@ Q2@ \2@ R�(�D��L
��(Q�ك���L
Z�,�<��|��:Z�:�~.9�w�)�9Ѝvȃ�Q�,�(у��)��,�<���Y�:�<���
��f�
�f��@f�
�BË�
Ë�@�
�BËf�@�
f�BË�@�
�B��(�:Í@ SV����Cf=��rf=��v�f   �,f=��t���j  f�sf�{H u�{ u�C�3@ ���S�؅�t��������^[Í@ f�������Ë�f�������Ë�f�������Ë�S��3��C3��Cj �CP�CP�CP�P�������u�H�����mu3�[�3�[Í@ 3�ÐSVQ�؋s��u3��&j �D$PV�CP�P�������u�����3�3҉SZ^[Ë�S��S�7���H��[ÐS��f�C�׋�������u�����[�3�[ÐV��1��F�Ff�F-��  tHt Ht.�h  �   ��   �   �F�2@ �'�   @�   �   ��   ��   �   �F$3@ �F$p3@ �F  3@ f�~H ��   j h�   Qj RP�FHP��������  �f�~����   f�Nj �6����@��   -�   s1�j j P�6����@��   j ��j Rh�   ��P  R�6�q���ZH��   1�9�sk��P  t@��jj )�P�6�`���@��   �6�J���Huv�=��P  �F�   �F$ 3@ �Ff�~��tj�����%A uj��j���������t9�f�~��t�6�������t��u�F $3@ 1�^��6�~���f�F�׸i   ��f�F��������Í@ SVW���؋�3ɺP  �3  ��P  �Cf�C���$A f�C�C�   �C�3@ ����  ���ǍSH��������f�DsH  3�_^[Í@ S�Hf���tIf��s���Ӌ��3��=#A t=�%A u3���g   ��t���o�����[Í@ �P ����Í@ SV��3��Cf=��r/f=��w)f%��f=��u���S����u���S$����t���������< A t
�g   ������^[Ë�f�x��u�P;PsPf�@ t�
��u��P��   Z��t��J1�Ð�� ��|?f�f�Hf�Hf�H��� ��T������)�������T��|�����Ð����~P�L�����ڍU"7@ �␐f�Hf�Hf�Hf�Hf�Hf�Hf�Hf�Hf�Hf�H
f�Hf�Hf�Hf�Hf��ÐS�؁�< A u�$A f�C������f�{�����؄�u
�h   �������[Ë�f�x��tP������XtO�P;Psf�@ �H�
t��t4B�P1����P�P��uX�P;Pr�f�@ t�H�
�@�����X��̈�Í@ SVWQ�Ή�f�x��tP�B�����Xt[�Å�~U�S�K)�SI|.�B<
t<t<t�N��f�C t���<
u�J+S�S��S���-����S�K)�S��t���Y)�_^[ÐRB�y���Z�
ÐSVW�É։ω���  ��   �؉��   �����������i  �<$�u3�؉��   ������j �����H  ���$�v  ���  X�<$�t́�   _^[Ë�S�É�����<
t��t<u���v���<
t
��t�K��[Ë�SVW��P����   1�1ۿ���f���f�� t�� f��-tvf��+trf��$ttf��xtnf��Xthf��0uf���f��xtVf��XtPf��t'�f��t5f��0f��	w+9�w'����f���f��u���t��}h������~]x[[)��Y��f���놿���f���f��t�f��arf�� f��0f��	vf��f��w�f��
9�w����f���f��u���u��Y1���2_^[Ë�S�؁�#A t���%A u�$A f�C������f�{�����؄�u
�i   ������[Ë�VW��f�x��tPRQ������YZXt5�xx�P+P9� P)�PQ����P��uYX�������YX_^�H�_^Ð�Ѻ�:@ ��@~d��@PQ�@   �����H>  ��    uYX��YX�                                                                ���4���Í@ ���-A Ë������Å�t���Q�À=A vj j j h���� A Ð�=A  tPPRTjj h���� A ��XÍ@ Tjj h���� A ��XÍ@ �=A vPS�����Í@ ��t�A�9�t�9�u��AA����Ë��=A vPRQ�����QTjj h���� A YYZXÐ�=A vRTjj h���� A Z�PR�=A vTjj h���� A ZXË��D$�@   �  �8����P�Htn������� A ����   �҅���   �T$�L$�9���t7������=A  v)�=A  w �L$PQ�}����� X��   �D$�H�0�D$�H�=A v�=A  wP�D$RQP�@����� YZXtp�HS1�VWUd�SPRQ�T$(j Ph�<@ R� A �|$(��;  ��    ��    �o�_�G(=@ ���f�������   ��;  ��    ���    �A������   Ë��D$�@   ��   S1�VWUUh�=@ d�3d�#d��P�HSPRQ�|$4�w;  ��    ��    �O�o�G�=@ ���������O;  ��    ���    ��1�ZYYd�]_^[� �#   �&;  ��    ���    �A�8����   Ë��D$�T$�@   t�J�B(>@ SVWU�j��������]_^[�   Ë��D$0�@{>@ ��:  ��    �
��    �B�`��8���t�B����������1���d�Y��]_^[�   Í@ �w:  ��    �
��    �B����Z�d$,1�Yd�X]�7������U��U�=�  �,t\=�  �tW-  �t\-�   t=HtN�`q��?��r6t0�R=�  �t=-�  �t.HtHt$�:-�  �t/��=t&�,���*���&���"������������������
�����������R����]� ���D$�@   ��   �=A  w�D$P������ tq�D$������T$j Ph�?@ R� A �\$�;����S�Ct� A ����������҅�������S�6���� A ��t�ыL$��   �Q�$�B  1�Í@ P1ҍE�d�
d���@T?@ �hY�AÍ@ �@1҅�td�
9�u� d�Ë	���t9u�� �Ë�U��SVW��JA ��tS��JA �x3�Uh�@@ d�0d� ��~K��JA �t���t�> t�օ��3�ZYYd�������������������_^[]ÐU��QSVW��JA ��tV�83ۋ@�E�3�Uh�@@ d�0d� ;�~�E��4�C��JA ��t�> t��;��3�ZYYd���)����<����+����z���_^[Y]�QSVW��JA �}|��JA �ލ}��   �C �C�C�k�C�S�M�������C,�C1Ƀ} u��K��@ � A ��@ � A ���z����E@�C(HY��S$t<}��Q�L$��t�E�U��Y�E<|���= A  u�$ A �=A �EH�K  ������ Ë�U��j SV���3�Uh B@ d�0d� �U����0  �U��ƹ    �*  3�ZYYd�h'B@ �E���
  ��+�����^[Y]�U��j SV���3�UhoB@ d�0d� �U����E0  �U�����  3�ZYYd�hvB@ �E��
  ��������^[Y]ÐSV��؋֋��	0  ^[Ë�S1�WV�<�t�F��ڋN��tItIt�������l����������Ou�^_[Í@ S1�WV�<�t�F��F���Ou�^_[�SVW�tA ��5 A �ƹ
   �����0�È�
   �ƙ����K��uܳ�5A �ƃ����A �ӈ�   ��3����K��u�_^[Éǋ_�o�w�w �7�   �_^1�� A ���@�� ÐQ�=4 A  tWf�=#A ��u�=#A  v�#A �(#A j �D$PjhtA j�����P�L���j �D$PjhD@ j������P�1���ZÀ= A  uj hlA htA j �+���Z� � ����   
  SVWU��JA �0 A �=A  t������O���3��A �= KA  t!����;(KA u��JA ������JA ������{( u�? t���3���փ? u�{(u�= A  u3��C�����{(v	�= A  t#�{��t���&-  �k�u;ut
��tV�y������>����{(u�S$�{( t���p����; u�= A  t� A � A P����������   ��g���]_^[Ë�� A �����Ð�A �����Ë��t�     �J�I|��J�u
P�B�����XÐSV�É֋��t�    �J�I|��J�u�B��������Nu�^[Ð��t:f�z�t��(A �	  �J�APR�B��R��2   ��XR�H�����ZX���B����t�J�I|��J�u�B�����Í@ ��~CP��p8���RP�L���ZYf�D�  ��Z�P��@�   ��u��(A ��f�P�f�@� ������1�Ë�U��SVW�É։ω��U�������ǅ�t	��������������;_^[]� U��V�u��u�5�(A j j RP�EPQj V�L���^]� �@ U��RP�EPQj �EP����]� �@ ���(A �n  ÐS�؋��:  �[Ë����t�ʃ�
f�9t	�������Ћ�Í@ S�؋��2  �[Ë�S���t�ك�
f�;t���������ȋ�[Í@ U����SVW�M��U����]�}� 	��������Vf��u��(A �E�P��P�M�3�3���������3ɋ��  ��~�E�P��P��M�����������f��������_^[YY]� ���$Q1Ʌ�t-Rf;
t f;Jtf;Jtf;Jt�����������Z)����@���Í@ �$Q1Ɋ
B�:���Ð��t!P1�:t:Ht:Ht:Ht����@@@Y)�Ë�����   ����V���SVW�É։�9�tuf�y�t1�f�~�u�V������ǉ�j f�~�t���4$�i  ���W������4$���y��V��pY���I��l  ���N������������t����X_^[�f�y�t��1��<������؋y�����p�I��&  ���j ��1���Å���   �������;��   ;tPQ�}���ZX����SVW�Ӊ�Pj j f�~�t!�4$���   1�f�{�u�S���m����4$f�{�t�\$���   �V�D$�����\$�C�F�p^�V��j����ǉ��؋K�����������N�S�������$D$t��   ����XXX����t�O������_^[É���������Q����D���Í@ ��t
�P�B~��@�Ð��t�   ����     �J@ �SVWU�É։�1���~y���tRf�x�tj �����  _����;�x�u1����p$P���1���X����p�� ��t:W�������_�/�����Љ��s����ǋ��t���H�9�|��������������;]_^[Ð3��   �SV�Ӊ�1Ʌ�t�K�)�Q�����Y��tf�{�u	��^[�p���j Q�ƍD$�ڋ�(A �J  �T$Y���N����D$�=�����^Ð�����Å�tPj ������������Í@ ���tR�����Í@ ���t�     PR����XÍ@ SV�É֋��t�    P������Nu�^[Í@ 9t#��������J��������QRP�i������m����U������P���SVW��U�����	���z����l�F=�  }/V�EP�������M���  �����؅�~�������ǋ��A   �3�^�ǋ��   V�EP��K   �M��������؅�}3ۋǋ��t   _^[��]� �@ �������PQR�����������Z�2�����Ð��tÐ  �^L@ Ë���t-P1�f;t f;Htf;Htf;Ht���������Y)���Ë�SVWQ���3ۅ�~5���[����؋�$�$��t��� ���~;�}�Ƌ�ɋ������ǋ��<���Z_^[Í@ �����Ë��?���Ë��[���Ë���t2f�z�t��  �J�APR�B��H  ��XR�H����.���ZX���B����t�J�I|��J�u�B�����Í@ ��tf�z�t�  �J�A~��B����t�J�I|��J�u�B������Í@ ��tø�A ÐU������P���SVW��U�����	���6����g�F=�  }/V�EP�������M���  �����؅�~�������ǋ��I   �.�^�ǋ��  V�EP��M��������؅�}3ۋǋ��a  _^[��]� S��(A S�_���[ÐSVW�É։ω��  ���ǅ�t�����������������;_^[�R��   �����ZÐ1Ʌ�t!R:
t:Jt:Jt:Jt����BBB��Z)�����Í@ 1Ʌ�t-Rf;
t f;Jtf;Jtf;Jt�����������Z)����X���Í@ WPQ��1��f�u��X�X_�<���Í@ 1Ʌ�tf�z�t�J�$Q�J��w������������Ç$Q1Ʌ�t
f�z�t�J������Y�$�:���Ð1Ʌ�t
�J�f�z�u������$Q�J�L$����Ð��t��� Ë�SVW�É�1���~}���tVf�x�tj ����[���_����;�x�u7���p+��p&P������X����p�f�p  ��t:W���O���_�/�+������t  �ǋ��t���H�9�|�����N����������;_^[Ð����   ��������SVW�É�9�tlf�y�t	�����ǉ�j f�~�t�ω��4$�������k����4$���y��V����   �u[���������N�����������������t����X_^[�f�y�t��1��������؋y�������   �u�������j ��>���Ð����   ������;��   ;tPQ����ZX����SVW�Ӊ�Pj j f�~�t�4$��������������4$f�{�t�\$�������D$�����\$�C�F��   �u`�
  �ǉ��؋K�����������N���S����������$D$t�   �������XXX����t�O��Y���_^[É��N������c����Z���ÐU��j SVWRP��1�j �L���t2f�y�t�ƋD�������ڍD���������ډ$��9u�ϋA�J�1��M1��j �L���t?f�y�t$�ƉU��D������U��D������U����$��A��   ���   9�u1�Ju���t�E�w������}��7��7K���  P�ƋD���t���t�H��������Ku�U���؍D������Z�E��u��t�J��<����U�$�XZ_^[X]X�$����<���Í@ 9�t<��t.�x�u3�z�u.�H�;J�u$�����S�;u��x�1�[Å�t��u�9�Òj P�D$�����X�$����Xf�������f�Í@ U��QSVW��ډE��E�����3�UhT@ d�0d� �E���t�Ѓ�
f�:t�E��U��7�����t��� ��}3��K;�}�؅�}3��
��+�;�}���}� t�E���
� �f� ����u���U��E���Z�����U�ӋE���9���3�ZYYd�hT@ �E��������:�����_^[Y]� U��j S��3�UheT@ d�2d�"�U���(A �����ËU�����3�ZYYd�hlT@ �E��������������[Y]Å�~:P�p0��p+�������Z�@�   �P�f�P  f�@� ��(A f�P���r���1�Í@ ��tG��t6SVW�Ɖ׋O�W�V�Jx f���)�~�f�u��VW���f�_^t����Z1��
1��Z��)���_^[�1�S�JVW�Ít
�|��t��F؋�   �'   ��O��_^[Í@ �=A  t�A ð�����Ã� �  PSVW�É։�1Ҋ�V<
t-<tc<tB<tr<t}<��   <��   <��   �   ����
�����   �������   ����
�p����   ���|����   ���������w�������n�؃��B���O��_U�ՋT.
��\.�L.��=���O�]�AU�Չ�\.�������O�]�+�؃��  O���؉���  O��_^[X������_^[XÐ�   �����Ð�=A  t�A ð�����SVWU�É�1��A�|
�o�1��O����  Q�O)�~���������G���
��
t:��tZ��tD��ta��tm����   ����   ����   �]_^[�(����0������   �   �0�������   �}�0��A����   �l�0��,����   �[1ɊJ�t�t�L
�	�0��`   X�;1ɊJ�LQ�э0�����X�"�0���  �   ��ы0��  �   G��M�����Y)�~
������]_^[ÐSVWU�É։ϋl$���
t:��tL��t^��tm��t|����   ����   ����   �]_^[�����؋�t�������Mu��   �؋�=�������Mu��   �؋��������Mu��|�؉���������Mu��h1ɊO�|9�؉�O�	�w�A���7Mu��E�؉�������1��G\8t8Mu��(�؋�  ����Mu���؋����  ����Mu�]_^[� Í@ P�~���X����Í@ ��5����RP�D$�$$���D$�d$��$�d$�YY� �U����SVW�U��E��E������3�Uhz\@ d�0d� �   3��E�    �E�    �}� u�E��8�  G�E��m���f�|x� t��E� �E���t�Ѓ�
f�:t�E��U��4���f�|x�-u�E�G�&�E���t�Ѓ�
f�:t�E��U�����f�|x�+uG��E���t�Ѓ�
f�:t�E��U������f�|x�$u��A�E���t�Ѓ�
f�:t�E��U������Tx��Lx����f��s
�Tx�f����f��X����t��g�E���t�Ѓ�
f�:t�E��U��n���f�|x�0u@�E���t�Ѓ�
f�:t�E��U��I����x�x���f��s	�xf����f��X���3�����   �E���t�Ѓ�
f�:t�E��U������f�|x�0uGG�E��Lx������f��
r���f��r���f��r�c���0����7����W�}� u�}� rA�|=�}����u�}��v�,*�ƙRP�E��U�����$T$���E��U�G3��v����}� ��   �E��U��؃� �ډE��U��   �E��Dx����f��
sZ�E��tx���0�}� u�}� rC�|?�}����u�}�����v�+)j j
�E��U��$���RP�ƙ$T$���E��U�G3�땀}� t�E��U��؃� �ډE��U�}� u�}� t�}� u	�}� �����:E�tO�E���t�Ѓ�
f�:t�E��U�����f�|x� t���Ä�t�E��8��E�3҉3�ZYYd�h�\@ �E��������������E��U�_^[��]Ë���t�@�������HÐU���u����]� �����Ë��  Ë�U����SVW�M��E��]���E�8����}��>����E���������V  3��E��t����E���FƋƋP�U�P��t�2�3����m�E��E����;E�t�������E��}� }��������t�;u5�]�;}�}��t�Ã����U�M�+ϋ��/����E܋U�������]��^��E������؋E�E�;}�}�}��t*�U��U�Ã�3�������E�P�U���Ã����������M��M�Ӄ��E�� �u����   ���;����+U��U�E��E��3��r����}�~.�E�M�O��|"G�E�    �EP�E����M���|����E�Ou�E��_^[��]� T�$�^���Ð���t3�     ��I�u'P��1ɊJ�T��t�H���t������������XË�S���t��B���t��K�uPR���C�����ZX�[Ð��t��@�Í@ SV�������؃{ u+h
  �D$P�CP�y����Ĳ�0  ���s��u�C�C�C��  ^[ÐSVW���(A ��t ;st
;st;su������������u�����_^[Ðzh-TW,zh-Hant,zh    es-ES_tradnl    nb-NO,nb,no tg-Cyrl-TJ  az-Latn-AZ  uz-Latn-UZ  mn-MN,mn-Cyrl,mn    iu-Cans-CA  ha-Latn-NG  qps-ploc,en qps-ploca,ja    zh-CN,zh-Hans,zh    nn-NO,nn,no sr-Latn-CS  az-Cyrl-AZ  dsb-DE,dsb,hsb  uz-Cyrl-UZ  mn-Mong-CN  iu-Latn-CA  tzm-Latn-DZ qps-plocm,ar    zh-HK,zh-Hant,zh    sr-Cyrl-CS  zh-SG,zh-Hans,zh    smj-NO,smj,se   zh-MO,zh-Hant,zh    bs-Latn-BA  smj-SE,smj,se   sr-Latn-BA  sma-NO,sma,se   sr-Cyrl-BA  sma-SE,sma,se   bs-Cyrl-BA  sms-FI,sms,se   sr-Latn-RS  smn-FI,smn,se   sr-Cyrl-RS  sr-Latn-ME  sr-Cyrl-ME  h<KA �&���f�TKA  �x���%�   ���8KA �=8KA  tNh b@ h b@ 蹱��P軱���,KA h<b@ h b@ 蟱��P衱���0KA h\b@ h b@ 腱��P臱���4KA � GetThreadPreferredUILanguages   k e r n e l 3 2 . d l l     SetThreadPreferredUILanguages   GetThreadUILanguage h<KA �N���Ð� ����   0123456789ABCDEF    U��QS�E��E��D���3�Uh,c@ d�0d� �E���t�Ѓ�
f�:t�E��U��������t��� �؃�|-�E���t�Ѓ�
f�:t�E��U������f�|X�-uK�K��u�3�3�ZYYd�h3c@ �E���������������[Y]Í@ U��3�QQQQSV�ڋ�3�Uhd@ d�0d� �Ë��"�����E�E��t��� ��~�   �f�|Q�,tfBHu�E���������3��k����G�3�u��u��ú   �����E��(d@ �����E�P�E�������Ⱥ   �E��u����U��E��v����}� u�3�ZYYd�hd@ �E�������E��   �������<�����^[��]ð ����   ,   U��Ĕ���SVW3ɉ������������������U���3�Uh�e@ d�0d� �E�3�����f;5�A rTf;5�A wK�@   3��E�;}�r<�]����f;4ݴA s��O�!f;4ݴA vC�]���U��ݸA �}����;}�sċE��8 ��   j��P軮������   jU��J���PjY��S�g���jU������PjZS�V�����������J����U   �����������h�e@ �������������U   ����������h�e@ ��������J����U   �����������E��   �S���3�ZYYd�h�e@ �������   �n����������_^[��]�   � ����   -   � ����   ,   SV����~�f;u����N���3ɋ�^[�U��QSV��3�3��Sj �E�Pj8�,KA ��t���:�����SV�E�Pj8�,KA ��^[Y]Í@ U����SV���3��E��4KA f;�t]�E������E���E�   �E��f����A��A �L�f������M����}��u�f�E�  f�E�  �E�P�E�Pj�0KA �E��;����؅�t;�E�����|!@�E�    �U�f�<S u	�U�f�S, �E�Hu�Ƌ���������z����}� tP�E�Pj j �0KA �E�������؋E�;E�u�M��ӋE�������t�E�P�E�Pj�0KA ���,����E��$���^[��]Ë�U��j SV���3�UhQh@ d�0d� h<KA �I���f;TKA u �ƺXKA �U   �g���h<KA �-����   h<KA ������3��]���j��P������tO�=8KA  t�֋��`����;�֋��U���贫��f;�t(�> t�ƺlh@ �2���虫���U��-����U�������h<KA 襪��f�TKA h�   ��n���PhXKA ����h<KA 腪��3�ZYYd�hXh@ �E�������������^[Y]�   � ����   ,   SV���S褪�����3f��tf��\u��^[Í@ U��Ĕ���SVW�U��E��E��E�h`j@ �ª���E��}� tCh|j@ �E�P質���Å�t/h  ������P�E�P�Ӆ�t�E�P������P�E�P質���R  �E�f�8\u;�E�f�x\�;  �E����L�����f�> �$  �F�8�����f�> �  ��u�����+]���y�� �CP�E�P������P�D�����   �F���������+���y�� �@=  ��   ��+���y�� @PV����������P�����������P������P�y����E��}����   �E�P�[���������P�ϩ���S�@=  ^fǄ]����\ �  +�HP������P����������P苩��������P臩��@؋�f�> �1����E�P������P�E�P�\����E�_^[��]�  k e r n e l 3 2 . d l l     GetLongPathNameW    U�������S�ډE��E��I���3�Uhul@ d�0d� �}� uh  ������Pj 袨���h  �E�����P������P�ƨ��f������ �g  3��E��E�Ph  j h�l@ h  �蹨����t^�E�Ph  j h�l@ h  �蛨����t@�E�Ph  j h�l@ h  ��}�����t"�E�Ph  j h�l@ h  ��_�������   3�UhXl@ d�0d� �������  ������E�Pj j j ������P�E�P�'�����u3�E������E��E�P�E�Pj j ������P�E�P������ËU�������K�E�Pj j j h,m@ �E�P�ا����u/�E��@����E��E�P�E�Pj j h,m@ �E�P诧���ËU�����3�ZYYd�h_l@ �}� t�E������E�P�q�����������3�ZYYd�h|l@ �E�������������[��]�   S o f t w a r e \ C o d e G e a r \ L o c a l e s   S o f t w a r e \ B o r l a n d \ L o c a l e s     S o f t w a r e \ B o r l a n d \ D e l p h i \ L o c a l e s       U�������SV3ɉ������������M���3�Uh�m@ d�0d� 3�h  ������Pj ��������������6���������P�������������  �U����������M�Z�  �}� tjj �E������P�ޥ����3�ZYYd�h�m@ �������   �����E�������a�������^[��]Í@ U��İ���S������P�E����P�%�������Ä�tP������[��]Ë�U����SVW�E��E�����3�Uh�n@ d�0d� �E��E��2������K������3f��,tf��u�f�;,uf�  ���E������PW�E������P�����EP�P���Y��u
f�; u��E� 3�ZYYd�h�n@ �E��(�����z������E�_^[YY]ÐU��S��E������P�E������Pj�c�����P�R����EP�����Y��u�E������f�@  �EP�����Y��u3ۋ�[]�U�������SVW3ۉ������������������������������������w����������l���������3�Uh�p@ d�0d� ��3��g���3�h  �����������P������P����������P���������������/�f�8.t
������;u덅����;��   ��f�   �������+���y�� �  +������������������W��������� tU�����������Y���XU��������������������������Y�؄�u(�=8KA  uU������������������������Y�؄�u	U�<���Y�؄�t�ƍ������  �/���3�ZYYd�h�p@ �������   �"�����l�����_^[��]Í@ S�ظ   �O����,A ��X�,A [ÐSVWU��=,A ��t!�G;�u�,A � �,A �   ���)����-�߅�t'�3��t�F;�u�����   ����������u�]_^[ÐU����SVW�E��,A �E��}� t93�Uh�q@ d�0d� �]��E��S3�ZYYd��
�p���������E�� �E��}� u�_^[YY]Ë��(A ��(A Ë�U��Q�E�3�UhDr@ d�2d�"�E��@�t���3�ZYYd�hKr@ �E�;(A u�E�� �(A ��(A ��t�;U�u	�U����� ��u��������Y]Ë����t�     PR��PXÍ@ ��tRP�R�PX�� ��uËQ�PË�ɉt�Q�P�SVP�   �����PHu���$    ����؅�t=�{   }*h   �D$P�CP�� �D���P�ʠ���ȋԋ��[����
�ƋS������    ^[Ë��%�rA �����T�����D$��$Í@ �����Ё��   % �  ����u��s��v��(A    ���(A 	  Ë��%�rA ���%�rA ���%�rA ���%�rA ��U��U�E�M�۽��]ÐU���M�E�U�����]�U��SV�ujj@�����؅�uVjj h ���"����s��A ���A ^[]�U��U��A �� �8 t;u�;u�
�R�`���]�U��E+E��y����]�U��E3����B�8 u���]�U��E@<]� U��S�]S�����Y��P�uS�"�����[]� U��E�@]� U��E�U;B4u�   �3�]� U����SVW�uj$j �E�P��������E�$   �uԋU�U؋N�M܋^�v�u�<������E��E���F�@����U���t
� ���E�������  �M�3��=�A  t�E�Pj ��A ����t�[  ����   �=�A  t�U�Rj��A �؅�u
�u�� ����؅�uC�����E��=�A  t�E�Pj��A �؅�u �EЉE��U�Rjj h~ ���_����E��	  hLA �����~ uV�����Y�^�	S蕝���^hLA � ����]�=�A  t�E�Pj��A ����uS�~ tB�~ t<S�>������?PE  u,W�^���;Fu!SW�_�����t�v�v� ����F�U��<��R�u�S�Q�������u>�����E��=�A  t�E�Pj��A ����u�EЉE�U�Rjj h ���x����}�E�8�=�A  t3҉U��]�}�M�Qj��A ��_^[��]� U��SVW�]��t3�C�x t*�s�~�v�v�q���W�x���3��FS�����Y�   �3�_^[]�U��SV�u��A hLA 跛����t3���t�C�pV�Y�����u����u�S�z���Y�����3�l���Y�; u�   hLA �t�����^[]� U��hLA �O���]�U��j �}���hLA �Q���]Í@ U��3�Uh�w@ d�0d� ��(A uA�< A �Y����#A �O�����%A �E��������;��������0A �p�����A �f���3�ZYYd�h�w@ ��g�����]Í@ �%psA ���%lsA ���%hsA ���%dsA ���%`sA ���%\sA ��Pj@�����Í@ �   Ë�S������؅�t6�=�A �u
��   ��������������u��   ������P��A P����[ø   ��t�z�����A ������A P�u����(LA Í@ �   ��t+�=�A �t"��A P�O�����tP�-���j ��A P�@���Í@ �   ��t�����=�A �t��A P�
���Ð�LA ��A ��u&d�,   ���������A P�������tá(LA �P�������t�ø�A ����Ð��A �}u0PR�LA �M� LA �J�B    �B    �@�B����ZX�5$LA ��A �y���� LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��   LA ��  �%tA ���% tA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ��SVW�����WVS�����_^[Í@ �%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ��U��j SV�]�u3�Uh�|@ d�0d� ����uSV�������� �E��ӹ    ������E��4���PV������3�ZYYd�h�|@ �E��b�����p�������^[Y]� ��%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%�sA ���%|sA ���%xsA ���������$  T�}�����t�D$�A �D$� A �D$�A ��  Í@ �,LA u�=0LA  t�0LA P�4���Í@  LA ��   LA ��  �}@ TBytes          d@ SysUtilsd@  � ~@ :35   �@ J   �@ SysUtils�@  (~@ :45   �@ J   �@ SysUtils�@  � ����   $   SVQ�ڋ��Ë������; t6��$�$��t�����|����f��s
�f�� f���J��u�Z^[ÐSVWQ���؅�t
�Ã�
� �f� f��t�׉$�$�����C�Å�t��� ���ǋ�������~)��փ�| ����ƿf��sf�� f�����J��u�Z_^[ÐU����SV�U��E��E�����3�Uh�@ d�0d� �E���t�Ѓ�
f�:t�E��U��c�����t��� ��   �C;�|�E��T���f�|X� v�;�}�E�3��n����$N�E��3���f�|p� v�E�P��+�A�ӋE�����3�ZYYd�h�@ �E��#�����u�����^[YY]Ð�u	�y���   �-AN�ù
   RV1���N��0��:r���	�u�YZ)�)�vѰ0)���2Ju���V���1�R1�������X�������^Í@ �u0�
   �@   �t"�p�0���$�T$ �\$�
   �F�-NA���V���|$�<$f�$ �,$f�$���@   �t'�p�0�d$���h���h�����l$�,$��������(�$��N���$���$0<:r����ӛ���s��l$����������Y)�)�v)ְ0���2Ju��ÐU��V��� 1�P1ҍE������X������� ^]� ��U��� ~1�V��� �   R�E�������X������� ^]� SQ�ڋ��}����<$ t��Z[Ë�� ����   0   � ����   - 1     U��İ���S�؍�����P�������P�������tP��������������3�[��]Ë�SV��������P�G������t���^[��=����؃�t��t��{t��������u3���^[�U����SVW�U��؋E�����3�Uh�@ d�0d� �E���t�Ѓ�
f�:t�E��U��O�����t��� �����	����E���~\�]���t�Ã�
f�8t�E��U�������f�|s� t0�}���t�ǃ�
f�8t�E��U���������Tw��E��  ��uN���3�ZYYd�h�@ �E��������G�������_^[YY]�SVW���؋ӸH�@ ������W�κ   ������_^[ð ����   \ :     SVW���؋Ӹ��@ �������W�V�����������_^[�   � ����   \ :     U����S�E��u3��U�R�U�R�U�R�U�RP�����؋E��m�3҉E�U�E�3�RP�E�U������M��Q�E�3�RP�E�U������M��Q��[��]� �SVW����$����3�;$sH���؃ßf��sf�� �ڃßf��sf�� f;�uf��u����+D$�����A;$r�3��D$�D$YZ_^[��f;�t���f��u�f��t3�Ë�U��� ���SV��]h   �� ���QRP������~��I�� ����������	�Ë��:���^[��]� ��SVWQ�����j�D$PVS�h�����~�$���Z_^[Í@ U����SVW�M������]S�E�@�3ɋ��e����; u�E������[���_^[YY]� ��U��3�QQQQQQSVW3�UhW�@ d�0d� �����E��   �`LA ��LA Uj�E�P�dA ��J�CDH�u���Y�U���n���Uj�E�P��A ��J�C8H�R���Y�U����K���C������u��   ��LA ��LA �C�   ����U�Uj�E�P��A ��J�E���1����Y�U�������Uj�E�P��A ��J�E���*�����Y�U�������C������u�3�ZYYd�h^�@ �E�   ������������_^[��]Í@ U��SV3��   ���tC�<�MA  u���MA �U�����   ��^[]� ��U��j SV3�Uh	�@ d�0d� 3��   ���t,C�<� MA �u��E��U������E�3������� MA �   3�ZYYd�h�@ �E��������B�������^[Y]� �@ U��j V3�Uh��@ d�0d� �E�P�����̇@ �  �D����E��   �������ƃ����s<jV����Phh�@ �\����   �$MA � ������Ju�jV�Z���Ph��@ �3���3�ZYYd�h��@ �E��F����阵����^Y]�  � ����   1   U��3�QQQQQQSVW���E��E�����3�Uh�@ d�0d� �   ��3������E�P������ �@ �	  �m����E��   �H����������  ��LA ��t����r3�����tC�+�E��tX���f��Gtf�� t�E���������U�������C�E��O��������;�~��I  �ǋU��g����:  �u���t�ƃ�
f�8t�E��U�������f�|^� �r@f�|^���w7�ӋE��G  ��y�� �E��E�P�M��ӋE��T����U������]��   �$�@ �E��DX��   �������u�Ǻ8�@ �����C�   �@�@ �E��DX��   ������u�ǺX�@ ��������e�d�@ �E��DX��   ������u�Ǻx�@ ����C�<�E��DX�f��Ytf�� u�Ǻ��@ �v�����E�U��TZ������U���Z���C�E���������;������3�ZYYd�h
�@ �E�   �����E��������H�����_^[��]�   � ����   1   g g     � ����   g g g   y y y y     � ����   e e e e     y y     � ����   e e     � ����   e   ��@ 	TErrorRec      �@        L@     Code �@    Ident  �܊@ TExceptType       ؊@ etDivByZeroetRangeErroretIntOverflowetInvalidOpetZeroDivide
etOverflowetUnderflowetInvalidCastetAccessViolationetPrivilege
etControlCetStackOverflowetVariantErroretAssertionFailedetExternalExceptionetIntfCastErroretSafeCallExceptionetMonitorLockExceptionetNoMonitorSupportExceptionSysUtils �0�@ 
TExceptRec      �@        ؊@     EClass �@    EIdent  �SVW�ڋ��>�;�Ƌϋ��r���;u�_^[Ë�SV�����t��Ƌ��S���;�u��^[Ë�SVW3��    �LMA �; u)j jS�"�����u�{ uj j j j ������C�{���Nu̅�uj j j j ������W������_^[Ë��    �PMA ;uj �B�P�����Ã�Iu�P�~���ÐS�LNA �I�����t�X3҉P�PNA ������j j j j �S�����S������[Í@ S�ظPNA ������u
�   譢���X�LNA ������[ÐS��t��u
3�P�k������t��uQR�r������j QRP�T����؋�[Ë���A � �A �SV���ޅ�t#�3�{ t	�CP�����   ���M����ޅ�u�^[�SV���| F��j jS������u�CP�z�����Nu�^[ÐS�LNA j S���������PNA j S���������LMA �   ����[Ë��������$  T�Y�����tP�D$�A �D$�A �D$� A �=A u�D$%��  �$A �	�D$�$A �(A �T$��   ������  Ë��f�� �rf����wf�x �rf�x��w�   ø   Í@ U��QSV�ډE��E�赽��3�Uh��@ d�0d� �   �E���t�Ѓ�
f�:t�E��U��]����TX�f�� �rf����w�E����������d�����3�ZYYd�h��@ �E��M����韭������^[Y]Ë�U��QSVW�}���Wj �O���3��*�D7�\7*�rC�E��E����,A �E���u����}�D7
D7u�_^[Y]Í@ U����SVW��LA �	  �C	   �C   ������t�f��t��f����҉S����
�C���@ �,A �   �=A ~�=A u�C�jJ����������C��C��tU����Y_^[��]�                                 U��   j j Iu�S3�Uh��@ d�0d� �%����L����=MA  t����������؍E�P3ɺ   ���m����U�4LA �ܻ���E�P�ȓ@ �   ���K����E�3��)����8LA �E�P�ȓ@ �   ���'����E�3������9LA f�, �   ���T���f�:LA f�. �   ���>���f�<LA �E�P�ȓ@ �   ��������E�3������>LA f�/ �   ������f�@LA �E�P�ؓ@ �   �������E܍U�������U�DLA �����E�P���@ �    ���p����EԍU������UظHLA �Ժ��f�: �   ������f�LLA �E�P��@ �(   ���-����UиPLA 蜺���E�P�0�@ �)   �������U̸TLA �z����E�3��ĺ���E�3�躺���E�P�ȓ@ �%   ��������E�3�������u�E��D�@ 芺����E��T�@ �{����E�P�ȓ@ �#   �������E�3��t�����u?�E�P�ȓ@ �  ���s����E�3��Q�����u�E��h�@ �(�����E����@ �����u��u�h��@ �u��XLA �   �h����u��u�h��@ �u��\LA �   �K���f�, �   ���K���f�MA 3�ZYYd�h��@ �E��   �S����革����[��]�  � ����   0   � ����   m / d / y y     � ����   m m m m   d ,   y y y y     � ����   a m     � ����   p m     � ����   h   � ����   h h     � ����     A M P M   � ����   A M P M     � ����   : m m   � ����   : m m : s s     ��@ PUnitHashEntryؔ@  ��ܔ@ TUnitHashEntry           ��@     Next ��@    Prev �@    	LibModule �@    UnitName  @    DupsAllowed �@    FullHash  �t�@ TUnitHashArray       ����ؔ@ SysUtilsؔ@  ���@ TModuleInfo      p�@         @     	Validated p�@    UnitHashArray  ��SVWU�������؋�������j j USj h��  ���������  v������������WVUSj h��  �����WV����3ۋ�H��|@3ҋ�����ˋ��V3�BHu��;�t�������Á�  ]_^[ÐVS��1�V����Àu�� t��A|��Z�� 2�F��Y[^�X[^�8���Í@ SVWU���A ���t;Bt���u��$�<$ ��   �$�x ��   �$�X�; t
�D$TNA ��D$H^A �C�s��������   E3��<v�C�|� t�C���v�K�T���L�C�|� tB�v�S�D��$�����  3���T$�D$�T$���S��;�u�C���T$�L$���C�<� t�C�D��v�K�щBFM�o������@ �������$3҉P��]_^[�SV�A �����   ���m����> u�^[ÐSh<�@ �Y����؅�thX�@ S�X����PA �=PA  u
���@ �PA [�  k e r n e l 3 2 . d l l     G e t D i s k F r e e S p a c e E x W   S�A ���t�{ t���@ �C�;���3��C���u�[Ë���@ TLanguageArray   �@ J   �@ SysUtils�@  �   �A �A    �A lA    �A �A    �A �A    �A 4A    �A �A    �A �A    �A `A    �A �A    �A A    �A �A    �A �A    �A xA    �A �A    �A A    xA |A    pA 0A    hA �A    `A �A    XA 4A    PA (A    HA �A    @A A    8A  A    0A XA    (A DA     A �A    A �A    A  A    A A     A �A    (   �A A     �A 8A     �A �A     �A ,A     �A PA     �A HA     �A <A     �A �A     �A �A     �A LA     �A �A     �A �A     �A �A     �A �A     �A tA     �A hA     �A (A     �A �A     �A �A     �A dA     �A �A     �A �A     �A �A     �A pA     �A $A     �A �A     �A $A     �A A     �A �A     �A TA     �A 0A     |A  A     xA 8A     tA @A     pA A     lA A     hA �A     dA ,A     `A �A     \A \A     U��3�Uhޝ@ d�0d� �HMA �s  �Ȗ@ ���������o���������A �x����A 誮���A 訨���(A �Z����4LA �P����DLA �F����HLA �<����PLA �2����TLA �(����XLA �����\LA �����`LA �   ��@ �W�����LA �   ��@ �B�����LA �   ��@ �-�����LA �   ��@ �����MA �   ��@ �����@MA ��}@ �����DMA �$~@ ������LA 聯���TA �   ��@ �ķ����A �   ���@ 请���4A �   �,�@ 蚷���<nA ���@ �����A �(���3�ZYYd�h�@ ��m�����]ÐS�@nA �; �}  h��@ �g�����; �h  h��@ �P�_����DnA hܟ@ �P�M����HnA h��@ �P�;����LnA h�@ �P�)����PnA h4�@ �P�����TnA hL�@ �P�����XnA h��@ �P������dnA h��@ �P������hnA h��@ �P������lnA h�@ �P�����pnA h��@ �P�����\nA h�@ �P�����`nA h �@ �P�����tnA h�@ �P�u����xnA h8�@ �P�c�����nA hT�@ �P�Q�����nA hp�@ �P�?�����nA h��@ �P�-�����nA hp�@ �P�����|nA h��@ �P�	�����nA �; t	�=DnA  u3�[ð[�  k e r n e l 3 2 . d l l     C r e a t e T o o l h e l p 3 2 S n a p s h o t     H e a p 3 2 L i s t F i r s t   H e a p 3 2 L i s t N e x t     H e a p 3 2 F i r s t   H e a p 3 2 N e x t     T o o l h e l p 3 2 R e a d P r o c e s s M e m o r y   P r o c e s s 3 2 F i r s t     P r o c e s s 3 2 N e x t   P r o c e s s 3 2 F i r s t W   P r o c e s s 3 2 N e x t W     T h r e a d 3 2 F i r s t   T h r e a d 3 2 N e x t     M o d u l e 3 2 F i r s t   M o d u l e 3 2 N e x t     M o d u l e 3 2 F i r s t W     M o d u l e 3 2 N e x t W   SV����1�����tVS�|nA ^[�3�^[ÐSV���������tVS��nA ^[�3�^[Ð�@ SList   �@ J   �@ LiteINI�@  �@ �@ INIValue      �@     �@        �@     Name �@    Value  ��l�@ :INISection.:1   �@ �����@ LiteINI�@  ����@ 
INISection      �@     h�@        �@     Name h�@    Values  �@ ��@ INIFile   ��@ ������@ LiteINI��@  �U��QS�U��؋E��©��3�Uh��@ d�0d� ��M���@P�ù   ��@ ��������/�����D���U�虩�������H��3�ZYYd�h��@ �E��j����鼙������[Y]�U����SVW�U��E��E������E��5���3�Uh�@ d�0d� ����E�輸����N��|F3ۋE����U������u���CNu�3�ZYYd�h!�@ �E�������E���@ �K�����1������_^[YY]Ë�U����SVW�U��E��E�腺���E�襨��3�Uh��@ d�0d� ����E��,�����N��|F3ۋE��؋U��l���u���CNu�3�ZYYd�h��@ �E��]����E���@ 軹���願�����_^[YY]Ë�U����SVW�M����E��E������E�����3�UhY�@ d�0d� �E�������|?�E�蒷��;�}3�E��D�肷����N��| F3ۋE��D��؋U�辭��u�]��CNu�3�ZYYd�h`�@ �E�讧���E���@ �����������E�_^[��]Ë�U��QSV�U����E��q���3�Uh��@ d�0d� ��U������؅�}J������؍CP�ƹ   ��@ 蜸������؋U��<���j ��D��   �h�@ �t�����3�ZYYd�h�@ �E��������N�������^[Y]ÐU��QSVW�M��ڋ��E��Φ���E�Ʀ��3�Uhܦ@ d�0d� �����|��J���;�}t��M����f��������uO��D��(������GP��D��   �h�@ �Է������D����U��p�����D��D��U�^������D��D��U�J���3�ZYYd�h�@ �E��%����E������o������_^[Y]� �@ S��j �ù   ��@ �Q�����[�U������SVW3ɉ���������������M��M�M��M�U��E�E�誥�������3�Uho�@ d�0d� �E������E���������  �U����č�����=���謉���t�U���茬�����1���蔉���U����@ ����HtN�U����@ �����Ht>�U����@ ������~�U����@ �֬�����U��̪@ �Ŭ����~�E�U��������K����*������x������ߍ�������E������E��c�����N����  F3ۋE���U�������E���t�Ѓ�
f�:t�E��U��b�����t��� ����   �E���t�Ѓ�
f�:t�E��U��3���f�8[��   �}���t�ǃ�
f�8t�E��U��������E���t�Ѓ�
f�:t�E��U�������t��� f�|G�]us�E���t�Ѓ�
f�:t�E��U�违������t���?�����P�σ��   �E��#������������������������E������E�U������E���   �E��U�������U��̪@ �:�������   �����P�U��̪@ ������I�   �E�誩��������U��p����E���t�Ѓ�
f�:t�E��U����������t���?�E�P�U��̪@ �Ǫ��+�W�U��̪@ 跪����B�E�Y�G����}��u�E�3��S����E�E�P�E�M�U������CN����3�ZYYd�hv�@ ������   譢���E��@ �����E�   蒢����ܒ����_^[��]�   � ����   ;   � ����   #   � ����   [   � ����   ]   � ����   =   U����S�U��E��E������E�����3�Uh.�@ d�0d� �U��E��&���@��3�ZYYd�h5�@ �E��١���E���@ �7�����������[YY]�U����S�M�U��E��E��t����E�蔡���E�茡��3�Uh��@ d�0d� �U��E������؋M�ӋE��0���@����3�ZYYd�h«@ �E��   �T����E���@ 課���鐑���݋�[��]Í@ U����SVW�M����E��E�����3�Uhg�@ d�0d� 3�j �E��   ��@ �N�������|:�E��w���;�}.�E��D��g�����K��|C3��E��D����E������FKu�3�ZYYd�hn�@ �E���@ �������������_^[YY]ÐU����S�ىU��E��E��9����E��Y���3�Uh�@ d�0d� �U��E��|����ˋЋE�����3�ZYYd�h�@ �E��'����E���@ 腱����k�����[YY]�U��QSVW����E��E��Ʊ��3�Uhg�@ d�0d� 3ۅ�|5�E��r���;�})��|%�E��D��^���;�}�E�U��T��T�迟���3�ZYYd�hn�@ �E���@ �������������_^[Y]� U����SVW�M�U��E��}�E��3����E��S����E��K����E�C���3�Uh#�@ d�0d� �U��E��f����؋M�ӋE��������W�΋ӋE�������u
�ǋU����3�ZYYd�h*�@ �E��   ������E���@ �J����E�֞����(�����_^[��]� �U����S3ۉ]��M�U��E��E��w����E�藞���E�菞��3�Uh®@ d�0d� j �E�P�M�U��E�������U�E�芪���؃}� t�]3�ZYYd�hɮ@ �E�   �M����E���@ 裯���鉎���݋�[��]� ��U����S3ۉ]�]��M�U��E��E��ԯ���E�������E�����3�Uh}�@ d�0d� j �E�P�M�U��E��R����E�M𺜯@ 计���E�U��ש���؃}� t�]3�ZYYd�h��@ �E�藝���E�   蒝���E���@ ������΍���Ջ�[��]�    � ����   $   U����S3ۉ]��M�U��E��E������E��+����E��#���3�Uh4�@ d�0d� j �E�P�M�U��E������U�E������}� t�]�����3�ZYYd�h;�@ �E�   �ۜ���E���@ �1���������݋�[��]� U����SV�ډE��E�藜��3�UhH�@ d�0d� �E� �E���t�Ѓ�
f�:t�E��U��@�����t��� ���  �E���t�Ѓ�
f�:t�E��U���������t���6��y�� V�ù   ��}@ �}������諫����J���>  B3��� ��ɋu��tN��Ѓ�6�!  ���@ �$�V�@ 	
                                 2�@ �@ ��@ ��@ ��@ ��@ ��@ ı@ ̱@ Ա@ ܱ@ �@ �@ ��@ ��@ �@ �@ �v�3��n�3��f�3��^�3��V�3��N�3��F�3��>�3��6�3�	�.�3�
�&�3���3���3���3���3��u��N��Ѓ�6�  ��3�@ �$�j�@ 	
                                 2�@ &�@ ��@ ��@ ��@ Ȳ@ в@ ز@ �@ �@ �@ ��@  �@ �@ �@ �@  �@ �v���n�� �f��0�^��@�V��P�N��`�F��p�>����6����.����&�������������������@J������E�3�ZYYd�hO�@ �E�豙����������E�^[YY]Í@ U����S3ۉ]��M�U��E��]�E��L����E��l����E��d���3�Uh��@ d�0d� j �E�P�M�U��E�������ӋE�������uj �ù   ��}@ 航����3�ZYYd�h�@ �E�   �����E���@ �i�����O�����[��]� ��� ����   \ r d p w r a p . t x t     �%tA ���%tA ���%tA ���%tA ��U���(���3҉�(����E��E��p���3�Uh�@ d�0d� �A �h�����t_�A ��,���裀����,����0~���|����(����$�@ �U��0�����(�����,����ϕ�������Y|����,��������I|��3�ZYYd�h�@ ��(����9����E��1�����?������]� � ����   
  �%tA ��Q3��$Th0�@ j������$Z�S�� ����؋�3ɺ   �)���h   �D$P�����P������Ë��7�����   [Í@ SVWU���������������j j�����؃��tM�$   TS������t5�D$;�t";|$uPj j�]������vU�Y���U�����TS�\�����u�S�������]_^[Ë�SVWU����(�����������j j�����؃��tM�$   TS������t5�D$;�t";|$uPj j��������vU�����U�[���TS�������u�S�J�����]_^[Ë�U��Ĵ���SVW3ۉ���������������������������������������������������E��E��#���3�UhA�@ d�0d� 3�Vj�W���������+  ǅ����(  ���������������  �������������  �˗�������������������������������e���������P�������E��P���������X耛����   ���������E�������V�7����   �������������  �L������������������������������������������P�������E������������X����u���������E�����������������������y���V����3�ZYYd�hH�@ �������   �Ȕ���E�踔����
�������_^[��]� �SVWU���3ۅ�uj ����������� ���P���������tqjjV�^�������taWV�m�����tV�P0�U �P4��f�U�P4f�U�PD�����U�PD�����U	�PD�����U
�@D�� �� ���E���]_^[�U��QSV��E��E�����3�Uha�@ d�0d� ��M��|�@ ��nA ������tj �M��|�@ ��nA �������3�3�ZYYd�hh�@ �E�蘓�����������^[Y]� � ����   S L P o l i c y     U��   j j Iu�QSVW�u�]3�Uh�@ d�0d� �E��������M��E��<�@ �����U�E��    �S����E��k����E��������E�U��������tB�}��>3ۋ�3�RP�E������M��E�h�@ 轖���U�E�    ������E������   h�nA jh�nA ��nA P�����P�����VS��nA �؅�u8�3�RP�E������MԍEغ��@ �W����U؍Eܹ    藔���E������
�Ļ@ ����h�nA jh�nA ��nA P�`���P�~���3�ZYYd�h"�@ �EԺ   �����E��L����E�   �����E��7����E�   �����E��"�����0���빋�_^[��]�    � ����   P o l i c y   q u e r y :       � ����   P o l i c y   r e w r i t e :       � ����   P o l i c y   r e s u l t :     � ����   Policy request failed   U��   j j Iu�QSVW���3�Uh(�@ d�0d� �E���詒���M��E��D�@ �ɔ���U�E��    �	����E��!����E���w����E�U�������t?�}��>3ۋ�3�RP�E������M��E�p�@ �s����U�E�    賒���E�������PVS��nA �؅�u8�3�RP�E��u����MԍEغ��@ �-����U؍Eܹ    �m����E������
�̽@ �y���3�ZYYd�h/�@ �EԺ   �����E��?����E�   ������E��*����E�   �����E�������#���빋�_^[��]ð ����   P o l i c y   q u e r y :       � ����   P o l i c y   r e w r i t e :       � ����   P o l i c y   r e s u l t :     � ����   Policy request failed   U��E�����]� �U��   j j Iu�SVW3�Uh��@ d�0d� 3�3�3�3��E�3��E�3��E�3��E�3��E踬�@ �����U���nA ������u�h��@ �U���nA ������u�h��@ �U���nA �����u�h��@ �U���nA �����u�h��@ �E��   �"����U���nA ��������   j � �@ �U���nA �������nA j �,�@ �U���nA �������5�nA j �h�@ �U���nA �������=�nA j ���@ �U���nA �����nA �E�j ���@ �U���nA �����nA �E�j ��@ �U���nA �w����nA �E�j �<�@ �U���nA �Z����nA �E�j �x�@ �U���nA �=����nA �E��tnj���@ ���@ ��nA �z����h��@ ��3�RP�U̸   �p����u�h�@ �3�RP�E��2����uȍEк   �Α���UЍEԹ    �*����E��B�����tnj�8�@ ���@ ��nA �����h��@ ��3�RP�U��   ������u�hl�@ �3�RP�E�������u��E��   �\����U��EĹ    踎���E��������tnj���@ ���@ ��nA �����h��@ ��3�RP�U��   �����u�h��@ �3�RP�E��N����u��E��   �����U��E��    �F����E��^����}� tuj���@ ���@ ��nA �"����U��h��@ �E�3�RP�U��   �����u�h,�@ �E�� 3�RP�E��ӿ���u��E��   �o����U��E��    �ˍ���E�������}� tuj�h�@ ���@ ��nA �����U�h��@ �E�3�RP�U��   虿���u�h��@ �E� 3�RP�E��X����u��E��   �����U��E��    �P����E��h����}� ��   j ���@ ���@ ��nA �(����U��h��@ �E�3�RP��|����   ������|���h �@ �E�� 3�RP��x����о����x����E��   �i����U��E��    �Ō���E�������}� ��   j �8�@ ���@ ��nA �����U�h��@ �E�3�RP��l����   茾����l���hl�@ �E� 3�RP��h����E�����h�����p����   �ێ����p�����t����    �1�����t����F����}� ��   j���@ ���@ ��nA �����U�h��@ �E�3�RP��\����   �������\���h��@ �E� 3�RP��X���讽����X�����`����   �D�����`�����d����    蚋����d�������3۸ �@ ����3�ZYYd�h��@ ��X����   �2�����d����c�����h����   ������t����H�����x����   ������E��0����E��   �����E������E��   �҈���E������E��   轈���E������E��   計���E��܀���EȺ   蓈���E��ǀ���Eغ   �~����E��n������x���)�����_^[��]�  � ����   >>> CSLQuery::Initialize    � ����   .   � ����   - S L I n i t   � ����   b S e r v e r S k u . x 8 6     � ����   b R e m o t e C o n n A l l o w e d . x 8 6     � ����   b F U S E n a b l e d . x 8 6   � ����   b A p p S e r v e r A l l o w e d . x 8 6   � ����   b M u l t i m o n A l l o w e d . x 8 6     � ����   l M a x U s e r S e s s i o n s . x 8 6     � ����   u l M a x D e b u g S e s s i o n s . x 8 6     � ����   b I n i t i a l i z e d . x 8 6     � ����
   b S e r v e r S k u     � ����   S L I n i t     � ����
   S L I n i t   [ 0 x     � ����   ]   b S e r v e r S k u   =     � ����   b R e m o t e C o n n A l l o w e d     � ����   ]   b R e m o t e C o n n A l l o w e d   =     � ����   b F U S E n a b l e d   � ����   ]   b F U S E n a b l e d   =       � ����   b A p p S e r v e r A l l o w e d   � ����   ]   b A p p S e r v e r A l l o w e d   =       � ����   b M u l t i m o n A l l o w e d     � ����   ]   b M u l t i m o n A l l o w e d   =     � ����   l M a x U s e r S e s s i o n s     � ����   ]   l M a x U s e r S e s s i o n s   =     � ����   u l M a x D e b u g S e s s i o n s     � ����   ]   u l M a x D e b u g S e s s i o n s   =     � ����   b I n i t i a l i z e d     � ����   ]   b I n i t i a l i z e d   =     � ����   <<< CSLQuery::Initialize     �@ :1   �}@    d@ rdpwrap�}@  ��U��   j j Iu�SVW3�Uhe�@ d�0d� �A 3���nA 3���nA 3���nA ���@ ������E������EЍU��w����UԍE����@ �7����EȋM����@ �'����UȍE̹    �g����E�������nA �U��*�����nA 褑����u��@ �Z�����  �E��A����E��U������E��8�@ �����E�P�E�P�\�@ �x�@ ��nA �=����UĸA ��������@ ����h��@ 蠱���؅�u���@ ������S  h �@ S�������nA h�@ S������nA hX�@ ��3�RP�U��   蛵���u�h��@ h��@ ��nA +�3�RP�U��   �v����u�h��@ h��@ ��nA +�3�RP�U��   �Q����u��E��   �Ņ���U��E��    �!����E��9���3���nA � �@ �(�����t�=�nA ��nA �����u�D�@ �����n  h��@ �U���nA �Ƴ���u�h��@ �U���nA 诳���u�h��@ �U���nA 蘳���u�h��@ �U���nA 聳���u��E��   �	����U��E��    �e����E��}������@ �s����������@ �d����M� �@ ��nA �v����E�膏��P�E�   ��@ �:������E��g�����N��|_F3ۍE�P�E���� �@ ��nA �����U��E����}@ �@����E���%�����~j�E���   ��}@ �А����CNu���   ��   j�$�@ �x�@ ��nA ���������   hH�@ �9�����hX�@ S訮����nA �=�nA  t\���@ �l�����nA h��nA ��@ ��nA �h�nA jh�nA ��nA P����P�����h�nA jh�nA ��nA P�����P������  ��   j���@ �x�@ ��nA �D�������   hH�@ 莮����hX�@ S�������nA �=�nA  t\���@ �������nA h��nA ��@ ��nA �h�nA jh�nA ��nA P�f���P�L���h�nA jh�nA ��nA P�I���P�g�����  uhH�@ ������hX�@ S�t�����nA ��  ��  �U���nA �����u�h��@ �U���nA ������u�h��@ �U���nA �ް���u�h��@ ��|�����nA �İ����|����E��   �I����U���nA �D������!  �E�P蓬���й�nA � �@ ���������  j � �@ �U���nA �������ty�4�@ �|���j �p�@ �U���nA �������5�nA j ��x���P���@ �U���nA �i�����x����E������؅�|$h�nA �E���]���P�E��PV����P����j ���@ �U���nA �E�����ty��@ �����j �T�@ �U���nA �W�����5�nA j ��t���P���@ �U���nA �������t����E�������؅�|$h�nA �E���̋��P�E��PV�V���P�t���j ���@ �U���nA ������ty���@ �Z���j ��@ �U���nA �������5�nA j ��p���P�L�@ �U���nA �G�����p����E��]����؅�|$h�nA �E���;���P�E��PV�Ū��P����j �|�@ �U���nA �#�������   ���@ �����j ���@ �U���nA �1�����5�nA �Eډ�E���E�h�E�ܻ@ �E��h �@ �E�P�D�@ �U���nA �����E�� �@ �����u�E�ܻ@ �E��t�@ ����u�E��@ h�nA j�E�PV����P�,���j ���@ �U���nA �l�����t}���@ ����j ���@ �U���nA �~�����5�nA �E�h�E���@ �E��h �@ �E�P�\�@ �U���nA ������E�� �@ �S���u�E���@ h�nA j�E�PV�y���P藪�����@ �����@���3�ZYYd�ho�@ ��p����   �z���E���}@ �u����E��   �z���E��8r���E��   ��y���E��#r���E��   ��y���E��r���Eк   ��y���E��@ �����E���@ �����E��   �y�����i���b���_^[��]�  � ����   Loading configuration...    � ����   r d p w r a p . i n i   � ����   C o n f i g u r a t i o n   f i l e :       � ����#   Error: Failed to load configuration � ����   r d p w r a p . t x t   � ����   L o g F i l e   � ����   M a i n     � ����   Initializing RDP Wrapper... t e r m s r v . d l l   � ����/   Error: Failed to load Terminal Services library S e r v i c e M a i n   S v c h o s t P u s h S e r v i c e G l o b a l s   � ����   B a s e   a d d r :     0 x     � ����    
     � ����   S v c M a i n :         t e r m s r v . d l l + 0 x     � ����   S v c G l o b a l s :   t e r m s r v . d l l + 0 x     � ����   t e r m s r v . d l l   � ����1   Error: Failed to detect Terminal Services version   � ����   V e r s i o n :             � ����   .   � ����   Freezing threads... � ����   Caching patch codes...  � ����
   P a t c h C o d e s     � ����   S L P o l i c y H o o k N T 6 0     s l c . d l l   S L G e t W i n d o w s I n f o r m a t i o n D W O R D     � ����!   Hook SLGetWindowsInformationDWORD   � ����   S L P o l i c y H o o k N T 6 1     � ����   L o c a l O n l y P a t c h . x 8 6     � ����.   Patch CEnforcementCore::GetInstanceOfTSLicense  � ����   L o c a l O n l y O f f s e t . x 8 6   � ����   L o c a l O n l y C o d e . x 8 6   � ����   S i n g l e U s e r P a t c h . x 8 6   � ����>   Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled  � ����   S i n g l e U s e r O f f s e t . x 8 6     � ����   S i n g l e U s e r C o d e . x 8 6     � ����   D e f P o l i c y P a t c h . x 8 6     � ����   Patch CDefPolicy::Query � ����   D e f P o l i c y O f f s e t . x 8 6   � ����   D e f P o l i c y C o d e . x 8 6   � ����   S L P o l i c y I n t e r n a l . x 8 6     � ����(   Hook SLGetWindowsInformationDWORDWrapper    � ����   S L P o l i c y O f f s e t . x 8 6     � ����
   N e w _ W i n 8 S L     � ����   S L P o l i c y F u n c . x 8 6     � ����   N e w _ W i n 8 S L _ C P   � ����   S L I n i t H o o k . x 8 6     � ����   Hook CSLQuery::Initialize   � ����   S L I n i t O f f s e t . x 8 6     � ����   N e w _ C S L Q u e r y _ I n i t i a l i z e   � ����   S L I n i t F u n c . x 8 6     � ����   Resumimg threads... U��S���@ �����=A  u����3ۃ=�nA  t�EP�EP��nA �ظ�@ �w�����[]� � ����   >>> ServiceMain � ����   <<< ServiceMain U��S�l�@ �*����=A  u����3ۃ=�nA  t�EP��nA �ظ��@ �������[]� � ����   >>> SvchostPushServiceGlobals   � ����   <<< SvchostPushServiceGlobals   U��3�Uh��@ d�0d� ��nA ��@ 苀���A �o��3�ZYYd�h��@ ��Z_����]Ë�   �@ <  ��@    ��@           A |w@         � A �}@                                                 �A �A �A �A �A �A � A @�@                     ��@ �@ �@ ��@ �@    �}@ �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A    �A �A �A    �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A    �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A        @ 0@ �A �A �A L@ d@ �A |@ �@ �A �A �A �A �A �A �A �A �A �A �@ �A �@ �A �A �A �A �@ �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �@ �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A  @ $@ <@ X@ �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �@ �@ �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A       �A �A �A �A �A �A �A �A �A       �A �A �A �A �A    �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A    �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A �A    LiteINISysUtils	CharacterWindowsTypesSysInitSystem	RTLConstsMathSysConstStrUtilsImageHlpTlHelp32�        �-�(A ��   �Bw���).���da���A � A �@ � A �@ �6 A ��r���8 A �  A �X@ �:��f�@ A ��f�#A ��f��%A �������, A ����( A �ur����(A ��(A �  �i���  A �sr��Ë��-,LA s�|��3��0LA Ë�U��3�UhBA d�0d� �-HMA sV��@ �A���\�@ ��A���=LA  t�LA �XA ��K���ٌ���Ȗ@ ��o���j��������A 3��ai��蜏��3�ZYYd�hIA ��	<����]� � ����   0 x     U�������@ ��w��3�Uh�A d�0d� 3�ZYYd�h�A ��;�����B��                                                                                                                �@         2�� �@  �@  �@ �@         p@ �@ �@  @ `@ l@ t@ �@ �@ �@                            �@                            �@                             �@   (                         @   0                         4@   8                         X@   @                         �@   H                         �@   P                               X                               `                               h                               p                               x                               �                               �                               �                               �                               �                               �                               �                               �                               �                               �                                                                                                                           0                              @                              `                              �                              �                              �                              �                                                            @                              p                              �                              �                                                             p                              �                                                             �                              �                              `                              �                              p                                                            �                              �                              P	                              0
                              0
                              0
                            X@ �@ � @ �#@ �'@  (@  ��������������������� ����Error ��Runtime error     at 00000000 ��0123456789ABCDEF�� ����      ��  T_@ 
  h_@   x_@ (  �_@ ,  �_@ C  �_@ P  �_@ ]  �_@ h  �_@   �_@ �  �_@   �_@   `@   `@ ,  `@ .  (`@ C  8`@ P  D`@ ]  P`@ _  \`@ �	  h`@   x`@   �`@   �`@ ;  �`@   �`@   �`@ ;  �`@   �`@ ;  �`@   a@ ;  a@    $a@ ;   0a@ $  @a@ ;$  La@ (  \a@ ,  ha@ 0  ta@ d  $a@ h  �`@ l  \a@ p  @a@ ;p  La@ ,t  `@ ;t  0a@ x  �_@ x  `@ x  �`@ ,x  �_@ ;x  a@ Cx  8`@ Px  �_@ ]x  �_@ |  x`@ |  x_@ |  @a@ (|  �_@ .|  (`@ ;|  �`@ C|  �_@ P|  D`@ ]|  P`@ _|  \`@ h|  �_@ �b@             ����                                �x@ xx@ 4x@ �x@                                                                             X~@     ��@ ��@  z@ (z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@ �z@  {@ {@ {@ {@  {@ ({@ 0{@ 8{@ @{@ H{@ P{@ X{@ `{@ h{@ p{@ x{@ �{@ �{@ �{@ �{@ �{@ �{@ �{@ �{@                             d       e       j                                                                       	       
                                                                                                  ��@ �@ D�@ ��@ ��@         �@  �@ �z@ 0z@ �y@ �z@ 8{@ �{@ �z@ `z@ �{@ �{@ �z@ �y@ �{@ p{@ �{@ �z@ �y@  z@ Xz@  {@ @{@ �z@  {@ H{@ z@  z@ z@ �{@ �}@ �y@ (z@ 8z@ �z@ �(A pz@ {@ Pz@ {@ ({@ Hz@ �z@ �z@ �z@ h{@ �y@ �y@ {@ x{@ �y@ P{@ xz@ �{@ �y@ hz@ 0{@ X{@ `{@ @z@ �z@ �z@ (A �{@ �z@ �}@ z@ �y@ �y@ �z@ �y@ �z@ �y@ �y@ �z@                                                                                                                                                                                                     �p         $t lr �p         lt |r �p         �t �r �p         �t �r �q         x \s �q         nx xs �q         �x �s Tr         { t                     2t Bt Xt     zt �t �t     �t �t �t     �t �t 
u u $u .u 6u Du Tu du ru �u �u �u �u �u �u �u �u v .v @v Tv jv �v �v �v �v �v �v �v �v  w w .w >w Jw Vw hw xw �w �w �w �w �w �w x     "x 0x >x Hx Tx `x     zx �x     �x �x �x �x  y y y *y >y Ty dy ty �y �y �y �y �y �y �y 
z z 4z Jz ^z jz �z �z �z �z �z �z �z �z     { 0{ @{ P{ l{     2t Bt Xt     zt �t �t     �t �t �t     �t �t 
u u $u .u 6u Du Tu du ru �u �u �u �u �u �u �u �u v .v @v Tv jv �v �v �v �v �v �v �v �v  w w .w >w Jw Vw hw xw �w �w �w �w �w �w x     "x 0x >x Hx Tx `x     zx �x     �x �x �x �x  y y y *y >y Ty dy ty �y �y �y �y �y �y �y 
z z 4z Jz ^z jz �z �z �z �z �z �z �z �z     { 0{ @{ P{ l{     oleaut32.dll    SysFreeString   SysReAllocStringLen   SysAllocStringLen advapi32.dll    RegQueryValueExW    RegOpenKeyExW   RegCloseKey user32.dll    LoadStringW   MessageBoxA   CharNextW kernel32.dll    lstrcmpiA   LoadLibraryA    LocalFree   LocalAlloc    GetACP    Sleep   VirtualFree   VirtualAlloc    GetSystemInfo   GetVersion    GetCurrentThreadId    VirtualQuery    WideCharToMultiByte   MultiByteToWideChar   lstrlenW    lstrcpynW   LoadLibraryExW    IsValidLocale   GetSystemDefaultUILanguage    GetStartupInfoA   GetProcAddress    GetModuleHandleW    GetModuleFileNameW    GetUserDefaultUILanguage    GetLocaleInfoW    GetLastError    GetCommandLineW   FreeLibrary   FindFirstFileW    FindClose   ExitProcess   WriteFile   UnhandledExceptionFilter    SetFilePointer    SetEndOfFile    RtlUnwind   ReadFile    RaiseException    GetStdHandle    GetFileSize   GetFileType   DeleteCriticalSection   LeaveCriticalSection    EnterCriticalSection    InitializeCriticalSection   CreateFileW   CloseHandle kernel32.dll    TlsSetValue   TlsGetValue   TlsFree   TlsAlloc    LocalFree   LocalAlloc  user32.dll    GetSystemMetrics    CharUpperBuffW  kernel32.dll    WriteProcessMemory    WaitForSingleObject   SuspendThread   SignalObjectAndWait   SetEvent    ResumeThread    ResetEvent    ReadProcessMemory   MultiByteToWideChar   LoadResource    LoadLibraryW    GetVersionExW   GetThreadLocale   GetProcAddress    GetModuleHandleW    GetModuleFileNameW    GetLocaleInfoW    GetLastError    GetFileAttributesW    GetDiskFreeSpaceW   GetCurrentThreadId    GetCurrentProcessId   GetCurrentProcess   GetCPInfo   InterlockedExchange   InterlockedCompareExchange    FreeLibrary   FindResourceW   FindFirstFileW    FindClose   EnumCalendarInfoW   CreateEventW    CloseHandle kernel32.dll    GetModuleHandleExW    Thread32Next    Thread32First   CreateToolhelp32Snapshot    OpenThread                                                                                                                                                    <�          (� 0� 8� ��  �  H� T�    rdpwrap.dll ServiceMain SvchostPushServiceGlobals                                                                                                                                                                                                                                                                                                                                                                                                                      8   0000L0d0|0�0�0�0�0�0�0�0 11$141<1R1X1{1�1�1�1�1�1�1	22-2E2]2t2�2�2�2�2�2�2�2�2�2�2�2�2�23
333"3*323:3B3J3R3Z3b3j3r3z3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�34
444N4V4^4J7`7q7�7�7�7�7�7�7�7*888e8m8r8�8�8�8�8�8�8�8@9F9L9W9�9f;u;|;<0<@<J<a<v<�<�<�<�<�<�<==2=J=�=�=�=�=>>*>3>:>@>U>a>~>�>�>�>O?g?�?�?�?    �   !0^0w0�0�0�0�1�1�12h2�2�2�2�23�3F4O4a4m4x466N7Y7h7�7�7�7�7�7�7�7�7�78K8k8l:�:;D;s;�;�;�;<T<b<�<�<�<�<�<�<\=j=�=�=�=>	>'>I>T>$?(?.?2?<?O?S?Y?]?m?r?�?�?�? 0  �   000#020?0R0n0�0�0�0�0�0�01u1�1�1�1�1�1�1�1�1�1�2�3�3�3�3�4�45g5y5�5�596�6)727:::�:;6;J;R;h;�;�;�;�;�;�;<<K<x<�<�<�<�<�<=i=�=>7>g?�?�?�?�?   @  �   0C0M0X0i0�0�0�01 1`1e1j1o1�1�1�1�12;2b2�2303<3y3�3�3�3�3�3�3�3�3�3�34"4(4<4B4P4W4a4�4�4�4�45%525�56}6�6W7:�:a<�=7>   P  $   j34,4<4X4�4:5C5n6w639m<#?   `  �   �1�1�1�1�1�1�1�1�1�1�1�1�1q2�23O3�3�3U4l4u4�4�4�4'5H5~566?6k6�6�617[7f7r7{7�7�7�7�7
88(828D8�8�8�:	;';E;c;};�;<<<h<R=�=L>�>�?   p  �  x0�0�0	11(1/1�1�1�1�1�1	222%23B3M3Z3b3j3r3�3�3�3�45'565X5g5�5�5�5�5?6N6z6�6�6�6C7X7n7�7�7�7�7�7�7�7�7�7�78
888B8l8�8�8�8�8�8�8�8�899 909A9M9[9e9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9 :::: :(:0:8:@:H:P:X:`:h:p:x:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�: ;;;; ;(;0;8;@;H;P;X;`;h;p;x;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;<"<*<2<:<B<J<R<Z<b<j<r<�<�<�<�<�<====&=.=6=>=F=N=V=^=�=�=�=�=�=�=�=�=�=�=�=�=	>>>$>1>9>F>>?�? �  �   R2�23Z3V5n5s55�5�5�5�56E66�6�6�6�6�6&7:7k7z7�7�7�78989+9;9W9f9�9�9�9�:�:�:�:�:�:,<D<Q<c<�<"=F=\=�=�=�=�=R>d>v>�>�>�>�>�>�>�>??�?�? �  X  "0a0f0s0|0�0�0#111L1U1p1�1�1�1�1�1�1�12+2F2O2c2q2�2�2�2�2�2	3+3:3J3R3g3o3�3�3�4�4�4�4	55.5B5Y5p5�5�5�5�5�5�5�677�7�788!8'8/848�8�8�8�8�8�8�8�8�8�8 999999$9(90949<9@9H9L9T9X9`9d9l9p9x9|9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9 ::::: :$:,:0:8:<:D:H:P:T:`:d:l:p:x:|:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�: ;;;;; ;$;,;0;8;<;D;H;P;T;\;`;h;l;t;x;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;<<<<< <(<,<4<8<G<S<^<w<�<�<�<�<�<�<�<�<�<�<�<�<�<===$=/=9=D=N=T=^=d=n=x=�=�=�=�=�=�=�=�=�=�=�=>>>,>1>>>C>P>U>b>g>t>y>�>�>�>�>�>�>�>�>�>�>�>�>�>�>?	???(?-?:???L?Q?^?c?p?{? �  �   �1�1�1�1222.262C2S2h2�2�2�2�2�2�2�2�2�23	3323N3�3�3�34O4�4�4�4>5O5�5�5�5�5.6{6�6�6P7�7�7�7�7�7q9�9�9�9?:X:�:;$;h;�;�;�;<T<]<�<�<�<=T=]=�=�=>e>�>�>?-?U?s?�?   �    0*0]0�011V1Z1^1b1f1j1n1r1v1z1~1�1�1�1�1�1�1(2/2j2n2r2v2z2~2�2�2�2�2�2�2�2�2�2�2�2;3�3�3�3�364>4F4N4t44�4�4�4*585�6$899$979<9T9�9�9:E:L:Q:e:�:�:�:�:�:�:�;<h<�<�<�<�<
>4>C>P>Z>g>q>~>�>�>�>�>�>�>�>�>�>�>�>???%?/?7?B?L?T?_?i?q?|?�?�?�?�?�?�?�?�? �  4  00#0/0J0�0�0�0�0�0�01	1141z11�1�1�1�1�12242�2�2�2�2�23 3%343V3�3�3:(:0:<:Z:f:n:u:|:�:�:�:�:�:�:;(;-;2;?;I;S;c;r;};�;�;�;�;�;�;�;�;�;<#<3<:<H<W<a<n<x<�<�<�<�<�<�<�<�<=>=C=W==�=�=�=�=�=�=�=�=�=�=�=�=>>>>%>*>I>N>S>e>q>|>�>�>�>�>�>�>�>�>�>�>�>�>�>�>??(?2???I?V?c?�?�?�?�?�?�?�?�?�?�?   �  `  0$0J0R0`0l0t0�0�0�0�0�0�0�0�011 1(1F1l1t1�1�1�1�1�1�1�1�1�1�1�12
2#2+292E2M2Z2e2n2w22�2�2�2�2�2�2@3N3�<�<�<�<�<!=,=<=I=P=�=�=�=�=�= >>>> >,>0>d>h>l>p>t>x>|>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�> ???????? ?$?(?,?0?4?8?<?@?D?H?L?P?T?X?\?`?d?h?l?p?t?x?|?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�? �      00000000 0$0(0,0004080@0D0H0P0T0X0\0`0d0h0l0p0t0x0|0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0 11111111 1$1(1,1014181<1@1D1H1L1P1T1X1\1`1d1h1l1p1t1x1|1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1 22222222 2$2(2,2024282<2@2D2H2L2P2T2X2\2`2d2h2l2p2t2x2|2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2 33333333 3$3(3,3034383<3@3D3H3L3P3T3X3\3`3d3h3l3p3t3x3|3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3�3 44444444 4$4(4,4044484<4@4D4H4L4P4T4X4\4`4d4h4l4p4t4x4|4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4�4 55555555 5$5(5,5054585<5@5D5H5L5P5T5X5\5`5d5h5l5p5t5x5|5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5�5 66666666 6$6(6,6064686<6@6D6H6L6P6T6X6\6`6d6h6l6p6t6x6|6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6�6 77777777 7$7(7,7074787<7@7D7H7L7P7T7X7\7`7d7h7l7p7t7x7|7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7�7 88888888 8$8(8,8084888<8@8D8H8L8P8T8X8\8`8d8h8l8p8t8x8|8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8 99999999 9$9(9,9094989<9@9D9H9L9P9T9X9\9`9d9h9l9p9t9x9|9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9�9 :::::::: :$:(:,:0:4:8:<:@:D:H:L:P:T:X:\:`:d:h:l:p:t:x:|:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�: ;;;;;;;; ;$;(;,;0;4;8;<;@;D;H;L;P;T;X;\;`;d;h;l;p;t;x;|;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�;�; <<<<<<<< <$<(<,<0<4<8<<<@<D<H<L<P<T<X<\<`<d<h<l<p<t<x<|<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�< ======== =$=(=,=0=4=8=<=@=D=H=L=P=T=X=\=`=d=h=l=p=t=x=|=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�=�= >>>>>>>> >$>(>,>0>4>8><>@>D>H>L>P>T>X>\>`>d>h>l>p>t>x>|>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�>�> ???????? ?$?(?,?0?4?8?<?@?D?H?L?P?T?X?\?`?d?h?l?p?t?x?|?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?   �  �   00000000 0$0(0,0004080<0@0D0H0L0P0T0X0\0`0d0h0l0p0t0x0|0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0�0 11111111 1$1(1,1014181<1@1D1H1L1P1T1X1\1`1d1h1l1p1t1x1|1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1�1 222222 2$2(2,2024282D2H2L2P2T2\2`2d2h2l2p2t2x2|2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2�2 33333333 3$3(3,3034383<3@3D3H3L3P3T3X3\3`3d3h3l3p3t3x3|3�3�3   L   00%0)0/03090D0J0N0Z0c0l0x0�0�0�0�0�0�0�0�0�0�0�0�011$1=1g1t1�1    �  004080<0@0D0H0L0P0T0t0�0�0�0�0141T187<7@7D7H7L7�7�7�7�7�7�7�7�7�7 8888 8(80888@8H8P8X8`8h8p8x8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8�8 9999 9(90989@9H9P9X9`9h9p9x9�9�9�9�9�9�9�9�9�9�9�9�9�9L:T:X:\:`:d:h:l:p:t:x:|:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�:�;�;�; <<<<< <$<(<,<0<4<8<<<@<D<H<L<P<T<X<\<`<d<h<l<p<t<x<|<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�<�< ======== =$=(=,=0=4=8=                                                                                                                                                                                                                                                                                                                                                                                                                                                        ܮ�E             �   X  �    ܮ�E       �  p  ��  �  ��  �  ��  �  �   �  �    ܮ�E          �  �    ܮ�E                  ܮ�E                 ܮ�E                  ܮ�E           0      ܮ�E           @      ܮ�E       	  P  `� �           8� �           �� �           �� �          � �          �� �           T u e s d a y 	 W e d n e s d a y  T h u r s d a y  F r i d a y  S a t u r d a y  I n v a l i d   f i l e   n a m e   -   % s   T h e   s p e c i f i e d   f i l e   w a s   n o t   f o u n d                    J u n e  J u l y  A u g u s t 	 S e p t e m b e r  O c t o b e r  N o v e m b e r  D e c e m b e r  S u n  M o n  T u e  W e d  T h u  F r i  S a t  S u n d a y  M o n d a y    F e b  M a r  A p r  M a y  J u n  J u l  A u g  S e p  O c t  N o v  D e c  J a n u a r y  F e b r u a r y  M a r c h  A p r i l  M a y    P r i v i l e g e d   i n s t r u c t i o n 1 F o r m a t   ' % s '   i n v a l i d   o r   i n c o m p a t i b l e   w i t h   a r g u m e n t  N o   a r g u m e n t   f o r   f o r m a t   ' % s ' " V a r i a n t   m e t h o d   c a l l s   n o t   s u p p o r t e d $ E r r o r   c r e a t i n g   v a r i a n t   o r   s a f e   a r r a y ) V a r i a n t   o r   s a f e   a r r a y   i n d e x   o u t   o f   b o u n d s  I n v a l i d   v a r i a n t   t y p e   c o n v e r s i o n  I n v a l i d   v a r i a n t   o p e r a t i o n  I n v a l i d   a r g u m e n t  E x t e r n a l   e x c e p t i o n   % x  A s s e r t i o n   f a i l e d  I n t e r f a c e   n o t   s u p p o r t e d  E x c e p t i o n   i n   s a f e c a l l   m e t h o d  O b j e c t   l o c k   n o t   o w n e d ( M o n i t o r   s u p p o r t   f u n c t i o n   n o t   i n i t i a l i z e d  J a n    T o o   m a n y   o p e n   f i l e s  F i l e   a c c e s s   d e n i e d  R e a d   b e y o n d   e n d   o f   f i l e 	 D i s k   f u l l  I n v a l i d   n u m e r i c   i n p u t  D i v i s i o n   b y   z e r o  R a n g e   c h e c k   e r r o r  I n t e g e r   o v e r f l o w   I n v a l i d   f l o a t i n g   p o i n t   o p e r a t i o n  F l o a t i n g   p o i n t   d i v i s i o n   b y   z e r o  F l o a t i n g   p o i n t   o v e r f l o w  F l o a t i n g   p o i n t   u n d e r f l o w  I n v a l i d   c l a s s   t y p e c a s t  A c c e s s   v i o l a t i o n  S t a c k   o v e r f l o w  C o n t r o l - C   h i t �4   V S _ V E R S I O N _ I N F O     ���                                         �    S t r i n g F i l e I n f o   �    0 4 0 9 0 0 0 0   :   C o m p a n y N a m e     S t a s ' M   C o r p .     l "  F i l e D e s c r i p t i o n     T e r m i n a l   S e r v i c e s   W r a p p e r   L i b r a r y   0   F i l e V e r s i o n     1 . 5 . 0 . 0   0   I n t e r n a l N a m e   R D P W r a p   `   L e g a l C o p y r i g h t   C o p y r i g h t   �   S t a s ' M   C o r p .   2 0 1 4   B   L e g a l T r a d e m a r k s     S t a s ' M   C o r p .     @   O r i g i n a l F i l e n a m e   r d p w r a p . d l l   B   P r o d u c t N a m e     R D P   H o s t   S u p p o r t     4   P r o d u c t V e r s i o n   1 . 5 . 0 . 0   @   C o m m e n t s   h t t p : / / s t a s c o r p . c o m   D     V a r F i l e I n f o     $    T r a n s l a t i o n     	                                                                                                                                                                                                                       � ,   ��
 R D P W 6 4                     MZ�       ��  �       @                                   �   � �	�!�L�!This program cannot be run in DOS mode.
$       N�rB/�!B/�!B/�!~!j/�!~!&/�!~3!H/�!��'!G/�!B/�!/�!O}	!F/�!O}0!C/�!O}7!C/�!O}2!C/�!RichB/�!                PE  d� Z��T        � "     �      Q        �                                  `                                   0� l   �� <      �   � �                                              `� p              �                          .text   �                        `.rdata  <�      �                @  @.data   =   �     �             @  �.pdata  �   �     �             @  @.rsrc             �             @  @.reloc          �             @  B                                                                                                                                                                                                                                                                                        �   �����������H�\$H�t$WH�� H���   3�D���E��t$H�W���    �<u	�|
u��H��I��u�O�   H��H������H@�H���o3  H�G�9v?�H�W�À<uD�CA�@��<
uH�G����D����;r԰H�\$0H�t$8H�� _�H�\$0@��H�t$8H�� _���������������E3�A��E���    A�< t<	u��I����I�����~OI���H��D8u�H��t6L��@ fff�     C�M�RA��A�B�I��H���<
 u�Ic�H;�r�Ic�� I��f�H���<
 u���Hc�L�A� < t<	u��I����Hc��     I��B�<
 u�I��I;�s�D 3��������H�\$H�l$VWAVH�� 3�H��2�A��M����E���=  I�� �<"t<'u����<=u��t��H��A;�r��  3�A��   H��L�|$@�d}  H���   3�A��   �P}  D��I��H���"�  �G+��D�EH���   I���  ��L�� A�< t<	u��I����H�����~?H�H��@84u�H��t&L��C�M�I��A�A�H��H���< u�Hc�H;�r�Hc�� H��f�H���< u���Hc�L�A� < t<	u��I����Hc��     H�< u�H��H;�s�D H���   �����L�|$@H�\$HH�l$P�H�� A^_^�����L��SUVWAVH��@  H��� H3�H��$0  �iM�cM�kA���E3�3�M�{ H��D�d$ ����   D�\$03�;���   H�FD�L�4�    E�A��E;�s0L�NA�R ��B�<uB�<

tA�@�;�t����A;�r����A+ځ�   v3��1H�L$03�A�   �{  H�FH�L$0B�0D��HV�Q�  D�\$0A��[u�C��|0]uA����;��N���H������E���   I��H@�H���/  N��    3�H��L���{  3�9n��   D�|$03�;nwyH�FD��<���A;�s.L�N�W��B�<u	B�<

��tA�@�;�t����A;�r����+߁�   v3��,H�L$03�A�   �z  H��H�L$0HVD���p�  D�|$0A��;tQA��[u�C��|0]uA���<E2�3҅�t3H�L$0��<"t<'uE��A��<=uE��t��H��;�r��C��A����;n����E���  H������D�nI��H@�H���j.  N��    3�H��H�F��y  L��$x  E��L��$�  tf3�I��fD  H�N����   ���  H��H@�H���.  H�N3�H��  �H�NH��  Li��  �y  H�H��  I��u�I���y.  L��$�  A���3�E��9n�Q   3�;nwwH�FD�����A;�s-L�N�S���B�<	uB�<

tA�H�;�t����A;�r����+���   v3��+H�L$03�A�   ��x  H��H�L$0HVD��跚  D�T$ �D$0<;��   <[uK�G��|0]uAH�NA��3�A��A��   E3�D�T$ Hi�  H��x  H�FD�G�H�H�T$1�X�  �dE2�3҅�t[H�L$0�<"t<'uE��A��<=uE��t��H��;�r��0H�NA��D��Li�  A��Hi��  I�  L�D$0�E���A��D�T$ ��;n������H��$0  H3�� ,  H��@  A^_^][���H�\$H�l$H�t$H�|$ AVH�� �q3�H�څ�t[L�qfD  ��Li�  M�H���H��A�< u�H���f�H���< u�H;�uI���I��B�< u�H��I���i�  ��t#��;�r�3�H�\$0H�l$8H�t$@H�|$HH�� A^Ë�Hi�  I�������H�\$ WH�� I��I���;���H��u�>  �� 2�H�\$HH�� _�H�l$0���   H�t$83�L�t$@��tdL��  @ �     ��Li��  M�H���H��A�< u�H���f�H���< u�H;�uI���I��B�< u�H��I��艗  ��t-��;�r��j  � 2�H�t$8H�l$0L�t$@H�\$HH�� _Ë�Hi��  I�t�3�A��  H���:v  �   D  H���   H���   G�K�O�C�G�K�O�C�G�K�O�C�G�K�O�H��u�KOC G K0O0C@G@KPOPC`G`H�CpH�Gp�Cx�Gx�C|f�G|����������������H�\$UVWH��0  H�� H3�H��$   H��I��H��H�L$ 3�A��   I���Au  H��$  3�A��   �,u  L�L$ L��H��H���������tf3�A�  H���u  H�D$ I���I��B�<  u�H�T$ H���Ŗ  3�H��$  D�B
��,  3�H��$  D�BH���   ��,  H��  �H��$   H3��(  H��$`  H��0  _^]�������������H�\$WH��0  H�� H3�H��$   I��H�L$ 3�A��   I���It  H��$  3�A��   �4t  H�� L�L$ H�yh L�����������  H��$@  H���H��$  H��H�À< u���t2���  �    A��  H��;�G�3���s  H�D$ fD  H�ƀ<0 u�H�T$ L��H��臕  E3�L��$  A��L����f�A���E  A���σ��  H�A����  I���H��H�耄8   ��   H��H�耄8    ��   H��H�耄8   0��   H��H�耄8   @�   H��H�耄8   P�   H��H�耄8   `�   H��H�耄8   p�~H��H�耄8   ��nH��H�耄8   ��^H��H�耄8   ��NH��H�耄8   ��>H��H�耄8   ��.H��H�耄8   ��H��H�耄8   ��H��H�耄8   �A�@��  ��σ��  H�A����  I���H��H����8   ��   H��H�耄8   ��   H��H�耄8   ��   H��H�耄8   �   H��H�耄8   �   H��H�耄8   �   H��H�耄8   �~H��H�耄8   �nH��H�耄8   	�^H��H�耄8   
�NH��H�耄8   �>H��H�耄8   �.H��H�耄8   �H��H�耄8   �H��H�耄8   A��H��I��D;�����������   H��$@  H��$   H3��%  H��$H  H��0  _�  ,  ?  R  e  x  �  �  �                �  �  �  �  �    @  R  e  x  �  �  �  �  �  ?  ?  ?  ?  ?  ?  ?  �  �      !  1  ������������H�\$WH��0  H��� H3�H��$   H�=
� I��H�L$!3�A��   �D$  � p  H��$  3�A��   ��o  H��$!  3�A��   Ƅ$    ��o  H��$!  3�A��   Ƅ$    �o  H�z] H��$   A��   �o-  H��$   A��   H���Y-  L�L$ L��$   H��$   H���4���H��$   H3��d#  H��$@  H��0  _����H�\$H�t$WH��0  H��� H3�H��$   H�=� I��H��$!  3�A��   I��Ƅ$    ��n  H��$!  3�A��   Ƅ$    ��n  H��\ H��$   A��   �,  H��$   A��   H���},  H�L$ 3�A��   �n  H��$  3�A��   �~n  L�L$ L��$   H��$   H���1�����tj3�A�  H���Mn  H�D$ I���@ I��B�<  u�H�T$ H���	�  3�H��$  D�B
�"&  3�H��$  D�BH���   �&  H��  �H��$   H3���!  L��$0  I�[I�sI��_���������������H�\$WH��PH�/� H3�H�D$HE3�H��H�D$0    H��� E�A�   @�D$(�   �D$    ���  H��H���tFA�   E3�3�H�����  I����I��B�< u�L�L$@H��H��H�D$     ���  H�����  H�L$HH3��&!  H�\$hH��P_������������H��8H�u� H3�H�D$(L�D$ H������   H�D$     ���  H�D$ H�L$(H3���   H��8�������H�\$H�t$ WH��`  H�� H3�H��$P  H���   H����   H�]Z L��H��H���f�  H������H���b!  H�L$A3�A��   �D$@ �?l  3�L��H��$?  H��$G  �������tTL�L$@L���������$?  3҄��   D��>�^   H��Y H��D��H�����  H������H����   3��   ���  H��� L�ɷ H��H�D$0A�   H�D$ ���  H��H����� ����u4�   ��  D�D$0H��Y H��H���l�  H������H���h   �H��Y �����p�  H�9� L�:� H��H�D$0A�   H�D$ �A�  ��H��$P  H3��  L��$`  I�[ I�s(I��_�����������H�\$H�t$ WH��P  H�W� H3�H��$@  H���   H���   H��X L��H��H�����  H�������H���  H�L$13�A��   �D$0 �j  3�L��H��$/  H��$7  �%�����tQL�L$0L��������$/  3҄��   D��>�  H�3X H��D��H���$�  H���\���H���   3��TH��H����� ����u4�   �X  D�D$ H� X H��H�����  H������H����  �H��W �������H��$@  H3��  L��$P  I�[ I�s(I��_��������H�\$H�t$H�|$UATAUAVAWH��$����H��P  H�� H3�H��@  3�H��W ����D��D��D��H�D$8H�D$0D���p����   �  3�A�   H��H���i  �� �ٴ D�ʹ D�Ǵ �L$(�T$ H�NW H�����  H�ƴ H�������H���n  H��� L�L$@L�2W H���*���3�L�L$@��L�*W H��EMG��H�z� H=[� �����3Ʉ�L�L$@L�W EMGH�Ӌ�H�N� H5/� �����3Ʉ�L�L$@L��V EMGH��D��H�!� L5� ����3Ʉ�L�L$@L��V EMGH��D��H��� L=ճ �x���3Ʉ�L�L$@L��V EMGH��D��H�ǳ L-�� �K���3Ʉ�L�L$@L��V EMGH�Ӌ�H��� H|� H�D$8����3Ʉ�L�L$@L��V EMGH�Ӌ�H�j� HK� H�D$0�����3Ʉ�EMGD��L%/� H���[  H����   H�L$@3�A��   �4g  H�M?3�A��   �#g  H�� L�L$@L�@V H�EV �������t 3�H�M?D�B
��  3�H�M?D�B��  ��   �   ��3  D�H�V H��L��H�����  H�������H���  H����   H�L$@3�A��   �f  H�M?3�A��   �zf  H�c� L�L$@L��U H��U �+�����t 3�H�M?D�B
�T  3�H�M?D�B�E  ��   �   ��  D�H��U H��L��H����  H���E���H���	  M����   H�L$@3�A��   ��e  H�M?3�A��   ��e  H��� L�L$@L�fU H��T ������t 3�H�M?D�B
�  3�H�M?D�B�  ��   �   A���  E�H�*U H��M��H���c�  H������H���_  M����   H�L$@3�A��   �8e  H�M?3�A��   �'e  H�� L�L$@L��T H�IT �������t 3�H�M?D�B
�  3�H�M?D�B��  ��   �   A��6  E�H��T H��M��H�����  H�������H���  M����   H�L$@3�A��   �d  H�M?3�A��   �}d  H�f� L�L$@L��T H��S �.�����t 3�H�M?D�B
�W  3�H�M?D�B�H  ��   �   A�E �  E�M H�TT H��M��H����  H���E���H���	  H�|$8H����   H�L$@3�A��   ��c  H�M?3�A��   ��c  H��� L�L$@L�T H��R �}�����t 3�H�M?D�B
�  3�H�M?D�B�  �3��   ���  D�H��S H��L��H���b�  H������H���^  H�|$0H����   H�L$@3�A��   �2c  H�M?3�A��   �!c  H�
� L�L$@L��S H�CR �������t 3�H�M?D�B
��  3�H�M?D�B��  �3��   ��4  D�H�~S H��L��H�����  H�������H���  M����   H�L$@3�A��   �b  H�M?3�A��   �{b  H�d� L�L$@L�HS H��Q �,�����t 3�H�M?D�B
�U  3�H�M?D�B�F  ��   �   A�$�  E�$H�
S H��M��H����  H���C���H���  H�S �/���3�H��@  H3���  L��$P  I�[0I�s8I�{@I��A_A^A]A\]��������������H��UATAUAVAWH��8���H��  H�D$H����H�XH�pH�xH��� H3�H���  �!� E3�fD���  3�A��  H���  �Ja  H�{R �~���L�t$PL�D$PH�-���A�N���  A��   H���  H�L$P�;�  H���  H���H��H��fD94Pu���t`��H���  H�Af�f�9\t
H����u��A�BH���  H�C��   +�D� 3�H���`  �Q �R �C��Q f�C�   ��  H��L���  H��Q H���k�  H������H���g  �$   �  H��H�D$@H����   3�H�H�CH�CH�C�C D�t$PL�t$0�D$(�   �D$    E3ɺ   �D�@H���  �y�  H��H���tO3�H���m�  ����t=���;  H�CL�t$ L�L$PD�H��H���J�  ��tH���>���H���V����I��H��� H��uaL�t$0�D$(�   �D$    E3ɺ   @D�CH��� ���  H��H����l  A�   E3�3�H�����  A�%   H��P �*  3�A��   H�M��#_  3�A��   H���   �_  L�M�L��P H��P H�����������   3�A��  H���  ��^  H�E�L��f�I��B�<  u�H�U�H���  薀  H���   L��I��B�<  u�H���   H���  �o�  3�A�   H���	  �{^  A��   H���  H���	  �  I��H�5�� �     ���	  f�1H�If��u��   L�t$PL�D$PH�%����   ���  A��   H�5=� H��H�L$P�/�  H��H��f�<V u���tP��H�Ff�9\t
H����u��:�BH�F��   +�D� 3�H���]  }O ��O �C�~O f�CL�t$0�D$(�   �D$    E3ɺ   @E�AH�����  H��H���t=A�   E3�3�H�����  L�t$ L�L$PA�   H� O H�����  H�����  H�'O �Y�  H�� H��u]L�t$0�D$(�   �D$    E3ɺ   @D�@H���k�  H��H�����  A�   E3�3�H���j�  A�1   H��N �  H�O H�����  H�i� H��N H�{� ���  H�F� �   ��  H��H�2� L�S� I+�L�)� M+�H�L$ H��N H���I�  H������H���E  H�2N �,�  H��H����  �   D�BH����  H����  H��H���	�  H����  �P0��� �H6f��� �@4f��� ��D��fA����� fD��V  �   �  H���v� �m� D�a� D�[� �L$(�T$ H��N H���q�  H������H���m  L�t$0�D$(�   �D$    E3ɺ   @E�AH�����  H��H���t=A�   E3�3�H�����  L�t$ L�L$PA�   H�+N H�����  H�����  ���  D�����  D��3ҍJ���  L��H���tm�D$X   H�T$XH�����  D  D�D$`E;�t-D9l$du&3ҍJ�t�  H��H���tH���r�  H���)�  H�T$XI���c�  ��u�I����  3�A��   H�M��MZ  3�A��   H���   �9Z  L�M�L�nM H��K H�� �������t3�D�B
H���   �}  �������   H�@���fD;���   ����   H�/M �	�  H��� H�+M H�����  H��� H���t}H�.M �����f��� H�H��� f��� P����  H��H�E�H�D$ A�   L�y� H�Z� ���  �~�  H��H�E�H�D$ A�   L�=� H�.� �P�  3�A��   H���  �Y  3�A��   H���  �Y  L���  L��L H��J H�ܤ ������t3�D�B
H���  �I  �������  fD;���   ����   H�L ���  H�}� H��K H�����  H�~� H�����   H��K ����f�g� H�H�b� f�a� P��y�  H��H�E�H�D$ A�   L�H� H�)� �s�  �M�  H��H�E�H�D$ A�   L�� H��� ��  �6�  fD;�u+H�CK ��  H��� H�?K H����  H��� �   �!  L��3�A�   H���W  �y� �p� D�d� D�^� �L$(�T$ H�EK I���t�  I��H�Z� H������H����  H�:� H����  HcA<H�� �| ��  3�A��   H���  �W  3�A��   H���  �W  L���  L��J I��H����������W  3�D�B
H���  �P  �������8  H��J �����L���  L��J I��H��� �"���3Ʉ�E��  D��L=e� 3�A��   H���  �yV  3�A��   H���  �eV  L���  L��J I��H�=� ��������   3�A��  H�M��/V  H���  L��D  I��B�<  u�H���  H�M���w  H���  L��I��B�<  u�H���  H���   �w  L���  L���   �L�����t5L;=�� v,���  ���  H��H�E�H�D$ D��L���  I�����  3�A��   H���	  �U  3�A��   H���
  �kU  L���	  L��I I��H�C� �������S  3�D�B
H���
  �  �������4  H��I �[���L���  L��I I��H�� �~���3Ʉ�E��  D��L=�� 3�A��   H���  ��T  3�A��   H���  ��T  L���  L��I I��H��� �t�������   3�A��  H�M��T  H���  L�ǐI��B�<  u�H���  H�M��Fv  H���  L��I��B�<  u�H���  H���   �v  L���  L���   ������t5L;=�� v,���  �:�  H��H�E�H�D$ D��L���  I����  3�A��   H���  ��S  3�A��   H���  ��S  L���  L��H I��H��� �~������S  3�D�B
H���  �  �������4  H��H ����L���  L��H I��H�S� �����3Ʉ�E��  D��L=!� 3�A��   H���  �5S  3�A��   H���  �!S  L���  L�[H I��H��� ���������   3�A��  H�M���R  H���  L�ǐI��B�<  u�H���  H�M��t  H���  L��I��B�<  u�H���  H���   �t  L���  L���   ������t5L;=Y� v,���  ���  H��H�E�H�D$ D��L���  I���s�  3�A��   H���	  �?R  3�A��   H���
  �+R  L���	  L�}G I��H�� ���������  3�D�B
H���
  �l  ��������  H�XG �����   �5  H��L���  L�hG I��H��� �1���3Ʉ�E��  D��L=t� f�D$xH�L�%����L�d$zf�E�P�3�A�   H���sQ  3�A��   H�M��bQ  3�A��   H���   �NQ  L�M�L�G I��H�)� ������tj3�A��  H���  �Q  H�E�L��D  I��B�<  u�H�U�H���  ��r  H���   L��I��B�<  u�H���   H���  �r  L���  �L�F �   H���  H�kF H���O  H�L$z��IE�H�L$zH���  L;=\� v&���  H��H�E�H�D$ A�   L�D$xI���|�  3�A��   H���  �HP  3�A��   H���  �4P  L���  L�F I��H�� ���������  3�D�B
H���  �u
  ��������  H��E �$����   �>  H��L���  L��E I��H��� �:���3Ʉ�E��  D��L=}� f�D$xH�L�%���L�d$zf�E�P�3�A�   H���|O  3�A��   H�M��kO  3�A��   H���   �WO  L�M�L��E I��H�2� ������td3�A��  H���	  �%O  H�E�L��I��B�<  u�H�U�H���	  ��p  H���   H�ǀ<8 u�L��H���   H���
  �p  L���
  �L��D �   H���  H��D H����M  H�L$z��IE�H�L$zH���  L;=k� v&���  H��H�E�H�D$ A�   L�D$xI�����  I���o  H�D$0    �D$(�   �D$    E3ɺ   @E�AH�����  H��H���tAA�   E3�3�H�����  H�D$     L�L$PA�   H�UD H�����  H�����  ���  �����  D��3ҍJ���  H��H�����   �D$X   H�T$XH�����  D�D$`D;�t-D9t$du&3ҍJ�p�  H��H���tH���f�  H���%�  H�T$XH���_�  ��u�H���jL�t$0�D$(�   �D$    E3ɺ   @E�AH�����  H��H���t=A�   E3�3�H�����  A�3   H��? L�t$ L�L$PH�����  H�����  H���  H3���   L��$�  I�[0I�s8I�{@I��A_A^A]A\]���������������H�\$WH�� ��H�C H��������=F�  u�����H�H� H��tH�Ӌ���H��B H�\$0H�� _������������������@SH�� H��H��B �{����=�  u�}���H�� H��tH����H��B H�� [�K��������������������ff�     H;il uH��f����u��H���  �@SH�� H����  H�S�  H�H��H�� [����H�=�  H���  �@SH��@H���H����  ��tH���  H��t�H��@[�H��  H�T$XH�L$ A�   H�D$X�U  H���  H�S H�L$ H�D$ ��  ����H�\$WH�� H���  ��H��H��^  ��tH���   H��H�\$0H�� _������  ���@SH�� H���A H����   �A$  H�CH���   H�H���   H�KH;�t t���   �+v u�  H�H��q H9CtH�C���   �v u	��  H�CH�K���   �u�����   �C��H��H�� [�H��H�XH�hH�p WATAUAVAWH��@L��H��H�H�E��M���'���M��tM�'M��tE��t A�F���"v�7  �    �`  3��  A�4$L�D$ 3�I�\$A���   ~L�D$ @�κ   ��   L�D$ �I��  @���H����t@�3H��뾋�$�   @��-u���@��+u@�3H��E��u$@��0tA�
   �2�,X��tA�   �"A�   A��u@��0u�,X��u@�sH��M��  Mc�3�H���I��L��L��@��E�DM A�ȃ�t	@�փ�0�A��  t/�F�@��<w�� ���A;�s��I;�r%u��I;�v��M��u H��@��uM��IE�3��pI��H�ϋ�H�@�3H���H��������@��u%@��uF�Ń�tH�       �H;�w	��u,H;�v'�  � "   @��tH����@��$��H�H��H�M��tI�@��tH�߀|$8 tH�L$0���   �L�\$@H��I�[0I�k@I�sHI��A_A^A]A\_����H��83�E��L��9�� �D$ H��u	H�Js �3�����H��8�H�\$H�l$VWATAVAWH��@L��H��H�L$ E��M������M��tM�'M��tE��tA�F���"v�  �    ��  �   A�4$L�D$ 3�I�\$A���   ~L�D$ @�κ   �_  L�D$ �I��  @���H����t@�3H��뾋�$�   @��-u���@��+u@�3H��E��tA�F���"vM��tM�'3��%  E��u&@��0tA�
   �4�,X��tA�   �$A�   �A��u@��0u�,X��u@�sH��M��  3҃��A��D��@��E�JA�ȃ�t	@�΃�0�A��  t,�F�@��<w�� ���A;�s��A;�r"u;�v��M��uH��@��uM��IE�3��YA���@�3H��돾���@��u@��u:�Ń�t��   �w��u';�v#�(  � "   @��t����@��$������M��tI�@��t�߀|$8 tH�L$0���   �L�\$@��I�[0I�k@I��A_A^A\_^�H��83�E��L��9"� �D$ H��u	H��p �3�����H��8�H�\$ UVWATAUAVAWH��H��   H��e H3�H�E�E3�I��L��L��A��D�e�H��tM��u3��  H��u�F  �    �o  H����  H�M�I�������M����  L�m�M9�8  uGH���[  ��   fA9w%A�A�A�I��f���8  H��H;�r��+  ��  H����  A���   uzH��t,I��H��fD9 t	H��H��u�H��tfD9 uH��I+�H��H��A�MH�E�D��H�D$8L�d$0M��3҉t$(L�|$ ���  Hc؅�t�D9e�u�E8d���  H���  A�MH�E�H���H�D$8L�d$0D��M��3҉t$(L�|$ �<�  Hc���tD9e��P  H�_��R  D9e��=  �
�  ��z�.  H���3  A�MH�E�A�   H�D$8A���   L�d$0�D$(H�E�M��3�H�D$ ���  ����   D9e���   ����   Hc�H����   H�:H;���   I��H��~�D�A�?����   H��H��H;�|�I��H;���   �`���H�E�L9�8  u9A�I��f��tz��   f;�wI��H��A�f��u��^�  H���� *   �MH�M�H���M��H�L$8�HL�d$0D��3�D�d$(L�d$ ���  Hc���tD9e�uH����  � *   H��D8e�tH�M؃��   �H��H�M�H3��U���H��$�   H�Ā   A_A^A]A\_^]���E3������@SH�� H��tH��tM��uD��G  �   ��o  ��H�� [�L��M+�A� C�I����tH��u�H��u��  �"   ��3������H��H�XH�hH�pH�x ATAVAWH��PE3�I��L��H��A��H��tM��u3��  fD�!H��u�  �    ��
  H����^  H�L$0I���d���H�D$0H����   L9�8  u,H���  B�3f�F8$3�	  H��H��H;�r���   �HH���M�ƍS
D�ˉl$(H�|$ �^�  Hcȅ���   �=�  ��zu_D��I����t)A��D8&t!�H�T$0�5  ��tH��D8&t4H��E����H�D$0A+�M�ƋH�   D�Ήl$(H�|$ ���  Hcȅ�u�
  � *   fD�'�SH���NL9�8  uI���r  H���8�HH���M�ƍS
D��D�d$(L�d$ ���  Hcȅ�u�e
  � *   �H�Y�D8d$HtH�L$@���   �H��L�\$PI�[ I�k(I�s0I�{8I��A_A^A\Ã=�~  u	L�Hk �E3��
�����L�D$SH�� I�؃�u}�m&  ��u3��7  �y  ��u�t&  ���=7  ���  H�� �.  H�\x �[&  ��y��  ����)  ��x�,  ��x3���"  ��u�!x ��   �S)  �ʅ�uR�x ���z����ȉ�w 9~ u�"  �!  H��u�)  �V  ��%  �H��u�= f �tv�=  �o��u^�f �0  H��uZ�x  �H��4  H��H������H�Ћ�e ��/  H�˅�t3��  �O�  �H�K���U  �������u3��  �   H�� [��H�\$H�t$WH�� I����H���u��,  L�ǋ�H��H�\$0H�t$8H�� _�   ���H��H�X L�@�PH�HVWAVH��PI����L��   �P���u9�v u3���   �C���w8H���  H��t
���ЋЉD$ ��tL�Ƌ�I��������ЉD$ ��u3��   L�Ƌ�I���������D$ ��u4��u0L��3�I�������L��3�I������H�"�  H��t
L��3�I���Ѕ�t��u7L�Ƌ�I���������#ϋ��L$ tH���  H��tL�Ƌ�I���Ћ��D$ ���3�H��$�   H��PA^_^�@SH�� H���u�  �   �Z{ ��6  H����2  �=F{  u
�   ��6  �	 �H�� [�2  ���H�L$H��8�   �ݨ  ��t�   �)H�3v �-  H�D$8H�w H�D$8H��H��v H�w H�tu H�D$@H�xv �Nu 	 ��Hu    �Ru    �   Hk� H�Ju H�   �   Hk� H��\ H�L �   Hk�H��\ H�L H���  �����H��8����H�\$H�t$WH�� H��H���w|�   H��HE�H��z H��u �5  �   �%6  ��   �  H��z L��3���  H��H��u,9� tH����  ��t��  �    �  �    H����  �  �    3�H�\$0H�t$8H�� _���@SH�� H�a H���  �A H�H�H����   H��H�� [����H���  H�H��A H�AH������@SH�� H�a H���  H��H��A �   H��H�� [���H���  H���   �H�\$WH�� H��H��H;�t!��   � tH�WH���T   �H�GH�CH��H�\$0H�� _�H�\$WH�� H�'�  ��H��H��z   ��tH���A���H��H�\$0H�� _����H��tTH�\$H�t$WH�� H��H��H���"  H��H�H����H�FH��tH�WL��H�������FH�\$0H�t$8H�� _���@SH�� �y H��t	H�I�  H�c �C H�� [��H�y H�|�  HEA���@SH�� H��H��w ��  H��tH���Ѕ�t�   �3�H�� [��H��w �H�\$H�|$UH��H��`(7�  (@�  H��H��)E�(?�  )M�(D�  )E�)M�H��t�tH�	H��H�H�X0�P@H�UH��H�}�H�]����  H��H�EH�E�H��t�� @�t�M���E�H��D��E�D�E؋UċM�L�M��M�  L�\$`I�[I�{ I��]����H��(H��H�QH�H�7  ����H��(���H�\$WH�� H���  ��H��H���7  ��tH���I���H��H�\$0H�� _����H��t7SH�� L��H�(w 3����  ��u�K  H���^�  ���[  �H�� [����H��H�XH�pH�x UH��H���H��  H�GX H3�H���  A����ك��t�1  �d$0 H�L$43�A��   �7  H�D$0H�M�H�D$ H�E�H�D$(�'  H���  H���   H���  �t$0H���|$4H�EhH���  H�D$@���  H�L$ ���F-  ��u��u���t���&1  H���  H3��#���L��$�  I�[I�s I�{(I��]���H�qu �H�\$H�l$H�t$WH��0H��H�Ru A��I��H���c�  D��L��H��H��H��tH�\$@H�l$HH�t$PH��0_H��H�D$`H�D$ �$   ����H��8H�d$  E3�E3�3�3�����H��8���H��(�   蒢  ��t�   �)A�   � �A�H�O���� �H��(�,  �H��(�  H��u	H�X �H��H��(�H�\$WH�� ���  H��u	H��W �H���8�v  H��W H��tH�X���/   �H�\$0H�� _���H��(�G  H��u	H��W �H��H��(�L�%V 3�M��D�JA;t/��M�Hc�H��-r�A��w�   Á�D����   ��AF��Hc�A�D�������H���   H��t�� H���   H��t�� H���   H��t�� H���   H��t�� H�A(A�   H�<\ H9P�tH�H��t��H�x� tH�P�H��t��H�� I��u�H��   ���\  �H�\$H�l$H�t$WH�� H���   H��H��tyH��b H;�tmH���   H��ta�8 u\H���   H��t�9 u�>���H���   �6  H���   H��t�9 u����H���   �x7  H���   ����H���   �����H���   H��tG�8 uBH��   H���   �����H��  ��   H+������H��  H+�����H���   ����H��   H�[ H;�t��\   u�X7  H��   �x���H��(  H�{(�   H��Z H9G�tH�H��t�9 u�I���H��A���H�� tH�O�H��t
�9 u�'���H��H�� H��u�H��H�\$0H�l$8H�t$@H�� _�������H����   A����D	H���   H��t�DH���   H��t�DH���   H��t�DH���   H��t�DH�A(A�   H�Z H9P�tH�H��t�D
H�x� tH�P�H��t�D
H�� I��u�H��   �D�\  H���@SH�� ��  H�؋�] ���   tH���    t��  H���   �+�   �6/  �H���   H�G\ �&   H�ع   �1  H��u�K �d  H��H�� [����H�\$WH�� H��H��tCH��t>H�H;�t1H�H������H��t!H�������; uH��[ H;�tH�������H���3�H�\$0H�� _���H��(�=%�  u�������  ��    3�H��(�@SH��@��H�L$ 3������%p  ���u��o    � �  ����u��o    ��  ������uH�D$ ��o    �X�|$8 tH�L$0���   ���H��@[����H�\$H�l$H�t$WH�� H�YH��  H��D��3���0  3�H�~H�FH��   �   ��f�H�=�T H+���H��H��u�H��  �   �9�H��H��u�H�\$0H�l$8H�t$@H�� _���H�\$H�|$UH��$����H��  H��P H3�H��p  H���IH�T$P��  �   ���5  3�H�L$p���H��;�r��D$V�D$p H�T$V�"D�B���;�s���Dp ��A;�v�H�����uڋG�d$0 L�D$p�D$(H��p  D�˺   3�H�D$ �S<  �d$@ �GH��   �D$8H�Ep�\$0H�D$(L�L$pD��3ɉ\$ �:  �d$@ �GH��   �D$8H��p  �\$0H�D$(L�L$pA�   3ɉ\$ ��9  L�EpL��p  L+�H��p  H�OL+��t
�	A�D���t�	 A�D	爁   �Ɓ    H��H��H��u��?3�H�OD�B�A�@ ��w�	�B �A��w�	 �B���   �Ɓ    ��H��;�r�H��p  H3�����L��$�  I�[I�{ I��]����H�\$WH�� ��  H����Y ���   tH���    t	H���   �l�   �?+  �H���   H�\$0H;kU tBH��t��uH�8R H�L$0H;�t�����H�BU H���   H�4U H�D$0�� H�\$0�   ��,  H��u�K �,  H��H�\$8H�� _���H��H�XH�pH�xL�p AWH��0��A����  H������H���   ������D��;C��  �(  �0$  H��3�H����  H���   H�ˍWD�B| HI@ A H0I0@@A@HPIP@`A`I�HpI�I�H��u� HIH�@ H�A �;H��A���i  D�����  H���   L�5�P ��	uH���   I;�t����H���   �����   �  �0X ��   �   ���)  ��C�k �C�k H��   H�k ��L�����T$ ��}Hc��DKfA��H� ����׉T$ ��  }HcʊDB���� ����|$ ��   }Hcϊ�  B���� ����H�4S �������uH�"S I;�t����H�S �����*  �+���u&L�5�O I;�tH������������    �3�D��A��H�\$@H�t$HH�|$PL�t$XH��0A_�H�\$H�l$ VWATAVAWH��@H��K H3�H�D$8H�������3�����uH���O����D  L�%�Q ��A�   I��98�8  A�H��0��r썇��A;��  ���̼  ���  H�T$ ���ϼ  ����   H�K3�A�  ��*  �{H��   D9|$ ��   H�T$&@8t$&t9@8rt3�zD�D;�wA�HH�CH�A+�A�?�I�I+�u�H��@82u�H�C��   �I�I+�u��K��  t.��t ��t��tH���"H���  �H���  �H���  �H���  H��   D�{��sH�{�ƹ   f���   95�h ����������   H�K3�A�  ��)  ��M�L$L�@L�5P �   I��M�I��A81t@@8rt:D��BD;�w$E�PA��  sA�E�AD�BE�D;�v�H��@82u�I��M�I+�u��{D�{��  t)��t��t��u"H�5��  �H�5��  �H�5��  �H�5��  L+�H��   H�KK�<#�   �D�f�H�II+�u�H������3�H�L$8H3�����L�\$@I�[@I�kHI��A_A^A\_^���H�t$UWAVH��H��`Hc�D��H�M�I��������G=   wH�E�H��  �y�y��H�U���@���	  �   ��t@�u8@�}9�E: D�J�@�}8�E9 D��H�E��T$0L�E8�HH�E �L$(H�M�H�D$ ��4  ��u8E�tH�E����   �3���E A#ƀ}� tH�M����   �H��$�   H��`A^_]��H���)  H�\$WH�� H��H�I8H��t����H�KHH��t����H�KXH��t����H�KhH��t����H�KpH��t�x���H�KxH��t�j���H���   H��t�Y���H���   H�w�  H;�t�A����   ���Q$  �H���   H�L$0H��t��	uH�SK H�L$0H;�t��������&  �   �$  �H���   H��t+H�������H;=Q tH�Q H;�t�? u	H���+�����   ��%  H������H�\$8H�� _��@SH�� H�ً�M ���t"H��u��  ��M H��3���  H������H�� [�@SH�� �   H��H��u�H��	  H��H�� [�H�\$WH�� ���  ��M ���  H��H��uG�H�x  �j  H��H��t2�dM H���|  H�˅�t3��.   �ж  H�K��������3ۋ����  H��H�\$0H�� _���H�\$WH�� H��H��H�Ѿ  H���   �a �A   ǁ�      �C   f��d  f��j  H��I H���   H��p   �   �r"  �H���   �� �   �M$  �   �S"  �H���   H��uH�_O H���   H���   �������   �$  H�\$0H�� _���@SH�� �A	  �#  ��t^H�	����  �6L ���tG�x  �   �  H��H��t0�L H���,  ��t3�H����������  H�K���   ��	   3�H�� [��H��(��K ���t�  ��K �H��(�!  @SVWH��   H��D H3�H�D$xH��H��H�L$HI��I���d���H�D$HH�T$@H�D$8�d$0 �d$( �d$  H�L$hE3�L���<  ��H��tH�L$@H�H�L$hH����6  �ȸ   ��u��t��u���t�   ���u3��|$` tH�L$X���   �H�L$xH3������H�Ā   _^[��H�\$WH��   H�D H3�H�D$xH��H��H�L$@I������H�D$@H�T$`H�D$8�d$0 �d$( �d$  H�L$hE3�L����;  H�L$hH�׋��`0  �ȸ   ��u��t��u���t�   ���u3��|$X tH�L$P���   �H�L$xH3��
���H��$�   H�Ā   _��E3��`���@WH�� H�=�L H9=�L t+�   �  �H��H��L ����H��L �   �!  H�� _���   ���H�	X  H�NM  H��Q H��X  H��Q H��Q H��X  H��Q H��Q H�:Y  H��Q H�,M  H��Q H�VX  H��Q H��W  H��Q H��X  H��Q ���H��(M�A8H��I���   �   H��(����@SH�� E�H��L��A���A� L��tA�@McP��L�Hc�L#�Ic�J�H�C�HHK�At�A���H�L�L3�I��H�� [�����@SH��@��H�L$ ����H�D$ ��H��  �Q% �  �|$8 tH�L$0���   �H��@[��@SH��@��H�L$ 3��@���H�D$ ��H��  �Q% �  �|$8 tH�L$0���   �H��@[������������������ff�     H��H��H�   tf��H����t_�u�I��������~I� �H�M��H��L�H��I3�I#�t�H�P���tQ��tGH����t9��t/H����t!��t����t
��u�H�D��H�D��H�D��H�D��H�D��H�D��H�D��H�D��H�\$H�l$H�t$WH�� H�������E3�H��H����  H���   H��99tH���   H��H;�r�H���   H;�s99tI��H���N  L�AM���A  I��uL�IA�@��0  I��u����"  H���   H���   �y��   �0   H���   H��L�L�H���   |�9�  ����   uǃ�   �   �   �9�  �uǃ�   �   �   �9�  �uǃ�   �   �v�9�  �uǃ�   �   �b�9�  �uǃ�   �   �N�9�  �uǃ�   �   �:�9�  �uǃ�   �   �&�9� �uǃ�   �   ��9� �u
ǃ�   �   ���   �   A�Љ��   �
L�I�IA��H���   �����3�H�\$0H�l$8H�t$@H�� _øcsm�;�u���$���3���@SH�� ��L�D$8H��  3����  ��tH�L$8H��  �f�  H��t����H�� [����@SH�� ���������߯  ���H�\$WH�� H�k{ ���  H��\ H��H��tH�H��t����H��u�H��\ H������H�}\ H�%}\  H��tH�H��t�g���H��u�H�V\ H���R���H�?\ H�%?\  �>���H�#\ �2���H�%\  H�%\  H���H;�tH�=�z  tH������H���®  H�#h H��z H��t�����H�%
h  H�h H��t�����H�%�g  H�D �����uH�	D H��@ H;�t����H��C H�\$0H�� _���@SH�� ���  ���   E3���   A�P�  ���3�3�D�B�  ���@SH�� H�=^�   ��tH�S�  ��S  ��t���B�  �QS  H���  H�_�  �  ��uJH�  �U  H�;�  H�,�  �   H�=y  tH�vy �S  ��tE3�3�A�P�^y 3�H�� [���E3�A�P�   @SH�� 3��b�  H��H���g���H������H���U  H���U  H���WU  H����W  H�� [�y  �H�\$H�l$H�t$WH�� 3�H��H��H+ً�H��H��H;�HG�H��tH�H��t��H��H��H;�r�H�\$0H�l$8H�t$@H�� _�H�\$WH�� 3�H��H��H;�s��uH�H��t��H��H;�r�H�\$0H�� _���̹   ��  �̹   �  ��H�\$H�t$D�D$WATAUAVAWH��@E����D��   �  ��=ZY �  ��Y    D�5Y ����   H��w ��  H��H�D$0H����   H��w ���  H��H�D$ L��H�t$(L��H�D$8H��H�|$ H;�rv3��«  H9u��H;�rbH����  H��3����  H���H�~w ���  H��H�fw ���  L;�uL;�t�L��H�\$(H��H�\$0L��H�D$8H��H�D$ �H�%�  H���  ����H�"�  H��  �
����E��t�   �f  E��u&�/X    �   �M  A������A���<�  �H�\$pH�t$xH��@A_A^A]A\_����H��(��  3�H��H�:X ����H��(�H�%(X  ����H��H�XH�pH�xL�` AUAVAWH���   H�d$H�   ��  ��X   ��D�o�A���  H��H�D$(E3�H��uH�
   H���U  ������  H��W D�-v H   H;�s9f�A 
H�	�D�a�a8��A8$�A8f�A9

D�aPD�aLH�H�L$(H�xW �H�L$P�S�  fD9�$�   �B  H��$�   H���1  L�pL�t$8Hc0I�H�t$@A�   D98DL8�   �\$0D9=bu }sH��I���  H��H�D$(H��u	D�=Au �RHc�L��V I��D-*u I��H   H;�s*f�A 
H�	�D�a�a8�f�A9

D�aPD�aLH�H�L$(�����A��D�d$ L�-�V A;�}wH�H�AH��vQA�tKA�u
�J�  ��t;Hc�H��H����Hk�XI\� H�\$(H�H�A��CH�KE3���  �  �C�ǉ|$ I��L�t$8H��H�t$@�A��D�d$ I����������   Hc�Hk�XH�U H�\$(H�H��H��v�C���C�   �C��G���Ƀ���������D����  L��H�HH��vFH���v�  ��t9L�3����u	�C��@���u
�C���CH�KE3���  �  �C�!�C��@�CL�;H�Ub H��tH��D�x�ǉ|$ �*����   ��  3�L��$�   I�[ I�s(I�{0M�c8I��A_A^A]����H�\$H�t$WH�� H�=�T �@   H�H��t7H��   ��{ t
H�K���  H�H��XH   H;�r�H��b���H�' H��H��u�H�\$0H�t$8H�� _��H�\$H�t$ WH��0�=�r  u����H�=lV A�  3�H���^W  �D�  H��r H�=T H��t�; uH��H�D$HL�L$@E3�3�H��H�D$ �   Hct$@H��������H;�sYHcL$HH���sNH��H;�rEH���}  H��H��t5L��H�D$HL�L$@H��H��H�D$ �+   �D$@H�=\S �ȉPS 3�����H�\$PH�t$XH��0_��H��H�XH�hH�pH�x ATAVAWH�� L�t$`M��I��A�& L��H��A�   H��tL�I��3�;"u3���@�"��H�Ë��7A�H��t��H���3H�Ë��S  ��tA�H��t��H��H��@��t��u�@�� t@��	u�H��t	�G� �H��3��; ��   �; t�;	uH����; ��   M��tI�?I��A�$�   3��H�����;\t��;"u5��u��tH�C�8"uH���3�3҅����������H��t�\H��A���u���tL��u< tD<	t@��t4���<R  H��t��t�H�ÈH��A���H���
��tH��A�A�H���]���H��t� H��A�����M��tI�' A�$H�\$@H�l$HH�t$PH�|$XH�� A_A^A\��H�\$H�l$H�t$WH��0�=!p  u�����H�sK 3�H��u����   <=t��H������H��H؊��u�G�   Hc��  H��H�Q H��t�H�$K �; tPH���O����;=�pt.Hc�   H���G  H�H��t]L��H��H���������udH��Hc�H؀; u�H��J H������H�%�J  H�' �Uo    3�H�\$@H�l$HH�t$PH��0_�H�{P �z���H�%nP  ����H�d$  E3�E3�3�3���������H�\$ UH��H�� H��1 H�e H�2��-�+  H;�uoH�M�n�  H�EH�E� �  ��H1E���  H�M ��H1E�<�  �E H�� H�MH3E H3EH3�H�������  H#�H�3��-�+  H;�HD�H�i1 H�\$HH��H�b1 H�� ]�H��H�XH�hH�pH�x AVH��@�ݢ  E3�H��H����   H��fD90tH��fD93u�H��fD93u�L�t$8H+�L�t$0H��L��3�D�K3�D�t$(L�t$ �ơ  Hc��tQH����  H��H��tAL�t$8L�t$0D�KL��3�3ɉl$(H�D$ ���  ��uH�������I��H���;�  H���H���-�  3�H�\$PH�l$XH�t$`H�|$hH��@A^�H�\$ WH��@H����  H���   H�T$PE3�H�����  H��t2H�d$8 H�T$PH�L$XH�L$0H�L$`L��H�L$(3�L��H�\$ �ơ  H�\$hH��@_����@SVWH��@H�����  H���   3�H�T$`E3�H�����  H��t9H�d$8 H�T$`H�L$hH�L$0H�L$pL��H�L$(3�L��H�\$ �V�  �ǃ�|�H��@_^[����H�Uk H3n/ tH��H�%Z�  ��H�Ak H3R/ tH��H�%V�  ��H�-k H36/ tH��H�%*�  ��H�k H3/ tH��H�%�  ��H��(H�k H3�. tH��(H���ˠ  �   H��(��@SH�� �L: 3ۅ�y/H��k �\$0H3�. tH�L$03��Ѓ�z�Ct�É: ���Ë�H�� [�@SH�� H���  ��  H��  H��H���.�  H��  H��H3]. H�6j ��  H���  H3B. H��H� j ��  H��  H3$. H��H�
j �Ԟ  H�ݧ  H3. H��H��i ���  H�ߧ  H3�- H��H��i ���  H�ѧ  H3�- H��H��i �z�  H�˧  H3�- H��H��i �\�  H�ŧ  H3�- H��H��i �>�  H���  H3p- H��H��i � �  H���  H3R- H��H�pi ��  H���  H34- H��H�Zi ��  H���  H3- H��H�Di �Ɲ  H���  H3�, H��H�.i ���  H���  H3�, H��H�i ���  H���  H3�, H��H�i �l�  H3�, H���  H��H��h �N�  H���  H3�, H��H��h �0�  H���  H3b, H��H��h ��  H���  H3D, H��H��h ���  H���  H3&, H��H��h �֜  H���  H3, H��H�~h ���  H���  H3�+ H��H�ph ���  H���  H3�+ H��H�Jh �|�  H���  H3�+ H��H�<h �^�  H�w�  H3�+ H��H�&h �@�  H�i�  H3r+ H��H�h �"�  H�k�  H3T+ H��H��g ��  H�e�  H36+ H��H��g ��  H�W�  H3+ H��H��g �ț  H�Q�  H3�* H��H��g ���  H�C�  H3�* H��H��g ���  H3�* H�>�  H��H��g �n�  H3�* H��g H�� [���H�%y�  �@SH�� ���*�  ��H��H�� [H�%a�  �@SH�� H��3��7�  H��H�� [H�% �  H��H�XH�hH�pH�x AVH�� 3�H��H��A���E3�H��H���I  H��H��u&9�K v���n������  ;�K ��AG�A;�u�H�\$0H�l$8H�t$@H��H�|$HH�� A^��H��H�XH�hH�pH�x AVH�� �5YK 3�H��A���H���<���H��H��u$��t ��������5/K ���  ;΋�AG�A;�u�H�\$0H�l$8H�t$@H��H�|$HH�� A^���H��H�XH�hH�pH�x AVH�� 3�H��H��A���H��H����G  H��H��u+H��t&9�J v���p������  ;�J ��AG�A;�u�H�\$0H�l$8H�t$@H��H�|$HH�� A^����H�\$WH�� H�� H�=� �H�H��t��H��H;�r�H�\$0H�� _�H�\$WH�� H�_ H�=X �H�H��t��H��H;�r�H�\$0H�� _�H��H�XH�hH�pWATAUAVAWH��@M�aM�9I�Y8M+��AfM��L��H����   A�qHH�H�L�@�;3�m  ��H��D�L;���   �D�L;���   �|� ��   �|�t�D�H�L$0I��I��Ѕ�x}~t�} csm�u(H�=��   tH���  �>  ��t�   H�����  �L�A�   I��I��C  I�F@�T�D�M H�D$(I�F(I�L��I��H�D$ �p�  �C  ���5���3��   I�q A�yHI+��   ��HɋD�L;�ry�D�L;�sp�E tDE3Ʌ�t8E��M�B�D�H;�r B�D�H;�s�D�B9D�u�D�B9D�tA��D;�r�D;�u2�D���tH;�t%��GI��A�FHD�D��M�A���ǋ;��m����   L�\$@I�[0I�k8I�s@I��A_A^A]A\_���̃%5b  �H��(�   �~F  ��t�   �oF  ��u�=�G u��   �@   ��   �6   H��(��L�ɢ  3�M��A;t��I��Hc�H��r�3��Hc�H�I�D���H�\$H�l$H�t$ WAVAWH��P  H��% H3�H��$@  ������3�H��H����  �N��E  ���  �N�E  ��u�=JG �  ���   �c  H�-AG A�  L���  H��A���,  3Ʌ���  L�5JG A�  f�5EI I����  A���uL���  ��I���y,  ���)  I����,  H��H��<v9I����,  H�M�L���  H�AA�   H��I+�H��H+�H���,  ����   L���  I��H���+  ���  L��I��H���w+  ����   H�`�  A�  H����D  �k��������  H��H�H�H���wSD��H�T$@��
f93tA��H��H��Ic�H=�  r�H�L$@@��$3  �����L�L$0H�T$@H��L��H�t$ �M�  H��$@  H3�襷��L��$P  I�[(I�k0I�s8I��A_A^_�E3�E3�3�3�H�t$ ������E3�E3�3�3�H�t$ ������E3�E3�3�3�H�t$ ������E3�E3�3�3�H�t$ �����E3�E3�3�H�t$ ������H�\$WH�� Hc�H�=�. H�H�<� u�   ��u�H�-���H��H�\$0H�� _H�%l�  H�\$H�l$H�t$WH�� �$   H��. ��H�3H��t�{tH�����  H���_���H�# H��H��u�H�. H�K�H��t�;u�c�  H��H��u�H�\$0H�l$8H�t$@H�� _��H�\$H�|$AVH�� Hc�H�=9A  u�.����   ������   �����H�L�5. I�<� t�   �^�(   ����H��H��u�#����    3��=�
   �����H��I�<� uE3���  �'���I�<���|����H�@. �B�  �H�\$0H�|$8H�� A^����H�\$H�t$WH�� 3�H�l- �~$�{u$Hc�H��I E3�H����H�ʺ�  H�����H��H��u�H�\$0H�t$8�GH�� _����Hc�H�- H�H��H�%��  ��������������ff�     H+���t�:uOH����tE��u�I���������I���������g�%�  =�  w�H�H;u�M�H��H��I#�I��t�3��H�H����@SH��0H�ٹ   �e����H�CH��t?H�K H��J H�L$ H��tH9uH�AH�B�����H����H�K����H�c �   ����H��0[�������������������ff�     L����I���\  �%�K sWH����I���_�mI�I���%rK ��   I��@rH�ك�tL+�I�I�M��I��?I��u?M��I��I��tfff��H�H��I��u�M��t
�H��I��u�I����    fff�ff�H�H�QH�QH��@H�Q�H�Q�I��H�Q�H�Q�H�Q�u��fffffff�     fHn�f`���tH��H��H��H+�N�D �M��I��t2��))AH���   )A�)A�I��)A�)A�)A�)A�u�I��M��I��t�     )H��I��u�I��tAD�I���I�I��L��n��C����  L�I�I��A��n�  k�  |�  g�  ��  ��  y�  d�  ��  ��  ��  o�  ��  ��  u�  `�  fff�     H�Q�Q�f�Q��Q��H�Q���H�Q�Q�f�Q��H�Q�Q��Q��H�Q�Q��H�Q�f�Q��H�Q��Q��H�Q��������H���   SH�� H��H�IH;, t����H�K H;, t�o���H�K(H;, t�]���H�K0H;�+ t�K���H�K8H;�+ t�9���H�K@H;�+ t�'���H�KHH;�+ t����H�KhH;�+ t����H�KpH;�+ t�����H�KxH;�+ t�����H���   H;�+ t�����H���   H;�+ t����H���   H;�+ t����H�� [���H��tfSH�� H��H�	H;�* t�z���H�KH;�* t�h���H�KH;�* t�V���H�KXH;+ t�D���H�K`H;+ t�2���H�� [�H����  SH�� H��H�I����H�K�	���H�K� ���H�K �����H�K(�����H�K0�����H������H�K@�����H�KH�����H�KP�����H�KX����H�K`����H�Kh����H�K8����H�Kp����H�Kx����H���   ����H���   �t���H���   �h���H���   �\���H���   �P���H���   �D���H���   �8���H���   �,���H���   � ���H���   ����H���   ����H���   �����H���   �����H���   �����H���   �����H���   �����H��   �����H��  ����H��  ����H��  ����H��   ����H��(  ����H��0  �x���H��8  �l���H��@  �`���H��H  �T���H��P  �H���H��h  �<���H��p  �0���H��x  �$���H���  ����H���  ����H���  � ���H��`  �����H���  �����H���  �����H���  �����H���  �����H���  ����H���  ����H���  ����H���  ����H���  ����H���  �|���H���  �p���H���  �d���H���  �X���H��   �L���H��  �@���H��  �4���H��  �(���H��   ����H��(  ����H��0  ����H��8  �����H��@  �����H��H  �����H��P  �����H��X  �����H��`  ����H��h  ����H��p  ����H��x  ����H���  ����H���  ����H���  �t���H���  �h���H���  �\���H���  �P���H���  �D���H���  �8���H�� [���@UATAUAVAWH��PH�l$@H�]@H�uHH�}PH�� H3�H�E�]`3�M��E��H�U ��~*D��I��A��@88tH��E��u�A�����A+���;ÍX|��D�ux��E��uH�D�p���   D��M���A�Ή|$(��H�|$ ���+�  Lc���u3��  I����������~n3�H�B�I��H��r_K�?H�AH;�vRJ�}   H��   w*H�AH;�wI��H����]<  H+�H�|$@H��t����  ��_���H��H��t
� ��  H��H���t���D��M�ĺ   A��D�|$(H�|$ �z�  ���Y  L�e !t$(H!t$ I��E��L��A����   Hc����0  A�   E��t6�Mp���  ;��  H�Eh�L$(E��L��A��I��H�D$ �   ��   ��~w3�H�B�H��H��rhH�6H�AH;�v[H�u   I;�w5H�AH;�w
H��������H����O;  H+�H�\$@H����   ���  ��M���H��H��t� ��  H���3�H��tmE��L��A��I�̉t$(H�\$ ��  3Ʌ�t<�Ep3�H�L$8D��L��H�L$0��u�L$(H�L$ ��D$(H�EhH�D$ A���$�  ��H�K��9��  u�}���H�O��9��  u�l�����H�MH3�蚩��H�]@H�uHH�}PH�eA_A^A]A\]�H�\$H�t$WH��pH��H��H�L$PI��A���_�����$�   H�L$PL�ˉD$@��$�   D�ǉD$8��$�   H�։D$0H��$�   H�D$(��$�   �D$ �����|$h tH�L$`���   �L�\$pI�[I�sI��_���@UATAUAVAWH��@H�l$0H�]@H�uHH�}PH�2 H3�H�E D�uh3�E��M��D��E��uH�D�p�]pA�Ή|$(�H�|$ ������  Hc���u3���   ~wH��������H;�whH�6H�AH;�v[H�u   H��   w1H�AH;�w
H��������H����9  H+�H�\$0H��t����  �����H��H��t� ��  H���H��H���t���L��3�H��M������E��M�ĺ   A�Ήt$(H�\$ �$�  ��tL�M`D��H��A���M�  ��H�K��9��  u�^�����H�M H3�茧��H�]@H�uHH�}PH�eA_A^A]A\]���H�\$H�t$WH��`��H��H�L$@A��I���P�����$�   H�L$@D�ˉD$0��$�   L�ǉD$(H��$�   ��H�D$ �/����|$X tH�L$P���   �H�\$pH�t$xH��`_�H�\$H�t$H�|$ UATAUAVAWH��H��`H�> H3�H�E��A
D�	3ۋ�% �  A���EċA���  �E�A���?  A�   H�U�D�M؉E�D�M��sE�t$�����u)D�Ë�9\��uH�I;�|��  H�]�]�   �  H�E�E��A���H�E��'! �}���D��E����A#��D��A#�A��+�D+�Mc�B�L��D�E�D����   A��A��Ic����ЅD��uA�BHc��	9\��u
H�I;�|��r�E�A�̙A#��D��A#�+�A����+�Mc�B�D����;�r;�sD��A�@�B�L��HcЅ�x'E��t"�D��D��D�@D;�rD;�sD��D�D��H+�y�D�E�Mc�A��A����B!D��A�BHc�I;�}H�M�M��L+�H��3�I������D�M�E��t��
  ��+  ;�}H�]�]�D�û   �T  ;��1  +M�H�E�E��H�E��D�M�M��D��A#�L�E��D��A#�+�A���ȋ��    A��+�D��A��A� �ϋ���A��A�A#�D��A� M�@A��L+�u�Mc�A�{E�sM��D��I��M;�|I��H��J���L�L��B�\��L+�y�D�E�E��A�@�A#��D��A#�+�A��D+�Ic��L��D����   A��A��Ic����ЅD��uA�AHc��	9\��u
H�I;�|��lA��A�̙A#��D��A#�+�A����+�Mc�B�D�����D�D;�rD;�s��A�B�F�D��HcЅ�x$��t �D���D�@D;�rD;�s��D�D��H+�y�A��A����Ic�!D��A�AHc�I;�}H�M�M��L+�H��3�I���I����G A�    D����L�E�A#��D��A#�+�A����D��A��D+�A��A� A�ˋ���A��A�A#�D��A� M�@A��L+�u�Mc�L��M��I��M;�|I��H��J���L�L��B�\��L+�y�D�Ë��  �� D�� A�    �A#��D��A#�+�A����A��A��A;�|zH�]��m��]�D+��D��L�E�A� ��A��#���A��A�D��A��A� M�@L+�u�Mc�A�~M��I��I;�|H��H��J���L�L���\��H+�y�D� ��E��oD� �u�D��Dǋ�D+�L�M�A��ϋ���A��A�A#�D��A�M�IA��L+�u�Mc�A�~M��I��I;�|H��H��J���L�L���\��H+�y�H�U�D+%� A��A���]��%   �D��~ DE��@u�E�D�B���� uD���H�M�H3��\���L�\$`I�[0I�s@I�{HI��A_A^A]A\]���H�\$H�t$H�|$ UATAUAVAWH��H��`H�� H3�H�E��A
D�	3ۋ�% �  A���EċA���  �E�A���?  A�   H�U�D�M؉E�D�M��sE�t$�����u)D�Ë�9\��uH�I;�|��  H�]�]�   �  H�E�E��A���H�E��� �}���D��E����A#��D��A#�A��+�D+�Mc�B�L��D�E�D����   A��A��Ic����ЅD��uA�BHc��	9\��u
H�I;�|��r�E�A�̙A#��D��A#�+�A����+�Mc�B�D����;�r;�sD��A�@�B�L��HcЅ�x'E��t"�D��D��D�@D;�rD;�sD��D�D��H+�y�D�E�Mc�A��A����B!D��A�BHc�I;�}H�M�M��L+�H��3�I���g���D�M�E��t��j ��+f ;�}H�]�]�D�û   �T  ;��1  +M�H�E�E��H�E��D�M�M��D��A#�L�E��D��A#�+�A���ȋ��    A��+�D��A��A� �ϋ���A��A�A#�D��A� M�@A��L+�u�Mc�A�{E�sM��D��I��M;�|I��H��J���L�L��B�\��L+�y�D�E�E��A�@�A#��D��A#�+�A��D+�Ic��L��D����   A��A��Ic����ЅD��uA�AHc��	9\��u
H�I;�|��lA��A�̙A#��D��A#�+�A����+�Mc�B�D�����D�D;�rD;�s��A�B�F�D��HcЅ�x$��t �D���D�@D;�rD;�s��D�D��H+�y�A��A����Ic�!D��A�AHc�I;�}H�M�M��L+�H��3�I�������� A�    D����L�E�A#��D��A#�+�A����D��A��D+�A��A� A�ˋ���A��A�A#�D��A� M�@A��L+�u�Mc�L��M��I��M;�|I��H��J���L�L��B�\��L+�y�D�Ë��  � D�  A�    �A#��D��A#�+�A����A��A��A;�|zH�]��m��]�D+��D��L�E�A� ��A��#���A��A�D��A��A� M�@L+�u�Mc�A�~M��I��I;�|H��H��J���L�L���\��H+�y�D�| ��E��oD�n �u�D��Dǋ�D+�L�M�A��ϋ���A��A�A#�D��A�M�IA��L+�u�Mc�A�~M��I��I;�|H��H��J���L�L���\��H+�y�H�U�D+%� A��A���]��%   �D��� DE��@u�E�D�B���� uD���H�M�H3�褛��L�\$`I�[0I�s@I�{HI��A_A^A]A\]���H�\$UVWATAUAVAWH�l$�H��   H�� H3�H�E�L�u3�D�M�D�KH�M�H�U�L�U�f�]�D��D�M�D���]�D��D����M��u�O����    �x���3��  I��A�8 wI� H� &     H��sM���A�M����
  ��  D�Ʌ���  A���:  A����   A����   A����  A�   �0E��D�M�E��u0�	A�A+�M�:�t����9A��s*�E�A�M�A+�A�M�:�}ݍBը�t$��C�<  ��E~��dA:��+  �   �I���M+��   �<���A�   �0E���!��9 A��s*�E�A�M��A�A�M�:�}�I�H���   H�:u��   ������B�<w�   A�   M+������I�H���   H�:u�   A�   ������0��  A�   A�������B�A�   E��<wA�I�I�H���   H�:�y����Bը�������0t�������B�<�j���I�H���   H�:�y�����+t)��-t��0t�A�   M+��p  �   �E� �  �P����   f�]��B�����0D�M���	��   �   �
���D��A����   A��tsA��tBA����   A����   9]wt�I�x���+t��-��   �M���   ������   �����A�   E���A�M���0t���1���D����	   �����B�<w
�	   �n�����0��   �   �����B�I�x�<v؀�+t��-t��ֹ   ��
tg�Y���L���cA�   @�0E���$��9=G�l� ��E�m�F�,hA��P  A�M�@:�}��A�Q  ���9�����A�M�@:�}�����L��A�   H�E�L� E���  A��v�E�<|A��E�M+�A�   A�E��u���Ë�����  A��A�M+�A8t�L�E�H�M�A���v(  9]�}A��D�E��uDmg9]�uD+moA��P  ��  A�������e  H�5H H��`E���?  yH�5� A��H��`9]�uf�]�E���  �   �A��  A��H��TA��H�u�����  H�A� �  A�   H�@H��H�U�fD9r%�B�H�UωE��E�H�E�H��H�U�A+ƉE��B
�M�H�]�D��fA#��]�fD3�fA#�fE#�D�fA;��g  fA;��]  A���  fE;��M  A��?  fE;�wH�]É]��I  f��u fE��E����u9]�u9]�u	f�]��$  f��ufE��B���u	9Zu9t�D��L�M�A�   D�U�E��~lC�?H�}�H�rHc�A��A#�H�����D����A�D�4D;�rD;�sA�   E�1A�   E��tfEqD�]�H��H��E+�D�]�E���H�U�E+�I��E�E���x���D�U�D�M���  fD��   �A���  fE��~?D��u4D�]�A��E���E�A����C�fE��D�D�M��E�D�U�fE���fE��jfE�ydA����f����fD�D�u�tA�D�]�A��A��A����A����D�A��D�D�]�D�M�I+�u˅�D�U��   �tA��fA�f�E�D�M���E�H�u�A� �  fA;�wA���� A�� � uH�E����;�u8�E��]�;�u"�E��]�fA;�ufD�]�fE��fA�f�E��AƉE�D�U��AƉE�A��  fE;�s�E�fE�D�U�f�E��E�fD�EɉE��fA��H�]��#� ���E�E��������E��U��M��}����5���Ë��˻   �%���Ӹ�  �   �   �����Ë��˻   L�E�fE�fA�@
��fA�A�HA�xH�M�H3��>���H��$�   H�Ġ   A_A^A]A\_^]����������ff�     H+�I��r"��tf��:
u,H��I����u�M��I��uM��t�:
uH��I��u�H3������ÐI��t7H�H;
u[H�AH;D
uLH�AH;D
u=H�AH;D
u.H�� I��u�I��M��I��t�H�H;
uH��I��u�I���H��H��H��H�H�H�H;���������������������ff�     L��L��I����   H+�sI��I�H;���  �%�) sWVH��I��I���^_I����%�) �V  ��t6��t�
I�ȈH����tf�
I��f�H����t�
I���H��M��I����  M��I��tH�
H�H��I��u�I��M��uI��� H�
L���M��L��M��C���@�  I�����  ��  ��  ��  ��  ��  ϲ  �  ��  �  �  /�  L�  ]�  w�  ��  ��  I���H�A�I���H�fA�I���H�H�JA�fA�JI��ËA�I���H��JA�A�JI���H��JfA�A�JI���H�H�J�RA�fA�JA�RI���H�I�I���H�H�JA�I�JI���H�H�JfA�I�JI���H�H�JH�RA�fA�JI�RI��ËH�JA�I�JI���H��JH�RA�A�JI�RI���H��JH�RfA�A�JI�RI���L�H�B�JH�RE�fA�BA�JI�RI����o�AI���fffff�     H�
L�T
H�� H�A�L�Q�H�D
�L�T
�I��H�A�L�Q�u�I�������I�� ��   ��u
H��I���
H�� ���D
�AH��I+�L+�M��I��tf)A��
f�)A�)I�
L
H���   )A�)I�D
�L
�I��)A�)I�D
�L
�)A�)I�D
�L
�u�)A�I��(�M��I��tf�     )A�
H��I��u�I��tI�L�H�)A�I���@ AI�L�
A	I����     fff�fff�f��%& ��   I���t6��tH�Ɋ
I�Ȉ��tH��f�
I��f���tH���
I���M��I��uAM��I��tH��H�
I��H�u�I��M��uI���fff�     I+�L��H�
�}����H�D
�L�T
�H�� H�AL�QH�D
L�
I��H�AL�u�I���I�� ����I���uH��
I���H��
H�����
L��M+�M��I��th)�fD  )A)	D
�L
�H��   )Ap)I`D
PL
@I��)AP)I@D
0L
 )A0)I D

u�)AI��(�M��I��tff�     )H��
I��u�I��tA
A)I������@SH�� E3�L��H��tH��t	M��ufD��آ���   �� �����H�� [�fD9t	H��H��u�H��ufE���I+�A� fB�M�@f��tH��u�H��ufE�肢���"   �3�����@SH�� E3�H��tH��t	M��ufD��S����   ��{�����H�� [�L��M+�A� fC�M�@f��tH��u�H��ufD������"   �3����H���H��f��u�H+�H��H������@SH�� 3�M��uH��uH��u 3��/H��tH��tM��uf���M��uf�谡���   ��ؠ����H�� [�L��L��I���uM+�A� fC�M�@f��t/I��u��(L+�C�fA�M�[f��t
I��tI��u�M��ufA�M���n���I���uf�\Q�A�BP�f��*����"   �u���H��H�XH�hH�pH�x AVH�� H��3���   L�5��  �>A�U   H�͙+���Hc�H��H�I���  ��ty�s���{;�~˃���H��H�A�D�H�\$0H�l$8H�t$@H�|$HH�� A^���H��(H��t"�f�����xH�H=�   sH�݆  H����3�H��(���L��I�[I�sWH��PL�E3 A��I��L3x�  ��t*3�I�C�I�C�I�C؋�$�   �D$(H��$�   I�C�A���-�u���D��L�ǋȋ�$�   �։D$(H��$�   H�D$ �Uh  H�\$`H�t$hH��P_��E3�L��L��M��tCL+�C��A�f��wf�� A��B�f��wf�� I��I��t
f��tf;�t���D��D+�A������H��H�D$xH�d$0 �D$(�D$p�D$ �   H��H�H��8A�A�A�����A��tJA��fuH�D$pD�L$`H�D$ �[  �JA�A�D�L$`A��H�D$pH�D$(�D$h�D$ t�	  �#�%   �H�D$pD�L$`H�D$(�D$h�D$ �  H��8���H��H�XH�hH�pWATAUAVAWH��PH��H��$�   L��H�H�A�0   A��I��A��  A���[���E3Ʌ�AH�H��u�x����   �H��t�CD�Hc�H;�w�Y����"   �聝��E3���  I���  H��4H#�H;���   L�L$(D�L$ L�F�H���H�WD��LD�I����  E3ɋ؅�tD��  �-�   u�-H���$�   D�?�e   ����ɀ����x�7H�NH���  E3�H���V  ��ɀ����p�D�H�A  H�       ��   I�t�-H�D��$�   E��I������� D�H�A����A��ɀ����x�H����H�      �������I�uD�I�H�I#�H��M�A���  ��1H�L��H���uE��H�D$0H���   H��A�M���   I�       ��~-I�@��I#�I#�H��fA�f��9vfI��+�H�f���y�f��xHI�@��I#�I#�H��f��v3H�O��,F��uD�H+���I;�t�<9u��:��@ƈ�H+�@ 1��~L��A��H������H�E3�E�Q0E8ID�A���$�p�I�H�H��4���  I+�x�+H��	�-H�H��L��D�H���  |3H���S㥛� H��H��H��H��?H�A��H�Hi����H�I;�uH��d|.H�ףp=
ףH��H�H��H��H��?H�A��H�HkH�I;�uH��
|+H�gfffffffH��H��H��H��?H�A��H�Hk��H�AʈD�OA��D8L$HtH�L$@���   �L�\$P��I�[0I�k8I�s@I��A_A^A]A\_�H��H�XH�hH�pH�x AUAVAWH��PL��H��$�   H��H�H�E��Ic�躅��H��tM��u�ۚ���   �3���Oƃ�	H�L;�w辚���"   ������8  ��$�    H��$�   t43ۃ} -��E3�H߅�A��E��tH���U���Ic�H��L�@H������} -H��u�-H�W��~�B�H�D$0H��H���   H���
3�H�2L���  8�$�   ��H�H+�I���H��I�>ID�裍������   H�KE��t�EH�E�80tVD�EA��yA���C-A��d|���QA��������� SkD�A��
|�gfffA��������� Sk��D�D C�� t�90uH�QA�   ����3ۀ|$H tH�L$@���   �L�\$P��I�[ I�k(I�s0I�{8I��A_A^A]�H�d$  E3�E3�3�3�耘������@SUVWH��   H�Q�  H3�H�D$pH�	I��H��A��   L�D$XH�T$@D����  H��u������(�������   H��t�H���H;�t3��|$@-H����H+�3�����H+�3��|$@-D�F��3Ʌ���H�L�L$@H���  ��t� �2H��$�   D��$�   D��H�D$0H�D$@H��H���D$( H�D$ �&���H�L$pH3��	���H�Ĉ   _^][��H��H�XH�hH�pH�x AVH��@A�YH��H�T$xH��H�H�I����E���ǂ��H��tH��u�����   �������   �|$p tA;�u3��} -Hc���H�f�0 �} -u�-H�ǃ}  H���x���H�OH��L�@�(����0H���HcEH�E��~wH��H�w�H���H��H��L�@�����H�D$ H���   H����]��yB�ۀ|$p u��A��D;�M؅�tH�������Hc�H��L�@H�����Lcú0   H������3ۀ|$8 tH�L$0���   �H�l$XH�t$`H�|$h��H�\$PH��@A^����@SUVWH��xH���  H3�H�D$`H�	I��H��A��   L�D$HH�T$0D���  H��u臖���(贕�����kH��t�H���H;�t3��|$0-H����H+�D�D$43�L�L$0Dƃ|$0-��H��  ��t� �%H��$�   L�L$0D��H�D$(H��H���D$  �����H�L$`H3�����H��x_^][����@SUVWAVH��   H��  H3�H�D$pH�	I��H��A��   L�D$XH�T$@D���  H��u讕����۔������   H��t�D�t$D3�A�΃|$@-��H���H�0H;�tH��H+�L�L$@D��H����  ��t� �~�D$D��D;������|;;�}7��t�H�Ä�u��C�H��$�   L�L$@D��H�D$(H��H���D$ ������2H��$�   D��$�   D��H�D$0H�D$@H��H���D$(H�D$ ����H�L$pH3��~��H�Ā   A^_^][�3��   �@SH��@H��H�L$ �y���L�D$ ��tI���   H��:�t	H�Ê��u�H�Ä�t=�	,E��t	H�Ê��u�H��H�ˀ;0t�I���   H��8uH�ˊH��H���u�|$8 tH�D$0���   �H��@[���E3��    @SH��0I��H��M��H�Ѕ�tH�L$ ����H�D$ H��H�L$@輦���D$@�H��0[�3��   �@SH��@H��H�L$ �~����  ��etH�����  ��u���  ��xuH��H�D$ �H���   H���H�Ê��ЊH�Ä�u�8D$8tH�D$0���   �H��@[���3�f/��  �����H�\$WH�� 3�H�)�  H��xZ  ��H�Hc�H�[H��
r�H�\$0H�� _����LcA<E3�L��L�A�@E�XH��I�E��t�PL;�r
�H�L;�rA��H��(E;�r�3��������������H�\$WH�� H��H�=�8��H���4   ��t"H+�H��H������H��t�@$���Ѓ��3�H�\$0H�� _����H���MZ  f9t3��HcH<H�3��9PE  u�  f9Q�����@SH�� �   �J����H��H���iY  H�J% H�;% H��u�C�H�# 3�H�� [��H�\$H�t$H�|$ATAVAWH�� L��蛬���H�% �Y  L��H��$ �Y  H��I;���   H��I+�L�I����   I���M  H��I;�sU�   H;�HB�H�H;�rI���M���3�H��u�3�H�V H;�rII���1���H��t<H��H��H����X  H�h$ I���wX  H�H�K�jX  H�C$ I���3��۫��H��H�\$@H�t$HH�|$PH�� A_A^A\���H��(�����H�������H��(��H��(H�= �X  H��t��� �   �H��(�ϟ��H���   H��t��� �  ��H��(H�������W  H�� H��(����H�� �H�� H�%�W  ��H�� H�� H�� H�� ����H�\$H�t$ WATAUAVAWH��0��E3�D!l$h3��|$`3��у���   ��tb��tM��tX��tS��t.��t��t5�ُ���    �����@L�5Y H�R �   L�5V H�O �{L�5> H�7 �k����H��H��u����k  H���   H��Lc�^  9YtH��I��H��H�H;�r�I��H��H�H;�s9Yt3�L�qM�>� L�5� H�� �   �|$`�{V  L��I��u3���   M��u
A�O�٨��̅�t3������A�	  ��w3A��s-L���   L�l$(H���    ��uR���   �D$hǆ�   �   ��u9�/^  �щL$ �'^  �;�},Hc�H�H���   H�d� �T$ ��]  ��3���U  I���t3��������u���   ��A�����A�׃��,���A���"���L���   �������D$h���   ����H�\$pH�t$xH��0A_A^A]A\_��H�� �����������ff�     H���  M3�M3�H�d$ L�D$(��/  H���  �������fD  H�L$H�T$D�D$I�� ��������f��������f�     ����H�\$WH�� �\ 3ۿ   ��u�   �;�L�HcȺ   �7 �2���H�# H��u$�PH�ω= ����H� H��u�   �#H�[�  H�H��0H�[H��t	H�� ��3�H�\$0H�� _�H��(�  �=�  t�m  H�� �U���H�%�  H��(�@SH�� H��H���  H;�r@H�x�  H;�w4H��H��������*H+�H��H��H��H��?Hʃ������kH�� [�H�K0H�� [H�%�T  ���@SH�� H�ڃ�}�������kH�� [�H�J0H�� [H�%{T  ���H�a�  H;�r7H���  H;�w+�qH+�H��������*H��H��H��H��?Hʃ��u���H��0H�%2T  �̃�}�r���V���H�J0H�%T  ���H�\$H�t$WH��@��H��H�L$ A��A���Xv��H�D$(��@�|u��tH�D$ H��  �Q#��3���t�   �|$8 tH�L$0���   �H�\$PH�t$XH��@_���̋�A�   E3�3��r�����H�\$H�t$WH�� H��H��H��u
H���҄���jH��u�~����\H���wCH���  �   H��HD�L��3�L���AS  H��H��uo9� tPH���݆����t+H���v�H���ˆ��薊���    3�H�\$0H�t$8H�� _��y���H����Q  ��艊������`���H���sQ  ���p����H����H�\$WH�� I��H��H��t3�H�B�H��H;�s� ����    3��]H�ٸ   H��HD�3�H���wH���  �PL���7Q  H��u-�=  tH��������u�H��t��   �H��t�   H�\$0H�� _���H��(��x ��~��u�d
 �!�\
 �V
 ������    計�����H��(�@SUVWATAVAWH��PH���  H3�H�D$HL��3�A��L����P  3�H��菰��H9= 
 D����   H���  3�A�   ��O  H��H��u-�P  ��W��  H�\�  E3�3���O  H��H����  H�V�  H����O  H����  H���P  H�D�  H��H�z	 ��O  H����O  H�4�  H��H�b	 �|O  H����O  H�,�  H��H�J	 �\O  H����O  H�D	 H��t H� �  H���7O  H����O  H�	 �aO  ��tM��t	I����P  E��t&�   ��   E��tH�� �NO  �   ��   H�� H;�tcH95� tZ�)O  H�� H���O  L��H��t<H��t7��H��t*H�L$0A�   L�D$8H�L$ A�Q�H��A�օ�t�D$@u���@H�N H;�t4��N  H��t)��H��H��tH�5 H;�t��N  H��tH����H��H� ��N  H��tD��M��I��H�����3�H�L$HH3���p��H��PA_A^A\_^][��H�\$H�l$H�t$WH��3�3�3�����     ���     D�ۋ�D��ntelD��A��A��ineI��Genu��DÍGD�A��A��AuthA��entiEف�cAMDD�@��3��D��D�ȉ\$�T$E��tO�Ё��?���� t+��` t#��p t�°����� w$H�     H��sD�� A��D�� �D�y @��tA�� �A�� ` |A��D�Y �   ;�|"3�����$�L$�T$��	sA��D�. A��sP���     ���     A��s5A��s.���     ���     @�� t���     �{�  .   H�\$ H�l$(H�t$03�H��_�������ff�     H��L�$L�\$M3�L�T$L+�MB�eL�%   M;�sfA�� �M�� ���A� M;�u�L�$L�\$H�����H�\$H�l$H�t$WATAVH��A�  A�` A�` M�Ћ�H��N@  ���A  E3�E3�E3�E�c�AE�rA����E�E��$D�C�A����E�D����A����E���D�3�Dɋ$A��4
E�BE�J;�r;�sA��A�2��t$A��A��3�D;�rE;�sA��E�B��tA��E�JH�$3�H�� E� E;�rD;�sA��E�Z��tE�E�JE΍6A����G�E�Dɋ�A���E�JD�3�E�B�M D�
D;�rD;�sA��E���t$A��A��3�D;�rE;�sA��E�B��tA��E�JI�E�BE�J�������A�z u:E�BA�A��E����������A��A�D��D����  f�E��t�E�BE�JA�RA� �  A��u8E�
E�BA��A��E������D����  �f�E�A��t�E�
E�BA�RH�l$8H�t$@fA�Z
H�\$0H��A^A\_���@SH��@�=+�   Hc�uH���  �X���RH�L$ 3��rm��H�D$ ���   ~L�D$ �   ���c������H��  �X���|$8 tH�D$0���   ���H��@[���H�|$L�t$ UH��H��pHc�H�M��m����   s]H�U����   ~L�E�   ������H�U��H��  �x����tH��  �8��   �}� tH�E����   ����   H�E����   ~+D��H�U�A��A��������tD�u@�}�E �   �蔁���   � *   @�}�E H�U��D$@   L�M�BH��8  A�   �D$8H�E �D$0   H�D$(�L$ H�M��������N������E t	�M!����}� tH�M����   �L�\$pI�{M�s(I��]��̃=a�   u�A���w�� ���3�������H��E3�L�Ʌ�uHA��H��W�H���A��A���A��foft�f��A#�uH��foft�f����t���H��   �=��  ��   L����A��I�����W����fn�A��A���A���p� fo�fAtfp� f��fo�fAtf��A#�A#�u.��fo�fo�Iʅ�LE�I��fAt
fAtf��f�Ѕ�tҋ���#���#���Iʅ�LE�I��H�����tA�;�MD�A�9 t�I��A��u���fn�fA:c@sLc�M�fA:c@t�I����H�\$WH�� H��I�IE3�H��u�~���   ��~�����   H��t�A��E��D�AO���H�H;�w�K���"   ��H�{�0H���D8t�H����0   �H��A��E���D�x�95|�� 0H�Ȁ89t�� �;1uA�A�H���ɓ��H��H��L�@�z���3�H�\$0H�� _��H�\$D�ZL�ыJE�ø �  A��  fA��fD#؋fE#����� �   �A�Ѕ�tA;�t� <  fD��$A��  ���u��u	A!BA!�X�<  fD�3�D������A��A�D�D�E�JE��x*A�C�	����D��DȍA����  fD�E��y�E�JfE�H�\$fE�Z����@USVWH�l$�H��   H�$�  H3�H�E'H��H�M�H�U�H�M�I��I��������E�E3��E��E�L�MH�M�A�Pf�E���  �M	��ML�E�OH��H�ΉG�q����uH�wH��H�M'H3��7g��H�Ĉ   _^[]�H�d$  E3�E3�3�3��|���̹   �F�����H��(H��u�.}���    �W|��H���H��(�L��H���  3�H��(H�%�E  ���H��(����H��t
�   �������  t)�   ��  ��t�   �)A�   �  @A�H�z���   脖������H��(H��u�|���    ��{�������AH��(���H��(���u�r|��� 	   �B��x.;� s&Hc�H�0�  H����H��Hk�XH���D��@��3|��� 	   �\{��3�H��(��@SH�� H��H��u
H�� [�   �/   ��t���� �C @  tH���A�������  ����3�H�� [�H�\$H�t$WH�� �A3�H��$<u?�A  t6�9+y��~-�����H�SD�ǋ��  ;�u�C��y����C��K ���H�K�c ��H�t$8H�H�\$0H�� _���̹   �   ��H�\$H�t$H�|$AUAVAWH��0D��3�3��N�Э���3�A����\$ ;��  }~Lc�H���  J��H��td�B�t^�������H���  J���A�t3A��u����A;�t#�Ɖt$$�E��u�At����A;�AD��|$(H���  J������������v����   �%���A��D���H�\$PH�t$XH�|$`H��0A_A^A]���H�\$H�t$WH��03��O�������_�\$ ;)�  }cHc�H��  H��H��tL�A�t�e  ���t�ǉ|$$��|1H���  H��H��0��A  H���  H���xw��H���  H�$� ��둹   �j�����H�\$@H�t$HH��0_�H�\$UVWATAUAVAWH�l$�H���   H���  H3�H�ED�QI��D�	�U�� �  A�   D�E�D�AA��f#�D�j�A�CE3�fE#�H�]��E������E������E����?f�M��xf��t@�{��CfE��u.E����   E����   f;�D�fD�#�Cf�C0D�c�[	  fE;���   �   �fD�D;�uE��t)A��r"H�KL�"�  �   �\l������   �{	  f��t+A��   �u"E��uMH�KL���  A�Q�(l����t+�`	  D;�u+E��u&H�KL�֛  A�Q�l�����O	  �   �C�!H�KL���  �   ��k�����=	  �CE���  A��D�M�fD�U�A�ȋ�L�-�  ����A�   ��HA�   I��`D�E�fD�e���  k�Mi�M  ���D�u�A�����D�щM�A���o  E��yL�/�  A��I��`E���S  D�E�U�A��I��TA��D�U�L�M����  H�H�@I�4�A� �  H�u�fD9r%�F�H�u�E�EH�EH��H�u�A+ÉE	�N
�E�D�e���fA#�H�E�    f3�fA#�D�e�fA#�D�f�]�fA;��}  fA;��s  A���  fE;��]  ��?  fD;�wH�E�    A��  �Y  f��u"fE˅}�uE��u��ufD�e�A��  �;  f��ufE˅~uD9fuD9&t�A��H�U�E3�D���~_C�$L�u�A��Hc�A#�L�~L�3�A�A�D���ȋD�D;�rD;�sE��D�E��tfDZE+�I��I��E���H�u�E3�A+�H��E���D�U�D�E׸�  fD�E3���  A�   �fE��~<E��u1�}�A��E���E������?fD��D�D�E׉E�D�U�fE���fE��mfD�ygA��f����fD�fD�M�D�M�D�]�tEˋ}�A��A����������A��D��}�D�E�I+�u�E��D�M�D�U�tA��fA�f�E�D�E���E׹ �  f;�wA���� A�� � uH�Eك��;�u8�E�D�e�;�u!�E�D�e�f;�u
f�M�fE��fA�f�E��AÉE�D�U��AÉE�A��  A�   ����fE;�r�E�D�U�f���2�E�fDM�D�U�D�U�f�E�EۉE�D�E�U�fD�M��#A��  f���D�e�A#� ���E�A��E�ĉU�L�M�E�������H�]��M����  �D�E�U�E�A��?  ��fA;���  fA�A� �  D�e�E�Q��M��MD��fA#�H�E�    fD3�fA#�D�e�fE#�D�fA;��X  fA;��N  fD;��D  A��?  fE;�w	D�e��@  f��ufE˅}�uE��u��u
fD�e��%  f��ufE˅}�uD9e�uD9e�t�A��H�U�A��E��~]�?L�}�D��Hc�E#�L�u�L�3�A�A�D���ȋD�D;�rD;�sE��D�E��tfDZA+�I��I�����D�u�E3�E+�H��A�D�u�E���H�]�D�E�D�U׸�  �   �A���  fD�fE��~<D��u1�}�A��E���Eҋ����?fE��D�D�U׉E�D�E�fE���fE��efE�y_�]�A��f����fD�D�]�tAۋ}�A��A����������A��Dщ}�D�U�I+�uЅ�H�]�D�E�tA��fA�f�E�D�U���E׹ �  f;�wA���� A�� � uI�Eك��;�u9�E�D�e�;�u"�E�D�e�fA;�u
f�M�fE��fA�f�E��AÉE�D�E��AÉEٸ�  fD;�rfA��E��A���#� ���E��@�E�fE�D�E�f�E�E�fD�M�E�D�E�U��fA���A#� ���E�A��E�Ĺ �  �E�D�u�f�D�]�t�D�E��f9M��    �HD��<���D�M�   fD�e�u�D;�D�P�DO�A��A���?  A�ȋ��E�����D���M+�u�D�E�U�E��y2A��E��E��~&A�ȋ���A������E+���D��E���D�E�U�E�~H�{L��E����   �E�A��E��������D�6�ED�Dɋ�A����E�D��E���E�D�$D�D;�rD;�s!E3�A�@A��A;�rA;�sA��D����tE�H�EH�� E�4 E;�rD;�sE�A��D�C�$��E3�G�6D�A��C�	��E+��U��D�E�E���D�e�0A�M�E��~�u��,���M+�A�M+�<5|j�A�:9uA�0M+�L;�s�L;�sM�fDE D*�A��I��D�SD�dA��H�MH3��[Y��H��$  H���   A_A^A]A\_^]�A�:0uM+�L;�s�L;�s��    A� �  fD�#fD9M��HD�[D��C�0�6���E3�E3�3�3�L�d$ �xn���E3�E3�3�3�L�d$ �cn���E3�E3�3�3�L�d$ �Nn���E3�E3�3�3�L�d$ �9n���H�\$�L$VWAVH�� Hc����u��n��� 	   �   ����   ;=� s}H��H��H��L�5v�  ��Hk�XI���L0��tW���.
  �I���D0t+���_  H����6  ��u
�t5  ���3ۅ�t��m����Bn��� 	   ������  ����)n��� 	   �Rm�����H�\$PH�� A^_^��H�\$�L$VWATAVAWH�� A��L��Hcك��u�tm���  ��m��� 	   �   ��xu;�  smH��H��H��L�%��  ��Lk�XI��B�L8��tF���G	  �I��B�D8tD��I�֋��U   ����tm��� 	   ��l���  �������
  �����l���  �Km��� 	   �tl�����H�\$XH�� A_A^A\_^����H�\$ UVWATAUAVAWH��$�����@  �����H+�H�8�  H3�H��0  E3�E��L��Hc�D�d$@A��A��E��u3��n  H��u �Ul��D� �l���    ��k������I  H��H��H�y�  H����H�L$HH��Lk�XE�d8L�l$XE�A��A�D$�<wA���Шu��k��3ɉ�A�D t3ҋ�D�B��	  �������H�|$H���@  H��  H��A�D��)  �C{��H�T$dH���   3�H9�8  ��H�D$HH���  @��H��I�L ��4  3Ʌ���  3���t	E����  �^4  I���D$h3���f�D$D�D$`E���  D��E����  �L�l$XH�f�  ��
��E3��D$dH�D$HH��E9DPtA�DL�L$m�D$lE�DPA�   H�T$l�I��������t4I��H+�I�H����  H�L$DA�   H���
  �����  H���A�   H��H�L$D�w
  �����  �L$h3�L�D$DH�D$8H�D$0H�D$lA�   3��D$(   H�D$ H����1  D����p  H�D$HH��  L�L$`H��3�H�T$lH�D$ H�D$XE��H���0  ���-  �D$@��A+��D9l$`��  E3�D9l$dtXH�D$HE�E�D$lH��  L�l$ L�l$XH��L�L$`H�T$lI�L ��0  ����   �|$`��   �D$@�L$D���o�L$D�cA�D$�<w�3�f��
D��f�L$DA��H��A�D$�<w8�I	  �L$Df;�ut��E��t!�   ��f�D$D�&	  �L$Df;�uQ���D$@L�l$X��A+�A;�sI3�������L�|$HL�%J�  K����I��A�DLK��A�DP   ��g0  ����]0  ��L�l$XH�|$H�D$@����  3ۅ���  ���l  �i��� 	   �h���0�M���H�|$H�H�|$H3�L���  I��A�D���  ��E����   M��E���*  �   �3�D�l$@H��0  H��A��A+�A;�s'A�$I��<
u�A��H��H��H���H��H���  r�H��0  D��D�l$@L�l$XD+�H�D$HI��3�L�L$PI�L H��0  H�D$ ��.  �������\$PH��0  H+�HcD$PH;������A�ĺ   L���  A+�A;��@�������A��M����   E���H  �   �3�D�l$@H��0  H��A��A+�A;�s2A�$I��f��
uf�A��H��H��H��f�H��H���  r�H��0  D��D�l$@L�l$XD+�H�D$HI��3�L�L$PI�L H��0  H�D$ ��-  �������\$PH��0  H+�HcD$PH;������A�ĺ   L���  A+�A;��5��������E���h  A�   �3�H�M�H��A��A+�A;�s/A�$I��f��
ufD�H��H��H��f�H��H���  r�H�E�3�L�E�+�H�|$8H�|$0�����  �D$(U  �+�3���D��H��0  H�D$ ��-  D����#���Hc�E��H��0  H�H�D$HH�*�  H��3�L�L$PH�D$ H�D$XD+�H���,  ��t|$PD;����3-  ��D;������A��A�   A+�A;����������I�L L�L$PE��I��H�D$ �;,  ��t�\$P��������,  ��������L�l$XH�|$H�y������Se�������H�|$HH�n�  H��A�D@t
A�>������we���    ��d�������+؋�H��0  H3��O��H��$�  H��@  A_A^A]A\_^]����H�\$WH�� ���H��H��u�e���    �Cd����F�A�t:�,���H�ˋ��V  H���F�������  ��y����H�K(H��t
�`b��H�c( �c ��H�\$0H�� _���H�\$H�L$WH�� H�ك��3�H������u�d���    �c�����&�A@t�a �������H���5�����H���C�����H�\$8H�� _���H�\$H�t$H�|$AWH�� Hc�H��H��L�=�  ��Hk�XI�<��|; u4�
   躖����|; uH�KH�E3���  �"����D;�
   耘��I��H��H��/,  �   H�\$0H�t$8H�|$@H�� A_�H�\$H�|$AVH�� ��xo;��  sgHc�L�5n�  H����H��Hk�XI���DtDH�<�t=�=W�  u'��t��t��u�����������������3��V*  I��H��3���0c��� 	   �b���  ���H�\$0H�|$8H�� A^���H��(���u�b���  ��b��� 	   �M��x1;�  s)Hc�L���  H����H��Hk�XI���DtH���Db���  �b��� 	   ��a��H���H��(�Hc�L�j�  H��H��Hk�XI��H��H�H�%�*  ��H�\$H�t$WH�� Hc�A��H����A���H���u�Bb��� 	   H����ML�D$HD��H��H���.)  ��u�4)  ����a����H��H��H���  H����H��Hk�X�d�H�D$HH�\$0H�t$8H�� _��H��H�XH�hH�pH�x AVH��PE3�I��H��H��H��tM��tD82u&H��tfD�13�H�\$`H�l$hH�t$pH�|$xH��PA^�H�L$0I���AL��H�D$0L9�8  uH��t�f��   �   �H�T$0�yu���   ��tZH�L$0D���   D;�~/A;�|*�IA��H�����SL�ƉD$(H�|$ �-(  H�L$0��uHc��   H;�r=D8vt7���   �=A��H��D����L�ƺ	   �D$(H�D$0H�|$ �H��'  ��u�`������ *   D8t$HtH�L$@���   �����������E3�����f�L$H��8H�H�  H���u�  H�6�  H���u���  �%H�d$  L�L$HH�T$@A�   ��(  ��t��D$@H��8����H�\$�L$VWAVH�� Hcك��u�_���  ��_��� 	   �   ��xe;	�  s]H��H��H��L�5��  ��Hk�XI���L0��t7���f����I���D0t���G   ����_��� 	   ��������������_���  �y_��� 	   �^�����H�\$PH�� A^_^��H�\$WH�� Hc����<���H���tYH��  �   ��u	@���   u
;�u�@`t�����   H��� ���H;�t�������H���c%  ��u
�	&  ���3ۋ��(���H��H��H����L���  I��Hk�X�D ��t���d^������3�H�\$0H�� _���@SH�� �A�H��t"�AtH�I�\���c����3�H�H�C�CH�� [��H��(H�9�  H�AH��v��$  H��(�H��HH�d$0 �d$( A�   H���  E3ɺ   @D�D$ �U$  H���  H��H���%J%  �%T&  H��H�XH�hH�pH�x AVH�� I�Y8H��M��H��L�CI��H��I���q��D�[D�UA��A��A�   A#�A��fDD�E��tL��M��H��H���
  D��H�\$0H�l$8H�t$@H�|$HA��H�� A^��H�\$H�l$VWATAVAWH�� A�xL��I��I��M��L����  M�$L����ttIcF��H��H��I_;k~�;k�I�H�T$PE3��%  LcCD�KLD$PD�3�E��tI�PHcI;�t��H��A;�r�A;�s�I�$H��IcL�H�H�H�\$XH�l$`H��H�� A_A^A\_^����H��H�XH�hH�pH�x ATAVAWH�� �zH�l$pH��H��H��E��3��  D����u����L�T$hL�D$`��A�
�A����t*L�]Lc{D�J�K��I��F;t8~F;t8~A��E��uޅ�t�B�H��HcCH�4�Hu3҅�t`E3�HcKI�HMH��t�F9~"�F9AD;!|D;aA�8�uA��BA���I��;�r�A� ���tH��HcCH��HE�
A�  A�" 3�H�\$@H�l$HH�t$PH�|$XH�� A_A^A\�H�\$H�l$VWAVH�� L�L$PI��H�������H��H��L����  �_���'���fj��H��H��(  H��HcGH�;q~;q~��u�3�H��uA����D�IL��H��I���  H�\$@H�l$HH�� A^_^�H�\$H�l$H�t$WH��@I��I��H��H����i��H��8  H���i��H�S8H�L$xL�L$p�D$8   H��0  3�H�\$0�\$(H�L$ H�L��H���%  �i��H��$�   H�l$XH�t$`H��8  �CH�\$P�   H��@_����H��L�H L�@H�PH�HSH��`H�ك`� H�H�L�@��@i��L���   H�T$H�A���D$@    � �D$@H��`[����@SH�� H��H��i��H;�   s��h��H��   �3�H�K��h��H��   H��H�� [��H�\$WH�� H����h��H;�   t�����h��H��   �	H;�tH�[H��u�����H�\$0H�� _��h��H�KH��   ����H��(�kh��H��(  H��(����H��(�Sh��H��0  H��(����@SH�� H���6h��H��   �	H9tH�RH��u�BH�� [�3�����@SH�� H���h��H��(  H�� [��@SH�� H����g��H��0  H�� [��@UH��$P���H��  H�Ю  H3�H���  L���  H�H�  L��H�L$0 H@ IH0A @@I0HPA@@`IP��   A`@pH���   Ap��   H���   I�H��  H�D$PH���  H�U�I�H�D$`Hc��  H�D$hH���  L�D$pH�D$x��   L�L$XH�E�I�B@L�D$0H�D$(H�E�E3�H�D$ H�E� ���  H���  H3��`A��H�İ  ]����H�\$H�t$WH��@I��I��H��H�T$P�f��H�SH��(  �f��H�V8H��0  �rf��H�S8D�H�T$PL��L�(  3�H�ΉD$8H�D$0�D$(L�D$ L����  H�\$XH�t$`H��@_��H��th�T$H��(�9csm�uT�yuN�A - ���wAH�A0H��t8HcP��tH��H�Q8H�H�I(�Ґ������� tH�A(H�H��tH��PH��(���@SH�� H���^Q��H��  H�H��H�� [����H�ك  H��eQ���H�\$WH�� H���  ��H��H��FQ����tH����@��H��H�\$0H�� _����H��H�XH�hVWATAVAWH��PL��$�   I��L��M��H��L�HM��H��I���s���L��$�   H��$�   H��M��tL��H��H���y  �p���HcNL��H���$�   M�ĈL$@H��$�   H�l$8�L�|$0I�ΉT$(H��H�D$ �����L�\$PI�[0I�k@I��A_A^A\_^����H�\$L�D$UVWATAUAVAWH�l$�H��   H�]gL��H��E3�I��H��M��M��D�eGD�e��  L�M�L��I��I�͋�����L��I��I���  L��I��;�~H�M�D���5  D��L��I��I���0  �
I����  �����|;s|������?csm��{  ��7  �G - ����&  L9g0�  �c��L9��   �)  �c��H���   �c��H�O8L���   �EGL�uW�}����   H���l  ��u�c����?csm�u�u�G - ���wL9g0u�=����0c��L9�  ��   �c��L��  �c��I��H��L��  �  ��uhE��E9&��  I���t���IcNH�D9dt�a���IcNH�Hc\�P���H��I��H���  H���P������  A��H��E;>|��v  L�uW�?csm��.  ��$  �G - ����  D9c�N  D�EwH�E�L�|$0H�D$(H�E�D��H��I��H�D$ �f����M��U�;��  L�pA9v���   A;v���   ����Mc&L�A�F��EÅ���   ����H�O0HcQH��H�H�E��}���H�O0HcQ��Mǅ�~7�f���H�M�L�G0Hc	H�I��H��H�E��M  ��u�E�H�E��ȉEǅ�ɋE���I��넊EoL�EWM�ψD$X�EGI�ՈD$PH�EH��H�D$H�Ew�E��D$@I�F�H�D$8H�E�H�D$0L�d$(H�\$ ������U��M���I���M�;������E3�D8e���   �%���=!�r�s ��tHc�����H��I��H��tc��t�j���H��HcC H��I��H���[  ��u?L�MGL��I��I�������MoL�EW�L$@L�|$8H�\$0�L$(�L��H��I��L�d$ �����`��L9�  t�y���H��$�   H�İ   A_A^A]A\_^]�D9cv�D8eoupH�EM��M��H�D$8�EwI�ՉD$0H�ωt$(H�\$ �L   ��A���̲H�������H�_~  H�UGH�M�H�EG�ZK��H�7~  H�Ȏ  H�M�H�E��M���������H�\$L�D$UVWATAUAVAWH��p�9  �M��I��L��H���  �_��H��$�   H���    ta3���  H���|_��H9��   tH�>MOC�t@�>RCC���$�   t8H��$�   M��L��H�D$0I��H�Ή\$(H�l$ ���������  ���$�   �} u�!���D��$�   H�D$`L�|$0H�D$(H��$�   D��E��H��I��H�D$ ������$�   ;L$`�L  H�xL�o�E;u �#  D;w��  �>���HcH��HcOH���|� t#�#���HcH��HcOH��Hc\��
���H��3�H��tJ�����HcH��HcOH���|� t#�����HcH��HcOH��Hc\������H��3��x ��   ����HcH��HcOH���D�@uh�����L��$�   �D$X �D$P��Hc�M��H��H��HcGI��H�H��$�   H�D$H��$�   �D$@L�l$8H�d$0 H�L$(H��H�l$ �Y�����$�   ��H����$�   ;L$`�����H��$�   H��pA_A^A]A\_^]����H�\$H�l$H�t$WATAUAVAWH�� H��L��H����   3�E2�9:~x�����H��I�E0LcxI��L������H��I�E0HcH�,
��~DHc�L�$�����H��IcH��|���HcNM�E0J��H��H��	  ��u��I������A���;>|�H�\$PH�l$XH�t$`A��H�� A_A^A]A\_�裼��込����HcH��z |LcJHcRI�	Lc
M�I���H�\$H�t$H�|$AVH�� I��L��A�    �tH���IcpH2�   ��t7��u[3�9_t�����H��HcGH�H�WI�N(�|���H��A�   H�����(3�9_t����Hc_H�H�WI�N(�L���H��H�����������H�\$0H�t$8H�|$@H�� A^���H�\$H�t$H�|$AUAVAWH��0M��I��H��L��3�E�xE��tMc�����I��H��H����  E��t�����H��HcCH��H��@8y��  9{u�   ���  ���x
HcCHH����yWA�tQH���  H��tE��L���   ��H���
  ���c  ��H����	  ���Q  L�>I��I�V�C���H��@  �   ��t.��I�M(��	  ���  ��H���	  ���  I�M(H��A�tQ��I�M(�	  ����   ��H���}	  ����   McFI�U(H���͢��A�~��   H9>��   H��a���A9~t�����H��IcFH��H�ϋ�H��I�M(u8�	  ��t~��H���	  ��tpIc^I�VI�M(�`���H��L��H���V����U��  ��tF��H����  ��t8A9~t�f���H��IcFH��H���  ��tA�$�����ˋ��L$ �蘹������讹���3�H�\$PH�t$XH�|$`H��0A_A^A]��@SVWATAUAVAWH��   H��E3�D�|$ D!�$�   L!|$@L!�$�   �0Y��L���   L�l$P�Y��H���   H��$�   H�wPH��$�   H�GHH�D$HH�_@H�G0H�D$XL�w(L�t$`��X��H���   ��X��H���   ��X��H���   H�R(H�L$x����L��H�D$8L9XtǄ$�      �X��H��8  H��$�   A�   I��H�L$X�  H��H�D$@H��$�   �{�D$    �TX����`   H��$�   ��$�    t!�H������H��$�   L�H D�@�P��L�N D�F�V��G  D�|$ H�\$@L�l$PH��$�   L�t$`L�d$8I���
���E��u2�>csm�u*�~u$�F - ���wH�N(�q�����t
�H���{����W��H���   �W��L���   H�D$HHcHI�H�����H��H�Đ   A_A^A]A\_^[��H��(H��8RCC�t�8MOC�t
�8csm�u� �>W����    ~�0W����   3�H��(��W����    �:�����H��D�H L�@H�PH�HSVWATAUAVAWH��0E��I��L��L���i���H�D$(L��I��I���  ����V����   �����   A;���   ���~;~|褶��Lc�� ���HcNJ���<�|$ ����HcNJ���| t�����HcNJ��Hc\�����H��3�H��t^D��L��I��I���i  �����HcNJ���| t����HcNJ��Hc\����H��3�A�  I��H���*  H�L$(������D��$�   H��$�   L�l$xL�|$p�|$ �|$$�
�����U����    ~�U����   ���t
A;�~觵��D��L��I��I���  H��0A_A^A]A\_^[���H�\$H�l$H�t$WATAVH��@I��M��H��H���SU��H��$�   ��`   ����A�)  �A�&  �A�   u8�;csm�t0D9u�{u
H�{` �tD9t�#ʁ�"�r
D�g$�  �C�f��   � �j  ��$�    �\  �� t>D9u9M���   H��H���0  �؃��|;G|諴��D��H��H��L�������  ��t D9u�s8���|;w|�z���H�K(D����L��H��H��������   � u.�#�=!���   �  t�����HcO H��3�H����   �;csm�um�{rg�{ "�v^H�C0�x t����H�K0LcQL��E3�M��t:��$�   L��M�ƉD$8H��$�   H��H�D$0��$�   H�ˉD$(H�|$ A���<H��$�   L��M��H�D$8��$�   H�։D$0��$�   H�ˈD$(H�|$ �����A��H�\$`H�l$hH�t$pH��@A^A\_�H��H�XH�hH�pH�x AVH�� �q3�M��H��H����tHc�����H��H��H����   ��tHcw����H��H��8Y��   ��t
�E ��   ��t�h���H��HcGH��H���l���H��HcEH�H;�t:9_t�;���H��HcGH��H���?���HcUH�NH��H��'x����t3��9��E t�t$A�t�tA�t�tA�t�t�   ����   H�\$0H�l$8H�t$@H�|$HH�� A^����H��(McHH�M��A����uL�I���   H��(��@SH�� L�L$@I���Q���H�HcCH�L$@�DH�� [����IcPH�D��H�\$WH�� A��L�L$@I������H�HcCH�L$@;|~�|H�\$0H�� _��L��    H�\$H�l$H�t$WH�� I��H��H��H��u�e���HcC�{HFu�S���E3���t4L�NLcSK��JcI�H;�|A��D;�r�E��tA�H�I��B�D����H�\$0H�l$8H�t$@H�� _�H���������������������������ff�     H��(H�L$0H�T$8D�D$@H�H���ҳ���������H��H�T$8H�A�   赳��H��(�H�$H����������H��@   �,��@UH�� H��H�}@ u�=%�  �t�BR���H�� ]��@UH�� H��H�M@H���U0H�M8�U(�}xuL���   3�H�Mp��6���H�U8�M(�1X���H�� ]��@UH�� H��   H�� ]�]u���@UH�� H��   H�� ]�Du���@UH�� H��   H�� ]�+u���@UH�� H��   H�� ]�u���@UH�� H�ꃽ�    t�   ��t���H�� ]��@UH�� H��   ��t���H�� ]��@UH�� H��H���  H�� ]H�%~  �@UH�� H��   H�� ]�t���������������@UH�� H��H�3Ɂ8  �����H�� ]��@UH�� H��H�� ]�Z���@UH�� H��}` t3��Ft���H�� ]��@UH�� H��HcM H��H�o�  H��足���H�� ]��@UH�� H��   H�� ]��s���@UH�� H��   H�� ]��s���@UH�� H��MPH�� ]�����@UH�� H��H�M0H�� ]������@UH�� H��
   H�� ]�s���@UH�� H��M@H�� ]�R����@UH��@H��H�E@H�D$0H���   H�D$(H���   H�D$ L���   L�ExH�Up������H��@]��@UH�� H��H�MpH�MhH�EhH�H�M(�E     H�E(�8csm�uMH�E(�xuCH�E(�x  �tH�E(�x !�tH�E(�x "�uH�U(H���   H�H(H9J(u�E    H�E(�8csm�u[H�E(�xuQH�E(�x  �tH�E(�x !�tH�E(�x "�u*H�E(H�x0 u�M��ǀ`     �E    �E0   ��E0    �E0H�� ]��@SUH��(H��H�M8������}  u:H���   �;csm�u+�{u%�C - ���wH�K(�S�����t�H���]�����L��H���   H���   �pL��H�MPH���   H��(][��@UH�� H��3�8E8��H�� ]��@UH�� H��������H�� ]��@UH�� H���!L����    ~�L����   H�� ]��                                                                                                                                                                                                                                                                                      h�     v�     ��     ��     ��     ��     ��     ̛     �     ��     �     *�     :�     H�     X�     h�     x�     ��     ��     ��     ��     Ԝ     �     ��     �      �     �     �     Z�     j�     ��     ��     ��     ��     ؝     �     ��     �     �     *�     6�     H�     R�     ^�     j�     x�     ��     ��     ��     ��     Ҟ     �     �     �     6�     P�     d�     ~�     ��     ��     ̟     ��     ��     �     �     *�     8�     B�     P�     h�     ��     ��     ��     ��     Ơ     Ҡ     �     ��     ,�             B�                                     �] �   �� �   D� �   �� �                   �l �   \� �   �� �                                    ��   PD �   �U �   bad allocation          ���    ��   ���    U �   �U �   Unknown exception       csm�                           �                            Ȉ�   W �   �#�    $�   $�    $�   j a - J P       z h - C N       k o - K R       z h - T W   Sun Mon Tue Wed Thu Fri Sat Sunday  Monday  Tuesday Wednesday       Thursday    Friday      Saturday    Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec     January February    March   April   June    July    August      September       October November        December    AM  PM      MM/dd/yy        dddd, MMMM dd, yyyy     HH:mm:ss        S u n   M o n   T u e   W e d   T h u   F r i   S a t   S u n d a y     M o n d a y     T u e s d a y   W e d n e s d a y       T h u r s d a y         F r i d a y     S a t u r d a y         J a n   F e b   M a r   A p r   M a y   J u n   J u l   A u g   S e p   O c t   N o v   D e c   J a n u a r y   F e b r u a r y         M a r c h       A p r i l       J u n e         J u l y         A u g u s t     S e p t e m b e r       O c t o b e r   N o v e m b e r         D e c e m b e r     A M     P M         M M / d d / y y         d d d d ,   M M M M   d d ,   y y y y   H H : m m : s s         e n - U S               	
 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~ �l �             �             �           �  �           �  �           �  �           �  �           �  �           �  �           �  �           �  �           � �           � �              �      	   m s c o r e e . d l l   CorExitProcess  k e r n e l 3 2 . d l l         FlsAlloc        FlsFree FlsGetValue     FlsSetValue     InitializeCriticalSectionEx     CreateEventExW  CreateSemaphoreExW      SetThreadStackGuarantee CreateThreadpoolTimer   SetThreadpoolTimer      WaitForThreadpoolTimerCallbacks CloseThreadpoolTimer    CreateThreadpoolWait    SetThreadpoolWait       CloseThreadpoolWait     FlushProcessWriteBuffers        FreeLibraryWhenCallbackReturns  GetCurrentProcessorNumber       GetLogicalProcessorInformation  CreateSymbolicLinkW     SetDefaultDllDirectories        EnumSystemLocalesEx     CompareStringEx GetDateFormatEx GetLocaleInfoEx GetTimeFormatEx GetUserDefaultLocaleName        IsValidLocaleName       LCMapStringEx   GetCurrentPackageId     GetTickCount64  GetFileInformationByHandleExW   SetFileInformationByHandleW            .�          p.�   	       �.�   
       0/�          �/�          �/�          @0�          �0�          �0�          `1�          �1�           2�          �2�          �2�           3�           �3�   !       `4�   "       P6�   x       �6�   y       �6�   z       �6�   �       7�   �        7�   R 6 0 0 2  
 -   f l o a t i n g   p o i n t   s u p p o r t   n o t   l o a d e d  
         R 6 0 0 8  
 -   n o t   e n o u g h   s p a c e   f o r   a r g u m e n t s  
               R 6 0 0 9  
 -   n o t   e n o u g h   s p a c e   f o r   e n v i r o n m e n t  
           R 6 0 1 0  
 -   a b o r t ( )   h a s   b e e n   c a l l e d  
             R 6 0 1 6  
 -   n o t   e n o u g h   s p a c e   f o r   t h r e a d   d a t a  
           R 6 0 1 7  
 -   u n e x p e c t e d   m u l t i t h r e a d   l o c k   e r r o r  
         R 6 0 1 8  
 -   u n e x p e c t e d   h e a p   e r r o r  
                 R 6 0 1 9  
 -   u n a b l e   t o   o p e n   c o n s o l e   d e v i c e  
                 R 6 0 2 4  
 -   n o t   e n o u g h   s p a c e   f o r   _ o n e x i t / a t e x i t   t a b l e  
         R 6 0 2 5  
 -   p u r e   v i r t u a l   f u n c t i o n   c a l l  
       R 6 0 2 6  
 -   n o t   e n o u g h   s p a c e   f o r   s t d i o   i n i t i a l i z a t i o n  
         R 6 0 2 7  
 -   n o t   e n o u g h   s p a c e   f o r   l o w i o   i n i t i a l i z a t i o n  
         R 6 0 2 8  
 -   u n a b l e   t o   i n i t i a l i z e   h e a p  
         R 6 0 3 0  
 -   C R T   n o t   i n i t i a l i z e d  
     R 6 0 3 1  
 -   A t t e m p t   t o   i n i t i a l i z e   t h e   C R T   m o r e   t h a n   o n c e . 
 T h i s   i n d i c a t e s   a   b u g   i n   y o u r   a p p l i c a t i o n .  
             R 6 0 3 2  
 -   n o t   e n o u g h   s p a c e   f o r   l o c a l e   i n f o r m a t i o n  
             R 6 0 3 3  
 -   A t t e m p t   t o   u s e   M S I L   c o d e   f r o m   t h i s   a s s e m b l y   d u r i n g   n a t i v e   c o d e   i n i t i a l i z a t i o n 
 T h i s   i n d i c a t e s   a   b u g   i n   y o u r   a p p l i c a t i o n .   I t   i s   m o s t   l i k e l y   t h e   r e s u l t   o f   c a l l i n g   a n   M S I L - c o m p i l e d   ( / c l r )   f u n c t i o n   f r o m   a   n a t i v e   c o n s t r u c t o r   o r   f r o m   D l l M a i n .  
     R 6 0 3 4  
 -   i n c o n s i s t e n t   o n e x i t   b e g i n - e n d   v a r i a b l e s  
     D O M A I N   e r r o r  
     S I N G   e r r o r  
         T L O S S   e r r o r  
    
         r u n t i m e   e r r o r       R u n t i m e   E r r o r ! 
 
 P r o g r a m :         < p r o g r a m   n a m e   u n k n o w n >     . . .   
 
             M i c r o s o f t   V i s u a l   C + +   R u n t i m e   L i b r a r y                                                                                                                                                                                                                                                                                           ( ( ( ( (                                     H                � � � � � � � � � �        � � � � � �                           � � � � � �                                                                                                                                                                                                                                                                                                               ( ( ( ( (                                     H                � � � � � � � � � �        ������      ������                                                                                                                    �������������������������������������������������������������������������������������������������������������������������������� 	
 !"#$%&'()*+,-./0123456789:;<=>?@abcdefghijklmnopqrstuvwxyz[\]^_`abcdefghijklmnopqrstuvwxyz{|}~���������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������������� 	
 !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`ABCDEFGHIJKLMNOPQRSTUVWXYZ{|}~��������������������������������������������������������������������������������������������������������������������������������u k     A             �\�          �\�          �\�          �\�          �\�          �\�          �\�          �\�   	       �\�   
        ]�          ]�          ]�          ]�           ]�          (]�          0]�          8]�          @]�          H]�          P]�          X]�          `]�          h]�          p]�          x]�          �]�          �]�          �]�          �]�          �]�           �]�   !       �]�   "        @�   #       �]�   $       �]�   %       �]�   &       �]�   '       �]�   )       �]�   *       �]�   +       �]�   ,       �]�   -        ^�   /       ^�   6       ^�   7       ^�   8        ^�   9       (^�   >       0^�   ?       8^�   @       @^�   A       H^�   C       P^�   D       X^�   F       `^�   G       h^�   I       p^�   J       x^�   K       �^�   N       �^�   O       �^�   P       �^�   V       �^�   W       �^�   Z       �^�   e       �^�          �^�         �^�         �^�         �^�          $�         �^�         _�         _�         (_�   	      �'�         8_�         H_�         X_�         h_�         x_�         �_�         �#�         $�         �_�         �_�         �_�         �_�         �_�         �_�         �_�         `�         `�         (`�         8`�         H`�          X`�   !      h`�   "      x`�   #      �`�   $      �`�   %      �`�   &      �`�   '      �`�   )      �`�   *      �`�   +      �`�   ,      a�   -       a�   /      0a�   2      @a�   4      Pa�   5      `a�   6      pa�   7      �a�   8      �a�   9      �a�   :      �a�   ;      �a�   >      �a�   ?      �a�   @      �a�   A       b�   C      b�   D      (b�   E      8b�   F      Hb�   G      Xb�   I      hb�   J      xb�   K      �b�   L      �b�   N      �b�   O      �b�   P      �b�   R      �b�   V      �b�   W      �b�   Z      c�   e      c�   k      (c�   l      8c�   �      Hc�         Xc�          $�         hc�   	      xc�   
      �c�         �c�         �c�         �c�         �c�         �c�         �c�          d�   ,      d�   ;      (d�   >      8d�   C      Hd�   k      `d�         pd�         �d�         �d�   	      �d�   
      �d�         �d�         �d�   ;      �d�   k      �d�         e�         e�         (e�   	      8e�   
      He�         Xe�         he�   ;      xe�         �e�         �e�         �e�   	      �e�   
      �e�         �e�         �e�   ;       f�         f�   	       f�   
      0f�         @f�         Pf�   ;      hf�         xf�   	      �f�   
      �f�         �f�   ;      �f�          �f�   	       �f�   
       �f�   ;        g�   $      g�   	$       g�   
$      0g�   ;$      @g�   (      Pg�   	(      `g�   
(      pg�   ,      �g�   	,      �g�   
,      �g�   0      �g�   	0      �g�   
0      �g�   4      �g�   	4      �g�   
4       h�   8      h�   
8       h�   <      0h�   
<      @h�   @      Ph�   
@      `h�   
D      ph�   
H      �h�   
L      �h�   
P      �h�   |      �h�   |      �h�   �^�   B       ^�   ,       �h�   q       �\�           �h�   �       �h�   �       �h�   �       i�   �       i�   �       (i�   �       8i�   �       Hi�   �       Xi�   �       hi�   �       xi�   �       �i�   �       �i�   C       �i�   �       �i�   �       �i�   �       �]�   )       �i�   �       �i�   k       �]�   !       j�   c       �\�          j�   D       (j�   }       8j�   �       �\�          Pj�   E       �\�          `j�   G       pj�   �       �\�          �j�   H       �\�          �j�   �       �j�   �       �j�   I       �j�   �       �j�   �       �^�   A       �j�   �       �\�          �j�   J       �\�           k�   �       k�   �        k�   �       0k�   �       @k�   �       Pk�   �       `k�   �       pk�   �       �k�   �       �k�   �       �k�   K       �k�   �       �k�   �        ]�   	       �k�   �       �k�   �       �k�   �        l�   �       l�   �        l�   �       0l�   �       @l�   �       Pl�   �       `l�   �       pl�   �       �l�   �       �l�   �       �l�   �       �l�   �       �l�   �       �l�   �       �l�   �       �l�   �       �]�   #        m�   e        ^�   *       m�   l       �]�   &        m�   h       ]�   
       0m�   L        ^�   .       @m�   s       ]�          Pm�   �       `m�   �       pm�   �       �m�   M       �m�   �       �m�   �       �^�   >       �m�   �       h^�   7       �m�          ]�          �m�   N       (^�   /       �m�   t       x]�          �m�   �        n�   Z        ]�          n�   O       �]�   (        n�   j       �]�          0n�   a       (]�          @n�   P       0]�          Pn�   �       `n�   Q       8]�          pn�   R       ^�   -       �n�   r       8^�   1       �n�   x       �^�   :       �n�   �       @]�          �^�   ?       �n�   �       �n�   S       @^�   2       �n�   y       �]�   %       �n�   g       �]�   $       �n�   f        o�   �       ^�   +       o�   m        o�   �       �^�   =       0o�   �       �^�   ;       @o�   �       0^�   0       Po�   �       `o�   w       po�   u       �o�   U       H]�          �o�   �       �o�   T       �o�   �       P]�          �o�   �       `^�   6       �o�   ~       X]�          �o�   V       `]�          �o�   W        p�   �       p�   �        p�   �       0p�   �       h]�          @p�   X       p]�          Pp�   Y       �^�   <       `p�   �       pp�   �       �p�   v       �p�   �       �]�          �p�   [       �]�   "       �p�   d       �p�   �       �p�   �       �p�   �       �p�   �        q�   �       q�   �       �]�           q�   \       �h�   �       0q�   �       Hq�   �       `q�   �       xq�   �       �]�          �q�   �       �q�   ]       H^�   3       �q�   z       �^�   @       �q�   �       p^�   8       �q�   �       x^�   9       �q�   �       �]�          �q�   ^        r�   n       �]�          r�   _       X^�   5        r�   |        @�           0r�   b       �]�          @r�   `       P^�   4       Pr�   �       hr�   {       �]�   '       �r�   i       �r�   o       �r�          �r�   �       �r�   �       �r�   �       �r�   �       �r�   �        s�   F       s�   p       a r     b g     c a     z h - C H S     c s     d a     d e     e l     e n     e s     f i     f r     h e     h u     i s     i t     j a     k o     n l     n o     p l     p t     r o     r u     h r     s k     s q     s v     t h     t r     u r     i d     b e     s l     e t     l v     l t     f a     v i     h y     a z     e u     m k     a f     k a     f o     h i     m s     k k     k y     s w     u z     t t     p a     g u     t a     t e     k n     m r     s a     m n     g l     k o k   s y r   d i v           a r - S A       b g - B G       c a - E S       c s - C Z       d a - D K       d e - D E       e l - G R       f i - F I       f r - F R       h e - I L       h u - H U       i s - I S       i t - I T       n l - N L       n b - N O       p l - P L       p t - B R       r o - R O       r u - R U       h r - H R       s k - S K       s q - A L       s v - S E       t h - T H       t r - T R       u r - P K       i d - I D       u k - U A       b e - B Y       s l - S I       e t - E E       l v - L V       l t - L T       f a - I R       v i - V N       h y - A M       a z - A Z - L a t n     e u - E S       m k - M K       t n - Z A       x h - Z A       z u - Z A       a f - Z A       k a - G E       f o - F O       h i - I N       m t - M T       s e - N O       m s - M Y       k k - K Z       k y - K G       s w - K E       u z - U Z - L a t n     t t - R U       b n - I N       p a - I N       g u - I N       t a - I N       t e - I N       k n - I N       m l - I N       m r - I N       s a - I N       m n - M N       c y - G B       g l - E S       k o k - I N     s y r - S Y     d i v - M V     q u z - B O     n s - Z A       m i - N Z       a r - I Q       d e - C H       e n - G B       e s - M X       f r - B E       i t - C H       n l - B E       n n - N O       p t - P T       s r - S P - L a t n     s v - F I       a z - A Z - C y r l     s e - S E       m s - B N       u z - U Z - C y r l     q u z - E C     a r - E G       z h - H K       d e - A T       e n - A U       e s - E S       f r - C A       s r - S P - C y r l     s e - F I       q u z - P E     a r - L Y       z h - S G       d e - L U       e n - C A       e s - G T       f r - C H       h r - B A       s m j - N O     a r - D Z       z h - M O       d e - L I       e n - N Z       e s - C R       f r - L U       b s - B A - L a t n     s m j - S E     a r - M A       e n - I E       e s - P A       f r - M C       s r - B A - L a t n     s m a - N O     a r - T N       e n - Z A       e s - D O       s r - B A - C y r l     s m a - S E     a r - O M       e n - J M       e s - V E       s m s - F I     a r - Y E       e n - C B       e s - C O       s m n - F I     a r - S Y       e n - B Z       e s - P E       a r - J O       e n - T T       e s - A R       a r - L B       e n - Z W       e s - E C       a r - K W       e n - P H       e s - C L       a r - A E       e s - U Y       a r - B H       e s - P Y       a r - Q A       e s - B O       e s - S V       e s - H N       e s - N I       e s - P R       z h - C H T     s r     a f - z a       a r - a e       a r - b h       a r - d z       a r - e g       a r - i q       a r - j o       a r - k w       a r - l b       a r - l y       a r - m a       a r - o m       a r - q a       a r - s a       a r - s y       a r - t n       a r - y e       a z - a z - c y r l     a z - a z - l a t n     b e - b y       b g - b g       b n - i n       b s - b a - l a t n     c a - e s       c s - c z       c y - g b       d a - d k       d e - a t       d e - c h       d e - d e       d e - l i       d e - l u       d i v - m v     e l - g r       e n - a u       e n - b z       e n - c a       e n - c b       e n - g b       e n - i e       e n - j m       e n - n z       e n - p h       e n - t t       e n - u s       e n - z a       e n - z w       e s - a r       e s - b o       e s - c l       e s - c o       e s - c r       e s - d o       e s - e c       e s - e s       e s - g t       e s - h n       e s - m x       e s - n i       e s - p a       e s - p e       e s - p r       e s - p y       e s - s v       e s - u y       e s - v e       e t - e e       e u - e s       f a - i r       f i - f i       f o - f o       f r - b e       f r - c a       f r - c h       f r - f r       f r - l u       f r - m c       g l - e s       g u - i n       h e - i l       h i - i n       h r - b a       h r - h r       h u - h u       h y - a m       i d - i d       i s - i s       i t - c h       i t - i t       j a - j p       k a - g e       k k - k z       k n - i n       k o k - i n     k o - k r       k y - k g       l t - l t       l v - l v       m i - n z       m k - m k       m l - i n       m n - m n       m r - i n       m s - b n       m s - m y       m t - m t       n b - n o       n l - b e       n l - n l       n n - n o       n s - z a       p a - i n       p l - p l       p t - b r       p t - p t       q u z - b o     q u z - e c     q u z - p e     r o - r o       r u - r u       s a - i n       s e - f i       s e - n o       s e - s e       s k - s k       s l - s i       s m a - n o     s m a - s e     s m j - n o     s m j - s e     s m n - f i     s m s - f i     s q - a l       s r - b a - c y r l     s r - b a - l a t n     s r - s p - c y r l     s r - s p - l a t n     s v - f i       s v - s e       s w - k e       s y r - s y     t a - i n       t e - i n       t h - t h       t n - z a       t r - t r       t t - r u       u k - u a       u r - p k       u z - u z - c y r l     u z - u z - l a t n     v i - v n       x h - z a       z h - c h s     z h - c h t     z h - c n       z h - h k       z h - m o       z h - s g       z h - t w       z u - z a   e+000               U S E R 3 2 . D L L     MessageBoxW     GetActiveWindow GetLastActivePopup      GetUserObjectInformationW       GetProcessWindowStation         �v�   �v�   �v�    w�   w�    w�   0w�   @w�   Lw�   Xw�   `w�   pw�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�   �w�    x�   x�   x�   x�   x�   x�   x�   x�    x�   $x�   (x�   ,x�   0x�   4x�   8x�   <x�   @x�   Dx�   Hx�   Xx�   hx�   px�   �x�   �x�   �x�   �x�   �x�    y�    y�   @y�   `y�   �y�   �y�   �y�   �y�   z�   8z�   Hz�   Lz�   Xz�   hz�   �z�   �z�   �z�   �z�   �z�   �z�    {�   H{�   p{�   �{�   �{�   �{�   |�   @|�   p|�   �w�   �|�   �|�   �|�   �|�    }�   __based(        __cdecl __pascal        __stdcall       __thiscall      __fastcall      __vectorcall    __clrcall   __eabi      __ptr64 __restrict      __unaligned     restrict(    new         delete =   >>  <<  !   ==  !=  []      operator    ->  *   ++  --  -   +   &   ->* /   %   <   <=  >   >=  ,   ()  ~   ^   |   &&  ||  *=  +=  -=  /=  %=  >>= <<= &=  |=  ^=  `vftable'       `vbtable'       `vcall' `typeof'        `local static guard'    `string'        `vbase destructor'      `vector deleting destructor'    `default constructor closure'   `scalar deleting destructor'    `vector constructor iterator'   `vector destructor iterator'    `vector vbase constructor iterator'     `virtual displacement map'      `eh vector constructor iterator'        `eh vector destructor iterator' `eh vector vbase constructor iterator'  `copy constructor closure'      `udt returning' `EH `RTTI       `local vftable' `local vftable constructor closure'  new[]       delete[]       `omni callsig'  `placement delete closure'      `placement delete[] closure'    `managed vector constructor iterator'   `managed vector destructor iterator'    `eh vector copy constructor iterator'   `eh vector vbase copy constructor iterator'     `dynamic initializer for '      `dynamic atexit destructor for '        `vector copy constructor iterator'      `vector vbase copy constructor iterator'        `managed vector copy constructor iterator'      `local static thread guard'      Type Descriptor'        Base Class Descriptor at (      Base Class Array'       Class Hierarchy Descriptor'     Complete Object Locator'   1#SNAN  1#IND   1#INF   1#QNAN      C O N O U T $   S L P o l i c y         Policy query: %S
      Policy rewrite: %i
    Policy result: %i
     Policy request failed
 >>> CSLQuery::Initialize
      %d.%d.%d.%d-SLInit      bServerSku.x64  bRemoteConnAllowed.x64  bFUSEnabled.x64 bAppServerAllowed.x64   bMultimonAllowed.x64    lMaxUserSessions.x64    ulMaxDebugSessions.x64  bInitialized.x64        bServerSku  SLInit      SLInit [0x%p] bServerSku = %d
 bRemoteConnAllowed      SLInit [0x%p] bRemoteConnAllowed = %d
 bFUSEnabled     SLInit [0x%p] bFUSEnabled = %d
        bAppServerAllowed       SLInit [0x%p] bAppServerAllowed = %d
  bMultimonAllowed        SLInit [0x%p] bMultimonAllowed = %d
   lMaxUserSessions        SLInit [0x%p] lMaxUserSessions = %d
   ulMaxDebugSessions      SLInit [0x%p] ulMaxDebugSessions = %d
 bInitialized    SLInit [0x%p] bInitialized = %d
       <<< CSLQuery::Initialize
      Loading configuration...
      r d p w r a p . i n i   Configuration file: %S
        Error: Failed to load configuration
   LogFile Main    r d p w r a p . t x t   Initializing RDP Wrapper...
   t e r m s r v . d l l   Error: Failed to load Terminal Services library
       ServiceMain     SvchostPushServiceGlobals       Base addr:  0x%p
SvcMain:    termsrv.dll+0x%p
SvcGlobals: termsrv.dll+0x%p
  Error: Failed to detect Terminal Services version
     Version:    %d.%d.%d.%d
       Freezing threads...
   SLPolicyHookNT60        s l c . d l l   SLGetWindowsInformationDWORD    Hook SLGetWindowsInformationDWORD
     SLPolicyHookNT61        %d.%d.%d.%d     LocalOnlyPatch.x64      Patch CEnforcementCore::GetInstanceOfTSLicense
        LocalOnlyOffset.x64     LocalOnlyCode.x64       PatchCodes      SingleUserPatch.x64     Patch CSessionArbitrationHelper::IsSingleSessionPerUserEnabled
        SingleUserOffset.x64    SingleUserCode.x64      DefPolicyPatch.x64      Patch CDefPolicy::Query
       DefPolicyOffset.x64     DefPolicyCode.x64       SLPolicyInternal.x64    Hook SLGetWindowsInformationDWORDWrapper
      SLPolicyOffset.x64      New_Win8SL      SLPolicyFunc.x64        SLInitHook.x64  Hook CSLQuery::Initialize
     SLInitOffset.x64        New_CSLQuery_Initialize SLInitFunc.x64  Resumimg threads...
   >>> ServiceMain
       <<< ServiceMain
       >>> SvchostPushServiceGlobals
 <<< SvchostPushServiceGlobals
 "�   �            $� H                  )  �                           �                                                                                                                    ��   @��   h�   �U �   bad exception           p                                                                                        ��                   ��         ����    @   ��                        �         Ї                        �� H�  �                            `�         x� Ї                 ��        ����    @   H�                        �� �� ��                             � �� Ȉ                            �         �              �         ����    @   ��                         � h� @�                            ��         �� Ї                  �        ����    @   h�                                              d 4 2p T
 4	 2�p`! � �    �� !   �    �� " H 	�p`P0  xm  0  ! �Q �P �O 0  U  (� !   �Q 0  U  (� !   0  U  (� 
 t	 d T 4 2�
 
4	 
2p! � d T P  �  �� !   �  d  T P  �  �� ! 4L F p`P  xm      4I F p  xm     ! dH    o  �� !      o  ��  4� � p  xm     $ d� 4� � p  xm      
4 
�pxm  H    b  xm  (   $ d1 40 , p  xm  P  $ d/ 4. * p  xm  @  8 'tR 'dQ '4P 'J ����P  xm  @  @ /t�+d�'4���
���P  ��  `� �  ����p �-  ����7/      �/  ����
 
4 
2p 20    r0 d T 4 r����p
 T 4 r���p`(
 4 ����
�p`Pxm  p    t d T 4 ����
 
20��     eP  �P  |     	 4 ��p`��     �Q  eR  � iR  	 	b   d 4 2p t 4 �P/	 t� d� 4� � P  xm  �   20��     ;]  Q]  6     
 
4 
2p��     2a  �a  �     
 � t
 d	 4 R�     �b  �c  �     %
 T 4 r���p`xm  8    d T 4 2p+ t� 4� � P  xm  p   d �	�pP 4 2p��      h  Mh       _h  �h       
 
4 
2p��     �i  	j       j  Ej        4 �pxm  x    �p`0xm  x    2p��     �l  �l  6      B     
 d 4 r����p��     �t  �u  O        �  t  d  4   ���  ��     �v  �v  s     �v  ky  s      d 4
 Rp d
 T	 4 Rp 4	 2P
 t d T 4
 r�
 
4 
rp rp`0
 t	 d T 4 2� d T 4 r����p- dQ TP 4O J ��p  xm  @   t 4 2ࠇ     ��  ٍ  �             R0��     �  T�  �            
 
20 2
0 d 4 �p-Et d 4 C�
����P  xm  H    d 4 �p-5t d 4 3r
����P  xm  0   - t d 4 �����Pxm  X   * 4  ���
�p`P  xm  �                  d 4 �p �   b   R0 t d T 4 ����  p`P0xm  p    d T 4 �����p 	�p`P0  xm  `    ��p`P0xm  p   	
 
4 
2p��     �  P�  � P�   2P
 t
 d	 4 2�����     ��  ��  �     	 B  ��     -�  1�     1�  	 B  ��     �  �     �  
 d 4 R����p��     ��  W�        �           d 4
 rp ��	��p`P0xm  H    d T 4 p       
 d T 4 ��p � t �P "    p`0Pxm  p    4 
 t d 4
 R��Р�     ��  �  "     ��  1�  J      d	 4 Rp��     z�  ��  c     * 4!  ���
�p`P  xm  �    4
 2�p
`��     G�  ��  �      4 2���p
`��     .�  a�  |     6 %4s%h���
�p`P  xm  0   4 2p��     S�  ]�  �      t 4 2� t d 4 2�     ��  ��  �     
 t d T 4 �� 4
 2�p
`��     �  3�  �      T	 4 2�p`" � P  xm  �  	 �0��     ��  ��  � ��   rP t d
 T	 4 2���
 T 4 2���p` d 4 rp d T 4
 rp	  �
���p`0  ��     j � ! � j 
       BP0  " "R����p`0��     k  �  3 ) �     ! !4 ! ����p`P  
 T 4 ����p`	 t d 4 2ࠇ     �      
 4 �����p`P	 B  ��     �  �   d T 4
 2����p
 d T 4 r��p	
 t d 4
 R��Р�     � a    e  B      �C      h�                    �� ��                ��     ����       �C                  ��     ����       �T                  X     �                    � ��                  �     ����       4                 Y��T    l�          X� `� h� �B  0C  v� ��    BTREE.dll ServiceMain SvchostPushServiceGlobals ؘ         4�    X�         N� �"                     h�     v�     ��     ��     ��     ��     ��     ̛     �     ��     �     *�     :�     H�     X�     h�     x�     ��     ��     ��     ��     Ԝ     �     ��     �      �     �     �     Z�     j�     ��     ��     ��     ��     ؝     �     ��     �     �     *�     6�     H�     R�     ^�     j�     x�     ��     ��     ��     ��     Ҟ     �     �     �     6�     P�     d�     ~�     ��     ��     ̟     ��     ��     �     �     *�     8�     B�     P�     h�     ��     ��     ��     ��     Ơ     Ҡ     �     ��     ,�             B�             � CreateFileW BGetFileSize SReadFile  SetLastError  
SetFilePointer  �WriteFile  CloseHandle lGetModuleHandleExW  GetCurrentThreadId  GetCurrentProcessId � CreateToolhelp32Snapshot  ~Thread32First �OpenThread  �ResumeThread  gSuspendThread Thread32Next  mGetModuleHandleW  �FindResourceW �LoadResource  �LoadLibraryExW  �WriteProcessMemory  GetCurrentProcess iGetModuleFileNameW  �LoadLibraryW  �GetProcAddress  VReadProcessMemory KERNEL32.dll  �wsprintfA USER32.dll  VGetLastError  �WideCharToMultiByte �MultiByteToWideChar �GetCommandLineA jIsDebuggerPresent pIsProcessorFeaturePresent 8HeapAlloc %EncodePointer � DecodePointer �RtlPcToFileHeader CRaiseException  <HeapFree  uIsValidCodePage �GetACP  �GetOEMCP  �GetCPInfo WExitProcess �GetProcessHeap  �GetStdHandle  EGetFileType DeleteCriticalSection �GetStartupInfoW hGetModuleFileNameA  0QueryPerformanceCounter �GetSystemTimeAsFileTime .GetEnvironmentStringsW  �FreeEnvironmentStringsW �RtlCaptureContext �RtlLookupFunctionEntry  �RtlVirtualUnwind  �UnhandledExceptionFilter  PSetUnhandledExceptionFilter QInitializeCriticalSectionAndSpinCount _Sleep nTerminateProcess  �TlsAlloc  �TlsGetValue �TlsSetValue �TlsFree �RtlUnwindEx )EnterCriticalSection  �LeaveCriticalSection  �GetStringTypeW  �LCMapStringW  ?HeapReAlloc �OutputDebugStringW  AHeapSize  �FlushFileBuffers  �GetConsoleCP  �GetConsoleMode  .SetStdHandle  SetFilePointerEx  �WriteConsoleW                                                                                                                                                                                                     2��-�+  �] �f���                                 	               	      
                                                !      5      A      C      P      R      S      W      Y      l      m       p      r   	         �   
   �   
   �   	   �      �      �   )   �      �      �      �      �      �      �                                                                                                                                                                                                                                                                                                                                        abcdefghijklmnopqrstuvwxyz      ABCDEFGHIJKLMNOPQRSTUVWXYZ                                                                                                                                                                                                                                                                                                                                                                                                                                                                     abcdefghijklmnopqrstuvwxyz      ABCDEFGHIJKLMNOPQRSTUVWXYZ                                                                                                                                                        �  `�y�!       ��      ��      ����    @~��    �  ��ڣ                        ��      @�      �  ��ڣ                        ��      A�      �  Ϣ� ��[                 ��      @~��    Q  Q�^�  _�j�2                 ������  1~��    ���   ����   C               ,$�   0$�   4$�   8$�   <$�   @$�   D$�   H$�   P$�   X$�   `$�   p$�   |$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   �$�   %�   %�    %�   0%�   <%�   @%�   H%�   X%�   p%�          �%�   �%�   �%�   �%�   �%�   �%�   �%�   �%�   �%�   �%�   �%�    &�   &�   (&�   @&�   H&�   P&�   X&�   `&�   h&�   p&�   x&�   �&�   �&�   �&�   �&�   �&�   �&�   �&�   �&�   `&�   �&�   �&�   '�   '�   0'�   @'�   X'�   l'�   t'�   �'�   �'�   �'�   �'�   ���                                                                  ���                           ���                           ���                           ���                           ���                                                 н�                   9�   �=�    ?�   ж�                                                   ���   ���   ����    ;�   u�  s�  ���������
                                                                              ����                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            �        h��   0��   0��   0��   0��   0��   0��   0��   0��   0��   l��   4��   4��   4��   4��   4��   4��   4��   .   .   н�      ���5      @   �  �   ����             9�   ;�           |� �   |� �   |� �   |� �   |� �   |� �   |� �   |� �   |� �   |� �   ���           ���                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           �@         �@         �@        @�@        P�@        $�@       ���@        ��@     ���4@   ������N@ �p+��ŝi@�]�%��O�@q�וC�)��@���D�����@�<զ��Ix��@o�����G���A��kU'9��p�|B�ݎ�����~�QC��v���)/��&D(�������D������Jz��Ee�Ǒ����Feu��uv�HMXB䧓9;5���SM��]=�];���Z�]�� �T��7a���Z��%]���g����'���]݀nLɛ� �R`�%u    �����������?q=
ףp=
ף�?Zd;�O��n��?��,e�X���?�#�GG�ŧ�?@��il��7��?3=�Bz�Ք���?����a�w̫�?/L[�Mľ����?��S;uD����?�g��9E��ϔ?$#�⼺;1a�z?aUY�~�S|�_?��/�����D?$?��9�'��*?}���d|F��U>c{�#Tw����=��:zc%C1��<!��8�G�� ��;܈X��ㆦ;ƄEB��u7�.:3q�#�2�I�Z9����Wڥ����2�h��R�DY�,%I�-64OS��k%�Y����}�����ZW�<�P�"NKeb�����}�-ޟ���ݦ�
   ��������        \ r d p w r a p . t x t                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         �#�           .?AVbad_alloc@std@@     �#�           .?AVexception@std@@     �#�           .?AVtype_info@@ �#�           .?AVbad_exception@std@@                                                                                                                                                                                                                                                                                                                                                                                                                                                           �  �� �    ��     �   ,  � 0  U  (� U  �  D� �  0  `� 0  �  t� �  L  �� P  �  �� �  (  �� (  �  Ċ    �  ��    o  �� o  c  � c  4  (� @  =   8� @   �!  P� �!  u"  l� �"  �"  �� �"  �$  �� �$  �%  �� �%  �-  ȋ �-  �B  �� �B  "C  <� 0C  uC  H� �C  �C  P� �C  �C  H� �C  MD  T� PD  �D  <� �D  <E  H� <E  �G  \� �G  �G  d� �G  �I  x� �I  (J  d� (J  VM  �� `M  �M  H� �M  �O  �� �O  Q  ̌ Q  YQ  �� \Q  |R  � |R  �R  H� �R  �S  � �S  RT  �� TT  �T  H� �T  �T  H� �T   U  <�  U  YU  <� \U  �U  � �U  �U  H� �U  'V  H� 0V  �V  ,� �V  W  �� W  QW  <� TW  �W  t� �W  �X  <� �X  �X  t� �X  Y  d� Y  SY  �� TY  tY  �� tY  �Y  <� �Y  �Y  �� �Z  V\  �� �\  q]  \� t]  �]  <� �]   ^  ��  ^  }^  T� �^  _  �� _  �`  � �`  �a  |� �a  �c  �� �c  �f  Ѝ �f  g   � �g  �h  0� �h  �h  H� �h  i  H� i  �i  <� �i  Zj  d� \j  �j  H� �j   k  ��  k  �k  �� �k  �l  �� �l  �l  �� xm  �m  �� �m  �m  H� �m  ?n  T� @n  �n  T� �n  Ho  � Ho  q  �� (q  iq  H� lq  �q  H� �q  �r  <� �r  �r  H� s  �s  H� �s  �s  H� �s  Tt  �� Tt  �t  <� �t  =v  � @v  `v  �� lv  �y  � �y  z  �� z  {  d� {  �|  d� �|  �}  t�  ~  �~  �� �~  �  �� �  �  �� �  ��  �� �  �  ��  �  l�  H� l�  f�  H� p�  ��  H� ��  ��  H� ��  /�  ď 0�  ��  ď ��  -�  ď 0�  h�  <� h�  ��  <� ��  ��  ܏ ��  ω  ��  �  o�  �� p�  ��  <� ��  ;�  �� <�  ��  � ��  ]�  �� ��  ��  H� ��  d�  L� ��  ��  p� ��  ��  |� ��  (�  t� (�  "�  |� $�  �  �� �  ��  �� ��  �  ̐  �  ��  �� ��  R�  �� T�  
�  �� �  m�  � ��  G�  @� `�  Ŷ  H� ȶ  M�  H� P�  ��  H� ط  ��  H� ��  .�  ď 0�  b�  �� d�  �  L� L�  p�  \� p�  �  d� �  ��  �� ��  ��  t� ��  ��  �� ��  ��  �� ��  ��  đ ��   �  ܑ �  ��  T� ��  ��  l� ��  o�  T� ��  ��  <� �  ]�  �� ��  ��  H� ��  ��   � ��  ��  �� ��  �  p� �  7�  P� 8�  U�  �� ��  ��  �� ��  �  �� �  (�  Ȓ 0�  1�  ̒ @�  A�  В D�  ��  <� ��  �  �� �  q�  H� t�  ��  H� �  ��  Ԓ ��  {�  �� |�  �  <� �  X�  �� X�  ��  � ��  p�   � ��  ��  � ��  ��   � ��  n�  T� p�  ��  8� ��  (�  H� (�  ��  <� ��  ��  h� ��  {�  P� ��  ��  �� ��  �  �� �  B�  �� D�  ��  �� ��  ��  H� ��  i�  �� x�  ^�  p� `�  �  �� �  ��  ؓ ��  ��  �� ��  ��  $� ��  ��  P� ��  
�  <� �  r�  t� t�  �  �� �  ��  �� ��  ,�  �� X�  ��  �� ��  =�  Ԕ H�  ��  � ��  g�  � h�  "�  <� $�  [�  H� \�  |�  �� |�  ��  \� ��  S�  ď T�  �  ��  �  L�  d� L�  ��  � ��  ��  �� ��  ��  <� ��    H�   z  <� |  �  �� �  �  �� �  �  H� �  �  H� �   H�  9 (� < � �� � 2 �� 4 U H� h � <� � e `� h 	 D� 	 � �� � [ ܖ � 6 x� 8 � � � � �� � � �� � r � t � �� � � ď � � �� �  H� ( c <� l � ��   ` @� | � � � � � �  �   �  6 � 6 O � O s � s � � � � � � � � � � � �  �  " � " J � J c � c | � | � � � � � � � � � � � � ! \� !  �  � �� � � � � � � � � �                                                                                                                                                                                                                                                                                                                                         �    ���T        0  �    ���T     	  H   X  �          �4   V S _ V E R S I O N _ I N F O     ���                                         �    S t r i n g F i l e I n f o   �    0 4 0 9 0 0 0 0   :   C o m p a n y N a m e     S t a s ' M   C o r p .     l "  F i l e D e s c r i p t i o n     T e r m i n a l   S e r v i c e s   W r a p p e r   L i b r a r y   0   F i l e V e r s i o n     1 . 5 . 0 . 0   0   I n t e r n a l N a m e   R D P W r a p   `   L e g a l C o p y r i g h t   C o p y r i g h t   �   S t a s ' M   C o r p .   2 0 1 4   B   L e g a l T r a d e m a r k s     S t a s ' M   C o r p .     @   O r i g i n a l F i l e n a m e   r d p w r a p . d l l   B   P r o d u c t N a m e     R D P   H o s t   S u p p o r t     4   P r o d u c t V e r s i o n   1 . 5 . 0 . 0   @   C o m m e n t s   h t t p : / / s t a s c o r p . c o m   D     V a r F i l e I n f o     $    T r a n s l a t i o n     	                                             d   ��������آ���� �@�H�P�X�`���ȣУأ��p�����Ȭج�����(�8�H�X�h�x���������ȭح����   @   8�H�X�h�x���������Ƞؠ�����(�8�H�X�h�x���������ȡء�����(�8�H�X�h�x���������Ȣآ�����(�8�H�X�h�x���������ȣأ�����(�8�H�X�h�x���������Ȥؤ�����(�8�H�X�h�x���������ȥإ�����(�8�H�X�h�x���������Ȧئ�����(�8�H�X�h�x���������ȧا�����(�8�H�X�h�x���������Ȩب�����(�8�H�X�h�x���������ȩة�����(�8�H�X�h�x���������Ȫت�����(�8�H�X�h�x���������ȫث�����(�8�H�X�h�x���������Ȭج�����(�8�H�X�h�x���������ȭح�����(�8�H�X�h�p�����������Ю�� �� �0�@�P�`�p�����������Я��   P �   �� �0�@�P�`�p�����������Р�� �� �0�@�P�`�p�����������С�� �� �0�@�P�`�p�����������Т�� �� �0�@�P�`�p�����������У�� �� �0�@�P�`�p�����������Ф�� �� �0�@�P�`�p�����������Х�� �� �0�@�P�`�p�����������Ц�� �� �0�@�P�`�p�����������Ч�� �� �0�@�P�`�p�����������Ш�� �� �0�@�P�`�p�����������Щ�� �� �0�@�P�`�p�����������Ъ�� �� �0�@�P�`�p�����������Ы�� �� �0�@�P�`�p�������   p �   ��ȣУأ����� ���� �(�0�8�@�H�P�X�`�h�p�x�������������������ȤФؤ����� ���� �(�0�8�@�H�P�X�`�h�p�x�������������������ȥХإ����� ���� �(�0�8�@�H�P�X�`�h�p�x�������������������ȦЦ   �    (�0�8�@���   �   ��Цئ����� ���� �(�0�8�@�H�P�X�`�h�p�x�������������������ȧЧا����� ���� �0�8�@�H�P�X�`�h�p�x�������������������ȨШب����� ���� �(�0�8�@�H�P�X�`�h�p�x�������ة���8�X������������� ��Эح����� ����(�0�8�@�H�P�X�`�p�������ȮЮخ����� ��� �   �    ��ا � �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            �      �� ��       	        �4   V S _ V E R S I O N _ I N F O     ���                                         �    S t r i n g F i l e I n f o   �    0 4 0 9 0 0 0 0   :   C o m p a n y N a m e     S t a s ' M   C o r p .     d   F i l e D e s c r i p t i o n     R D P   W r a p p e r   L i b r a r y   I n s t a l l e r   0   F i l e V e r s i o n     2 . 2 . 0 . 0   2 	  I n t e r n a l N a m e   R D P W I n s t     `   L e g a l C o p y r i g h t   C o p y r i g h t   �   S t a s ' M   C o r p .   2 0 1 4   B   L e g a l T r a d e m a r k s     S t a s ' M   C o r p .     B   O r i g i n a l F i l e n a m e   R D P W I n s t . e x e     B   P r o d u c t N a m e     R D P   H o s t   S u p p o r t     4   P r o d u c t V e r s i o n   1 . 5 . 0 . 0   @   C o m m e n t s   h t t p : / / s t a s c o r p . c o m   D     V a r F i l e I n f o     $    T r a n s l a t i o n     	  e      �� ��       	        <assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">
  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
    <security>
      <requestedPrivileges>
        <requestedExecutionLevel level="requireAdministrator" uiAccess="false"></requestedExecutionLevel>
      </requestedPrivileges>
    </security>
  </trustInfo>
</assembly>   