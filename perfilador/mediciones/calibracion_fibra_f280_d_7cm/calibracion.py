import numpy as np
import matplotlib.pyplot as plt
import scipy as sp
from scipy import optimize, special

plt.rcParams["errorbar.capsize"] = 3
plt.rcParams["lines.linewidth"] = 3
plt.rcParams["lines.markersize"] = 10
plt.rcParams["figure.figsize"] = (6*(1+np.sqrt(5))/2,6)
plt.rcParams["figure.dpi"] = 200
plt.rcParams["xtick.labelsize"] = 20
plt.rcParams["ytick.labelsize"] = 20
plt.rcParams["font.size"] = 30
plt.rcParams["legend.fontsize"] = 25

err_f = lambda x, a, b, c, d: a + b * sp.special.erf(np.sqrt(2)*(x - c) / d)
data = np.loadtxt('calibracion_x.csv', delimiter=',')

x = data[:,0]
y = data[:,1]
yerr = data[:,2]
xerr = np.ones_like(data[:,0])


plt.figure()

plt.grid()
plt.tick_params(axis="both")
plt.xlabel("d[$\mu$m]")
plt.ylabel("A[mW]")

plt.errorbar(x, y, yerr=yerr, xerr=xerr, fmt="ro", label="Datos")

p0 = [y.max()/2, -y.max()/2, (x.max() + x.min())/2, 0.5*(x.max() - x.min())]
p, cov = sp.optimize.curve_fit(err_f, x, y, p0 = p0)

t = np.linspace(x.min(),x.max(),1000)
plt.plot(t,err_f(t,*p),"b-", label="Ajuste")

txt = "$\sigma$ = ({:.0f} $\pm$ {:.0f})$\mu$m".format(2*p[3], 2*np.sqrt(cov[3,3]))
plt.text(0.1,0.15, txt, transform=plt.gca().transAxes) 
print("Error relativo {}".format(100 * np.sqrt(cov[3,3]) / (2 * p[3]) ))

plt.legend(loc=0)
plt.show()
