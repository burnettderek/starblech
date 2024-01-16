#include "gameobject.h"

//static struct GameObject* GameObjects = GameObject[OBJECT_TYPE.COUNT];

struct GameObject* gameobjects(int index) {
    static struct GameObject objects[GO_COUNT];
    return &objects[index];
}