;QssStylesheetEditor Installer, compiled by nsis mui2
;Author: lileilei
;lastedited: 2021.7


;!pragma warning error all ;������Ϊ����
;����һ�������������ݵ�7zѹ��������ִ���ļ�ͷ����ʹ7-zip�򿪿������������ݡ�
!system '>blank set/p=MSCF<nul'
!packhdr temp.dat 'cmd /c Copy /b temp.dat /b + blank && del blank'
SetCompress force ;ʼ��ѹ��,��ѹ���ᱻ360��Malware.QVM06.GEN����
SetCompressor /SOLID /FINAL lzma  ;ʹ��zip�ᱻ360��Ϊ���� ;/FINAL ����ߵ��õ� SetCompressor ���ᱻ���ԡ�
                           ;/SOLID ���е����ݽ���ѹ����һ��������������ѹ���ʡ�ʹ��SOLIDʱ��SetCompress������Ч
                           

/*** �곣������������ ***/
;--------------------------------
;constant, var definition

    ;user constant
    ;!define tst ;��ʾ���ԣ���������ļ�����Լʱ��
    #!define bin "bin" ;��ʽ���ɰ汾;
    !define bit "x64" ; x64 or x32;

    !define ProductName "QssStylesheetEditor"  ;��Ʒ��������Ŀ����ͬ
    !define StartFile "AppStart" ;.exe�ļ���,���������exe����
    !define Version "1.8" ;�汾
    !define Publisher "lileilei" ;������
    !define Website "https://github.com/hustlei/QssStylesheetEditor" ;��վ��ַ
    !define Year "2023"
    !define Brand "hustlei,${Year} @wuhan" ;Ʒ��,��������
    
    ;��Դ
    #!define LICENSE "License.rtf"
    !define ICON "img\install.ico" ;��װ��ͼ��
    !define HEADER "img\header.bmp"
    !define SIDE "img\side.bmp"
    !define ICON_UN "img\uninstall.ico" ;ж��appͼ��
    !define HEADER_UN "${NSISDIR}\Contrib\Graphics\Header\orange-uninstall.bmp"
    !define SIDE_UN "${NSISDIR}\Contrib\Graphics\Wizard\orange-uninstall.bmp"
    
    !define DOCEXT1 "qss"
    !define DOCEXT2 "qsst"
    !define DOCTYPE "qssfile"
    !define DOCDESC "qt stylesheet file"
    !define DOCICON "$INSTDIR\scripts\res\qss.ico"

    ;ע���Ĭ����
    !define REGKEY_ROOT "HKCU" ;ע���λ��,HKM HKCU
    !define REGKEY_APPPATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${ProductName}.exe" ;���λ��ע���keyֵ������.exe������ʲô������ProductName
    !define REGKEY_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall\${ProductName}" ;ж��ע���key
    
;--------------------------------
;user Variables
    
    Var StartMenuDir


/*** ���� ***/
;--------------------------------
;General Settings

    Unicode true ;Properly display all languages (Installer will not work on Windows 95, 98 or ME!)
    Name "${ProductName} ${Version}" ;����
    OutFile "..\dist\${ProductName}${Version}_win_${bit}_Installer.exe" ;��װ������
    InstallDir "$PROGRAMFILES64\${ProductName}" ;installerλ��;$PROGRAMFILES��64λ�����Ͽ��ܻᰲװ��x86�ļ����ڡ�
    InstallDirRegKey ${REGKEY_ROOT} "${REGKEY_UNINST}" "UninstallString"  ;����Ѿ���װ�˱����������ע�����Ұ�װĿ¼��ʹ�ø�ֵ������InstallDir
    RequestExecutionLevel admin ;Request application privileges for Windows Vista, user����д�ļ���program files�ļ���


;--------------------------------
;File property, all property using default lang
   
    VIAddVersionKey "ProductName" "${ProductName}"
    VIAddVersionKey "ProductVersion" "${Version}.0.0"
    VIAddVersionKey "FileDescription" "${ProductName} Installer"
    VIAddVersionKey "FileVersion" "${Version}.0.0" ;���ȼ�VIFileVersion>VIVersion>FileVersion����������ֻ��ʾһ��
    VIAddVersionKey "Comments" "${ProductName} ${Version}"
    VIAddVersionKey "CompanyName" "${Publisher}"
    ;VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "${ProductName} is a trademark of ${ProductPbulisher}" ;�̱�
    VIAddVersionKey "LegalCopyright" "Copyright (C) ${Year} ${Publisher}" ;��Ȩ

    VIProductVersion "${Version}.0.0" ;���붨�����VIFileVersion���ܱ���ͨ��
    VIFileVersion "${Version}.0.0"
    
;--------------------------------
;Interface Configuration

    ;UI constant
    !define MUI_ICON ${ICON} ; ���ð�װ��ͼ��
    !define MUI_UNICON ${ICON_UN} ;����ж��ͼ��
    !define MUI_BGCOLOR F3F3F3 ; ���û�ӭ�����ҳ�汳��ɫ
    !define MUI_WELCOMEFINISHPAGE_BITMAP ${SIDE} ;��ӭ�ͽ���ҳ������ͼƬ(�Ƽ��ߴ�: 164x314 ����).
    !define MUI_UNWELCOMEFINISHPAGE_BITMAP ${SIDE_UN} ;����ж��ҳ������ͼƬ(�Ƽ��ߴ�: 164x314 ����).
    !define MUI_HEADERIMAGE ;����HeadͼƬ
    !define MUI_HEADERIMAGE_BITMAP ${HEADER}
    #!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
    !define MUI_HEADERIMAGE_UNBITMAP ${HEADER_UN}
    BrandingText "${Brand}" ;����ҳ�涼��ʾ��brand��Ϣ
    !define MUI_STARTMENUPAGE_DEFAULTFOLDER ${ProductName} ;Ĭ�Ͽ�ʼ�˵��ļ�������
    
    ;Language Selection Dialog Settings    
    ;Remember the installer language
    !ifndef tst
        !define MUI_LANGDLL_REGISTRY_ROOT "${REGKEY_ROOT}"
        !define MUI_LANGDLL_REGISTRY_KEY "Software\${ProductName}"
        !define MUI_LANGDLL_REGISTRY_VALUENAME "Installer Language"
    !endif
    
    ;UI Settings
    !define MUI_COMPONENTSPAGE_SMALLDESC ;˵��λ�����ѡ����·�����Ƚ�Сmyui.exe��Ч  
    !define MUI_ABORTWARNING ;���û�Ҫ�رհ�װ����ʱ, ��ʾһ��������Ϣ��
    !define MUI_UNABORTWARNING ;���û�Ҫ�ر�ж�س���ʱ, ��ʾһ��������Ϣ��
    !define MUI_FINISHPAGE_NOAUTOCLOSE ;���Զ��������ҳ��, �����û���鰲װ��¼
    !define MUI_UNFINISHPAGE_NOAUTOCLOSE ;���Զ��������ҳ��, �����û����ж�ؼ�¼


/*** ��װ���� ***/
;--------------------------------
;Include

    !include "MUI2.nsh" ;MUI �ִ����涨�� (1.67 �汾���ϼ���)
    !include "Assoc.nsh"
    !include "x64.nsh"
    #!include "nsDialogs.nsh"
    #!include "WordFunc.nsh"
    

;--------------------------------
;install pages

    #!define MUI_PAGE_CUSTOMFUNCTION_SHOW show ;��ӭҳ�����ú���
    !insertmacro MUI_PAGE_WELCOME ;1.��ӭҳ��

    !insertmacro MUI_PAGE_LICENSE $(LICENSE) ;2.���Э��ҳ��
    
    !insertmacro MUI_PAGE_COMPONENTS ;3.���ѡ��ҳ��
    ShowInstDetails show ;�����Ƿ���ʾ��װ��ϸ��Ϣ�����������ʹ�� SetDetailsView �������������á�
    ShowUnInstDetails show
    #ChangeUI IDD_SELCOM myui.exe ;�޸�ѡ�����ҳ���ui,myui.exeĬ��˵���������,�ռ�Ƚϴ�
    
    #!define MUI_PAGE_CUSTOMFUNCTION_SHOW shownet ;4.�Զ��尲װҳ��
    
    !insertmacro MUI_PAGE_STARTMENU Application $StartMenuDir ;5.ѡ���Ƿ񴴽���ʼ�˵���ݷ�ʽ
      
    !insertmacro MUI_PAGE_DIRECTORY ;6.��װĿ¼ѡ��ҳ��
    !insertmacro MUI_PAGE_INSTFILES ;7.��װ����ҳ��
    
    !define MUI_FINISHPAGE_RUN "$INSTDIR\${StartFile}.exe" ;����ҳ���Ƿ���ʾ���г���ѡ��
    !define MUI_FINISHPAGE_RUN_NOTCHECKED ;��װ��ɺ��Ƿ�����Ӧ�ó��� checkbox Ϊ��ѡ��״̬
    !insertmacro MUI_PAGE_FINISH ;8.��װ���ҳ��

;--------------------------------
;uninstall pages

    ;!insertmacro MUI_UNPAGE_WELCOME
    #!insertmacro MUI_UNPAGE_CONFIRM
    ;!insertmacro MUI_UNPAGE_LICENSE ${LICENSE}
    ;!insertmacro MUI_UNPAGE_COMPONENTS
    ;!insertmacro MUI_UNPAGE_DIRECTORY
    !insertmacro MUI_UNPAGE_INSTFILES ;ж�ع���ҳ��
    ;!insertmacro MUI_UNPAGE_FINISH


;--------------------------------
;Languages

    !insertmacro MUI_LANGUAGE "English"
    !insertmacro MUI_LANGUAGE "SimpChinese"
    #!insertmacro MUI_LANGUAGE "French"
    #!insertmacro MUI_LANGUAGE "German"
    #!insertmacro MUI_LANGUAGE "Italian"
    #!insertmacro MUI_LANGUAGE "Spanish"
    #!insertmacro MUI_LANGUAGE "Russian"
    #!insertmacro MUI_LANGUAGE "Japanese"
    #!insertmacro MUI_LANGUAGE "Korean"
    #!insertmacro MUI_LANGUAGE "TradChinese"

    LicenseLangString LICENSE ${LANG_ENGLISH} "License.rtf"
    LicenseLangString LICENSE ${LANG_SIMPCHINESE} "License.zh_cn.rtf"
    # http://blog.sina.com.cn/s/blog_6aeaee7e0100smr3.html

    
;--------------------------------
;Reserve Files

    ;If you are using solid compression, files that are required before
    ;the actual installation should be stored first in the data block,
    ;because this will make your installer start faster.

    !insertmacro MUI_RESERVEFILE_LANGDLL ;Ԥ���ͷ�����ѡ��Ի�����Դ
    #!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
    #ReserveFile "my.dll"   ;�����ʹ���˹�ʵѹ������װǰʹ�õ��ļ����봢�������ݿ�Ŀ�ʼ����������İ�װ���������ĸ��졣
                            ;��������κͺ���֮ǰ��Ϊ��Щ�ļ�ʹ��Ԥ���ļ����



/*** ��װѡ��ļ� ***/
;--------------------------------
; intall type

    !ifndef NOINSTTYPES
        LangString default  ${LANG_ENGLISH} "Default"
        LangString default  ${LANG_SIMPCHINESE} "���Ͱ�װ"
        LangString full     ${LANG_ENGLISH} "Full"
        LangString full     ${LANG_SIMPCHINESE} "��ȫ��װ"
        LangString minimal  ${LANG_ENGLISH} "Minimal"
        LangString minimal  ${LANG_SIMPCHINESE} "��С��װ"
        
        InstType $(Default) ;����
        InstType $(Full) ;��ȫ
        InstType $(Minimal) ;��С��
        #�Զ�����Ĭ�Ͼ��еģ�����Ҫ�Լ����
    !endif

;--------------------------------
;Sections

    ;;;multi-lang stirngs
    LangString name_sec1 ${LANG_ENGLISH} "Core Files(required)"
    LangString desc_sec1 ${LANG_ENGLISH} "Core files for ${ProductName} program."
    LangString name_sec4 ${LANG_ENGLISH} "File Association"
    LangString desc_sec4 ${LANG_ENGLISH} "Assciate qss and qsst file to .qss .qsst ext."
    LangString name_sec1 ${LANG_SIMPCHINESE} "�����ļ�(����)"
    LangString desc_sec1 ${LANG_SIMPCHINESE} "${ProductName} ������Ҫ�ļ���"
    LangString name_sec4 ${LANG_SIMPCHINESE} "�ļ�����"
    LangString desc_sec4 ${LANG_SIMPCHINESE} "����.qss,.qsst�ļ���"


    ;;;Sections
    
    Section !$(name_sec1) section1 ;��ʾ���� ID  !��ʾ�Ӵ�
      SectionIn 1 2 3 RO   #�ڵ�1 2 3��instType�ڣ�ROָ�����޸�
      SetOverwrite ifnewer
      SetOutPath "$INSTDIR"
      !ifndef tst
        File /r /x ".git" "..\dist\build\*.*"
      !endif
      Sleep 1000
    SectionEnd
    
    ; Section "Examples"  section2
    ; SectionEnd
    
    ; Section "Language Files" section3
    ; SectionEnd

    Section $(name_sec4) section4
        SectionIn 1 2
        !insertmacro Assoc "${DOCEXT1}" "${DOCTYPE}" "${DOCDESC}" "$INSTDIR\${StartFile}.exe" "${DOCICON}"
        !insertmacro Assoc "${DOCEXT2}" "${DOCTYPE}" "${DOCDESC}" "$INSTDIR\${StartFile}.exe" "${DOCICON}"
        System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
        Sleep 500
    SectionEnd
    
    Section -AdditionalIcons ;"Start Menu and Shortcuts"     ;-��ʾ����
        SetOutPath "$INSTDIR"
        ;desktop shortcut
        CreateShortCut "$DESKTOP\${ProductName}.lnk" "$INSTDIR\${StartFile}.exe"
        
        ;Start Menu
        !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
            CreateDirectory "$SMPROGRAMS\$StartMenuDir"
            CreateShortCut "$SMPROGRAMS\$StartMenuDir\${ProductName}.lnk" "$INSTDIR\${StartFile}.exe"
            WriteIniStr "$INSTDIR\${ProductName}.url" "InternetShortcut" "URL" "${Website}"
            CreateShortCut "$SMPROGRAMS\$StartMenuDir\Website.lnk" "$INSTDIR\${ProductName}.url"
            CreateShortCut "$SMPROGRAMS\$StartMenuDir\Uninstall.lnk" "$INSTDIR\uninst.exe"
        !insertmacro MUI_STARTMENU_WRITE_END
    SectionEnd
    
    Section -Post ;ж�س���,ע���
        WriteUninstaller "$INSTDIR\uninst.exe"
        
        !ifndef tst
            WriteRegStr ${REGKEY_ROOT} "${REGKEY_APPPATH}" "${ICON}" "$INSTDIR\${StartFile}.exe"
            WriteRegStr ${REGKEY_ROOT} "${REGKEY_UNINST}" "DisplayName" "$(^Name)"
            WriteRegStr ${REGKEY_ROOT} "${REGKEY_UNINST}" "UninstallString" "$INSTDIR\uninst.exe"
            #WriteRegStr ${REGKEY_ROOT} "${REGKEY_UNINST}" "DisplayIcon" "$INSTDIR\bin\rc4net.dll"    #
            WriteRegStr ${REGKEY_ROOT} "${REGKEY_UNINST}" "DisplayVersion" "${Version}"
            WriteRegStr ${REGKEY_ROOT} "${REGKEY_UNINST}" "URLInfoAbout" "${Website}"
            WriteRegStr ${REGKEY_ROOT} "${REGKEY_UNINST}" "Publisher" "${Publisher}"
        !endif
    SectionEnd

;--------------------------------
;��������

    !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
        !insertmacro MUI_DESCRIPTION_TEXT ${section1} $(desc_sec1)
        !insertmacro MUI_DESCRIPTION_TEXT ${section4} $(desc_sec4)
    !insertmacro MUI_FUNCTION_DESCRIPTION_END


;--------------------------------
;Uninstall Section

    Section Uninstall
        
        ;ɾ��ע���
        DeleteRegKey ${REGKEY_ROOT} "${REGKEY_APPPATH}"
        DeleteRegKey ${REGKEY_ROOT} "${REGKEY_UNINST}"
        DeleteRegKey /ifempty ${REGKEY_ROOT} "Software\${ProductName}" ;������ѡ��ע���
        
        ;Ϊ�˷���������û�й����ļ���ʽ������ȡ������
        !insertmacro UnAssoc ${DOCEXT1}
        !insertmacro UnAssoc ${DOCEXT2}
        System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
        
        ;ɾ��������
        Delete "$INSTDIR\${ProductName}.url"
        Delete "$INSTDIR\${ProductName}.exe"
        RMDir /r "$INSTDIR\*.*"
        
        ;ɾ����ʼ�˵�
        !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuDir
        DetailPrint $StartMenuDir
        Delete "$SMPROGRAMS\$StartMenuDir\${ProductName}.lnk"
        Delete "$SMPROGRAMS\$StartMenuDir\Website.lnk"
        Delete "$SMPROGRAMS\$StartMenuDir\Uninstall.lnk"
        RMDir "$SMPROGRAMS\$StartMenuDir"
        
        ;ɾ�������ݷ�ʽ
        Delete "$DESKTOP\${ProductName}.lnk"
        
        Delete "$INSTDIR\uninst.exe"
        RMDir "$INSTDIR"
        
        #SetAutoClose true
    SectionEnd


/*** �ص��������Զ��庯�� ***/
;--------------------------------
;multi-lang string
       
    LangString langTitle ${LANG_SIMPCHINESE} "Installer Language"
    LangString langTitle ${LANG_ENGLISH} "Installer Language"
    LangString langInfo ${LANG_SIMPCHINESE} "��ѡ��װ����ʹ�õ����ԣ�"
    LangString langInfo ${LANG_ENGLISH} "Please select a language:"
    !define MUI_LANGDLL_WINDOWTITLE $(langTitle)
    !define MUI_LANGDLL_INFO $(langInfo)

    LangString msgRuning ${LANG_SIMPCHINESE} "��װ�����Ѿ�������"
    LangString msgRuning ${LANG_ENGLISH} "Installer is running."
    LangString msgUninstConfirm ${LANG_SIMPCHINESE} "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е����?"
    LangString msgUninstConfirm ${LANG_ENGLISH} "Do you want to remove $(^Name) ��and all its components?"
    LangString msgUninstSuccess ${LANG_SIMPCHINESE} "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
    LangString msgUninstSuccess ${LANG_ENGLISH} "$(^Name) was removed."

;--------------------------------
;Function��������ڶ�ӦSection����֮���Ա��ⰲװ�������δ��Ԥ֪�����⡣

    Function .onInit
        #��ֹ�����װ����ʵ��
        System::Call 'kernel32::CreateMutexA(i 0, i 0, t "JWBClient") i .r1 ?e'
        Pop $R0
        StrCmp $R0 0 +3
        MessageBox MB_OK|MB_ICONEXCLAMATION $(msgRuning)
        Abort
        
        !include "Library.nsh"
        ${If} ${RunningX64}
            #${EnableX64FSRedirection} ;����û����
        ${Else}
        MessageBox MB_OK "Sorry this application runs only on x64 machines"
        Abort
        ${EndIf}
        ; ${If} bin == "x64"
            ; !define x64
        ; ${ElseIf} bin == "x32"
            ; !define x32
        ; ${EndIf}
   
        !insertmacro MUI_LANGDLL_DISPLAY ;����ѡ��Ի���        
    FunctionEnd

    Function un.onInit
        ; !insertmacro MUI_UNGETLANGUAGE ;��ȡע������������ѡ��
        MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 $(msgUninstConfirm) IDYES +2
        Abort
    FunctionEnd

    Function un.onUninstSuccess
        HideWindow
        MessageBox MB_ICONINFORMATION|MB_OK $(msgUninstSuccess)
    FunctionEnd
