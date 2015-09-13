#!/usr/bin/python2

from mydb import *
import Utils
import cgi
import cgitb
cgitb.enable()

form = cgi.FieldStorage()
acc = form.getvalue('acc')
logging.debug("acc : " + str(acc))
newaddr = form.getvalue('addr')
logging.debug("newaddr : " + str(newaddr))


res = Utils.updateAddr(acc, newaddr)

print "Content-type:text/plain"
print

if res != 0 :
    print "Updated Address"
else :
    print "Failed. Check Logs!"
