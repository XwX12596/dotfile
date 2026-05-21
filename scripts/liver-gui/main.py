import os
import shlex
import sys
import requests
import datetime
import subprocess

from PySide6.QtWidgets import (
    QApplication, QAbstractItemView, QHeaderView, QHBoxLayout, QMainWindow,
    QMessageBox, QPushButton, QTableWidget, QTableWidgetItem, QVBoxLayout,
    QWidget, QLabel
)
from PySide6.QtCore import QTimer, Qt, QEvent, QPoint
from PySide6.QtGui import QPixmap, QCursor


URL = "https://api.live.bilibili.com/room/v1/Room/get_status_info_by_uids"
REQUEST_HEADERS = {
    "User-Agent": "Mozilla/5.0",
    "Referer": "https://live.bilibili.com/",
    "Origin": "https://live.bilibili.com",
    "Accept": "application/json, text/plain, */*",
}

REFRESH_MS = 10000
IGNORE_WORDS = ["战双", "鸣潮", "瓦", "明日方舟", "突击", "游戏"]

LIVERC = {}
DEFAULT_COMMAND = "bili-live {room}"

# 简单图片缓存，避免重复下载
IMAGE_CACHE = {}


def load_config():
    global LIVERC
    path = f"{os.path.expanduser('~')}/.liverc"
    with open(path, "r") as f:
        for line in f:
            name, uid = line.strip().split()
            LIVERC[uid] = name


def fetch_data():
    uids = list(LIVERC.keys())

    try:
        r = requests.post(URL, json={"uids": uids}, headers=REQUEST_HEADERS, timeout=10)
        data = r.json().get("data", {})
    except:
        return []

    rows = []

    for uid in uids:
        info = data.get(uid)
        if not info:
            continue

        if info.get("live_status") != 1:
            continue

        title = info.get("title", "")

        if any(w in title for w in IGNORE_WORDS):
            continue

        room = info.get("short_id") or info.get("room_id")
        start = datetime.datetime.fromtimestamp(info.get("live_time")).strftime("%H:%M:%S")

        cover = (
            info.get("keyframe")
        )

        rows.append([
            LIVERC.get(uid, uid),
            title,
            str(room),
            start,
            cover
        ])

    return rows


def launch_room(room, command_template):
    command_text = command_template.format(room=room)
    command = shlex.split(command_text)
    subprocess.Popen(command)


class Main(QMainWindow):
    def __init__(self):
        super().__init__()

        self.setWindowTitle("Liver GUI")
        self.resize(400, 500)

        # ===== table =====
        self.table = QTableWidget()
        self.table.setColumnCount(5)
        self.table.setHorizontalHeaderLabels(
            ["NAME", "TITLE", "ROOM", "START", "COVER"]
        )

        self.table.setAlternatingRowColors(True)
        self.table.setShowGrid(False)
        self.table.setSelectionBehavior(QAbstractItemView.SelectionBehavior.SelectRows)
        self.table.setEditTriggers(QAbstractItemView.EditTrigger.NoEditTriggers)
        self.table.verticalHeader().setVisible(False)

        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(2, QHeaderView.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(3, QHeaderView.ResizeToContents)
        self.table.setColumnHidden(4, True)

        self.table.cellDoubleClicked.connect(self.on_click)

        self.table.setMouseTracking(True)
        self.table.viewport().installEventFilter(self)

        self.preview = QLabel(self)
        self.preview.setWindowFlags(Qt.ToolTip)
        self.preview.hide()

        self.current_row = -1

        refresh_button = QPushButton("Refresh")
        refresh_button.clicked.connect(self.refresh)

        launch_button = QPushButton("Launch")
        launch_button.clicked.connect(self.launch_selected)

        button_layout = QHBoxLayout()
        button_layout.addWidget(refresh_button)
        button_layout.addWidget(launch_button)
        button_layout.addStretch()

        layout = QVBoxLayout()
        layout.addLayout(button_layout)
        layout.addWidget(self.table)

        container = QWidget()
        container.setLayout(layout)
        self.setCentralWidget(container)

        self.timer = QTimer()
        self.timer.timeout.connect(self.refresh)
        self.timer.start(REFRESH_MS)

        self.refresh()

    def refresh(self):
        rows = fetch_data()
        self.table.setRowCount(len(rows))

        for i, row in enumerate(rows):
            name, title, room, start, cover = row

            items = [
                QTableWidgetItem(name),
                QTableWidgetItem(title),
                QTableWidgetItem(room),
                QTableWidgetItem(start),
                QTableWidgetItem(cover),
            ]

            for col, item in enumerate(items):
                item.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
                self.table.setItem(i, col, item)

        self.table.resizeRowsToContents()

    def eventFilter(self, obj, event):
        if obj == self.table.viewport():

            if event.type() == QEvent.MouseMove:
                index = self.table.indexAt(event.position().toPoint())
                row = index.row()
                col = index.column()

                if col != 3 or row < 0:
                    self.preview.hide()
                    return super().eventFilter(obj, event)

                if row != self.current_row:
                    self.current_row = row

                    if row >= 0:
                        cover_item = self.table.item(row, 4)
                        if cover_item:
                            self.show_preview(cover_item.text())

            elif event.type() == QEvent.Leave:
                self.current_row = -1
                self.preview.hide()

        return super().eventFilter(obj, event)

    def show_preview(self, url):
        if not url:
            self.preview.hide()
            return

        try:
            # cache
            if url in IMAGE_CACHE:
                pixmap = IMAGE_CACHE[url]
            else:
                r = requests.get(url, timeout=5)
                pixmap = QPixmap()
                pixmap.loadFromData(r.content)
                IMAGE_CACHE[url] = pixmap

            pixmap = pixmap.scaled(
                240, 140,
                Qt.AspectRatioMode.KeepAspectRatio,
                Qt.TransformationMode.SmoothTransformation
            )

            self.preview.setPixmap(pixmap)
            self.preview.adjustSize()

            self.preview.move(QCursor.pos() + QPoint(20, 20))
            self.preview.show()

        except:
            self.preview.hide()

    def selected_rooms(self):
        rows = sorted({i.row() for i in self.table.selectionModel().selectedRows()})
        rooms = []
        seen = set()

        for r in rows:
            item = self.table.item(r, 2)
            if not item:
                continue
            room = item.text().strip()
            if room and room not in seen:
                seen.add(room)
                rooms.append(room)

        return rooms

    def on_click(self, row, _col):
        room_item = self.table.item(row, 2)
        if room_item:
            launch_room(room_item.text(), DEFAULT_COMMAND)

    def launch_selected(self):
        rooms = self.selected_rooms()
        if not rooms:
            QMessageBox.information(self, "Not Selected", "Select at least one")
            return

        for room in rooms:
            launch_room(room, DEFAULT_COMMAND)


if __name__ == "__main__":
    load_config()

    app = QApplication(sys.argv)
    win = Main()
    win.show()
    sys.exit(app.exec())
