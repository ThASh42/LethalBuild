@echo off

CALL :find_steam_game_folder
CALL :install_mods
echo Installation complete.
cd ..
echo Removing the LethalBuild-master directory...
rd /s /q "LethalBuild-master"
echo Cleanup complete.
timeout /t 3

EXIT /B %ERRORLEVEL%

:find_steam_game_folder
echo Searching for Lethal Company game directory...
IF EXIST "%HOME%\.steam\steam\steamapps\common\Lethal Company\" (
  SET "GAME_DIR=%HOME%\.steam\steam\steamapps\common\Lethal Company"
) ELSE (
  IF EXIST "%HOME%\.local\share\Steam\steamapps\common\Lethal Company\" (
    SET "GAME_DIR=%HOME%\.local\share\Steam\steamapps\common\Lethal Company"
  ) ELSE (
    IF EXIST "C:\Program Files (x86)\Steam\steamapps\common\Lethal Company\" (
      SET "GAME_DIR=C:\Program Files (x86)\Steam\steamapps\common\Lethal Company"
    ) ELSE (
      IF EXIST "D:\SteamLibrary\steamapps\common\Lethal Company\" (
        SET "GAME_DIR=D:\SteamLibrary\steamapps\common\Lethal Company"
      ) ELSE (
        echo Could not find the Lethal Company directory. Please enter the path manually:
        SET /P "GAME_DIR=Enter the game directory: "
      )
    )
  )
)

IF EXIST "%GAME_DIR%\" (
  echo Lethal Company found at: "%GAME_DIR%"
) ELSE (
  echo Error: Lethal Company directory not found.
  EXIT /B 1
)
EXIT /B 0

:install_mods
echo Deleting existing BepInEx folder in game directory if it exists...
:: Copy custom config files
IF EXIST "%GAME_DIR%\BepInEx\config\" (
  xcopy /e /i /y "%GAME_DIR%\BepInEx\config\" "custom_config_backup\"
  echo Backup config file - custom_config_backup
)
:: Copy must-rewrite config files
IF EXIST "BepInEx\config\" (
  xcopy /e /i /y "BepInEx\config\" "must_rewrite_config_backup\"
  echo Backup config file - must_rewrite_config_backup
)

:: Deleating BepInEx folder
IF EXIST "%GAME_DIR%\BepInEx\" (
  rd /s /q "%GAME_DIR%\BepInEx"
  echo Previous BepInEx folder deleted.
)
:: End Deleating

echo Copying BepInEx to game directory...
IF EXIST "BepInEx\" (
  xcopy /e /i /y "BepInEx" "%GAME_DIR%\BepInEx"
  echo Mods installed successfully.
) ELSE (
  echo Error: BepInEx folder not found in the repository.
  EXIT /B 1
)
IF EXIST "custom_config_backup/" (
  xcopy /e /i /y "custom_config_backup\" "%GAME_DIR%\BepInEx\config\"
  echo Copy config file to the game - custom_config_backup
)
IF EXIST "must_rewrite_config_backup/" (
  xcopy /e /i /y "must_rewrite_config_backup\" "%GAME_DIR%\BepInEx\config\"
  echo Copy config file to the game - must_rewrite_config_backup
)
EXIT /B 0
