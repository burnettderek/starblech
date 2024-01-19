#ifndef EXPLORATIONMODE_H
#define EXPLORATIONMODE_H
#include "../model/common.h"

typedef struct ExplorationMode {
    int counter;
    struct GameObject* exploration_objects;
    byte gameover_fader;
};

void ExplorationMode_init(struct ExplorationMode* this);

void ExplorationMode_update(struct ExplorationMode* this);

void ExplorationMode_processInput(struct ExplorationMode* this, byte joypad);

#endif