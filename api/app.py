from flask import Flask, render_template, request

import pika
import mysql.connector

config = {
  'user': 'mysql',
  'password': 'mysql',
  'host': 'mysql',
  'database': 'frpsscan',
  'raise_on_warnings': True
}

connection = pika.BlockingConnection(pika.ConnectionParameters(host='rabbit', connection_attempts=50, retry_delay=1, heartbeat=0))
channel = connection.channel()

channel.queue_declare(queue='test', durable=False, auto_delete=True)

app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template('index.html')

@app.route('/view')
def view():
    c = mysql.connector.connect(**config)
    cursor = c.cursor()
    cursor.execute("select ip, port from targets")
    model = [ {'ip' : x[0], 'port': x[1]} for x in cursor.fetchall() ]
    c.close()
    return render_template('view.html', model=model)

@app.route('/add', methods=["POST"])
def add():
    ip = request.form['ip']
    port = request.form['port']
    channel.basic_publish(exchange='amq.topic',
                      routing_key='worker1',
                      body=f"{ip} {port}")
    return 'added'

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')