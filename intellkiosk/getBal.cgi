#!/usr/bin/python2

from mydb import *
import Utils
import cgi
import cgitb
cgitb.enable()

import logging
logging.basicConfig(filename='/tmp/intell.log', level=logging.DEBUG)


form = cgi.FieldStorage()

acc = form.getvalue('acc')
logging.debug("acc : " + acc)

res = Utils.getBal(acc)

print "Content-type:text/plain"
print

if res :
    print res[0]
else :
    print "Failed. Check Logs!"
