#ifndef GAMEOBJECT_H
#define GAMEOBJECT_H
#include "common.h"

typedef enum {
    GO_SHIP = 0,
    GO_PLANET1,
    GO_COUNT
} OBJECT_TYPE;

typedef struct GameObject {
    struct Position world;
    bool isAlive;
    struct Vector vector;
}GameObject;

struct GameObject* gameobjects(int index);

#endif