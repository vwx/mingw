;MyEmacs Setup Script
;--------------------------------

;!pragma warning error all
;!pragma warning warning 7010 ; File /NonFatal

!ifdef VER_MAJOR & VER_MINOR
  !define /ifndef VER_REVISION 0
  !define /ifndef VER_BUILD 0
!endif

!define /ifndef VERSION 'anonymous-build'

;--------------------------------
;Configuration

!if ${NSIS_PTR_SIZE} > 4
  !define BITS 64
  !define NAMESUFFIX " (64 bit)"
!else
  !define BITS 32
  !define NAMESUFFIX " (32 bit)"
!endif

!ifndef OUTFILE
  !define OUTFILE ".\myemacs${BITS}-${VERSION}-setup.exe"
  !searchreplace OUTFILE "${OUTFILE}" myemacs32 myemacs
!endif

OutFile "${OUTFILE}"
Unicode true
SetCompressor /SOLID lzma

InstType "Full"
InstType "Lite"
InstType "Minimal"

;;InstallDir $PROGRAMFILES${BITS}\MyEmacs
InstallDir $DESKTOP\MyEmacs
InstallDirRegKey HKLM Software\MyEmacs ""

RequestExecutionLevel user

;--------------------------------
;Header Files

!include "MUI2.nsh"
!include "Sections.nsh"
!include "LogicLib.nsh"
!include "Memento.nsh"
!include "WordFunc.nsh"

;--------------------------------
;Definitions

!define SHCNE_ASSOCCHANGED 0x8000000
!define SHCNF_IDLIST 0

;--------------------------------
;Configuration
!define MyEmacsDIR "."

;Names
Name "MyEmacs"
Caption "MyEmacs ${VERSION}${NAMESUFFIX} Setup"

!define REG_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\MyEmacs"

;Memento Settings
!define MEMENTO_REGISTRY_ROOT HKLM
!define MEMENTO_REGISTRY_KEY "${REG_UNINST_KEY}"

;Interface Settings
!define MUI_ABORTWARNING

!define MUI_ICON "${MyEmacsDIR}\orange-install.ico"
!define MUI_UNICON "${MyEmacsDIR}\orange-uninstall.ico"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "${MyEmacsDIR}\orange-r.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${MyEmacsDIR}\orange.bmp"

!define MUI_COMPONENTSPAGE_SMALLDESC

;Pages
!define MUI_WELCOMEPAGE_TITLE "Welcome to the MyEmacs ${VERSION} Setup Wizard"
!define MUI_WELCOMEPAGE_TEXT "This wizard will guide you through the installation of MyEmacs (Nullsoft Scriptable Install System) ${VERSION}, the next generation of the Windows installer and uninstaller system that doesn't suck and isn't huge.$\r$\n$\r$\nMyEmacs includes a Modern User Interface, LZMA compression, support for multiple languages and an easy plug-in system.$\r$\n$\r$\n$_CLICK"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "..\COPYING"
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
Page custom PageReinstall PageLeaveReinstall
!endif
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_LINK "Visit the MyEmacs site for the latest news, FAQs and support"
!define MUI_FINISHPAGE_LINK_LOCATION "http://myemacs.sf.net/"

!define MUI_FINISHPAGE_RUN "$INSTDIR\bin\runemacs.exe"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT

!define MUI_FINISHPAGE_SHOWREADME
!define MUI_FINISHPAGE_SHOWREADME_TEXT "Show release notes"
!define MUI_FINISHPAGE_SHOWREADME_FUNCTION ShowReleaseNotes

!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Version information

!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
VIProductVersion ${VER_MAJOR}.${VER_MINOR}.${VER_REVISION}.${VER_BUILD}
VIAddVersionKey "FileVersion" "${VERSION}"
VIAddVersionKey "FileDescription" "MyEmacs Setup"
VIAddVersionKey "LegalCopyright" "http://myemacs.sf.net/License"
!endif

;--------------------------------
;Installer Sections

!macro InstallPlugin pi
  !if ${BITS} >= 64
    File "/oname=$InstDir\Plugins\amd64-unicode\${pi}.dll" ..\Plugins\amd64-unicode\${pi}.dll
  !else
    File "/oname=$InstDir\Plugins\x86-ansi\${pi}.dll" ..\Plugins\x86-ansi\${pi}.dll
    File "/oname=$InstDir\Plugins\x86-unicode\${pi}.dll" ..\Plugins\x86-unicode\${pi}.dll
  !endif
!macroend

${MementoSection} "MyEmacs Core Files (required)" SecCore

  SetDetailsPrint textonly
  DetailPrint "Installing MyEmacs Core Files..."
  SetDetailsPrint listonly

  SectionIn 1 2 3 RO
  SetOutPath $INSTDIR
  RMDir /r $SMPROGRAMS\MyEmacs

  SetOverwrite on
  !if /FileExists "..\COPYING"
    File ..\COPYING
  !endif

  SetOutPath $INSTDIR\Bin
  !if /FileExists "..\runemacs.exe"
    File ..\runemacs.exe
  !endif

  CreateDirectory $INSTDIR\Plugins\x86-ansi
  CreateDirectory $INSTDIR\Plugins\x86-unicode
  !if ${BITS} >= 64
    CreateDirectory $INSTDIR\Plugins\amd64-unicode
  !endif

  ReadRegStr $R0 HKCR ".myemacs" ""
  StrCmp $R0 "MyEmacsFile" 0 +2
    DeleteRegKey HKCR "MyEmacsFile"

  WriteRegStr HKCR ".myemacs" "" "MyEmacs.Script"
  WriteRegStr HKCR ".myemacs" "PerceivedType" "text"
  WriteRegStr HKCR "MyEmacs.Script" "" "MyEmacs Script File"
  WriteRegStr HKCR "MyEmacs.Script\DefaultIcon" "" "$INSTDIR\bin\runemacs.exe,1"
  ReadRegStr $R0 HKCR "MyEmacs.Script\shell\open\command" ""
  ${If} $R0 == ""
    WriteRegStr HKCR "MyEmacs.Script\shell" "" "open"
    WriteRegStr HKCR "MyEmacs.Script\shell\open\command" "" '$INSTDIR\bin\runemacs.exe "%1"'
  ${EndIf}
  WriteRegStr HKCR "MyEmacs.Script\shell\edit" "" "Edit"
  WriteRegStr HKCR "MyEmacs.Script\shell\edit\command" "" '"$INSTDIR\bin\runemacs.exe" "%1"'

  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, p0, p0)'

${MementoSectionEnd}

${MementoSection} "Script Examples" SecExample

  SetDetailsPrint textonly
  DetailPrint "Installing Script Examples..."
  SetDetailsPrint listonly

  SectionIn 1 2
  SetOutPath $INSTDIR\Examples

${MementoSectionEnd}

!ifndef NO_STARTMENUSHORTCUTS
${MementoSection} "Start Menu and Desktop Shortcuts" SecShortcuts

  SetDetailsPrint textonly
  DetailPrint "Installing Start Menu and Desktop Shortcuts..."
  SetDetailsPrint listonly

!else
${MementoSection} "Desktop Shortcut" SecShortcuts

  SetDetailsPrint textonly
  DetailPrint "Installing Desktop Shortcut..."
  SetDetailsPrint listonly

!endif
  SectionIn 1 2
  SetOutPath $INSTDIR
!ifndef NO_STARTMENUSHORTCUTS
  CreateShortcut "$SMPROGRAMS\MyEmacs${NAMESUFFIX}.lnk" "$INSTDIR\bin\runemacs.exe"
!endif

  CreateShortcut "$DESKTOP\MyEmacs${NAMESUFFIX}.lnk" "$INSTDIR\bin\runemacs.exe"

${MementoSectionEnd}


SectionGroup "User Interfaces" SecInterfaces

${MementoSection} "Modern User Interface" SecInterfacesModernUI

  SetDetailsPrint textonly
  DetailPrint "Installing User Interfaces | Modern User Interface..."
  SetDetailsPrint listonly

  SectionIn 1 2

  SetOutPath "$INSTDIR\Examples\Modern UI"

${MementoSectionEnd}

${MementoSection} "Default User Interface" SecInterfacesDefaultUI

  SetDetailsPrint textonly
  DetailPrint "Installing User Interfaces | Default User Interface..."
  SetDetailsPrint listonly

  SectionIn 1

  SetOutPath "$INSTDIR\Examples\UIs"

${MementoSectionEnd}

SectionGroupEnd

${MementoSection} "Language Files" SecLangFiles

  SetDetailsPrint textonly
  DetailPrint "Installing Language Files..."
  SetDetailsPrint listonly

  SectionIn 1

  SetOutPath "$INSTDIR\Examples\Language files"

  ${If} ${SectionIsSelected} ${SecInterfacesModernUI}
    SetOutPath "$INSTDIR\Examples\Language files"
  ${EndIf}

${MementoSectionEnd}


${MementoSectionDone}

Section -post

  ; When Modern UI is installed:
  ; * Always install the English language file
  ; * Always install default icons / bitmaps

  ${If} ${SectionIsSelected} ${SecInterfacesModernUI}

    SetDetailsPrint textonly
    DetailPrint "Configuring Modern UI..."
    SetDetailsPrint listonly

    ${IfNot} ${SectionIsSelected} ${SecLangFiles}
      SetOutPath "$INSTDIR\Examples\Language files"
    ${EndIf}

  ${EndIf}

  SetDetailsPrint textonly
  DetailPrint "Creating Registry Keys..."
  SetDetailsPrint listonly

  SetOutPath $INSTDIR

  WriteRegStr HKLM "Software\MyEmacs" "" $INSTDIR
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
  WriteRegDword HKLM "Software\MyEmacs" "VersionMajor" "${VER_MAJOR}"
  WriteRegDword HKLM "Software\MyEmacs" "VersionMinor" "${VER_MINOR}"
  WriteRegDword HKLM "Software\MyEmacs" "VersionRevision" "${VER_REVISION}"
  WriteRegDword HKLM "Software\MyEmacs" "VersionBuild" "${VER_BUILD}"
!endif

  WriteRegExpandStr HKLM "${REG_UNINST_KEY}" "UninstallString" '"$INSTDIR\uninst-myemacs.exe"'
  WriteRegExpandStr HKLM "${REG_UNINST_KEY}" "InstallLocation" "$INSTDIR"
  WriteRegStr HKLM "${REG_UNINST_KEY}" "DisplayName" "Nullsoft Install System${NAMESUFFIX}"
  WriteRegStr HKLM "${REG_UNINST_KEY}" "DisplayIcon" "$INSTDIR\uninst-myemacs.exe,0"
  WriteRegStr HKLM "${REG_UNINST_KEY}" "DisplayVersion" "${VERSION}"
!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD
  WriteRegDWORD HKLM "${REG_UNINST_KEY}" "VersionMajor" "${VER_MAJOR}"
  WriteRegDWORD HKLM "${REG_UNINST_KEY}" "VersionMinor" "${VER_MINOR}"
!endif
  WriteRegStr HKLM "${REG_UNINST_KEY}" "URLInfoAbout" "http://myemacs.sourceforge.net/"
  WriteRegStr HKLM "${REG_UNINST_KEY}" "HelpLink" "http://myemacs.sourceforge.net/Support"
  WriteRegDWORD HKLM "${REG_UNINST_KEY}" "NoModify" "1"
  WriteRegDWORD HKLM "${REG_UNINST_KEY}" "NoRepair" "1"

  WriteUninstaller $INSTDIR\uninst-myemacs.exe

  ${MementoSectionSave}

  SetDetailsPrint both

SectionEnd

;--------------------------------
;Descriptions

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} "The core files required to use MyEmacs (compiler etc.)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecExample} "Example installation scripts that show you how to use MyEmacs"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecShortcuts} "Adds icons to your start menu and your desktop for easy access"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfaces} "User interface designs that can be used to change the installer look and feel"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfacesModernUI} "A modern user interface like the wizards of recent Windows versions"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecInterfacesDefaultUI} "The default MyEmacs user interface which you can customize to make your own UI"
  !insertmacro MUI_DESCRIPTION_TEXT ${SecLangFiles} "Language files used to support multiple languages in an installer"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Installer Functions

Function .onInit

  ${MementoSectionRestore}

FunctionEnd

!ifdef VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD

Var ReinstallPageCheck

Function PageReinstall

  ReadRegStr $R0 HKLM "Software\MyEmacs" ""
  ReadRegStr $R1 HKLM "${REG_UNINST_KEY}" "UninstallString"
  ${IfThen} "$R0$R1" == "" ${|} Abort ${|}

  StrCpy $R4 "older"
  ReadRegDWORD $R0 HKLM "Software\MyEmacs" "VersionMajor"
  ReadRegDWORD $R1 HKLM "Software\MyEmacs" "VersionMinor"
  ReadRegDWORD $R2 HKLM "Software\MyEmacs" "VersionRevision"
  ReadRegDWORD $R3 HKLM "Software\MyEmacs" "VersionBuild"
  ${IfThen} $R0 = 0 ${|} StrCpy $R4 "unknown" ${|} ; Anonymous builds have no version number
  StrCpy $R0 $R0.$R1.$R2.$R3

  ${VersionCompare} ${VER_MAJOR}.${VER_MINOR}.${VER_REVISION}.${VER_BUILD} $R0 $R0
  ${If} $R0 == 0
    StrCpy $R1 "MyEmacs ${VERSION} is already installed. Select the operation you want to perform and click Next to continue."
    StrCpy $R2 "Add/Reinstall components"
    StrCpy $R3 "Uninstall MyEmacs"
    !insertmacro MUI_HEADER_TEXT "Already Installed" "Choose the maintenance option to perform."
    StrCpy $R0 "2"
  ${ElseIf} $R0 == 1
    StrCpy $R1 "An $R4 version of MyEmacs is installed on your system. It's recommended that you uninstall the current version before installing. Select the operation you want to perform and click Next to continue."
    StrCpy $R2 "Uninstall before installing"
    StrCpy $R3 "Do not uninstall"
    !insertmacro MUI_HEADER_TEXT "Already Installed" "Choose how you want to install MyEmacs."
    StrCpy $R0 "1"
  ${ElseIf} $R0 == 2
    StrCpy $R1 "A newer version of MyEmacs is already installed! It is not recommended that you install an older version. If you really want to install this older version, it's better to uninstall the current version first. Select the operation you want to perform and click Next to continue."
    StrCpy $R2 "Uninstall before installing"
    StrCpy $R3 "Do not uninstall"
    !insertmacro MUI_HEADER_TEXT "Already Installed" "Choose how you want to install MyEmacs."
    StrCpy $R0 "1"
  ${Else}
    Abort
  ${EndIf}

  nsDialogs::Create 1018
  Pop $R4

  ${NSD_CreateLabel} 0 0 100% 24u $R1
  Pop $R1

  ${NSD_CreateRadioButton} 30u 50u -30u 8u $R2
  Pop $R2
  ${NSD_OnClick} $R2 PageReinstallUpdateSelection

  ${NSD_CreateRadioButton} 30u 70u -30u 8u $R3
  Pop $R3
  ${NSD_OnClick} $R3 PageReinstallUpdateSelection

  ${If} $ReinstallPageCheck != 2
    SendMessage $R2 ${BM_SETCHECK} ${BST_CHECKED} 0
  ${Else}
    SendMessage $R3 ${BM_SETCHECK} ${BST_CHECKED} 0
  ${EndIf}

  ${NSD_SetFocus} $R2

  nsDialogs::Show

FunctionEnd

Function PageReinstallUpdateSelection

  Pop $R1

  ${NSD_GetState} $R2 $R1

  ${If} $R1 == ${BST_CHECKED}
    StrCpy $ReinstallPageCheck 1
  ${Else}
    StrCpy $ReinstallPageCheck 2
  ${EndIf}

FunctionEnd

Function PageLeaveReinstall

  ${NSD_GetState} $R2 $R1

  StrCmp $R0 "1" 0 +2 ; Existing install is not the same version?
    StrCmp $R1 "1" reinst_uninstall reinst_done

  StrCmp $R1 "1" reinst_done ; Same version, skip to add/reinstall components?

  reinst_uninstall:
  ReadRegStr $R1 HKLM "${REG_UNINST_KEY}" "UninstallString"

  ;Run uninstaller
    HideWindow

    ClearErrors
    ExecWait '$R1 _?=$INSTDIR' $0

    BringToFront

    ${IfThen} ${Errors} ${|} StrCpy $0 2 ${|} ; ExecWait failed, set fake exit code

    ${If} $0 <> 0
    ${OrIf} ${FileExists} "$INSTDIR\Bin\runemacs.exe"
      ${If} $0 = 1 ; User aborted uninstaller?
        StrCmp $R0 "2" 0 +2 ; Is the existing install the same version?
          Quit ; ...yes, already installed, we are done
        Abort
      ${EndIf}
      MessageBox MB_ICONEXCLAMATION "Unable to uninstall!"
      Abort
    ${Else}
      StrCpy $0 $R1 1
      ${IfThen} $0 == '"' ${|} StrCpy $R1 $R1 -1 1 ${|} ; Strip quotes from UninstallString
      Delete $R1
      RMDir $INSTDIR
    ${EndIf}

  reinst_done:

FunctionEnd

!endif # VER_MAJOR & VER_MINOR & VER_REVISION & VER_BUILD

Function ShowReleaseNotes
  StrCpy $0 $WINDIR\hh.exe
  ${IfNotThen} ${FileExists} $0 ${|} SearchPath $0 hh.exe ${|}
  ${If} ${FileExists} $0
    Exec '"$0" $INSTDIR\COPYING'
  ${Else}
    ExecShell "" "http://myemacs.sourceforge.net/Docs/AppendixF.html#F.1"
  ${EndIf}
FunctionEnd

;--------------------------------
;Uninstaller Section

Section Uninstall

  SetDetailsPrint textonly
  DetailPrint "Uninstalling NSI Development Shell Extensions..."
  SetDetailsPrint listonly

  IfFileExists $INSTDIR\Bin\runemacs.exe myemacs_installed
    MessageBox MB_YESNO "It does not appear that MyEmacs is installed in the directory '$INSTDIR'.$\r$\nContinue anyway (not recommended)?" IDYES myemacs_installed
    Abort "Uninstall aborted by user"
  myemacs_installed:

  SetDetailsPrint textonly
  DetailPrint "Deleting Registry Keys..."
  SetDetailsPrint listonly

  !macro AssocDeleteFileExtAndProgId _hkey _dotext _pid
  ReadRegStr $R0 ${_hkey} "Software\Classes\${_dotext}" ""
  StrCmp $R0 "${_pid}" 0 +2
    DeleteRegKey ${_hkey} "Software\Classes\${_dotext}"

  DeleteRegKey ${_hkey} "Software\Classes\${_pid}"
  !macroend

  !insertmacro AssocDeleteFileExtAndProgId HKLM ".myemacs" "MyEmacs.Script"

  System::Call 'Shell32::SHChangeNotify(i ${SHCNE_ASSOCCHANGED}, i ${SHCNF_IDLIST}, p0, p0)'

  DeleteRegKey HKLM "${REG_UNINST_KEY}"
  DeleteRegKey HKLM "Software\MyEmacs"

  SetDetailsPrint textonly
  DetailPrint "Deleting Files..."
  SetDetailsPrint listonly

  Delete "$SMPROGRAMS\MyEmacs${NAMESUFFIX}.lnk"
  Delete "$DESKTOP\MyEmacs${NAMESUFFIX}.lnk"
  Delete $INSTDIR\COPYING
  Delete $INSTDIR\uninst-myemacs.exe
  RMDir /r $INSTDIR\Bin
  RMDir /r $INSTDIR\Examples
  RMDir /r $INSTDIR\Plugins
  RMDir $INSTDIR

  SetDetailsPrint both

SectionEnd
