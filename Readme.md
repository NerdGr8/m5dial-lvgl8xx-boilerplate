
### **M5Dial LVGL Project Boilerplate: Quick Setup for Developers**

This repository provides a **boilerplate** to quickly scaffold and configure an **LVGL project** for the **M5Dial**. Tailored for developers working with **Squareline Studio** and **EEZStudio**, this setup ensures seamless integration between **M5Dial**, **Arduino IDE**, and **LVGL (8.4.0)**. 

Whether you’re building complex UIs or exploring hardware interaction, this project gives you a ready-made foundation to get started.

### Key Features:
- **M5Dial + LVGL** configuration for UI development with **Arduino 2.x**
- Pre-configured **`lv_conf.h`** for optimal display, touch, and encoder input
- Support for UI designs exported from **Squareline Studio** and **EEZStudio**
- Example code for **touch**, **rotary encoder**, and **button** handling
- Bash script to automatically scaffold the project structure and download necessary libraries

### Why Use This Boilerplate?
- **Seamless Setup**: No need to configure LVGL or worry about library versions—this boilerplate is pre-tuned for M5Dial and LVGL version 8.4.0.
- **Quick Integration**: Start integrating your **Squareline Studio** or **EEZStudio** UI design right away.
- **Hobbyist and Pro-Developer Friendly**: Suitable for both beginners and seasoned developers working on IoT and hardware UI projects.

### How to Use:
1. **Run the included bash script** to scaffold the project.
2. **Export your UI** from Squareline or EEZStudio, and drop it into the project.
3. **Open the project** in Arduino IDE 2.x, and upload it to your **M5Dial**.

---

**Search Tags**: M5Dial, LVGL, Squareline Studio, EEZStudio, UI Design, Arduino 2.x, M5Stack, Touch Input, Rotary Encoder, LVGL Project Scaffold, Boilerplate, TFT_eSPI, Hardware UI, IoT Development, LVGL 8.4.0.


### How to Use the Scaffolding Script

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
