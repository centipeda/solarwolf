# solarwolf - collecting and dodging arcade game
# Copyright (C) 2006  Pete Shinners <pete@shinners.org>
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

#player ship class

from pygame.locals import Rect
import game, gfx
from random import randint
import gameinit

class Stars:
    def __init__(self):
        stars = []
        scrwide, scrhigh = gfx.rect.size
        self.maxstars = 800
        for _ in range(self.maxstars):
            val = randint(1, 3)
            color = val*40+60, val*35+50, val*22+100
            speed = -val, val
            rect = Rect(randint(0, scrwide), randint(0, scrhigh), 1, 1)
            stars.append([rect, speed, color])
        half = self.maxstars / 2
        self.stars = stars[:half], stars[half:]
        self.numstars = 50
        self.dead = 0
        self.odd = 0


    def recalc_num_stars(self, fps):
        if isinstance(game.handler, gameinit.GameInit):
            #don't change stars while loading resources
            return
        change = int((fps - 35.0) * 1.8)
        change = min(change, 12) #limit how quickly they can be added
        numstars = self.numstars + change
        numstars = max(min(numstars, self.maxstars/2), 0)
        if numstars < self.numstars:
            DIRTY, BGD = gfx.dirty, self.last_background
            for star in self.stars[self.odd][numstars:self.numstars]:
                DIRTY(BGD(star[0]))
        self.numstars = numstars
        #print 'STAR:', numstars, fps, change


    def erase_tick_draw(self, background, gfx):
        R, B = gfx.rect.bottomright
        FILL, DIRTY = gfx.surface.fill, gfx.dirty
        for s in self.stars[self.odd][:self.numstars]:
            DIRTY(background(s[0]))
        self.odd = not self.odd
        for rect, (xvel, yvel), col in self.stars[self.odd][:self.numstars]:
            rect.left = (rect.left + xvel) % R
            rect.top = (rect.top + yvel) % B
            DIRTY(FILL(col, rect))
        self.last_background = background


    def eraseall(self, background, gfx): #only on fullscreen switch
        for s in self.stars[0][:self.numstars]:
            background(s[0])
        for s in self.stars[1][:self.numstars]:
            background(s[0])

