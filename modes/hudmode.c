#include <gb/gb.h>
#include "hudmode.h"
#include "../sprite.h"
#include "../model/gameobject.h"
#include "../graphics/sensor_screen.h"
#include "../graphics/sensor_tiles.h"
#include "../graphics/sensor_sprites.h"

#define BORDER 0
#define SENSORS_LONG 100
#define SENSORS_SHORT 1
static int HUD_SCALE = 20;
const UWORD hud_pallette[4]={RGB_BLACK, RGB8(58, 0, 0), RGB_YELLOW, RGB8(0, 200, 255)};


struct Sprite planetSprite;

void Hud_init(struct Hud* this) {
    this->sensorLevel = SENSORS_LONG;
    HIDE_BKG;
    SHOW_WIN;
    sprites_reset();
    this->screen_position.x = 7 + BORDER;
    this->screen_position.y = 17 * 8;
    set_win_data(0, 15, sensor_tiles);
    set_win_tiles(0, 0, sensor_screenWidth, sensor_screenHeight, sensor_screen);
    move_win(this->screen_position.x, this->screen_position.y);
	set_bkg_palette(0,1, hud_pallette);
    sprite_init(&planetSprite, sensor_sprites, RENDER_16X16, 2, 2, 1);
    setFrame(&planetSprite, 0);
    //move(&planetSprite, 70, 70);
    byte planetPalette = create_palette(RGB_BLACK, RGB_YELLOW, RGB_ORANGE, RGB_RED);
    setPalette(&planetSprite, planetPalette);    
}

void Hud_drawScreen(struct Hud* this) {
    
    if(this->screen_position.y > BORDER) {
        this->screen_position.y -= 12;  
        if(this->screen_position.y < BORDER)this->screen_position.y = BORDER;
        move_win(this->screen_position.x, this->screen_position.y);
    }
    const int center_offset_x = (SCREENWIDTH/2); //8 = 1/2 tile width
    const int center_offset_y = (SCREENHEIGHT/2) + 8; 
    struct GameObject* ship = gameobjects(GO_SHIP);
    struct GameObject* planet1 = gameobjects(GO_PLANET1);
    int screen_x = (planet1->world.x - ship->world.x)/HUD_SCALE + center_offset_x;
	int screen_y = (planet1->world.y - ship->world.y)/HUD_SCALE + center_offset_y;
    if(screen_y < 20)hide(&planetSprite);
    else { 
        show(&planetSprite);
	    move(&planetSprite, screen_x, screen_y);
    }
}

void Hud_processInput(struct Hud* this, byte joypad) {
    /*if (joypad & J_RIGHT) {
        this->sensorLevel = SENSORS_SHORT;
        set_win_tile_xy(12, 0, 10);
        set_win_tile_xy(8, 0, 1);
    }
    if (joypad & J_LEFT) {
        this->sensorLevel = SENSORS_LONG;
        set_win_tile_xy(8, 0, 10);
        set_win_tile_xy(12, 0, 1);
    }*/
}
