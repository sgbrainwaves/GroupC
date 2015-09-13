#!/usr/bin/python2

from mydb import *
import Utils
import cgi
import cgitb
import os
cgitb.enable()

import logging
logging.basicConfig(filename='/tmp/intell.log', level=logging.DEBUG)


form = cgi.FieldStorage()
acc = form.getvalue('acc')
logging.debug("acc : " + str(acc))
logging.debug("uid : " + str(os.getuid()))
newemail = form.getvalue('email')
logging.debug("email : " + str(newemail))


res = Utils.updateEmail(acc, newemail)

print "Content-type:text/plain"
print

if res != 0 :
    print "Updated Email"
else :
    print "Failed. Check Logs!"
