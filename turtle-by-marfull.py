#!/usr/bin/env python
# -*- coding: utf-8 -*-
# By Marfull, long time ago.
# Version 1.0, tested on Windows & linux.

import turtle
from turtle import onkey, listen, mainloop, shape, done, onclick, goto

turtle.setup(800,600) #posicion inicial de la tortuga
turtle.shape("turtle") #formas: arrow, turtle, circle, square, triangle, classic, blank
turtle.color("yellow") #color de la tortuga
turtle.bgcolor("darkgreen") #color del fondo de pantalla
turtle.title("Tortoise by Marfull") #titulo de pantalla
turtle.right(90)

move = turtle.Turtle()
move.shape("circle")
move.color("#aaffcc")

def k1():
	move.forward(45)
	turtle.back(45)
def k2():
	move.left(45)
	turtle.right(45)
def k3():
	move.right(45)
	turtle.left(45)
def k4():
	move.back(45)
	turtle.forward(45)
def k5():
        turtle.bye()
        sys.exit()
def k6():
        turtle.home()
        move.home()
def oben():
        turtle.up()
        move.up()
def unten():
        turtle.down()
        move.down()

onkey(k1, "Up")
onkey(k2, "Left")
onkey(k3, "Right")
onkey(k4, "Down")
onkey(k5, "Escape")
onkey(k6, "h")
onkey(k6, "H")
onkey(oben, "u")
onkey(unten, "i")

move.screen.onclick(goto)
move.screen.onclick(move.goto, btn=3)

listen()
done()
