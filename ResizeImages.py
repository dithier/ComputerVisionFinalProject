#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 10 16:55:54 2019

@author: ithier
"""
import PIL
from PIL import Image
from os import listdir
from os.path import isfile, join

size = 32
y = "./yes_processed/" 
n = "./no_processed/"

y_save = "./yes_processed_resized/"
n_save = "./no_processed_resized/"

yes_pics = [f for f in listdir(y) if isfile(join(y, f))]
no_pics = [f for f in listdir(n) if isfile(join(n, f))]

def resize_image(image, state): 
    if state == "y":
        location = y + image
    else:
        location = n + image
    img = Image.open(location)
    img = img.resize((size, size), PIL.Image.ANTIALIAS)
    if state == "y":
        save_location = y_save + image
    else:
        save_location = n_save + image
    img.save(save_location)
    

for image in yes_pics:
    resize_image(image, "y")
    
for image in no_pics:
    resize_image(image, "n")

