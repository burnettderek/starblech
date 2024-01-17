#include <gbdk/platform.h>
#include <rand.h>
#include "modes/hudmode.h"
#include "modes/explorationmode.h"
#include "model/gameobject.h"

#define EXPLORATION_MODE 1
#define START_SCREEN_MODE 2
#define HUD_MODE 3

int gameState = EXPLORATION_MODE;

byte joypadCurrent=0;

struct Hud hud;
struct ExplorationMode explorationMode;

void init_game() {
	initrand(DIV_REG);
	struct GameObject* ship = gameobjects(GO_SHIP);
	ship->world.x = 0;
	ship->world.y = 0;
	ship->vector.x = 0;
	ship->vector.y = 1;

	struct GameObject* planet1 = gameobjects(GO_PLANET1);
	planet1->world.x = -64;
	planet1->world.y = -64;

}

void main(void)
{
    DISPLAY_ON;
	init_game();

	ExplorationMode_init(&explorationMode);
	int wait = 0;
    // Loop forever
    while(1) {
		if(wait > 0)wait++;
		if(wait > 50)wait = 0;
		joypadCurrent=joypad();
		if (joypadCurrent & J_START && wait == 0)
		{
			switch (gameState)
			{
			case EXPLORATION_MODE:
				gameState = HUD_MODE;
				Hud_init(&hud);
				wait = 1;
				break;
			case HUD_MODE:
				gameState = EXPLORATION_MODE;
				ExplorationMode_init(&explorationMode);
				wait = 1;
				break;
			default:
				break;
			}
		}

		switch (gameState)
		{
		case EXPLORATION_MODE:
			ExplorationMode_update(&explorationMode);
			ExplorationMode_processInput(&explorationMode, joypadCurrent);
			break;
		case HUD_MODE:
			Hud_processInput(&hud, joypadCurrent);
			Hud_drawScreen(&hud);
			break;
		default:
			break;
		}
		
		/*if(gameState == EXPLORATION_MODE) {
			ExplorationMode_update(&explorationMode);
			ExplorationMode_processInput(&explorationMode, joypadCurrent);
			
		}
		else if(gameState == HUD_MODE) {
			Hud_processInput(&hud, joypadCurrent);
			Hud_drawScreen(&hud);
		}*/
		// Done processing, yield CPU and wait for start of next frame
        wait_vbl_done();
    }
}

