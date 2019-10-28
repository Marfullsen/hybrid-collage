#!/usr/bin/env python
# -*- coding: utf-8 -*-
# tk-palette.py, by @Marfullsen 2017.
# Tested on Windows 7 & Linux.
# Works in both Python 2 & 3.

try:
    import Tkinter as tk
except ImportError:
    import tkinter as tk
else:
    raise ImportError("Se requiere el modulo Tkinter")
import random

def mix(*args):
    labels = range(5)
    for j in range(13):
        for i in range(18):
            ct = [random.randrange(256) for x in range(3)]
            brightness = int(round(0.299*ct[0] + 0.587*ct[1] + 0.114*ct[2]))
            ct_hex = "%02x%02x%02x" % tuple(ct)
            bg_colour = '#' + "".join(ct_hex).upper()
            etiqueta = ("#%02x-%02x-%02x" % tuple(ct)).upper()
            l = tk.Label(root, text=etiqueta, fg='White' if brightness < 120 else 'Black', bg=bg_colour)
            l.grid(ipadx=20,ipady=10,row=i,column=j)

root = tk.Tk()

# width x height + x_offset + y_offset:
root.geometry("1500x700+0+0")

root.bind("<Button-1>", mix)

root.mainloop()
