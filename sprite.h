#ifndef SPRITE_H
#define SPRITE_H
#include <gbdk/platform.h>
#include "model/common.h"

typedef enum {
  RENDER_8X8,
  RENDER_16X16,
} RENDER_MODE;

struct Sprite {
  int spriteIndex;
  int tileIndex;
  RENDER_MODE renderMode;
  struct Position position;
  struct Dimension tileDimension;
  int frames;
  int frame;
  bool visible;
  bool hidden;
  byte* data;
};

//Creates a sprite from an array of 8x8 tiles arranged in frames.
void sprite_init(struct Sprite* this, byte* data, RENDER_MODE renderMode, int tileWidth, int tileHeight, int frames);

//Sets the frame to draw to the screen
void setFrame(struct Sprite* this, int frame);

//Moves the sprite to screen position x, y
void move(struct Sprite* this, int x, int y);

//Creates a sprite pallet (you get 7)
byte create_palette(UWORD first, UWORD second, UWORD third, UWORD fourth);

void update_palette(byte hPallet, UWORD first, UWORD second, UWORD third, UWORD fourth);

bool isOnScreen(struct Sprite* this, int screen_x, int screen_y);

//sets the pallette to what was created by createPallette
void setPalette(struct Sprite* this, byte palletteIndex);

void show(struct Sprite* this);

void hide(struct Sprite* this);

void sprites_reset(void);

#endif