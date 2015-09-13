from mydb import *
import Utils
import json
import logging
logging.basicConfig(filename='/tmp/intell.log', level=logging.DEBUG)

def getBal(acc) :
    dbi = mydb("/tmp/details.db")
    dbi.connect()
    res = dbi.getBal(acc)
    logging.debug("Bal : " + str(res))
    dbi.close()
    return res


def updateAddr(acc, newaddr) :
    dbi = mydb("/tmp/details.db")
    dbi.connect()
    res = dbi.updateAddr(acc, newaddr)
    dbi.close()
    return res

def updateMob(acc, newmob) :
    dbi = mydb("/tmp/details.db")
    dbi.connect()
    res = dbi.updateMob(acc, newmob)
    dbi.close()
    return res

def updateEmail(acc, newemail) :
    dbi = mydb("/tmp/details.db")
    dbi.connect()
    res = dbi.updateEmail(acc, newemail)
    dbi.close()
    return res

def getLastNTrans(acc, n) :
    dbi = mydb("/tmp/details.db")
    dbi.connect()
    res = dbi.getLastTransN(acc,n)
    dbi.close()
    return res

def get_occurance(pat, text) :
    for i in range(len(text)) :
        if text[i] == pat  :
            return i
    return -1

def handleGetBal(acc, text) :
    res = getBal(acc)
    js = None
    if res :
        js = {"status" : 1, "resp" : {"acc" : acc, "bal" : res[0]}}
    else :
        js = {"status" : 0, "resp" : {"txt" : "Server Error"}}

    x = json.JSONEncoder().encode(js)
    logging.debug("resp : " + str(x))
    print x


def handleUpdateMob(acc, text) :
    idx = get_occurance("to", text)

    js = None

    if idx == -1 :
        idx = get_occurance("two", text)

    if idx != -1 :
        logging.debug("idx of 'to' : " + str(idx))
        newval = text[idx+1]
        logging.debug("text[idx+1] : " + str(newval))
        res = updateMob(acc, newval)
    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Cannot Recognize Mobile Number"}}

    if res != 0 :
        js = {"status" : 2, "resp" : {"acc" : acc, "txt" : newval}}
    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Server Error"}}

    print json.JSONEncoder().encode(js)

def handleUpdateAddr(acc, text) :
    idx = get_occurance("to", text)
    if idx == -1 :
        idx = get_occurance("two", text)

    if idx != -1 :
        logging.debug("idx of 'to' : " + str(idx))
        newval = text[idx+1]
        logging.debug("text[idx+1] : " + str(newval))
        res = updateAddr(acc, newval)
    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Cannot Recognize Address"}}
    if res != 0 :
        js = {"status" : 2, "resp" : {"acc" : acc, "txt" : newval}}
    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Server Error"}}

    print json.JSONEncoder().encode(js)

def handleUpdateEmail(acc, text) :
    idx = get_occurance("to", text)
    if idx == -1 :
        idx = get_occurance("two", text)

    if idx != -1 :
        logging.debug("idx of 'to' : " + str(idx))
        newval = "".join(text[idx+1:])
        logging.debug("''.join(text[idx+1:]) : " + str(newval))
        res = updateEmail(acc, newval)

    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Cannot Recognize Address"}}
    if res != 0 :
        js = {"status" : 2, "resp" : {"acc" : acc, "txt" : newval}}
    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Server Error"}}

    print json.JSONEncoder().encode(js)



def handleNTrans(acc, n) :
    res = getLastNTrans(acc, n)
    s = {"status" : 3}
    ret = ""
    tmp = {}
    for i in res :
        tmp["acc"] = acc
        tmp["type"] = i[3]
        tmp["date"] = i[2]
        tmp["amt"] = i[4]
        tmp["remark"] = i[5]
        ret = tmp['type'] + "ed  $ " + str(tmp['amt']) + " on " + tmp['date'] + "\n Remarks : " + tmp['remark']

    s['resp'] = tmp
    if ret == "" :
        s = {"status" : 3, "txt" : "No Transactions Found!"}
    else :
        s = {"status" :3, "txt": ret}

    logging.debug(str(s))
    return s


def handleGetLastNTrans(acc, text) :
    num = None
    for i in text :
        # check for spl case of 2 :/
        # cos google speech to text can't recognize 2 :/
        if i == "two" :
            num = 2
            break
        try:
            num = int(i)
            break
        except ValueError:
            continue

    logging.debug("text : " + str(text))
    logging.debug("num : " + str(num))

    if num :
        js =  handleNTrans(acc,1)
    else :
        js = {"status" : 0, "resp" : {"acc" : acc, "txt" : "Could Not Recognize n"}}

    print json.JSONEncoder().encode(js)

def handleGetLastTrans(acc, text) :
    print json.JSONEncoder().encode(handleNTrans(acc, 1))
