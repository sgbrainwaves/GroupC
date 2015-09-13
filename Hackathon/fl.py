from flask import Flask 
from flask import request
from flask import send_file

app = Flask(__name__)

@app.route("/api/aurora/trending",methods=['GET','POST'])
def hello():
		# x = int(request.args.get('num1'))
		# y = int(request.args.get('num2'))
		# z = x+y
		#return str(z)
		

		#filename = "C:\Users\shashank\Desktop\dumma.jpg"
		#return send_file(filename, mimetype="image/jpg")
		temp = "AAPL"+",89,"+"GOOGL"+",90"
		return temp

if __name__ == "__main__":
	#app.debug=True
	app.run()
