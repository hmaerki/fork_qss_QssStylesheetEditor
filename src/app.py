#!/usr/bin/python3
"""Class for application start

App class wrapped a QApplication, which will show splash and start gui.

Copyright (c) 2019 lileilei <hustlei@sina.cn>
"""

import os
import sys

from PyQt6.QtWidgets import QApplication

from i18n.language import Language
from splash.splash import SplashScreen

os.chdir(os.path.dirname(__file__))
sys.path.append(os.path.dirname(os.path.abspath(__file__)))


class App(QApplication):
    """Application to load splash and mainwindow"""

    def __init__(self):
        super().__init__(sys.argv)
        self.windows = {}
        # sys.setrecursionlimit(1500)

    def run(self, pytest=False):
        """run the app, show splash and mainwindow

        Args:
            pytest: if true, it will not start event loop, just for test
        """
        print("starting...")
        Language.setTrans()
        splash = SplashScreen("res/splash.png")
        splash.loadProgress()
        from ui.mainwin import MainWin

        self.windows["main"] = MainWin()
        self.windows["main"].show()
        splash.finish(self.windows["main"])
        if not pytest:
            sys.exit(self.exec())


def main():
    """main function for the program"""
    App().run()


if __name__ == "__main__":
    main()
