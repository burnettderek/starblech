#include <gb/gb.h>
#include "explorationmode.h"
#include "../sprite.h"
#include "../graphics/Enterprise.h"
#include "../graphics/bckground.h"
#include "../graphics/space1.h"
#include "../graphics/terra.h"
#include "../graphics/saturn.h"
#include "../graphics/photon.h"
#include "../model/planet.h"
#include "../model/gameobject.h"
#include "../graphics/asteroid_tiles.h"

//const UWORD space_pallette[4]={RGB_WHITE, RGB8(0, 200, 255), RGB8(127, 51, 0), 0x000000};
const UWORD space_pallette[4]={RGB8(128, 128, 128), RGB8(0, 100, 128), RGB8(64, 25, 0), 0x000000};

//struct Planet saturn;
struct GameObject photon;
struct Sprite saturnGraphic;
//struct GameObject ship;
struct Dimension mid_screen = { 84, 84 };

struct Sprite photonGraphic;
struct Sprite shipGraphic;
struct Sprite asteroidGraphic;

void ExplorationMode_init(struct ExplorationMode* this) {
    SHOW_SPRITES;
	SHOW_BKG;
    HIDE_WIN;
    sprites_reset();
    set_bkg_data(0, 12, space1_tile);
	set_bkg_tiles(0, 0, bckground_mapWidth, bckground_mapHeight, bckground_map);
	set_bkg_palette(0,1, space_pallette);
    this->counter = 0;
    byte ship_pal = createPalette(0xFFFFFF,RGB8(200,200,200),RGB8(127, 127, 127),RGB8(255, 255, 255));
	//byte ter_pal = createPalette(RGB8(255, 255, 255),0x00FF00,RGB8(127, 51, 0),RGB8(255, 255, 255));

	
	ctor(&shipGraphic, enterprise_tiles, 2, 2, 8);
	
	setFrame(&shipGraphic, 0);
	move(&shipGraphic, mid_screen.width, mid_screen.height);

    ctor(&saturnGraphic, saturn_tiles, 2, 2, 1);
	setFrame(&saturnGraphic, 0);
	setPalette(&saturnGraphic, createPalette(0, RGB8(255, 200, 200), RGB8(200, 50, 50), RGB8(255, 160, 68)));

    photon.isAlive = false;
	ctor(&photonGraphic, photon_tiles, 1, 1, 2);
	setFrame(&photonGraphic, 0);
	setPalette(&photonGraphic, createPalette(0, RGB_RED, RGB8(255, 160, 68), RGB_WHITE));
	hide(&photonGraphic);

    ctor(&asteroidGraphic, asteroid_tiles, 1, 1, 4);
    setFrame(&asteroidGraphic, 0);
    //setPalette(asteroidGraphic, ship_pal);
    setPalette(&asteroidGraphic, createPalette(0, RGB8(223, 223, 223), RGB8(128, 128, 128), RGB8(64, 64, 64)));

}

void ExplorationMode_update(struct ExplorationMode* this) {
    this->counter++;
    if(this->counter > 10) {
		this->counter = 0;

        photonGraphic.frame++;
        if(photonGraphic.frame > 1)photonGraphic.frame = 0;
		setFrame(&photonGraphic, photonGraphic.frame);

        asteroidGraphic.frame++;
        if(asteroidGraphic.frame > 3) {
            asteroidGraphic.frame = 0;
        }
        setFrame(&asteroidGraphic, asteroidGraphic.frame);
	}
			//processJoyPad(joypadCurrent, &shipGraphic);

			
	if(photon.isAlive) {
		photon.world.x += photon.vector.x;
		photon.world.y += photon.vector.y;
	}

    move(&asteroidGraphic, 52, 52);
}


void ExplorationMode_processInput(struct ExplorationMode* this, byte joypad) {
	int x = 0; int y = 0;
	struct GameObject* ship = gameobjects(GO_SHIP);
    struct GameObject* planet1 = gameobjects(GO_PLANET1);

	if(joypad & J_B) {
	}
	if (joypad & J_RIGHT)
    {
        x++;
    }

    // check if the left joypad button is pressed
    if (joypad & J_LEFT)
    {
        x--;
    }

    // check if the down joypad button is pressed
    if (joypad & J_DOWN)
    {
        y++;
    }

    // check if the up joypad button is pressed
    if (joypad & J_UP)
    {
        y--;
    }

	if(joypad & J_A) {
		if(photon.isAlive == false){
			photon.world.x = ship->world.x + 8;
			photon.world.y = ship->world.y + 4;
			show(&photonGraphic);
			photon.isAlive = true;
			photon.vector.x = ship->vector.x * 2;
			photon.vector.y = ship->vector.y * 2;
		}
	}
	if(x == 0 & y < 0)setFrame(&shipGraphic, 0);
	if(x > 0 & y == 0)setFrame(&shipGraphic, 1);
	if(x == 0 & y > 0)setFrame(&shipGraphic, 2);
	if(x < 0 & y == 0)setFrame(&shipGraphic, 3);
	if(x < 0 & y < 0)setFrame(&shipGraphic, 4);
	if(x > 0 & y < 0)setFrame(&shipGraphic, 5);
	if(x > 0 & y > 0)setFrame(&shipGraphic, 6);
	if(x < 0 & y > 0)setFrame(&shipGraphic, 7);
    
	ship->world.x += x;
	ship->world.y += y;
	if(x != 0 || y != 0) { //if we pushed something store it as the new vector.
		ship->vector.x = x;
		ship->vector.y = y;
	}

	int screen_x = planet1->world.x - ship->world.x + mid_screen.width;
	int screen_y = planet1->world.y - ship->world.y + mid_screen.height;
	move(&saturnGraphic, screen_x, screen_y);

	screen_x = photon.world.x - ship->world.x + mid_screen.width;
	screen_y = photon.world.y - ship->world.y + mid_screen.height;
	if(!isOnScreen(&photonGraphic, screen_x, screen_y)) {
		photon.isAlive = false;
		hide(&photonGraphic);
	} else 	move(&photonGraphic, screen_x, screen_y);
	scroll_bkg(x, y);
}
