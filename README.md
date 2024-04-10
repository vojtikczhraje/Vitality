![Header image](https://github.com/vojtikczhraje/Vitality/blob/main/img/Vitality-Github.png)


## 🚀 Vitality
Vitality is a free and open source batch optimizer designed to improve performance, decrease latency, enhance game settings, and optimize recording settings.


> [!WARNING]  
> **Use at Your Own Risk:** Compatibility varies. Backup your system first. Disable antivirus to prevent conflicts. Know what each tweak does before applying.

## 🔧 Usage
- Open PowerShell as administrator and enter the command below. <br />
```powershell
irm "https://raw.githubusercontent.com/vojtikczhraje/Vitality/main/Vitality.bat" -OutFile "Vitality.bat"
.\Vitality.bat
```
- Use `W, S, A, D, X` and `Numbers` to interact with the program
- If you would like to configure the settings before running the program [see](#-configure-settings)

## ⚙ Configure settings
### We have now included new way of configuring settings.
- Built in app configurator

- Out side the file configurator (.ini)
  - Open PowerShell as administrator and enter the command below.

    ```powershell
    New-Item -Path "C:\Vitality" -ItemType Directory -Force | Out-Null; Invoke-WebRequest -Uri "https://raw.githubusercontent.com/vojtikczhraje/Vitality/main/config.ini" -OutFile "C:\Vitality\config.ini"; C:\Vitality\config.ini
    ```
  - Change options to `True` for enabling options or `False` for disabling options
  - Run the script with [command ^](#-usage) . Now settings are changed and you do not need to configure it with actual script.



## ❓ About
- Vitality is being developed by vojtikczhraje and Pigeon 


- Made with Batch, Powershell


- [Discord](https://discord.gg/uEHp2Uejk3)


---

![Vitality](https://github.com/vojtikczhraje/Vitality/blob/main/img/Vitality.png)

