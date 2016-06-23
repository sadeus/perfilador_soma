from flask import Flask, Response, render_template, send_file
from perfilador import Perfilador
import base64
import numpy as np
import threading
import time

app = Flask(__name__)
port = 9000
perf = Perfilador()
test = True

def render_plot():
    while True:
        if test:
            data = np.loadtxt("prueba.csv",delimiter=",")
            data = data[:1000]
        else:
            data = perf.update()
        perf.process_data(data, "plot.png")
        time.sleep(2)

@app.route("/")
def index():
    return send_file("./templates/index.html")
	
@app.route("/perfilacion")
def get_perfilacion():
    return send_file("sigma.json")


@app.route('/plot')
def get_plot():
    return send_file("plot.png", mimetype='image/png')


if __name__ == "__main__":
    d = threading.Thread(target=render_plot, name='Render Plot')
    d.setDaemon(True)
    d.start()
    app.run(debug=True, port=port)
