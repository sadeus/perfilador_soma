#!/usr/bin/env python
from flask import Flask, Response, render_template, send_file, request, jsonify, url_for
from sensor import Sensor
from io import BytesIO
import json
import numpy as np

debug = False
app  = Flask(__name__)
port = 9000
ip = '192.168.0.131'

sensor = Sensor(ip = ip, debug = debug, sensor_type = Sensor.Perfilador)

@app.route('/sensor/reset', methods=["POST"])
def reset_sensor():
    json = request.get_json()
    sensor_type = Sensor.Perfilador
    if json is not None:
        ip = json["ip"]
        sensor_type = json["type"]
        assert sensor_type == Sensor.Perfilador or sensor_type == Sensor.Polarimetro
    global sensor
    sensor = Sensor(ip=ip, debug=debug, sensor_type = sensor_type)
    return 'Sensor connection reseted', 200

@app.route("/sensor/ip", methods=["GET"])
def get_sensor_ip():
    if sensor.connected():
        return sensor.ip(), 200
    else:
        return "Error: Sensor not found", 500

@app.route("/")
def get_polarimetro():
    return render_template("sensor.html")

@app.route("/sensor/data")
@app.route("/sensor/plot")
@app.route("/sensor/data/raw")
def get_sensor_data():
    sensor_type = request.args.get('sensor','1') == '1'
    if sensor.connected():
        data = sensor.update()
        if type(data) is str:
            return 'Error: ' + data, 500
        if not "raw" in request.url:
            val, fig = sensor.process_data(data)
            if "plot" in request.url:
                return fig
            else:
                ret = {}
                if sensor.sensor_type() == Sensor.Perfilador:
                    ret = {"avg_sigma": np.mean(val), "std_sigma": np.std(val), "plot": fig}
                elif sensor.sensor_type() == Sensor.Polarimetro:
                    ret = {'max-min': val}
                else:
                    return "Bad sensor", 500

                return json.dumps(ret), 200, {'Content-Type': 'application/json; charset=utf-8'}
        else:
            return json.dumps(data.tolist())
    else:
        return "Error: Sensor not found", 500


if __name__ == "__main__":
    app.run(debug=debug, port=port)
    url_for('static', filename='worker.js')
    url_for('static', filename='app.js')
