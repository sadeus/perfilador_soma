# -*- coding: utf-8 -*-
"""
Clase de manejo del perfilador
Proyecto SOMA

@author: S. Schiavinato
"""
import io
import time
import matplotlib.pyplot as plt, mpld3
import numpy as np
import pandas as pd
import scipy as sp
from scipy import special, signal
import telnetlib
from io import BytesIO
import base64

class Polarimetro():
    """Clase de manejo de Polarimetro de haz del Proyecto SOMA. El sensor está
    implementado con el uC Particle Photon, con código escrito en C++.

    Parametros
    -----------
        ip: IP del Polarimetro (Telnet)

    Propiedades
    -----------


    Métodos
    ----------

        update: Actualiza los datos del perfilador

        process_data: Obtiene una lista de ancho de haz a partir de los datos ingresados. También devuelve los ajustes y los indices de los datos donde se efecutó el ajuste
    """

    def __init__(self, ip = "10.200.1.219"):
        self.__ip = ip

    def __str__(self):
        print("Polarimetro SOMA. IP: {}.".format(t, self.__ip))

    def update(self):
        '''Devuelve los datos actualizados del sensor'''
        tel = telnetlib.Telnet(self.__ip)
        s = tel.read_until(b"END").decode().replace("END","")
        tel.close()
        data = pd.read_csv(io.StringIO(s),sep=";",names=["t","V"],
                           dtype={"t": np.float64, "V": np.float64})
        data = data.values
        return data

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
        V = data[:,1] / data[:,1].max()
        diff = (np.max(V) - np.min(V)) / (np.max(V) + np.min(V))

        #Obtengo automáticamente la frecuencia, a partir de FFT
        fig = plt.figure(1)
        plt.plot(T, V,'ro')
        plt.grid()
        plt.xlabel("t[s]")
        plt.ylabel("A[1]")

        figfile = BytesIO()
        plt.savefig(figfile, format='png')
        figfile.seek(0)
        figdata_png = base64.b64encode(figfile.getvalue())

        return diff, figdata_png
