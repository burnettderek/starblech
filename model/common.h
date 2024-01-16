#ifndef COMMON_H
#define COMMON_H
#include <gbdk/platform.h>
typedef uint8_t byte;
typedef byte bool;
#define Position Vector

#define true 1
#define false 0

struct Position {
    int x;
    int y;
};

//typedef struct Position Vector;
/*struct Vector {
    int x;
    int y;
};*/

struct Dimension {
    int width;
    int height;
};
#endif