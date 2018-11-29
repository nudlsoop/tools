; Purpose:  Deploy the package, unpack in the user's $TEMP, then run the 
;           included setup file unattended.
;           
; Changes:  
;           
;--------------------------------

!define VERSION "2018.11.29.1015"
!define PRODUCT_NAME "BigFix Agent"
!define PRODUCT_VERSION "9.5.7.90"
!define PRODUCT_PUBLISHER "IBM"
!define SHORT_NAME "BES_Client"

VIProductVersion "${PRODUCT_VERSION}"
VIFileVersion "${VERSION}"

VIAddVersionKey "FileDescription" "BES Client installer, configuration and masthead"
VIAddVersionKey "FileVersion" "${VERSION}"
VIAddVersionKey "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey "ProductVersion" "${PRODUCT_VERSION}"
;VIAddVersionKey "LegalCopyright" "(C) 2017 FooCorp"
VIAddVersionKey "Comments" "Silent install: /S"

;--------------------------------

SetCompressor lzma

;--------------------------------
; Modern UI 2.0
!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Components page
;!insertmacro MUI_PAGE_COMPONENTS
; InstFiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE 'English'

;--------------------------------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile 'Deploy_${SHORT_NAME}.exe'
InstallDir "$TEMP\${SHORT_NAME}\${PRODUCT_VERSION}"
ShowInstDetails show
 
Section -SETTINGS
  SetOutPath "$INSTDIR"
  SetOverwrite on
SectionEnd
 
; Package setup files
Section "Install ${PRODUCT_NAME} ${PRODUCT_VERSION}" SEC01
  File "clientsettings.cfg"
  File "masthead.afxm"
  File "setup.exe"

  ; Start unattended setup
  ExecWait '"$INSTDIR\setup.exe" /s /v/qn'
SectionEnd

 
