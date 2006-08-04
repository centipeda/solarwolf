"""in game help screens"""

import math
import pygame
from pygame.locals import *
import game
import gfx, snd, txt
import input
import gameplay

fonts = []

def load_game_resources():
    fonts.append(txt.Font('sans', 16, italic=1))
    fonts.append(txt.Font('sans', 18, bold=1))
    snd.preload('chimein', 'chimeout')


Help = {
"player":"""SolarWolf Help
You pilot the mighty SolarWolf fleet of ships.
-
There are no weapons, but it has the most
advanced manuevering of it's kind.
-
Take advantage of the Hyper Jets by holding the action button.
(usually space bar or the joystick button)
-
Collect all the Power Cubes on each level to advance.""",

"multibox":"""Color Power Cubes
Some power cubes will have alternate colors, which means
the SolarWolf ship must contact the cube multiple times
for it to be collected.""",

"guardians":"""Guardian Information
The Red Guardians protect the Power Cubes on every level.
They will become more aggressive in the later levels.
-
There is no way to stop or disable them.""",

"asteroids":"""Asteroid Warning
Asteroids have started to appear. They will destroy anything
they touch.
-
As you progress to deeper space, more asteroids will start to appear.""",

"powerup":"""Power Ups
When the green Power Ups appear be sure to grab them. They
will grant you with special abilities and bonuses.
-
As you reach harder levels the power ups will
have better effects.""",

"skip":"""Skip Level Timer
On the right side of the screen you see the large red
Skip A Level Timer. If you can clear a level before the
timer runs out, you will automatically skip the next level.""",

"Skip Bonus":"""Time Skip Power Up
This powerup adds more time to the Skip A Level Timer for a little while.
-
Collecting this prize makes it
much easier to pass the level and beat the skip timer.""",

"Shot Blocker":"""Shot Blocker Power Up
This Power Up destroys all the bullets currently in space.
It can be a life saver when things have gotten crazy.""",

"Shield":"""Shield Power Up
This powerup enables a temporary shield on your SolarWolf
ship. You will also be able to fly faster through space
when the shield is active.
-
Beware, the shield does not protect you from the Asteroids.
-
You will are given a second of invincibility even after the
shield wears out.""",

"Bullet Time":"""Bullet Time Power Up
This powerup enhances temporarily enhances your reflexes
which makes everything appear to move slowly.
-
Watch closely at the end, as time will slowly speed up
before returning to full speed.""",

"Extra Life":"""Extra Life Power Up
This powerup adds another SolarWolf ship to your fleet.
-
With skilled play and this prize you can collect many
more ships than the original fleet of 3.""",

}


def help(helpname, helppos):
    if not game.player.help.has_key(helpname):
        game.player.help[helpname] = 1
        game.handler = GameHelp(game.handler, helpname, helppos)



class GameHelp:
    def __init__(self, prevhandler, helpname, helppos):
        self.prevhandler = prevhandler
        self.helpname = helpname
        self.helppos = helppos
        self.time = 0.0
        self.img = None
        self.rect = None
        self.needdraw = 1
        self.done = 0
        if snd.music:
            snd.music.set_volume(0.6)
        snd.play('chimein')

        if hasattr(game.handler, 'player'):
            game.handler.player.cmd_turbo(0)

    def quit(self):
        snd.play('chimeout')
        if snd.music:
            snd.music.set_volume(1.0)
        if self.rect:
            r = self.rect.inflate(2, 2)
            r = self.background(r)
            gfx.dirty(r)
        game.handler = self.prevhandler
        self.done = 1

    def input(self, i):
        if self.time > 30.0:
            self.quit()

    def event(self, e):
        pass


    def drawhelp(self, name, pos):
        if Help.has_key(name):
            text = Help[name]
            lines = text.splitlines()
            for x in range(1, len(lines)):
                if lines[x] == '-':
                    lines[x] = "\n\n"
            title = lines[0]
            text = ' '.join(lines[1:])
        else:
            title = name
            text = "no help available"

        self.img = fonts[0].textbox((255, 240, 200), text, 260, (50, 100, 50), 30)
        r = self.img.get_rect()
        titleimg, titlepos = fonts[1].text((255, 240, 200), title, (r.width/2, 10))
        self.img.blit(titleimg, titlepos)
        r.topleft = pos
        r = r.clamp(game.arena)
        alphaimg = pygame.Surface(self.img.get_size())
        alphaimg.fill((50, 100, 50))
        alphaimg.set_alpha(192)
        gfx.surface.blit(alphaimg, r)
        self.img.set_colorkey((50, 100, 50))
        self.rect = gfx.surface.blit(self.img, r)
        gfx.dirty(self.rect)


    def run(self):
        if self.needdraw:
            self.needdraw = 0
            self.drawhelp(self.helpname, self.helppos)

        ratio = game.clockticks / 25
        speedadjust = max(ratio, 1.0)
        self.time += speedadjust

        if not self.done:
            pts = (self.rect.topleft, self.rect.topright,
                  self.rect.bottomright, self.rect.bottomleft)
            s = gfx.surface
            clr = 40, 80, 40
            gfx.dirty(pygame.draw.line(s, clr, pts[0], pts[1]))
            gfx.dirty(pygame.draw.line(s, clr, pts[1], pts[2]))
            gfx.dirty(pygame.draw.line(s, clr, pts[2], pts[3]))
            gfx.dirty(pygame.draw.line(s, clr, pts[3], pts[0]))
            off = int(self.time * 0.9)
            r = 255
            g = int(220 + math.cos(self.time * .2) * 30)
            b = int(180 + math.cos(self.time * .2) * 65)
            clr = r, g, b
            gfx.drawvertdashline(s, pts[0], pts[3], clr, 10, off)
            gfx.drawvertdashline(s, pts[1], pts[2], clr, 10, -off)
            gfx.drawhorzdashline(s, pts[0], pts[1], clr, 10, off)
            gfx.drawhorzdashline(s, pts[3], pts[2], clr, 10, -off)


        #gfx.updatestars(self.background, gfx)


    def background(self, area):
        return gfx.surface.fill((0, 0, 0), area)



