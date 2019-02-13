
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>


Local $i = 0

Local Const $sFilePath = "create_table.sql"

Local $hFileOpen = FileOpen($sFilePath, $FO_READ + $FO_OVERWRITE)
If $hFileOpen = -1 Then
	MsgBox($MB_SYSTEMMODAL, "", "An error occurred when reading/writing the file.")

EndIf


While $i <= 10000
	Local $strin_sql = "create table if not exists t11.t"&$i&" (a int, b int, PRIMARY KEY(a));" & @LF
    FileWrite($hFileOpen, $strin_sql)
    $i = $i + 1
WEnd


