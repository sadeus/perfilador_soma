from flask import Flask, make_response, render_template, send_file, request
from perfilador import Perfilador
from polarimetro import Polarimetro
from io import BytesIO
import json
import base64
import numpy as np
import threading
import time

app  = Flask(__name__)
port = 9000
perf = Perfilador(ip = "10.200.1.219")
pol  = Polarimetro(ip = "10.200.1.219")
test = True

@app.route("/polarimetro")
def get_polarimetro():
    return render_template("polarimetro.html")

@app.route("/perfilador")
def get_perfilador():
    return render_template("perfilador.html")

@app.route("/polarimetro/data")
@app.route("/polarimetro/data/raw")
def get_polarimetro_data():
    if test:
        data = np.loadtxt("prueba.csv",delimiter=",")
        data = data[:1000]
    else:
        data = pol.update()
        #perf.print_data(data, "plot.png")
    if not "raw" in request.url:
        sigma, fig = pol.process_data(data)
        return fig
    else:
        print("raw")
        output = BytesIO()
        np.savetxt(output, data)
        return send_file(output)

@app.route("/perfilador/data")
@app.route("/perfilador/data/raw")
def get_perfilador_data():
    if test:
        data = np.loadtxt("prueba.csv",delimiter=",")
        data = data[:1000]
    else:
        data = perf.update()
        #perf.print_data(data, "plot.png")
    if not "raw" in request.url:
        sigma, fig = perf.process_data(data)
        return fig
    else:
        return json.dumps(data.tolist())


if __name__ == "__main__":
    app.run(debug=True, port=port)
