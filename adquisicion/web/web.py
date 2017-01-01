from flask import Flask, Response, render_template, send_file, request, jsonify, url_for
from sensor import Sensor
from io import BytesIO
import json
import numpy as np

debug = True
app  = Flask(__name__)
port = 9000
network = '192.168.0.0/24'
ip = '192.168.0.122'
sensor = Sensor(ip = ip, network = network, debug = debug)

@app.route('/sensor/reset')
def reset_sensor():
    sensor = Sensor(network=network, ip=ip, debug=debug)
    return 'Sensor connection reseted', 200

@app.route("/")
def get_polarimetro():
    return render_template("sensor.html")

@app.route("/sensor/data")
@app.route("/sensor/plot")
@app.route("/sensor/data/raw")
def get_sensor_data():
    sensor_type = request.args.get('sensor','1') == '1'
    data = sensor.update()
    if type(data) is str:
        return 'Error: ' + data, 500
    if not "raw" in request.url:
        val, fig = sensor.process_data(data, type_flag = sensor_type)
        if "plot" in request.url:
            return fig
        else:
            ret = {}
            if sensor_type:
                ret = {"avg_sigma": np.mean(val), "std_sigma": np.std(val), "plot": fig}
            else:
                return {'max-min': val}
            return json.dumps(ret), 200, {'Content-Type': 'application/json; charset=utf-8'}
    else:
        return json.dumps(data.tolist())


if __name__ == "__main__":
    app.run(debug=debug, port=port)
    url_for('static', filename='worker.js')
    url_for('static', filename='app.js')
