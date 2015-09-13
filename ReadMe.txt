Installing and Using the application

Front-End
---------

1.) Download Android Studio.
2.) Import the BrainWaveHackAndroid folder which contains all the Android code and dependencies.
3.) Build it.
4.) Run it on a Android phone.

Extra Dependencies Used : [Might have to download these]
  -Google API for Speech to Text and vice-versa.
  -Base64Encoder and Base64Decoder.

Back-End
---------
[ This is used only if you want to develop/hack for this application, otherwise, Android application has all the necessary calls for calling the scripts on the server ]
[ This won't work for any user over the internet, as the server was built on another local machine ]

  -FaceDetection.py -> This module accepts a set of images from different people and trains the model and creates a 'mymodel' file in the temp folder of the current directory. Once the model file is created, this will test the image given as an argument and try to recognize whose image it belongs to.
  
  -intellkiosk -> This folder has all the server back-end files other than FaceDetection which is already specified above. These include, sqlite scripts, the functions called for updation of database, etc.
  
Note : For running the FaceDetection.py file it should be placed under 'facerec/py/app/scripts' folder where facerec is an API built for the Face detection purpose. [this API is not in this repository]
