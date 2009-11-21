# Makefile for creating orthographics animation images from
# the PovRay v3.5 3D models. Requires _GNU_ make.
#
# Before you add animation creation in this Makefile, you
# can test animating your 'name.pov' with a command like:
#   make NAME=name WD=xx HT=yy FRAMES=kk OPT='options' BLUR=1 anim
#
# WD, HT, OPT and BLUR parameters are optional. If you don't want
# povray to wait for user click after each rendering, give
# BATCH=1 as an additional argument.
#
# If you want to keep individial frames, give NO_RM=1 as extra arg.
#
# (w) 2003 by Eero Tamminen

# ---------------- default values -------------------------

# make batch mode the default
BATCH = 1

ifndef WD
WD := 128
endif

ifndef HT
HT := 128
endif

# PovRay with default flags
POVRAY = povray +FN +DTC +A0.3 -J +UA -P

ifdef BATCH
POVRAYP = $(POVRAY)
else
# wait until user clicks
POVRAYP = $(POVRAY) +P
endif

# ----------------- animation rules -----------------------

ifdef NAME

# I'm using submake to create animations because with
# shell-script you'd need to separately handle errors
# and Make does it automatically.

anim:
	$(RM) $(NAME).png
	$(POVRAY) +I$(NAME).pov +W$(WD) +H$(HT) +KFF$(FRAMES) $(OPT)
ifdef BLUR
	./blur.sh $(NAME)[0-9]*.png
endif
	-convert +append $(NAME)[0-9]*.png $(NAME).png
ifndef NO_RM
	$(RM) $(NAME)[0-9]*.png
endif
else

# ---------------- default dependencies -----------------------

# all models
POV = $(wildcard *.pov)
PNG = $(patsubst %.pov, %.png, $(POV))

all: $(PNG)

# default rule for other POV files
%.png: %.pov camera-ortho.inc lights.inc
	$(POVRAYP) +I$< +W$(WD) +H$(HT)

# -------------------- animations -----------------------------

# explicit rules are separated into animations that use submake
# and single frames which just use povray.  They are sorted
# alphabetically so that the rules are easier to find and in
# the same order as Make will execute them with the 'all' rule.
#
# OPT=+KC makes the animation cyclic.

asteroid.png: asteroid.pov
	$(MAKE) NAME=asteroid WD=32 HT=32 FRAMES=24 OPT=+KC anim

baddie.png: baddie.pov baddie.inc fire.inc
	$(MAKE) NAME=baddie WD=64 HT=32 FRAMES=16 anim

baddie-teleport.png: baddie-teleport.pov baddie.inc teleport.inc
	$(MAKE) NAME=baddie-teleport WD=64 HT=32 FRAMES=32 OPT=+KC anim

bonus-bullet.png: bonus-bullet.pov bonus.inc
	$(MAKE) NAME=bonus-bullet WD=32 HT=32 FRAMES=4 OPT=+KC anim

bonus-shield.png: bonus-shield.pov bonus.inc
	$(MAKE) NAME=bonus-shield WD=32 HT=32 FRAMES=4 anim

debris1.png: debris1.pov debris.inc
	$(MAKE) NAME=debris1 WD=10 HT=10 FRAMES=8 anim

debris2.png: debris2.pov debris.inc
	$(MAKE) NAME=debris2 WD=10 HT=10 FRAMES=8 anim

debris3.png: debris3.pov debris.inc
	$(MAKE) NAME=debris3 WD=10 HT=10 FRAMES=8 anim

debris4.png: debris4.pov debris.inc
	$(MAKE) NAME=debris4 WD=10 HT=10 FRAMES=8 anim

debris-base.png: debris-base.pov ship.inc
	$(MAKE) NAME=debris-base WD=28 HT=28 FRAMES=8 anim

debris-bubble.png: debris-bubble.pov ship.inc
	$(MAKE) NAME=debris-bubble WD=12 HT=12 FRAMES=8 anim

debris-motor.png: debris-motor.pov ship.inc
	$(MAKE) NAME=debris-motor WD=10 HT=10 FRAMES=8 anim

explosion.inc: explosion.py
	python $< > $@

explosion.png: explosion.pov explosion.inc
	$(MAKE) NAME=explosion WD=48 HT=48 FRAMES=16 anim

fire.png: fire.pov fire.inc
	$(MAKE) NAME=fire WD=24 HT=24 FRAMES=8 OPT=+KC anim

shielder.png: shielder.pov
	$(MAKE) NAME=shielder WD=10 HT=10 FRAMES=3 anim

ship-up-boost1.png: ship-up-boost1.pov ship.inc
	$(MAKE) NAME=ship-up-boost1 WD=32 HT=32 FRAMES=4 OPT=+KC anim

ship-up-boost2.png: ship-up-boost2.pov ship.inc
	$(MAKE) NAME=ship-up-boost2 WD=32 HT=32 FRAMES=4 OPT=+KC anim

ship-teleport.png: ship-teleport.pov teleport.inc ship.inc
	$(MAKE) NAME=ship-teleport WD=32 HT=32 FRAMES=24 OPT=+KC anim

ship-warp.png: ship-warp.pov ship.inc
	$(MAKE) NAME=ship-warp WD=48 HT=32 FRAMES=12 anim

spikeball.png: spikeball.pov
	$(MAKE) NAME=spikeball WD=24 HT=24 FRAMES=12 OPT=+KC anim

# --------------------- stilleben ----------------------------

ship-big.png: ship-big.pov ship.inc
	$(POVRAYP) +I$< +W240 +H240 +K0.2

ship-up.png: ship-up.pov ship.inc
	$(POVRAYP) +I$< +W32 +H32

ship-mini-boost2.png: ship-mini-boost2.pov ship.inc
	$(POVRAYP) +I$< +W25 +H25

# ------------- viewing, cleaning, packaging -----------------

endif # NAME

showanim: showanim.c
	$(CC) -Wall -O -o $@ $^ $$(sdl-config --cflags --libs) -lSDL_image

show: showanim $(PNG)
	@./animshow.sh $(PNG)

clean:
	$(RM) *~ showanim *.o

distclean: clean
	$(RM) *.png


PKG = solarwolf-gfx

dist: all clean
	$(RM) $(PKG)*.tar.gz
	cd ..; tar -zcvf $(PKG)-sprite.tar.gz $(PKG)/*.png
	cd ..; tar -zcvf $(PKG)-src.tar.gz --exclude CVS --exclude '*.png' $(PKG)/
	mv ../$(PKG)*.tar.gz ./
	ls -l $(PKG)*.tar.gz
