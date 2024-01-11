# Lua Memory Reading Script

This Lua script is designed to read game memory for a specific game, providing information about the player's character, target, and other relevant details. The script is primarily focused on retrieving data related to character status, health, mana, target information, and various in-game conditions.

## Usage

To use this script, follow these steps:

1. **Integration with the Game:** Ensure that this script is integrated into the game environment where memory reading is required. The script utilizes memory addresses specific to the game.

2. **Functions Overview:**
    - `bot.charName()`: Retrieves the character name.
    - `bot.Inventory()`: Checks if the inventory is open.
    - `bot.get_current_HP()`, `bot.get_percent_HP()`: Retrieves current and percentage health.
    - `bot.get_pethp_skillpoints()`, `bot.get_basic_max_HP()`: Retrieves additional health-related information.
    - `bot.TOTAL_CHAR_MAX_HP()`: Calculates the total character max health.
    - `bot.CharHPpercent()`: Calculates and returns the character's health percentage.
    - `bot.targetHP()`, `bot.targetHPpercent()`: Retrieves target health and percentage.
    - `bot.getLocation()`, `bot.getLocation_cords(p)`: Retrieves the character's location and specific coordinates.
    - `bot.getCharLevel()`, `bot.Battle_Status()`: Retrieves character level and battle status.
    - `bot.Target_Selected()`, `bot.Target_Name()`: Retrieves information about the selected target.
    - `bot.Char_Sit()`, `bot.mount_status()`: Retrieves character sitting status and mount status.
    - Mana-related functions: `bot.Mana()`, `bot.Current_Mana()`, `bot.Mana_Buff()`, `bot.Max_Mana()`, `bot.Mana_Percent()`.
    - Health and Mana percentages: `bot.HP_Percent()`, `bot.Mana_Percent()`.

3. **Gameplay Functions:**
    - `bot.killed(x)`: Records the number of kills.
    - `bot.Moke_Boss()`: Handles a specific boss encounter scenario.
    - `bot.KILLBOSS()`: Engages in attacking a boss.
    - `bot.auto_attack_on_rev()`, `bot.pcp_suwan()`: Automated attack functions based on character status.
    - `bot.Dialogue()`, `bot.SellDialogue()`, `bot.friendlist()`, `bot.Surroundings()`: Checks various in-game dialogues and lists.

4. **Additional Functions:**
    - `bot.getConfirmBox()`: Retrieves confirmation box status.
    - `bot.deadbox()`, `bot.dead()`: Checks character death status.
    - `bot.killed(x)`: Records the number of kills.

5. **Customization:**
    - Customize the Boss_Name variable in `bot.Moke_Boss()` for specific boss encounters.
    - Customize attack skills and keys in `bot.auto_attack_on_rev()`, `bot.pcp_suwan()`, and `bot.KILLBOSS()`.

## Important Notes

- Ensure the script is compatible with the game version and regularly check for updates.
- Understand and comply with the game's terms of service regarding third-party scripts.

**Disclaimer:** Use this script responsibly and in compliance with the game's terms of service. The script author is not responsible for any consequences resulting from its usage.
