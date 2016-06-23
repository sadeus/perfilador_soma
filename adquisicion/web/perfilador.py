# -*- coding: utf-8 -*-
"""
Clase de manejo del perfilador
Proyecto SOMA

@author: S. Schiavinato
"""
import io
import time
import serial
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import scipy as sp
from scipy import special, signal
from serial.tools import list_ports
import telnetlib


class Perfilador():
    """Clase de manejo del Perfilador del Proyecto SOMA. El perfilador está
    implementado con el uC Spark Photon, con código escrito en C++.

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

    def __init__(self, ip = "192.168.0.131", R = 10):
        self._R = R
        self._ip = ip

    def __str__(self):
        print("Perfilador SOMA. IP: {}. R: {}".format(self._ip, self._R))

    def update(self):
        '''Devuelve los datos actualizados del perfilador'''
        tel = telnet.Telnet(self._ip)
        s = tel.read_util("END").decode().replace("END","")
        tel.close()
        data = pd.read_csv(io.StringIO(s),sep=";",names=["t","V"],
                           dtype={"t": np.float64, "V": np.float64})
        data = data.values
        return data

    def _get_freq(T,V):
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

    def process_data(self, data, figfile):
        '''Procesa los datos ingresados, devolviendo el tamaño de los haces, el ajuste de la función error y la ubicación de cada ajuste'''
        T = (data[:,0] - data[:,0].min()) * 1e-6
        V = data[:,1] / data[:,1].max()

        #Obtengo automáticamente la frecuencia, a partir de FFT
        f = Perfilador._get_freq(T,V)

        filt = sp.signal.medfilt(V, kernel_size = 25)
        gauss = np.abs(sp.ndimage.gaussian_filter(filt, 10, order=1))
        gauss = gauss/gauss.max()

        fig = plt.figure(1)
        plt.plot(T, V,'ro')
        plt.grid()
        plt.xlabel("t[s]")
        plt.ylabel("A[1]")
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
            try:
                ind = np.abs(T - T[i]) < DeltaT
                indList.append(ind)
                x = T[ind]
                y = V[ind]
                p0 = [y.max()/2, -y.max()/2, (x.max() + x.min())/2, 0.5*(x.max() - x.min())]

                p, cov = sp.optimize.curve_fit(err_f, x, y, p0 = p0)
                t = np.linspace(x.min(), x.max() , 1000)
                plt.plot(t, err_f(t, *p))
                sigma.append(p[3] * self._R * w)
            except ValueError:
                pass
            except RuntimeError:
                print("No se pudo ajustar")
                pass

                #A.append(mod_max(int(i + DeltaT/2)))
        plt.savefig(figfile, format="png")
        open("sigma.json","w+").close()
        with open("sigma.json","r+") as f:
            f.write("{")
            f.write('"mean": {},'.format(np.mean(np.array(sigma))))
            f.write('"error": {},'.format(np.sqrt(np.var(np.array(sigma)))))
            f.write('"raw": [')
            for i, s in enumerate(sigma):
                f.write("{}".format(s))
                if i < len(sigma) - 1:
                    f.write(",")
            f.write("]}")
        return sigma
