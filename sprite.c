#include "sprite.h"

static int spriteIndex = 0;
static int tileIndex = 1; //leave the first tile clear so we can hide our sprites.
static byte palette_index = 0;

void ctor(struct Sprite* this, byte* data, int tileWidth, int tileHeight, int frames) {
	int totalTiles = tileWidth * tileHeight;
	this->spriteIndex = spriteIndex;
    this->tileIndex = tileIndex;
	this->tileDimension.width = tileWidth;
	this->tileDimension.height = tileHeight;
	this->frames = frames;
    this->data = data;
	spriteIndex += totalTiles;
    tileIndex += totalTiles;
    this->visible = true;
    this->hidden = false;
}

void sprites_reset() {
    spriteIndex = 0;
    tileIndex = 1;
    palette_index = 0;
    for(int i = 0; i < MAX_HARDWARE_SPRITES; i++)
        set_sprite_tile(i, 0);
}


bool isOnScreen(struct Sprite* this, int screen_x, int screen_y) {
    if(screen_x < -(this->tileDimension.width * 8)  || screen_x > SCREENWIDTH + (this->tileDimension.width * 8))return false;
    if(screen_y < -(this->tileDimension.height * 8) || screen_y > SCREENHEIGHT + (this->tileDimension.height * 8))return false;
    return true;
}

void setFrame(struct Sprite* this, int frame) {
    this->frame = frame;
    if(this->hidden || !this->visible)return;
	int frameOffset = frame * this->tileDimension.width * this->tileDimension.height;
	int totalTiles = this->tileDimension.height * this->tileDimension.height;
    set_sprite_data(this->tileIndex, totalTiles, this->data + (frameOffset * 16));
	for(int i = 0; i < totalTiles; i++)
	{
		set_sprite_tile(this->spriteIndex + i, this->tileIndex + i);
	}
}

void setVisible(struct Sprite* this, bool visible) {
    if(visible == this->visible) return; // no op;
    this->visible = visible;
    int totalTiles = this->tileDimension.width * this->tileDimension.height * this->frames;
    if(!visible) {
        //we leave tile 0 empty so we just set all of our tiles to that
        for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
            set_sprite_tile(i, 0);
    }
    else {
        //set all sprites back to the appropriate tiles
        for(int i = 0; i < totalTiles; i++)
        {
            set_sprite_tile(this->spriteIndex + i, this->tileIndex + i);
        }
    }
}

bool getVisible(struct Sprite* this) {
    return this->visible;
}

void move(struct Sprite* this, int screen_x, int screen_y) {
    if(this->hidden)return;
    if(isOnScreen(this, screen_x, screen_y)) {
        setVisible(this, true);
        for(int x = 0; x < this->tileDimension.width; x++)
        {
            for(int y = 0; y < this->tileDimension.height; y++)
            {
                move_sprite(this->spriteIndex + (y + this->tileDimension.width * x), screen_x + x * 8, screen_y + y * 8);
            }
        }
    }
    else {
        setVisible(this, false);
    }
}

byte createPalette(UWORD first, UWORD second, UWORD third, UWORD fourth) {
	static UWORD palette[4];
	palette[0] = first;
	palette[1] = second;
	palette[2] = third;
	palette[3] = fourth;
	set_sprite_palette(palette_index, 1, palette);
	byte oldIdex = palette_index;
	palette_index++;
	return oldIdex;
}

void setPalette(struct Sprite* this, byte paletteIndex) {
	int totalTiles = this->tileDimension.width * this->tileDimension.height * this->frames;
	for(int i = this->spriteIndex; i < this->spriteIndex + totalTiles; i++)
		set_sprite_prop(i, paletteIndex);
}



void show(struct Sprite* this) {
    this->hidden = false;
    setVisible(this, true);
}

void hide(struct Sprite* this){
    this->hidden = true;
    setVisible(this, false);
}



