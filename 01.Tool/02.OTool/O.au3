#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Iveshu

 Script Function:
	Use win+Run button to quick start the program as you have configed.

#ce ----------------------------------------------------------------------------

Global $ConfigFilename = "OToolConfig.ini"

;~ Script Start - Add your code below here

;~ copy local program
Copy_O_Program()

;~ =====================================Read command=============================================
;~ Defile the parameter which is used to save the program name
$ProName=""

;~ Check the number of the parameter that user input
$ParaNumber = $CmdLine[0]
If $ParaNumber = 0 Then
	MsgBox(0, "Error", "Please input a directory name.")
	;~ Ruturn code : 11
	Exit (11)
ElseIf $ParaNumber > 1 Then
	MsgBox(0, "Error", "You can only input one directory name.")
	;~ Ruturn code : 12
	Exit (12)
EndIf

;~ Read the parameter that user input
$ProName=$CmdLine[1]

;~ Config the ini file
If $ProName = "config" Then
	Run("notepad " & @SystemDir & "\" & $ConfigFilename)
	;~ Ruturn code : 0
	Exit (0)
EndIf

;~ =====================================Read config=============================================
;~ Read the paragram parameter from the config file
$Propath=IniRead(@SystemDir & "\" & $ConfigFilename, "Directory", $ProName, "")

;~ =====================================Check config============================================
;~ Check the program name configed in the config file
If $Propath = "" Then
	MsgBox(0, "Error", "Please input the right directory name.")
	;~ Ruturn code : 21
	Exit (21)
EndIf

;~ Check the program file exist
;~ IF FileExists($Propath) = 0 Then
;~ 	MsgBox(1, "Error", "Please check the directory file exist.")
;~ 	;~ Ruturn code : 22
;~ 	Exit (22)
;~ EndIf


;~ =====================================Start the program========================================
;~ Start the program
Run("explorer " & $Propath)
;~ Ruturn code : 0
Exit (0)


#cs ----------------------------------------------------------------------------
	Function name			:	Copy_R_Program
	Function description	:	Copy the R.exe to the path "C:\Windows\System32"
	Author					:	Iveshu
	Write time				:	2017-10-19 20:08:37
	Parameter liset			:
								NA
	Return value			:
								NA
	Modify history			:
								NA
#ce ----------------------------------------------------------------------------
Func Copy_O_Program()


	;~ Check run as first time
	Local $SysPath = @SystemDir & "\O.exe"
	Local $RToolFile = @ScriptDir & "\O.exe"

	Local $ConfigFile = @SystemDir & "\" & $ConfigFilename
	;~ Check the R.exe program exist int the path "C:\Windows\System32"
	;~ If R.exx does not exist in the path, copy the file to the path
	IF FileExists($SysPath)=0 Then
		$CopyResult = FileCopy($RToolFile,$SysPath,1)

		IF $CopyResult = 0 Then
			MsgBox(0, "Error", "Install programe failed, info: copy file failed.")
			Exit(-1)
		EndIf

		;~ write the config templet
		Write_config_Templet($ConfigFile)
		MsgBox(0, "Information", "Install programe success. Usage: win+r -> r DirName")
		Exit(-1)

	EndIf
EndFunc


#cs ----------------------------------------------------------------------------
	Function name			:	Write_config_Templet
	Function description	:	Write the config templet
	Author					:	Iveshu
	Write time				:	2017-10-19 20:06:15
	Parameter liset			:
								NA
	Return value			:
								NA
	Modify history			:
								NA
#ce ----------------------------------------------------------------------------
Func Write_config_Templet($Configfile_path)
	;~ Check the file alraedy exist
	Local $hFileOpen = FileOpen($Configfile_path, 2)
    If $hFileOpen = -1 Then
        MsgBox(0, "Wirte template Error", "An error occurred while writing the template config file.")
        Return False
    EndIf

    ; Write data to the file using the handle returned by FileOpen.
    FileWrite($hFileOpen, ";; ============================================================================="& @CRLF)
    FileWrite($hFileOpen, ";; Directory Name config" & @CRLF)
    FileWrite($hFileOpen, ";; Format:" & @CRLF)
    FileWrite($hFileOpen, ";; 		DirName=Directory Path"& @CRLF)
	FileWrite($hFileOpen, ";; ============================================================================="& @CRLF)
	FileWrite($hFileOpen, @CRLF)
	FileWrite($hFileOpen, "[Directory]"& @CRLF)
	FileWrite($hFileOpen, "sys=C:\Windows\System32"& @CRLF)

    ; Close the handle returned by FileOpen.
    FileClose($hFileOpen)
	;~ write the config templet

EndFunc