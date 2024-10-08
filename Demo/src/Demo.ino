#include <M5Dial.h>  // M5Dial specific library
#include <lvgl.h>    // LVGL library for GUI
#include "ui.h"   // Squareline Studio generated UI

// LVGL objects
lv_obj_t *label_menu;
static lv_indev_drv_t indev_drv;

// Display flushing function for M5Dial
void my_disp_flush(lv_disp_drv_t *disp, const lv_area_t *area, lv_color_t *color_p) {
    M5Dial.Lcd.startWrite();
    M5Dial.Lcd.setAddrWindow(area->x1, area->y1, lv_area_get_width(area), lv_area_get_height(area));
    M5Dial.Lcd.pushColors((uint16_t*)&color_p->full, lv_area_get_width(area) * lv_area_get_height(area), true);
    M5Dial.Lcd.endWrite();
    lv_disp_flush_ready(disp);
}

// Touch input handling for LVGL
static void touch_read(lv_indev_drv_t * indev_drv, lv_indev_data_t * data) {
    if (M5.Touch.getCount() > 0) {
        const m5::Touch_Class::touch_detail_t &touch = M5.Touch.getDetail(0);
        if (touch.isPressed()) {
            data->state = LV_INDEV_STATE_PR;
            data->point.x = touch.x;
            data->point.y = touch.y;
        } else {
            data->state = LV_INDEV_STATE_REL;
        }
    } else {
        data->state = LV_INDEV_STATE_REL;
    }
}

// Encoder input handling for LVGL
static void encoder_read(lv_indev_drv_t * indev_drv, lv_indev_data_t * data) {
    int encoderValue = M5Dial.Encoder.read();
    data->enc_diff = encoderValue - prevEncoderPos;
    prevEncoderPos = encoderValue;

    if (M5Dial.BtnA.isPressed()) {
        data->state = LV_INDEV_STATE_PR;
    } else {
        data->state = LV_INDEV_STATE_REL;
    }
}

void setup() {
    // Initialize Serial and M5Dial
    Serial.begin(115200);
    auto cfg = M5.config();
    M5Dial.begin(cfg, true, false);  // Initialize M5Dial with display and no I2C

    // Initialize LVGL
    lv_init();

    // Initialize display buffer
    static lv_disp_draw_buf_t draw_buf;
    static lv_color_t buf[240 *  240];
    lv_disp_draw_buf_init(&draw_buf, buf, NULL, M5Dial.Display.width() * M5Dial.Display.height());

    // Initialize display driver
    static lv_disp_drv_t disp_drv;
    lv_disp_drv_init(&disp_drv);
    disp_drv.flush_cb = my_disp_flush;
    disp_drv.draw_buf = &draw_buf;
    disp_drv.hor_res = M5Dial.Display.width();
    disp_drv.ver_res = M5Dial.Display.height();
    lv_disp_drv_register(&disp_drv);

    // Initialize the touch input driver
    static lv_indev_drv_t touch_indev_drv;
    lv_indev_drv_init(&touch_indev_drv);
    touch_indev_drv.type = LV_INDEV_TYPE_POINTER;
    touch_indev_drv.read_cb = touch_read;
    lv_indev_drv_register(&touch_indev_drv);

    // Initialize the encoder input driver
    static lv_indev_drv_t indev_drv;
    lv_indev_drv_init(&indev_drv);
    indev_drv.type = LV_INDEV_TYPE_ENCODER;
    indev_drv.read_cb = encoder_read;
    lv_indev_drv_register(&indev_drv);

    // Load the UI created in Squareline Studio
    ui_init();  // This function initializes the UI as defined in the "ui.h" file
}

void loop() {
    M5Dial.update();  // Update M5Dial state (buttons, encoder, touch)
    lv_timer_handler();  // Let LVGL handle the rendering and input
    delay(5);  // Small delay to prevent the loop from running too fast
}
