# Bewitcher Cave Lua Script

This Lua script is designed to automate various tasks within the game, specifically tailored for the Bewitcher Cave (BC) area. The script is organized into several functions, each serving a specific purpose.

## Usage

1. The main functionality is initiated by calling the `BC.start()` function. This function repeats the BC process multiple times to ensure the completion of the specified tasks.
   
   ```lua
   BC.start()
   ```

## Functions

### `BC.outsideBC()`

This function serves as the entry point for the BC activities. It handles the overall flow, from preparing for BC outside the cave to navigating through different locations.

### `BC.InsideBC()`

This function is responsible for executing tasks within the Bewitcher Cave, including health checks, movement, and battling.

### `BC.attackBlazeSkullMarshal()`

This function handles the battle logic, attacking enemies based on certain conditions. It also incorporates healing mechanisms if required.

### `BC.MovingtoAltar()` and `BC.MovingtoBoss()`

These functions handle movement between specific locations within the Bewitcher Cave.

### `BC.TeleporttoBoss()`

This function manages the teleportation process to reach the Boss area.

### `BC.MovingfromStonecity()`, `BC.MovingfromVastmountain()`, and `BC.MovingfromGhostdinwoods()`

These functions handle movement when the character is located in Stone City, Vast Mountain, and Ghost Din Woods, respectively.

### `BC.findcourage()`

This function is responsible for locating and interacting with a specific item (Courage Badge) in the game.

### `BC.clickCoordinates()` and `BC.EquipCorrectGears()`

These functions involve clicking on specific coordinates within the game window, simulating interactions such as opening bags and equipping gears.

### `BC.Addteam()` and `BC.Leaveteam()`

These functions manage team-related actions, such as adding and leaving a team.

### `BC.Healthcheck()`

This function checks the character's health status and performs healing actions if needed.

### `BC.Invisiblemode()`

This function simulates actions to enter an invisible mode, involving screen resetting and zoom adjustments.

### `BC.StoneCity()`, `BC.VastMountain()`, and `BC.Ghostdinwoods()`

These functions check the character's current location.

### `BC.Surroundings()` and `BC.Viewreset()`

These functions handle actions related to the character's surroundings and screen view adjustments.

### `BC.attack(attackskills)`

This function is a generic attack function that repeatedly attacks enemies until the battle status changes.

### `BC.convert_epoch_to_normal()`, `BC.calculate_time_difference(epoch1, epoch2)`, and `BC.convertSecondsToTime(seconds)`

These utility functions convert epoch time, calculate time differences, and convert seconds into a readable time format.

## Notes

- The script assumes the availability of certain game features, such as specific coordinates, items, and dialogue options. Make sure these elements match the current game state.
- Adjust the script parameters and coordinates based on the specific requirements of your gameplay.
- Always consider the terms of service of the game to ensure compliance with automation rules.
- Use this script responsibly and at your own risk. The script might need adjustments depending on updates or changes to the game.

**Disclaimer:** Use of automation scripts in games may violate the terms of service, leading to penalties or bans. Always ensure compliance with the game's policies. Use at your own risk.
