@Echo OFF
SetLocal EnableDelayedExpansion
Set 7zip="C:\Program Files\7-Zip\7z.exe"
Set newLine=^


Set errorCount=0
Set separator=--------------------------------------------------------
Set errorLog=!newLine!!newLine!!separator!!newLine!!newLine!
Set errorPrefix=ERROR @:
Set successMessage=All Files Were Successfully Archived
SetLocal DisableDelayedExpansion
for %%x in (%*) do (

    SetLocal DisableDelayedExpansion
    Set filePath="%%~x"
    Set directoryFiles="%%~x\*"
    Set archivePath="%%~x.zip"
    SetLocal EnableDelayedExpansion

    if exist !directoryFiles! (
            Set sourcePath=!directoryFiles!
    )

    if not exist !directoryFiles! (
            Set sourcePath=!filePath!
    )

    echo !newLine!!newLine!!separator!!newLine!!newLine!

    !7zip! A -TZIP !archivePath! !sourcePath!

    if ErrorLevel 1 (
        Set /A errorCount=errorCount+1
        Set errorLog=!errorLog!!newLine!!errorPrefix!!sourcePath!
    )
)
if !errorCount!==0 (
    Set errorLog=!errorLog!!newLine!!successMessage!
)
Echo !errorLog!!newLine!!newLine!!newLine!
pause