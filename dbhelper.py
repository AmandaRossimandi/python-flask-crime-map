"""
Database helper class.
"""
import pymysql
import dbconfig

class DBHelper:

    def connect(self, database="crimemap"):
        return pymysql.connect(host='localhost',
                               user=dbconfig.db_user,
                               passwd=dbconfig.db_password,
                               db=database)


    def add_crime(self, category, date, latitude, longitude, description):
        connection = self.connect()
        try:
            query = "INSERT INTO crimes (caregory, date, latitude, longitude, \
            description) VALUES (%s, %s, %s, %s, %s)"
            with connection.cursor() as cursor:
                cursor.execute(query, (category, date, latitude, longitude,
                                       description))
                connection.commit()
        except Exception as e:
            print(e)
        finally:
            connection.close()


    def get_all_inputs(self):
        connection = self.connect()
        try:
            query = "SELECT latitude, longitude, date, category, description FROM crimes;"
            with connection.cursor() as cursor:
                cursor.execute(query)
            return cursor.fetchall()
        finally:
            connection.close()
