import sqlite3

import logging
logging.basicConfig(filename='/tmp/intell.log', level=logging.DEBUG)

class mydb() :
    def __init__(self, db_name) :
        self.db_path = db_name

    def connect(self) :
        self.conn = sqlite3.connect(self.db_path)
        self.cur = self.conn.cursor()

    def getBal(self, acc) :
        stmt = 'select bal from balance where acc='+str(acc)
        logging.debug("trying : " + stmt)
        self.cur.execute(stmt)
        self.conn.commit()
        res = self.cur.fetchone()
        logging.debug("DB OUT : " + str(res))
        return res

    def updateAddr(self, acc, addr) :
        stmt = 'update details set addr='+'"' + str(addr) + '"' + " where acc="+str(acc)
        logging.debug("trying : " + stmt)
        self.cur.execute(stmt)
        res = self.cur.rowcount
        self.conn.commit()
        logging.debug("Affected : " + str(res))
        return res

    def updateEmail(self, acc, email) :
        stmt = 'update details set email='+'"' + str(email) + '"' + " where acc="+str(acc)
        logging.debug("trying : " + stmt)
        self.cur.execute(stmt)
        res = self.cur.rowcount
        self.conn.commit()
        logging.debug("Affected : " + str(res))
        return res


    def updateMob(self, acc, mob) :
        stmt = 'update details set mob='+'"' + str(mob) + '"' + " where acc="+str(acc)
        logging.debug("trying : " + stmt)
        self.cur.execute(stmt)
        res = self.cur.rowcount
        self.conn.commit()
        logging.debug("Affected : " + str(res))
        return res

    def getLastTransN(self, acc, n) :
        stmt = 'select * from trans where acc='+str(acc) + ' order by date desc limit ' + str(n)
        logging.debug("trying : " + stmt)
        self.cur.execute(stmt)
        self.conn.commit()
        res = self.cur.fetchall()
        logging.debug("DB OUT : " + str(res))
        return res

    def close(self) :
        self.conn.close()
