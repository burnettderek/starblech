#ifndef HUD_H
#define HUD_H
#include "../model/common.h"

struct Hud {
    struct Position screen_position;
    int sensorLevel;
};

void Hud_init(struct Hud* this);

void Hud_drawScreen(struct Hud* this);

void Hud_processInput(struct Hud* this, byte joypad);

#endif