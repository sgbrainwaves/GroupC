#!/usr/bin/python2

from mydb import *
import Utils
import cgi
import cgitb
cgitb.enable()

form = cgi.FieldStorage()
acc = form.getvalue('acc')
logging.debug("acc : " + str(acc))
newmob = form.getvalue('mob')
logging.debug("newmob : " + str(newmob))

res = Utils.updateMob(acc, newmob)

print "Content-type:text/plain"
print

if res != 0 :
    print "Updated Mobile Number"
else :
    print "Failed. Check Logs!"
