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

"""text and font classes, helps everyone to text"""

import pygame.font, gfx

from pygame.sysfont import SysFont


FontPool = {}



def initialize():
    pygame.font.init()
    return 1


class Font:
    def __init__(self, name, size, bold=0, italic=0):
        val = name, size
        if FontPool.has_key(val):
            font = FontPool[val]
        else:
            font = SysFont(name, size, bold, italic)
            FontPool[val] = font
        self.font = font
        if size >= 20:
            self.text = self.textshadowed

    def render(self, *args):
        return self.font.render(*args)

    def set_underline(self, *args):
        return self.font.set_underline(*args)

    def set_italic(self, *args):
        return self.font.set_italic(*args)

    def set_bold(self, *args):
        return self.font.set_bold(*args)

    def _positionrect(self, img, center, pos):
        r = img.get_rect()
        if center:
            setattr(r, pos, center)
        return r

    def get_height(self):
        return self.font.get_height()

    def get_linesize(self):
        return self.font.get_linesize()

    def text(self, color, text, center=None, pos='center', bgd=(0,0,0)):
        if text is None: text = ' '
        try:
            if gfx.surface.get_bytesize()>1:
                img = self.font.render(text, 1, color, bgd)
                img.set_colorkey(bgd, pygame.RLEACCEL)
            else:
                img = self.font.render(text, 0, color)
        except (pygame.error, TypeError):
            img = pygame.Surface((10, 10))
        img = img.convert()
        r = self._positionrect(img, center, pos)
        return [img, r]


    def textlined(self, color, text, center=None, pos='center'):
        darkcolor = [int(c/2) for c in color]
        if text is None: text = ' '
        try:
            if gfx.surface.get_bytesize()>1:
                img1 = self.font.render(text, 1, color)
                img2 = self.font.render(text, 1, darkcolor)
            else:
                img1 = img2 = self.font.render(text, 0, color)
                img2 = self.font.render(text, 0, darkcolor)
        except (pygame.error, TypeError):
            img1 = img2 = pygame.Surface((10, 10))

        newsize = img1.get_width()+4, img1.get_height()+4
        img = pygame.Surface(newsize)
        img.blit(img2, (0, 0))
        img.blit(img2, (0, 4))
        img.blit(img2, (4, 0))
        img.blit(img2, (4, 4))
        img.blit(img1, (2, 2))
        img = img.convert()
        img.set_colorkey((0,0,0), pygame.RLEACCEL)
        r = self._positionrect(img, center, pos)
        return [img, r]


    def textshadowed(self, color, text, center=None, pos='center'):
        darkcolor = [int(c/2) for c in color]
        if text is None: text = ' '
        try:
            if gfx.surface.get_bytesize()>1:
                img1 = self.font.render(text, 1, color)
                img2 = self.font.render(text, 1, darkcolor)
            else:
                img1 = img2 = self.font.render(text, 0, color)
                img2 = self.font.render(text, 0, darkcolor)
        except (pygame.error, TypeError):
            img1 = img2 = pygame.Surface((10, 10))

        newsize = img1.get_width()+2, img1.get_height()+2
        img = pygame.Surface(newsize)
        img.blit(img2, (2, 2))
        img.blit(img1, (0, 0))
        img = img.convert()
        img.set_colorkey((0,0,0), pygame.RLEACCEL)
        r = self._positionrect(img, center, pos)
        return [img, r]




    def textbox(self, color, text, width, bgcolor, topmargin=6):
        sidemargin = 6
        lines = []
        for line in text.splitlines():
            cursize = 0
            build = ''
            for word in line.split():
                wordspace = word + ' '
                size = self.font.size(wordspace)[0]
                if size + cursize >= width:
                    lines.append(build)
                    cursize = size
                    build = wordspace
                else:
                    build += wordspace
                    cursize += size
            lines.append(build)

        lineheight = self.font.get_linesize()
        height = len(lines) * lineheight + topmargin + sidemargin
        width += sidemargin * 2
        surf = pygame.Surface((width, height))
        surf.fill(bgcolor)
        pos = topmargin
        for line in lines:
            if line:
                img = self.font.render(line, 1, color, bgcolor)
                img.set_colorkey(bgcolor)
                surf.blit(img, (sidemargin, pos))
            pos += lineheight

        return surf
