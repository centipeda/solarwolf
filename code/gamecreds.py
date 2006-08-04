"gamemenu handler. main menu"

import math, os
import pygame
from pygame.locals import *
import game, gfx, snd, txt
import gameplay



credits = (
    ('Developer', ('Pete "ShredWheat" Shinners',)),
    ('Graphics', ('Eero Tamminem',)),
    ('Music', ('"theGREENzebra"',)),
    ('Programming Help', ('Aaron "APS" Schlaegel', 'Michael "MU" Urman')),
    ('Special Thanks', ('David "Futility" Clark', 'Guido "Python" van Rossom', 'Sam "SDL" Lantinga')),
)

licenseinfo = ('This program is free software. You are encouraged to',
               'make copies and modify it, subject to the LGPL.',
               'See "lgpl.txt" file for details.')


fonts = []
images = []

def load_game_resources():
    global fonts, images
    fontname = None
    fonts.append((txt.Font(fontname, 25), (50, 50, 200)))
    fonts.append((txt.Font(fontname, 40), (100, 100, 250)))

    img = gfx.load('oldsolarfox.png')
    r = img.get_rect()
    r.bottomright = gfx.rect.bottomright
    images.append((img, r))

    img = gfx.load('pygame_powered.gif')
    r = img.get_rect().move(540, 20)
    images.append((img, r))

    img = gfx.load('menu_creds_on.png')
    r = img.get_rect().move(20, 5)
    images.append((img, r))

    font = txt.Font(None, 15)
    top = 560
    mid = 400
    for l in licenseinfo:
        t = font.text((50, 150, 150), l, (mid, top))
        top += t[1].height
        images.append(t)

    snd.preload('select_choose')


class GameCreds:
    def __init__(self, prevhandler):
        self.prevhandler = prevhandler
        self.done = 0
        self.center = gfx.rect.centerx - 120
        self.text = []
        self.credits = []
        self.area = Rect(40, 140, 500, 400)
        self.offset = 0
        for cred in credits:
            self.createtext(cred[0], 0)
            for peop in cred[1]:
                self.createtext(peop, 1)
            self.offset += 30
        self.offset = 0.0
        self.oldoffset = 0.0, 0.0
        self.text.extend(images)
        self.first = 1
        self.fade = ((1, 4), (8, 3), (15, 2), (21, 1))

    def createtext(self, text, size):
        f, c = fonts[size]
        t = f.text(c, text, (self.center, 0))
        t[1].top = self.offset
        self.offset = t[1].bottom - 5
        self.credits.append(t)


    def quit(self):
        game.handler = self.prevhandler
        self.done = 1
        snd.play('select_choose')


    def input(self, i):
        self.quit()

    def event(self, e):
        pass


    def run(self):
        if self.first:
            gfx.dirty(gfx.rect)
            self.first = 0
        ratio = game.clockticks / 25
        speedadjust = max(ratio, 1.0)

        self.offset += speedadjust * 0.9
        offset = math.cos(self.offset * .04)*30.0, self.area.bottom-self.offset

        oldclip = gfx.surface.get_clip()
        gfx.surface.set_clip(self.area)
        for cred in self.credits:
            r = cred[1].move(self.oldoffset)
            gfx.dirty(self.background(r))
        gfx.surface.set_clip(oldclip)

        gfx.updatestars(self.background, gfx)

        if not self.done:
            for cred, pos in self.text:
                gfx.surface.blit(cred, pos)
            gfx.surface.set_clip(self.area)
            for cred, pos in self.credits:
                r = pos.move(offset)
                bottom = r.bottom
                gfx.dirty(gfx.surface.blit(cred, r))
            gfx.surface.set_clip(oldclip)

            for y,h in self.fade:
                r = Rect(self.area.left, self.area.top+y, self.area.width, h)
                self.background(r)
                r = Rect(self.area.left, self.area.bottom-y-h, self.area.width, h)
                self.background(r)

            self.oldoffset = offset
            if bottom < self.area.top:
                self.offset = 0.0
        else:
            for text in self.text:
                r = text[1]
                gfx.dirty(self.background(text[1]))

    def background(self, area):
        return gfx.surface.fill((0, 0, 0), area)



