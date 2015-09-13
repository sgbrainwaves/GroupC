#!/usr/bin/python2

import Utils
import cgi
import cgitb
cgitb.enable()

import logging
logging.basicConfig(filename='/tmp/intell.log', level=logging.DEBUG)
logging.debug("test")

form = cgi.FieldStorage()
inp = form.getvalue('inp')
logging.debug("INPUT : " + str(inp))
acc = form.getvalue('acc')
logging.debug("acc : " + str(acc))

#acc = 1
#inp = "last transaction"
inp = inp.strip().split()

kw = { "balance" : Utils.handleGetBal,
        "home" : Utils.handleUpdateAddr,
        "transaction" : Utils.handleGetLastTrans,
        "transactions" : Utils.handleGetLastNTrans,
        "mobile" : Utils.handleUpdateMob,
        "email" : Utils.handleUpdateEmail }

keys = kw.keys()

logging.debug("INPUT : " + str(inp))

key = None
for i in range(len(inp)) :
    for j in range(len(keys)) :
        if inp[i] == keys[j] :
            key = j

logging.debug("key : " + str(key))

print "Content-type: application/json"
print

if key == None :
    print "Failed. Check Logs!"
    exit(1)

kw[keys[key]](acc, inp)
