# Kerakli typst versiyasi
typst 0.14.2 (b33de9de)

```cmd
set PROJECT=mexatron_modul_va_robotlarning_informatsion_qurilmalari
git clone https://github.com/axmud/mexatron_modul_va_robotlarning_informatsion_qurilmalari.git %PROJECT%
winget install typst -v 0.14.2
cd %PROJECT%
for %f in (*.typ) do typst compile "%f"
```
