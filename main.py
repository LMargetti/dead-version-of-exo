#############################################################################################################
#                                                                                                           #
#                            ██╗          ███████╗      █████╗      ███████╗                                #
#                            ██║          ██╔════╝     ██╔══██╗     ██╔════╝                                #
#                            ██║          █████╗       ███████║     █████╗                                  #
#                            ██║          ██╔══╝       ██╔══██║     ██╔══╝                                  #
#                            ███████╗ ██╗ ███████╗ ██╗ ██║  ██║ ██╗ ██║     ██╗                             #
#                            ╚══════╝ ╚═╝ ╚══════╝ ╚═╝ ╚═╝  ╚═╝ ╚═╝ ╚═╝     ╚═╝                             #
#                              Local Environment for Any (+ All) Functions v0.1                             #
#                              Alt: Letting Executive functions Act in Fantasy                              #
#                                             Created by Liam                                               #
#                                                                                                           #
#############################################################################################################
# This Python file uses the following encoding: utf-8
import sys
import os

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.load(os.path.join(os.path.dirname(__file__), "qml/main.qml"))

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
