# Bloxstrap
A script that attempts to recreate Bloxstrap, so you can use FFlags without installing a program.

## Installation
```lua
getgenv().autosetup = {
    path = 'Bloxstrap', --> doesnt work rn
    setup = true --> init after installaiton
}
loadstring(game.HttpGet(game, 'https://raw.githubusercontent.com/SpexzYTO/Bloxstrap/main/main/initiate.lua', true))()
```
