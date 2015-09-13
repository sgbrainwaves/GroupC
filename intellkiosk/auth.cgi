#!/usr/bin/python2

from mydb import *
import subprocess
import base64
import cgi
import cgitb
cgitb.enable()

import logging
logging.basicConfig(filename='/tmp/intell.log', level=logging.DEBUG)

import cv2

form = cgi.FieldStorage()
bindata = base64.b64decode(form.getvalue("image"))
f = open("/tmp/img.jpg","wb")
f.write(bindata)
f.close()

print "Content-type:application/json"
print

acc = subprocess.Popen("cd data_for/facerec/py/apps/scripts && ./FaceRecognition.py ../../../../newdata/ " + " /tmp/img.jpg", stdout=PIPE).stdout.read()

logging.debug("acc : "+str(acc) + "\t" + str(type(acc)))

if acc != "-1" :
    js = {"status" : 1, "resp" : {"acc" : res}}
else :
    js = {"status" : 0, "resp" : {"acc" : "Couldnot Identify"}}

json.JSONEncoder().encode(js)
