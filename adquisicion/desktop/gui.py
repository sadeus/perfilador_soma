import sys
import os
import random
from matplotlib.backends import qt_compat

#Importo o PyQT o PySide
from PyQt4 import QtGui, QtCore


from matplotlib.backends.backend_qt4agg import FigureCanvasQTAgg
from matplotlib.figure import Figure
from perfilador import Perfilador

progname = os.path.basename(sys.argv[0])
progversion = "0.1"

perf = Perfilador(test = True)

class FigureCanvas(FigureCanvasQTAgg):
    """A canvas that updates itself every second with a new plot."""

    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        self.axes = fig.add_subplot(111)

        #Init the canvas
        FigureCanvasQTAgg.__init__(self, fig)
        self.setParent(parent)

        FigureCanvasQTAgg.setSizePolicy(self,
                                   QtGui.QSizePolicy.Expanding,
                                   QtGui.QSizePolicy.Expanding)
        FigureCanvasQTAgg.updateGeometry(self)
    

    def update_figure(self):
        # Build a list of 4 random integers between 0 and 10 (both inclusive)
        #l = [random.randint(0, 10) for i in range(4)]

        perf.update()
        self._sigma, self.axes = perf.process_data(self.axes)
        self.draw()


class ApplicationWindow(QtGui.QMainWindow):
    def __init__(self):

        QtGui.QMainWindow.__init__(self)
        self.setAttribute(QtCore.Qt.WA_DeleteOnClose)
        self.setWindowTitle("application main window")

        self.file_menu = QtGui.QMenu('&File', self)
        self.file_menu.addAction('&Quit', self.fileQuit,
                                 QtCore.Qt.CTRL + QtCore.Qt.Key_Q)
        self.menuBar().addMenu(self.file_menu)

        self.help_menu = QtGui.QMenu('&Help', self)
        self.menuBar().addSeparator()
        self.menuBar().addMenu(self.help_menu)

        self.help_menu.addAction('&About', self.about)

        self.main_widget = QtGui.QWidget(self)

        l = QtGui.QVBoxLayout(self.main_widget)
        self.text_widget = QtGui.QLineEdit(parent=None)
        self.plot_widget = FigureCanvas(self.main_widget, width=10, height=5, dpi=200)
        l.addWidget(self.text_widget)
        l.addWidget(self.plot_widget)

        self.main_widget.setFocus()
        self.setCentralWidget(self.main_widget)

        self.statusBar().showMessage("All hail matplotlib!", 2000)
        
        timer = QtCore.QTimer(self)
        timer.timeout.connect(self.update)
        timer.start(1000)

    def update(self):
        self.plot_widget.update_figure()
        self.text_widget.setText("{}".format(self.plot_widget._sigma))
    
    def fileQuit(self):
        self.close()

    def closeEvent(self, ce):
        self.fileQuit()

    def about(self):
        QtGui.QMessageBox.about(self, "About",
                                """Interfaz Sensores SOMA
Copyright 2016 Proyecto SOMA, S. Schiavinato"""
                                )


qApp = QtGui.QApplication(sys.argv)

aw = ApplicationWindow()
aw.setWindowTitle("%s" % progname)
aw.show()
sys.exit(qApp.exec_())
#qApp.exec_()
