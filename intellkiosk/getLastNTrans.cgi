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
logging.debug("acc : " + str(acc))
n = form.getvalue('n')
logging.debug("n : " + str(n))

res = Utils.getLastNTrans(acc,n)

print "Content-type:text/plain"
print

s = ""
for i in res :
    s += i[3] + "ed " + str(i[4]) + " on " + i[2] + ". Remarks : " + i[5] + "\n"

logging.debug("s : " + str(s))

if s != "" :
    print s
else :
    print "No Transactions Found!"
