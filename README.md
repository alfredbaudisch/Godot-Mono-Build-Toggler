# Godot Mono Build Toggler for Godot 4

Adds a toggle button to the editor toolbar which allows enabling or disabling Mono build by hiding the project's solution file. Useful for projects which use both C# and another language like GDScript, so that you can disable Mono while you're not editing any C# source files.

<img src="screenshot_01.png" style="zoom:150%;" align="left" /> <br /> <br />

### Installation

1. Clone or download the repository
2. Move the `addons/Mono-Build-Toggler` folder to the `addons` folder within your project directory (`res://addons/Mono-Build-Toggler`)
3. Enable the plugin from the `plugins` tab of the Godot editor project settings

### Original Author
This is a fork from the original Godot 3 [addon by @toasterofbread](https://github.com/toasterofbread/Godot-Mono-Build-Toggler). Since toasterofbread archived the repository, I forked it to migrate it to Godot 4.