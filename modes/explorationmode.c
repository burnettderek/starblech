#include <gb/gb.h>
#include <rand.h>
#include <stdlib.h>
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
#include "../graphics/explosion_tiles.h"
#include "../graphics/gameover.h"

//const UWORD space_pallette[4]={RGB_WHITE, RGB8(0, 200, 255), RGB8(127, 51, 0), 0x000000};
//const UWORD space_pallette[4]={RGB8(128, 128, 128), RGB8(0, 100, 128), RGB8(64, 25, 0), 0x000000};
const UWORD space_pallette[4]={0x000000, RGB8(64, 64, 64), RGB8(0, 50, 64), RGB8(32, 12, 0)};

//struct Planet saturn;
struct GameObject photon;
struct GameObject asteroid;
struct Sprite saturnGraphic;
struct GameObject explosion;
//struct GameObject ship;
struct Dimension mid_screen = { 84, 84 };

struct Sprite photonGraphic;
struct Sprite shipGraphic;
struct Sprite asteroidGraphic;
struct Sprite explosionGraphic;
struct Sprite gameoverGraphic;

void do_explosion(int world_x, int world_y) {
	explosion.isAlive = true;
	explosion.world.x = world_x;
	explosion.world.y = world_y;
	show(&explosionGraphic);
}

void do_gameover(void) {
	/*set_win_tiles(0, 0, gameover_mapWidth, gameover_mapHeight, gameover_map);
	move_win(7, 0);
	const UWORD gameover_pallette[4]={ 0x000000, RGB_WHITE, RGB8(0, 200, 255), RGB8(127, 51, 0) };
	set_bkg_palette(0, 1, gameover_pallette);
	SHOW_WIN;*/
}

struct Vector to_screen(struct Vector* ship, struct Vector* object) {
	struct Vector result;
	result.x = object->x - ship->x + mid_screen.width;
	result.y = object->y - ship->y + mid_screen.height;
	return result;
}

void manage_asteroid(struct GameObject* ship) {
	if(asteroid.isAlive == false){
		byte rando = rand();
		if(rando > 254) {
			asteroid.isAlive = true;
			int randx = (int)rand();
			int randy = (int)rand();
			if(randx < 100)randx += 100; //make sure the asteroid is position at least 100 away
			if(randy < 100)randy += 100;
			if(randx % 2 == 0)randx = -randx; //50% of the time switch the sign so it comes from both sides
			if(randy % 2 == 0)randy = -randy;
			asteroid.world.x = ship->world.x - randx;
			asteroid.world.y = ship->world.y - randy;
			if(asteroid.world.x < ship->world.x)asteroid.vector.x = 1;
			else asteroid.vector.x = -1;
			if(asteroid.world.y < ship->world.y)asteroid.vector.y = 1;
			else asteroid.vector.y = -1;
			int screen_x = asteroid.world.x - ship->world.x + mid_screen.width;
			int screen_y = asteroid.world.y - ship->world.y + mid_screen.height;
			show(&asteroidGraphic);
			move(&asteroidGraphic, screen_x, screen_y);
		}
	} else { //asteroid is alive, check for collisions
		asteroid.world.x += asteroid.vector.x;
		asteroid.world.y += asteroid.vector.y;
		if(photon.isAlive == true && asteroid.world.x/8 == photon.world.x/8 && asteroid.world.y/8 == photon.world.y/8) {
			asteroid.isAlive = false;
			photon.isAlive = false;
			hide(&asteroidGraphic);
			hide(&photonGraphic);
			do_explosion(photon.world.x, photon.world.y);
		}
		if(asteroid.world.x/8 == ship->world.x/8 && asteroid.world.y/8 == ship->world.y/8) {
			asteroid.isAlive = false;
			ship->isAlive = false;
			hide(&asteroidGraphic);
			hide(&shipGraphic);
			do_explosion(ship->world.x, ship->world.y);
			do_gameover();
		}
		if(abs(asteroid.world.x - ship->world.x) > 255 || abs(asteroid.world.y - ship->world.y) > 255) { //we're so far away, kill the asteroid
			asteroid.isAlive = false;
			//hide(&asteroidGraphic);
		}
		else {
			int screen_x = asteroid.world.x - ship->world.x + mid_screen.width;
			int screen_y = asteroid.world.y - ship->world.y + mid_screen.height;
			//if(asteroid.world.x )asteroid.isAlive = false;
			//else 
			move(&asteroidGraphic, screen_x, screen_y);
		}
	}
}

void ExplorationMode_init(struct ExplorationMode* this) {
    SHOW_SPRITES;
	SHOW_BKG;
    HIDE_WIN;
    sprites_reset();
    set_bkg_data(0, 48, space1_tile);
	set_bkg_tiles(0, 0, bckground_mapWidth, bckground_mapHeight, bckground_map);
	set_bkg_palette(0,1, space_pallette);
    this->counter = 0;
    byte ship_pal = createPalette(0xFFFFFF,RGB8(200,200,200),RGB8(127, 127, 127),RGB8(255, 255, 255));
	//byte ter_pal = createPalette(RGB8(255, 255, 255),0x00FF00,RGB8(127, 51, 0),RGB8(255, 255, 255));

	this->exploration_objects = gameobjects(0);

	ctor(&shipGraphic, enterprise_tiles, 2, 2, 8);
	
	setFrame(&shipGraphic, 0);
	move(&shipGraphic, mid_screen.width, mid_screen.height);

    ctor(&saturnGraphic, saturn_tiles, 2, 2, 1);
	setFrame(&saturnGraphic, 0);
	setPalette(&saturnGraphic, createPalette(0, RGB8(255, 200, 200), RGB8(200, 50, 50), RGB8(255, 160, 68)));

	byte fire_pallet = createPalette(0, RGB_WHITE, RGB8(255, 160, 68), RGB_RED);
    photon.isAlive = false;
	ctor(&photonGraphic, photon_tiles, 1, 1, 2);
	setFrame(&photonGraphic, 0);
	setPalette(&photonGraphic, fire_pallet);
	hide(&photonGraphic);

    ctor(&asteroidGraphic, asteroid_tiles, 1, 1, 4);
    setFrame(&asteroidGraphic, 0);
	hide(&asteroidGraphic);
    //setPalette(asteroidGraphic, ship_pal);
    setPalette(&asteroidGraphic, createPalette(0, RGB8(223, 223, 223), RGB8(128, 128, 128), RGB8(64, 64, 64)));
	asteroid.isAlive = false;

	ctor(&explosionGraphic, explosion_tiles, 2, 2, 4);
	setFrame(&explosionGraphic, 0);
	hide(&explosionGraphic);
	setPalette(&explosionGraphic, fire_pallet);
	explosion.isAlive = false;

	/*ctor(&gameoverGraphic, gameover_tiles, 6, 1, 1);
	setFrame(&gameoverGraphic, 0);
	setPalette(&gameoverGraphic, fire_pallet);
	move(&gameoverGraphic, 84, 84);*/
}

void ExplorationMode_update(struct ExplorationMode* this) {
    this->counter++;
    if(this->counter > 10) {
		this->counter = 0;

		if(photon.isAlive){
			photonGraphic.frame++;
			if(photonGraphic.frame > 1)photonGraphic.frame = 0;
			setFrame(&photonGraphic, photonGraphic.frame);
		}
		if(asteroid.isAlive == true){
			asteroidGraphic.frame++;
			if(asteroidGraphic.frame > 3) {
				asteroidGraphic.frame = 0;
			}
			setFrame(&asteroidGraphic, asteroidGraphic.frame);
		}
		if(explosion.isAlive == true) {
			explosionGraphic.frame++;
			if(explosionGraphic.frame > 3) {
				explosion.isAlive = false;
				hide(&explosionGraphic);
				setFrame(&explosionGraphic, 0);
			}
			else {
				setFrame(&explosionGraphic, explosionGraphic.frame);
			}
		}
		
	}
			
	if(photon.isAlive) {
		photon.world.x += photon.vector.x;
		photon.world.y += photon.vector.y;
	}

	struct GameObject* ship = gameobjects(GO_SHIP);
	manage_asteroid(ship);

	if(explosion.isAlive == true){
		struct Vector screen;
		screen = to_screen(&ship->world, &explosion.world);
		move(&explosionGraphic, screen.x, screen.y);
	}
    
}


void ExplorationMode_processInput(struct ExplorationMode* this, byte joypad) {
	int x = 0; int y = 0;
	struct GameObject* ship = this->exploration_objects + GO_SHIP;
    struct GameObject* planet1 = this->exploration_objects + GO_PLANET1;

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
