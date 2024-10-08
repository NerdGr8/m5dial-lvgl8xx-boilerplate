#!/bin/bash

# Prompt user for the project name
read -p "Enter the project name: " project_name

# Create the project directory
echo "Setting up the project structure for '$project_name'..."
mkdir -p "$project_name"/src
mkdir -p "$project_name"/lib
echo "Done creating project directories."

# Download LVGL (version 8.4.0)
echo "Downloading LVGL 8.4.0..."
mkdir -p "$project_name"/lib/lvgl
curl -L https://github.com/lvgl/lvgl/archive/refs/tags/v8.4.0.zip -o lvgl.zip
unzip lvgl.zip -d "$project_name"/lib/lvgl
rm lvgl.zip
echo "LVGL 8.4.0 downloaded."

# Create src/project_name.ino as a starting point
echo "Creating src/$project_name.ino..."
cat > "$project_name"/src/"$project_name".ino <<EOL
#include <M5Dial.h>
#include <lvgl.h>
#include "ui.h"  // Include generated UI

void my_disp_flush(lv_disp_drv_t *disp, const lv_area_t *area, lv_color_t *color_p) {
    M5Dial.Lcd.startWrite();
    M5Dial.Lcd.setAddrWindow(area->x1, area->y1, lv_area_get_width(area), lv_area_get_height(area));
    M5Dial.Lcd.pushColors((uint16_t*)&color_p->full, lv_area_get_width(area) * lv_area_get_height(area), true);
    M5Dial.Lcd.endWrite();
    lv_disp_flush_ready(disp);
}

void setup() {
    Serial.begin(115200);
    M5Dial.begin();
    lv_init();

    static lv_disp_draw_buf_t draw_buf;
    static lv_color_t buf[240 * 240];
    lv_disp_draw_buf_init(&draw_buf, buf, NULL, M5Dial.Display.width() * M5Dial.Display.height());

    static lv_disp_drv_t disp_drv;
    lv_disp_drv_init(&disp_drv);
    disp_drv.flush_cb = my_disp_flush;
    disp_drv.draw_buf = &draw_buf;
    disp_drv.hor_res = M5Dial.Display.width();
    disp_drv.ver_res = M5Dial.Display.height();
    lv_disp_drv_register(&disp_drv);

    ui_init();  // Load UI from Squareline or EEZStudio
}

void loop() {
    M5Dial.update();
    lv_timer_handler();
    delay(5);
}
EOL
echo "src/$project_name.ino created."

# Add a README.md with basic information
echo "Creating README.md..."
cat > "$project_name"/README.md <<EOL
# $project_name

This is a boilerplate for setting up an **M5Dial** project with **LVGL 8.4.0** using **Arduino 2.x**. It includes support for UIs exported from **Squareline Studio** or **EEZStudio**, and is pre-configured for touch, rotary encoder, and button inputs.

## Installation Instructions:

1. Install Arduino IDE 2.x.
2. Install the following libraries using the Arduino Library Manager:
   - **M5STACK 2.1.2**
   - **TFT_eSPI 2.5.43**
   - **M5Dial 1.0.2**
   - **M5Unified 0.1.16**
   - **lvgl 8.4.0**
3. Copy your exported UI files (e.g., \`ui.h\`, \`ui.c\`) from Squareline or EEZStudio to the \`src\` folder.
4. Open the \`src/$project_name.ino\` file in Arduino IDE and upload it to your M5Dial.

## Customizing \`lv_conf.h\`:

1. Modify the \`lv_conf.h\` file in your LVGL library to match the M5Dial's specs:

   ```c
   #define LV_HOR_RES_MAX 240
   #define LV_VER_RES_MAX 240
   #define LV_COLOR_DEPTH 16
   #define LV_USE_INDEV_TOUCHPAD 1
   #define LV_USE_INDEV_ENCODER 1
   ```

2. Save the file and recompile the project.

## Useful Links:

- [LVGL Documentation](https://docs.lvgl.io/)
- [M5Stack Documentation](https://docs.m5stack.com/)

## Connect with Me:

- [Blog](https://nerudo.substack.com)
- [Twitter](https://x.com/NerdGr8)
- [LinkedIn](https://www.linkedin.com/in/nerudomregi/)

EOL
    
echo "README.md created."

echo "Project '$project_name' scaffold is complete!"
