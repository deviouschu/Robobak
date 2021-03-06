$curUser = [Environment]::UserName
$creator = "Devious chu back up tool ^^"
$version = "1.0.1"
$start = "Pick an option.
1. Backup all user data for $curUser.
2. Backup all user data from users.
3. Backup from another location.
4. Restore options
5. Details of the script!"

Write-Host $creator
Write-Host $version
#loop for continuous backup
do{
Write-Host $start
$getOption = Read-Host

switch ($getOption) {
1{#Back up the current user only
$NotThere = "The folder does not exists. Creating the folder!"
$checkText = "Checking the path"
$drdesText = "Please give the drive.
Format = C:"
$Nametext = "please name the backup!"
Write-Host $drdesText
$drdes = Read-Host
Write-Host $Nametext
$Name = Read-Host
#$curUser will be the current user folder.
$des = "$drdes\$Name\$curUser"
Write-Host $checkText
#checks for folder location and will create it if path does not exist.
$TarDir = "$des"
if( -Not (Test-Path -Path $TarDir )){
    Write-Host $NotThere
    New-Item -ItemType Directory -Force -Path $TarDir
}
else{
Write-Host "Found a directory with the same name, backing up to $Name\$curUser!"
}
$NoBak = "AppData"
$NoBak2 = "Local Settings"
Set-Location C:\Users
Write-Host "Backing up $curUser!"
robocopy $curUser $des /E /Z /B /SEC /ETA /MT:100 /XD $NoBak $NoBak2 /R:3 /TEE /V /LOG:"$des\Baklog.txt"
}
2{#Back up all users
$DrdesText = "Please give the drive you are backing up to.
Format = C:"
$source = "C:\Users"
Write-Host $DrdesText
$Drdes = Read-Host
$NameText = "Please name the backup."
Write-Host $NameText
$NameDes = Read-Host
$checkText = "Checking path"
$NotThere = "The folder does not exists. Creating the folder!"
Write-Host $checkText
#bak will change to the folder you are backing up to.
$des = "$Drdes\$NameDes\bak"
#checks for folder location and will create it if path does not exist.
$TarDir = "$des"
if( -Not (Test-Path -Path $TarDir )){
    Write-Host $NotThere
    New-Item -ItemType Directory -Force -Path $TarDir
}
$NoBak = "AppData"
$NoBak2 = "Local Settings"
$NoBak3 = "All Users"
$NoBak4 = "Default"
$NoBak5 = "DefaultAppPool"
$NoBak6 = "DefaultAppPool.*"
$NoBak7 = "local"
Set-Location C:\
Write-Host "Backing up all users!!"
robocopy $source $des /E /Z /B /SEC /ETA /MT:100 /XD $NoBak $NoBak2 $NoBak3 $NoBak4 $NoBak5 $NoBak6 $NoBak7 /R:3 /TEE /V /LOG:"$des\Baklog.txt"
}
3{#back up from another location
$sourText = "please give the location of which you want to backup!
Format C:\Some folder"
Write-Host $sourText
$source = Read-Host
$checkText = "checking the path."
$noDir = "the path does not exist. please check for errors and rerun."
$found = "found the path, continuing!"
Write-Host $checkText  
if( -Not (Test-Path -Path $source )){
Write-Host $noDir
break;
}
else {
Write-Host $found
}
$drText = "please give the drive for the backup!
format C:"
Write-Host $drText
$drdes = Read-Host
$nameText = "please name the backup!"
Write-Host $nameText
$name = Read-Host
$des = "$drdes\$name"
$NotThere = "path does not exist, creating the path...."
$TarDir = "$des"
$checkText = "Checking the path for the destination !"
Write-Host $checkText
if( -Not (Test-Path -Path $TarDir )){
    Write-Host $NotThere
    New-Item -ItemType Directory -Force -Path $TarDir
}
$NoBak = "AppData"
$NoBak2 = "Local Settings"
$NoBak3 = "All Users"
$NoBak4 = "Default"
$NoBak5 = "local"
Set-Location $source
Write-Host "Backing up $source to $des!"
robocopy $source $des /E /Z /B /SEC /ETA /MT:100 /XD $NoBak $NoBak2 $NoBak3 $NoBak4 $NoBak5 /R:3 /TEE /V /LOG:"$des\Baklog.txt"
}
4{#restore options
$Options = "please choose what type of restore you are doing!
1. Restore current user $curUser?
2. Restore all users?
3. Restore a certain folder to a certain location?"
Write-Host $Options
$getOption = Read-Host
switch($getOption){
1{#restore the current user from a location.
$sourText = "where is the backup located?
Format C:\somefolder\.."
Write-Host $sourText
$source = Read-Host
$TarDir = $source
$checkText = "Chekcing the path!!"
Write-Host $checkText
if( -Not (Test-Path -Path $TarDir )){
Write-Host "error path does not exist, please check and rerun!"
break;
}
else {
Write-Host "Found the path!"
}
$NoBak = "AppData"
$NoBak2 = "Local Settings"
$des = "C:\Users\$curUser"
Write-Host "Restoring for $curUser..."
Set-Location $source
robocopy $source $des /E /Z /B /SEC /ETA /MT:100 /XF "Baklog.txt" /XD $NoBak $NoBak2 /R:3 /TEE /V /LOG:"$des\Restlog.txt"
}
2{#restore all user data
$sourText = "where is the backup located?
Format C:\somefolder\.."
Write-Host $sourText
$source = Read-Host
$TarDir = $source
$checkText = "Chekcing the path!!"
Write-Host $checkText
if( -Not (Test-Path -Path $TarDir )){
Write-Host "error path does not exist, please check and rerun!"
break;
}
else {
Write-Host "Found the path!"
}
$NoBak = "AppData"
$NoBak2 = "Local Settings"
$NoBak3 = "All Users"
$NoBak4 = "Default"
$NoBak5 = "DefaultAppPool"
$NoBak6 = "DefaultAppPool.*"
$NoBak7 = "local"
$des = "C:\Users"
Write-Host "Restoring All user data!..."
Set-Location $source
robocopy $source $des /E /Z /B /SEC /ETA /MT:100 /XF "Baklog.txt" /XD $NoBak $NoBak2 $NoBak3 $NoBak4 $NoBak5 $NoBak6 $NoBak7 /R:3 /TEE /V /LOG:"$des\Restlog.txt"
}
3{#restore from one another location to a certain location that is not a user.
$sourText = "where is the backup located?
Format C:\somefolder\.."
Write-Host $sourText
$source = Read-Host
$TarDir = $source
$checkText = "Chekcing the path for source!!"
Write-Host $checkText
if( -Not (Test-Path -Path $TarDir )){
Write-Host "error path does not exist for source, please check and rerun!"
break;
}
else {
Write-Host "Found the path for source!"
}
$desText = "please give the destination for the restore!
Format C:\somefolder\.."
Write-Host $desText
$des = Read-Host
$TarDir2 = $des
$checkText2 = "Chekcing the path for destination!!"
Write-Host $checkText2
if( -Not (Test-Path -Path $TarDir2 )){
Write-Host "error path does not exist for destination, please check and rerun!"
break;
}
else {
Write-Host "Found the path for destination!"
}
$NoBak = "AppData"
$NoBak2 = "Local Settings"
$NoBak3 = "All Users"
$NoBak4 = "Default"
$NoBak5 = "local"
Write-Host "Restoring for $source to $des!..."
Set-Location $source
robocopy $source $des /E /Z /B /SEC /ETA /MT:100 /XF "Baklog.txt" /XD $NoBak $NoBak2 $NoBak3 $NoBak4 $NoBak5 /R:3 /TEE /V /LOG:"$des\Restlog.txt"
}
}
}
5{#detail of the script
Write-Host "This is a script for a Robocopy backup. It will back up 
using theses switches /E /Z /B /SEC /ETA /MT:100 /XF /XD /R:3 /TEE /V /LOG:

/XD is the exclude directory switch. It will exclude in all Appdata, Local settings,
All users, default, local, defaultapppool and defaultapppool.*. The reason I excluded
these users and directories was for the infinite recursion that would happen when trying
to back these up. Gave nothing but problems!!

/E for everything and empty directories.

/Z will restart if failed.

/B you need to be a admin account / backup mode.

/SEC copies with all security, so it can be encrypted and it will move it. Don't loose
you keys!

/ETA will give you a percent of how much folder has been copied and log it as well.

/MT:100 multi treading, means it will use up to 100 threads to copy files for fast
backup and recovery. I take it will do 100 files at a time until done.

/XF exclude file, it only excludes baklog.txt when recovering from an already backed up
directory from this script.

/R:3 will retry 3 times before continuing on.

/TEE logs the progress and puts it in the prompt for user.

/V verbose

/LOG: for the logging of events when robocopy is copying files only. check baklog.txt
and restlog.txt for errors and fails."

}
}

#finished and ask to rerun
$fin = "Finished! If the backup ran all the way, 
please check the log, located in the destination location named baklog.txt!
If a restore, the file would be in the destination location named restlog.txt!!
Rerun from the beginning? y/n"
Write-Host $fin
$finWait = Read-Host 
}
#y for yes to rerun the script and back something else up
while ($finwait -eq "y")