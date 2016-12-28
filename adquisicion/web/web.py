from flask import Flask, Response, render_template, send_file, request, jsonify
from sensor import Sensor
from io import BytesIO
import json
import numpy as np

debug = True
app  = Flask(__name__)
port = 9000
network = '192.168.0.0/24'
sensor = Sensor(network = network, debug = debug)


@app.route('/sensor/reset')
def reset_sensor():
    sensor = Sensor(network=__network, debug=debug)
    return 'Sensor connection reseted', 200

@app.route("/polarimetro")
def get_polarimetro():
    return render_template("polarimetro.html")

@app.route("/perfilador")
def get_perfilador():
    return render_template("perfilador.html")

@app.route("/polarimetro/data")
@app.route("/polarimetro/plot")
@app.route("/polarimetro/data/raw")
def get_polarimetro_data():
    data = sensor.update()
    if type(data) is str:
        if DEBUG:
            print(data)
        return 'Error: ' + data, 500
    if not "raw" in request.url:
        diff, fig = sensor.process_data(data, type_flag = False)
        if "plot" in request.url:
            return fig
        else:
            return diff
    else:
        print("raw")
        output = BytesIO()
        np.savetxt(output, data)
        return send_file(output)

@app.route("/perfilador/data")
@app.route("/perfilador/plot")
@app.route("/perfilador/data/raw")
def get_perfilador_data():
    data = sensor.update()
    if type(data) is str:
        return 'Error: ' + data, 500
    if not "raw" in request.url:
        sigmas, fig = sensor.process_data(data, type_flag = True)
        if "plot" in request.url:
            return fig
        else:
            ret = {"avg_sigma": np.mean(sigmas), "std_sigma": np.std(sigmas), "plot": fig}
            return json.dumps(ret), 200, {'Content-Type': 'application/json; charset=utf-8'}
    else:
        return json.dumps(data.tolist())


if __name__ == "__main__":
    app.run(debug=debug, port=port)
