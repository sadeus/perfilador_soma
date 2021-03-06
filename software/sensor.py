# -*- coding: utf-8 -*-
"""
Clase de manejo del perfilador
Proyecto SOMA

@author: S. Schiavinato
"""
import io
import time
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy as sp
from scipy import special, signal
import telnetlib
from io import BytesIO
import base64

import ipaddress as ipaddr
import socket



class Sensor():
    """Clase de manejo de Perfilador de haz del Proyecto SOMA. El sensor está
    implementado con el uC Particle Photon, con código escrito en C++.

    Parametros
    -----------
    ip: IP del Perfilador (Telnet)
    R:  Radio del tambor del perfilador. Por defecto 10mm

    Propiedades
    -----------


    Métodos
    ----------

    update: Actualiza los datos del perfilador

    process_data: Obtiene una lista de ancho de haz a partir de los datos ingresados. También devuelve los ajustes y los indices de los datos donde se efecutó el ajuste
    """
    Perfilador = 1
    Polarimetro = 2

    __port = 7662
    __R = 10

    def __init__(self, ip="10.200.0.0", debug=False, sensor_type = Perfilador):
        self.__DEBUG = debug
        self.__type = sensor_type
        socket.setdefaulttimeout(1.0)
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        if self.__DEBUG:
            print('Sensor in IP {} and port {}'.format(ip, Sensor.__port))
            print('Testing connection')
        try:
            if s.connect_ex((str(ip), Sensor.__port)) == 0:
                s.close()
                if self.__DEBUG:
                    print('Connection successful')
                self.__ip = ip
            else:
                if self.__DEBUG:
                    print('Connection not working')
        except socket.timeout:
            if self.__DEBUG:
                print('Connection not working. Timeout')

    def __str__(self):
        print("Sensor SOMA. IP: {}".format(t, self.__ip))

    def ip(self):
        return self.__ip

    def sensor_type(self):
        return self.__type

    def connected(self):
        try:
            if self.__ip is not None:
                return True
        except:
            return False

    def update(self):
        '''Devuelve los datos actualizados del sensor'''
        try:
            if self.__DEBUG:
                print('Conecting to sensor with IP ' + self.__ip)
            tel = telnetlib.Telnet(self.__ip, port = Sensor.__port)
            s = tel.read_until(b"END").decode().replace("END","")
            tel.close()

            if self.__DEBUG:
                print('Parsing message')
            data = pd.read_csv(io.StringIO(s), sep=";", names=["t","V"],
            dtype= {"t": np.float64, "V": np.float64})
            data = data.values

            return data
        except (EOFError, ValueError) as e:
            return 'Parse or connection error'
        except (AttributeError, socket.timeout) as e:
            print(e)
            return "Sensor not found"



    def __get_freq(T,V):
        fft = np.fft.rfft(V)
        freq = np.fft.rfftfreq(len(T), d = np.diff(T)[0])

        #Elimino el máximo inicial, que es un artefácto del algoritmo
        freq = freq[1:]
        fft = np.abs(fft[1:])

        #Obtengo el valor máximo, que va a ser la fundamental de la señal
        max_fft = fft == fft.max()

        #Ploteo de debuggeo
        #plt.plot(freq[freq < 200], fft[freq < 200],"bo-")
        #plt.plot(freq[max_fft], fft[max_fft],"ro")

        #Devuelvo la frecuencia, como float
        return freq[max_fft][0]

    def process_data(self, data):
        '''Procesa los datos ingresados, devolviendo el tamaño de los haces,
        el ajuste de la función error y la ubicación de cada ajuste'''

        T = (data[:,0] - data[:,0].min()) * 1e-6
        V = data[:,1] * 3.3/4096

        plt.clf()
        fig = plt.figure(1)
        plt.plot(T, V,'ro')
        plt.grid()
        plt.xlabel("t[s]")
        plt.ylabel("A[V]")

        try:
            if self.__type:
                #Perfilador

                f = Sensor.__get_freq(T,V) #Obtengo automáticamente la frecuencia, a partir de FFT

                #Filtro gaussiano para eliminar ruido
                filt = sp.signal.medfilt(V, kernel_size = 25)
                gauss = np.abs(sp.ndimage.gaussian_filter(filt, 10, order=1))
                gauss = gauss/gauss.max()

                #Plot de debuggeo
                #plt.plot(T, gauss*V.max(), 'b-')

                peaks = sp.signal.find_peaks_cwt(gauss, np.array([20]))
                #plt.plot(T[peaks],V[peaks],'gd')

                err_f = lambda x, a, b, c, d: a + b * sp.special.erf(np.sqrt(2)*(x - c) / d)

                w = 2 * np.pi * f
                sigma = []
                DeltaT = 0.2/f
                indList = []
                for i in peaks:
                    ind = np.abs(T - T[i]) < DeltaT
                    indList.append(ind)
                    x = T[ind]
                    y = V[ind]
                    p0 = [y.max()/2, -y.max()/2, (x.max() + x.min())/2, 0.5*(x.max() - x.min())]

                    p, cov = sp.optimize.curve_fit(err_f, x, y, p0 = p0)
                    t = np.linspace(x.min(), x.max() , 1000)
                    plt.plot(t, err_f(t, *p))
                    sigma.append(p[3] * Sensor.__R * w)
            else:
                #Polarimetro
                diff = (np.max(V) - np.min(V)) / (np.max(V) + np.min(V))
                sigma.append(diff)
        except:
            sigma = [0]
        finally:
            figfile = BytesIO()
            plt.savefig(figfile, format='png')
            figfile.seek(0)
            figdata_png = base64.b64encode(figfile.getvalue()).decode("utf-8")
            return sigma, figdata_png
