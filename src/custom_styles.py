import pathlib
from typing import List

from PyQt6.QtWidgets import QApplication, QStyleFactory

THIS_FILE = pathlib.Path(__file__)
DIRECTORY_OF_THIS_FILE = THIS_FILE.parent
DIRECTORY_STYLES = DIRECTORY_OF_THIS_FILE / THIS_FILE.stem
assert DIRECTORY_STYLES.is_dir()


def style_names():
    """Return a list of styles, default platform style first"""
    default_style_name = QApplication.style().objectName().lower()
    result: List[str] = []
    for style_name in QStyleFactory.keys():
        if style_name.lower() == default_style_name:
            result.insert(0, style_name)
        else:
            result.append(style_name)
    for style in DIRECTORY_STYLES.glob("**/*.qss"):
        result.append(str(style.relative_to(DIRECTORY_STYLES)))
    return result


def set_style(style_name: str) -> None:
    if style_name.endswith(".qss"):
        # Try to disable the previous loaded stylesheet
        QApplication.instance().setStyleSheet("")
        default_style = QStyleFactory.create("Fusion")
        assert default_style is not None
        QApplication.setStyle(default_style)

        style = DIRECTORY_STYLES / style_name
        QApplication.instance().setStyleSheet(style.read_text())
        return
    QApplication.setStyle(QStyleFactory.create(style_name))
