#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 10 16:54:35 2019

@author: ithier
"""
from os import listdir
from os.path import isfile, join
import matplotlib.pyplot as plt
import numpy as np
import keras
import tensorflow as tf
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten
from keras.layers import Conv2D, MaxPooling2D
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix

size = 32
batch_size = 17
epochs = 12
num_classes = 2

# directory of pictures with tumors
y = './yes_processed_resized/'
# directory of pictures without tumors
n = './no_processed_resized/'

# get list of all file paths for pictures
y_pics = [y+f for f in listdir(y) if isfile(join(y, f))]
n_pics = [n+f for f in listdir(n) if isfile(join(n, f))]

# create labels for pictures ([1,0] for yes [0,1] for no)
labels = []
for i in range(len(y_pics)):
    labels.append([1,0])
for i in range(len(n_pics)):
    labels.append([0,1])

all_pic_names = y_pics + n_pics
images = []

# using the file paths make a list of pictures that tensorflow can understand
for file_path in all_pic_names:
    # load the raw data from the file as a string
    img = tf.io.read_file(file_path)
    # convert the compressed string to a 3D uint8 tensor
    img = tf.image.decode_jpeg(img, channels=3)
    # convert to floats in [0,1] range
    img = tf.image.convert_image_dtype(img, tf.float32)
    # add result to total images list
    images.append(img)
  
# split data randomly into testing and training
x_train, x_test, y_train, y_test = train_test_split(images, labels, test_size=0.33, random_state=42)
print('Number of training images: ', len(x_train))
print('Number of testing images: ', len(x_test))

# reshape data so that it's dimensions are acceptable
x_train = np.reshape(x_train,(len(x_train), size, size, 3))
x_test = np.reshape(x_test,(len(x_test), size, size, 3))
y_train = np.reshape(y_train, (len(y_train), 2))
y_test = np.reshape(y_test, (len(y_test), 2))


# create the tensor flow model
model = Sequential()
model.add(Conv2D(32, kernel_size=(3, 3),
                 activation='relu',
                 input_shape=(size,size,3)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Conv2D(64, (3, 3), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.25))
model.add(Flatten())
model.add(Dense(64, activation='relu'))
model.add(Dropout(0.5))
model.add(Dense(num_classes, activation='softmax'))
model.compile(loss=keras.losses.categorical_crossentropy,
              optimizer=keras.optimizers.Adadelta(),
              metrics=['accuracy'])

# train the model
history = model.fit(x_train, y_train,
          batch_size=batch_size,
          epochs=epochs,
          verbose=2,
          validation_data=(x_test, y_test))

# plot accuracy over epochs
plt.plot(history.history['accuracy'], label='accuracy')
plt.plot(history.history['val_accuracy'], label = 'val_accuracy')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.ylim([0.5, 1])
plt.legend(loc='lower right')

# evaluate model success
score = model.evaluate(x_test, y_test, verbose=2)
print('Test loss:', score[0])
print('Test accuracy:', score[1])

y_pred = model.predict(x_test, verbose=1)
y_pred_bool = np.argmin(y_pred, axis=1)
y_test_bool = np.argmin(y_test, axis=1)

print(classification_report(y_test_bool, y_pred_bool))
tn, fp, fn, tp = confusion_matrix(y_test_bool, y_pred_bool).ravel()
print("tn:", tn, " fp:", fp, "fn:", fn, "tp:", tp)