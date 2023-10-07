"""Qss preview for Custom QtWidgets"""

from PyQt6.QtCore import *
from PyQt6.QtGui import *
from PyQt6.QtGui import QAction, QIcon
from PyQt6.QtWidgets import *
from PyQt6.QtWidgets import QMainWindow


class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle("Custom")
        homeAct = QAction(QIcon("img/home.png"), "&Home", self)
        forwardAct = QAction(QIcon("img/forward.png"), "&Forward", self)
        backAct = QAction(QIcon("img/back.png"), "&Back", self)
        QAction(QIcon("img/config.png"), "&Config", self)
        cutAct = QAction(QIcon("img/cut.png"), "&Cut", self)
        copyAct = QAction(QIcon("img/copy.png"), "&Copy", self)
        pasteAct = QAction(QIcon("img/paste.png"), "&Paste", self)
        helpAct = QAction(QIcon("img/help.png"), "&Paste", self)

        menubar = self.menuBar()
        mainMenu = menubar.addMenu("&Main")
        mainMenu.addAction(homeAct)
        mainMenu.addAction(backAct)
        mainMenu.addAction(forwardAct)
        editMenu = menubar.addMenu("&Edit")
        editMenu.addAction(cutAct)
        editMenu.addAction(copyAct)
        editMenu.addAction(pasteAct)
        helpMenu = menubar.addMenu("&Help")
        helpMenu.addAction(helpAct)

        toolbar = self.addToolBar("Main")
        toolbar.addAction(homeAct)
        toolbar.addAction(backAct)
        toolbar.addAction(forwardAct)
        toolbar1 = self.addToolBar("Edit")
        toolbar1.addAction(cutAct)
        toolbar1.addAction(copyAct)
        toolbar1.addAction(pasteAct)
        toolbar2 = self.addToolBar("Help")
        toolbar2.addAction(helpAct)
