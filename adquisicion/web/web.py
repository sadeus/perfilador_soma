from flask import Flask, Response, render_template, send_file
from perfilador import Perfilador
import base64
import numpy as np
import threading
import time

app = Flask(__name__)
port = 9000
perf = Perfilador(ip = "192.168.1.100")
test = False

def render_plot():
    while True:
        try:
            if test:
                data = np.loadtxt("prueba.csv",delimiter=",")
                data = data[:1000]
            else:
                data = perf.update()
                perf.print_data(data, "plot.png")
            perf.process_data(data, "plot.png")
        except:
            pass

@app.route("/")
def index():
    return send_file("index.html")
	
@app.route("/sense")
def get_sense_data():
    data = perf.update()
    #perf.print_data(data, "plot.png")
    fig, json = perf.process_data(data)
    
    return send_file("sigma.json")


@app.route('/plot')
def get_plot():
    return send_file("plot.png", mimetype='image/png')


if __name__ == "__main__":
    d = threading.Thread(target=render_plot, name='Render Plot')
    d.setDaemon(True)
    d.start()
    app.run(debug=True, port=port)
