# screensaver \[[readme.md by ChatGPT](https://chat.openai.com/)\]

This repository contains a Lua script that serves as a simple terminal screensaver. The screensaver generates a dynamic display using a set of predefined blocks and animates them in a loop. The repository is licensed under the [WTFPL](http://www.wtfpl.net/) license, and the script assumes it is running on Luvit, so there is no need to download any additional libraries as they should be preinstalled with Luvit.

## Prerequisites

To run the screensaver, you'll need to have [Luvit](https://luvit.io/) installed on your system.

## Configuration

The configuration for the screensaver is stored in `config.json`. If this file is missing or invalid, the screensaver will fall back to a default space-themed configuration. You can customize the following parameters in the `config.json` file:

```json
{
	"blocks": {
		"750": " ",
		"20": "*",
		"2": "o",
		"1": "O"
	},
	"size": {
		"X": 91,
		"Y": 31
	},
	"renew": 50,
	"horizantalChance": 100,
	"useClear": false
}
```

- **blocks**: A table defining the available blocks to be displayed and their frequencies. The keys represent the frequency, and the values are the corresponding block characters.

- **size**: An object that specifies the size of the display area. It contains the `X` and `Y` dimensions, representing the screen's width and height, respectively.

- **renew**: The delay (in milliseconds) between each update of the screensaver. This value determines the animation speed.

- **horizantalChance**: The probability (in percentage) of a horizontal update happening. This value controls the chance of a new line appearing at the top or bottom of the display.

- **useClear**: A boolean flag indicating whether to clear the screen before updating the display. Set this to `true` if you want a cleaner animation without leaving previous frames on the screen.

## Running the Screensaver

Make sure you have Luvit installed on your system. Then, follow these steps:

1. Clone the repository:

```bash
git clone https://github.com/Cowrod/screensaver
```

2. Navigate to the repository directory:

```bash
cd screensaver
```

3. Install [Luvit](https://luvit.io/install.html) If You Haven't Already

4. Run the screensaver:

```bash
luvit init.lua
```

The screensaver will start executing and display the animated output in your terminal.

## How the Screensaver Works

The main script, `init.lua`, loads the configuration from `config.json` and initializes the necessary functions and variables. Here's a brief overview of the script's logic:

1. **Configuration Setup**: The script reads the configuration from `config.json` and verifies its validity. A default space-themed configuration is used if the configuration is missing or incomplete.

2. **Block and Screen Initialization**: The script creates a list of blocks based on the configuration's block frequencies. It also initializes the display area as an empty grid.

3. **Main Functions**: Several functions are defined to support the animation process:
   - `empty()`: An empty function.
   - `getRandomBlock()`: Returns a random block character from the list of available blocks.
   - `preTable(tbl, value)`: A function to prepend a value to a table.
   - `getEntireRandomLine()`: Generates a random line of blocks for the display.
   - `horizontalUpdate()`: Moves lines of blocks up or down to create animation.
   - `updateView()`: Shifts the blocks in the display area to create animation.
   - `getView()`: Creates a string representation of the current display.

4. **Better View Initialization**: The random number generator is seeded, and the display area is pre-filled with random blocks to improve the initial animation.

5. **Start the Loop**: The main loop of the screensaver begins, continuously updating the display in the terminal according to the defined settings.

Feel free to explore the code and modify the configuration to customize the screensaver to your liking.

## License

This project is licensed under the WTFPL - Do What the Fuck You Want to Public License. See the [LICENSE](LICENSE) file for more details.

Please note that the screensaver is provided as-is, and the author takes no responsibility for any damage caused by its use. Enjoy the mesmerizing visuals! 😄
