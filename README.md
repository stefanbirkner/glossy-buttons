Twitter Bootstrap with glossy buttons
=====================================

This project creates Twitter bootstrap with glossy buttons instead of gradient buttons. Simply execute

    make

and you find Bootstrap at `./target/bootstrap`.

Prerequisites
-------------

You need all prerequisites of Bootstrap. Additionally you need ImageMagick and apparently GNU make.

Configuration
-------------

If you need a different alpha for the gloss effect, you can change it in the `Makefile`. There is a variable called `ALPHA` at the top, which is set to `grey25`.
