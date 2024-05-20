![Header image](https://github.com/vojtikczhraje/Vitality/blob/main/img/Vitality-Github.png)


## 🚀 Vitality
Vitality is a free and open source batch optimizer designed to improve performance, decrease latency, enhance game settings, and optimize recording settings.


> [!WARNING]  
> **Use at Your Own Risk:** Compatibility varies. Backup your system first. Disable antivirus to prevent conflicts. Know what each tweak does before applying.

## 🔧 Getting started
- Open PowerShell as administrator and enter the command below. <br />
```powershell
$url = "https://raw.githubusercontent.com/vojtikczhraje/Vitality/main/Vitality.bat"; $tempFilePath = "temp_Vitality.bat"; $newFilePath = "Vitality.bat"; Invoke-WebRequest -Uri $url -OutFile $tempFilePath; $content = Get-Content -Path $tempFilePath; $content | Out-File -FilePath $newFilePath -Encoding Default; Start-Process cmd.exe -ArgumentList "/c .\$newFilePath"; Remove-Item -Path $tempFilePath
```
- Use `W, S, A, D, X` and `Numbers` to interact with the script
- If you would like to configure the settings before running the script [see](#-configure-settings)

## ⚙ Configure settings
### We have now included new way of configuring settings.
- Built in app configurator

- Out side the file configurator (.ini)
  - Open PowerShell as administrator and enter the command below. This will download optimal settings for desktop and laptop.

    ```powershell
    New-Item -Path "C:\Vitality" -ItemType Directory -Force | Out-Null; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/vojtikczhraje/Vitality/main/config.ini" -OutFile "C:\Vitality\config.ini"
    ```
  - If you would like to configure your settings, download the config file with command ^ and then paste this command inside PowerShell or cmd:
    ```
    C:\Vitality\config.ini
    ```
  - Change options to `True` for apply/revert the option or `False` for ignoring the option.
  - Run the script with [command ^](#-getting-started) . Now settings are changed and you do not need to configure it with actual script.



## ❓ About
- Vitality is being developed by [vojtikczhraje](https://discordapp.com/users/1056305220914786406) and designed by [Pigeonlonion](https://discordapp.com/users/1091070103933681685)


- Made with Batch, Powershell


- If you need any help feel free to join our [Discord](https://discord.gg/uEHp2Uejk3)


---

![Vitality](https://github.com/vojtikczhraje/Vitality/blob/main/img/Vitality.png)

