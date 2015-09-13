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

NLastTrans = 3

res1 = Utils.getBal(acc)
res2 = Utils.getLastNTrans(acc, NLastTrans)

print "Content-type:text/plain"
print

if res1 :
    print "Account Number : " + str(acc)
    print "Avail Bal : " + str(res1[0])
else :
    print "Failed. Check Logs!"
    exit(1)

s = ""
for i in res2 :
    s += i[3] + "ed " + str(i[4]) + " on " + i[2] + ". Remarks : " + i[5] + "\n"

if s != "" :
    print s
else :
    print "No Transactions Found!"
