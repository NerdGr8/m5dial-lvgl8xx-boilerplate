
### How to Use

1. **Copy Demo.ino and the dependencies.**:
   - Download the `./Demo` folder and change the names etc.

2. **Run the Script**:
   - Save the `scaffold_project.sh` script in a directory.
   - Open a terminal, navigate to the directory, and run the script:

   ```bash
   chmod +x scaffold_project.sh
   ./scaffold_project.sh

Project Name:
The script will prompt you to enter the project name, which it will use to create the necessary folder structure and files.

**LVGL Version:**
The script automatically downloads and configures *LVGL 8.4.0*, which is compatible with Squareline Studio and EEZStudio.

- Ensure you copy the library to you arduino libraries folder.
- Copy the lv_conf.h file to the root of the libraries folder

Add UI:
After scaffolding, place your Squareline Studio or EEZStudio exported files (e.g., ui.h, ui.c) in the src/ folder.

Open in Arduino IDE:
Open the .ino file in Arduino IDE 2.x and install the necessary libraries via the Library Manager.

This script simplifies the process for developers by creating a boilerplate setup for M5Dial and LVGL, saving time and reducing configuration errors.
