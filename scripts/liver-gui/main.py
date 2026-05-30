import os
import re
import shlex
import sys
import requests
import datetime
import subprocess
from PySide6.QtWidgets import (
    QApplication, QAbstractItemView, QHeaderView, QHBoxLayout, QMainWindow,
    QMessageBox, QPushButton, QTableWidget, QTableWidgetItem,
    QVBoxLayout, QWidget,
)
from PySide6.QtCore import QTimer, Qt

URL = "https://api.live.bilibili.com/room/v1/Room/get_status_info_by_uids"
REQUEST_HEADERS = {
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Safari/537.36",
    "Referer": "https://live.bilibili.com/",
    "Origin": "https://live.bilibili.com",
    "Accept": "application/json, text/plain, */*",
}

REFRESH_MS = 10000

IGNORE_REGEX = [r"战双", r"鸣潮", r"瓦", r"明日方舟", r"突击", r"游戏", r"前瞻", r"\d\.\d"]

MYFAVORITE = ["282994", "5714768"]

NOTIFY_SEND_ARGS = ["-a", "LIVE Start! - LiverGUI",
                    "-t", "0", "-i", "/home/xwx/.local/share/icons/livergui.svg"]

LIVERC = {}
DEFAULT_COMMAND = "bili-live {room}"

def load_config():
    global LIVERC
    path = f"{os.path.expanduser('~')}/.liverc"
    with open(path, "r") as f:
        for line in f:
            name, uid = line.strip().split()
            LIVERC[uid] = name

def fmt(n):
    u = ["", "K", "M", "B", "T"]
    i = 0
    n = float(n)

    while n >= 1000 and i < len(u)-1:
        n /= 1000
        i += 1

    s = f"{n:.3g}"   # 3 significant digits
    return s + u[i]

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

        if any([re.search(r, title) for r in IGNORE_REGEX]):
            continue

        room = info.get("short_id") or info.get("room_id")

        online = fmt(info.get("online"))

        start = datetime.datetime.fromtimestamp(info.get("live_time")).strftime("%H:%M:%S")

        rows.append({
            "uid": uid,
            "name": LIVERC.get(uid, uid),
            "title": title,
            "room": str(room),
            "online": online,
            "start": start,
        })

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

        self.table = QTableWidget()
        self.table.setColumnCount(5)
        self.table.setHorizontalHeaderLabels(["NAME", "TITLE", "ROOM", "ONLINE", "START"])
        self.table.setAlternatingRowColors(True)
        self.table.setShowGrid(False)
        self.table.setWordWrap(False)
        self.table.setTextElideMode(Qt.TextElideMode.ElideRight)
        self.table.setSelectionBehavior(QAbstractItemView.SelectionBehavior.SelectRows)
        self.table.setSelectionMode(QAbstractItemView.SelectionMode.ExtendedSelection)
        self.table.setEditTriggers(QAbstractItemView.EditTrigger.NoEditTriggers)
        self.table.horizontalHeader().setSectionResizeMode(0, QHeaderView.ResizeMode.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(1, QHeaderView.ResizeMode.Stretch)
        self.table.horizontalHeader().setSectionResizeMode(2, QHeaderView.ResizeMode.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(3, QHeaderView.ResizeMode.ResizeToContents)
        self.table.horizontalHeader().setSectionResizeMode(4, QHeaderView.ResizeMode.ResizeToContents)
        self.table.horizontalHeader().setStretchLastSection(False)
        self.table.verticalHeader().setVisible(False)

        self.table.cellDoubleClicked.connect(self.on_click)

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

        self.live_uids = None

        self.refresh()

    def show_live_reminder(self, rows, args):
        title = "\n".join(f"{row['name']}" for row in rows)
        message = "\n".join(
            f"{row['title']} | {row['room']} | {row['start']}" for row in rows
        )

        subprocess.Popen(["notify-send", title, message] + args)

    def refresh(self):
        rows = fetch_data()

        current_uids = {row["uid"] for row in rows}
        if self.live_uids is None:
            self.live_uids = current_uids
        else:
            new_uids = current_uids - self.live_uids
            if new_uids:
                new_rows = [row for row in rows if row["uid"] in new_uids]
                favo_rows = [row for row in new_rows if row["uid"] in MYFAVORITE]
                normal_rows = [row for row in new_rows if row not in favo_rows]
                if favo_rows != []:
                    self.show_live_reminder(favo_rows, NOTIFY_SEND_ARGS + ["-u", "critical"])
                    for favo_row in favo_rows:
                        launch_room(favo_row["room"], DEFAULT_COMMAND)
                if normal_rows != []:
                    self.show_live_reminder(normal_rows, NOTIFY_SEND_ARGS)
            self.live_uids = current_uids
        self.table.setRowCount(len(rows))

        for i, row in enumerate(rows):
            name = row["name"]
            title = row["title"]
            room = row["room"]
            online = row["online"]
            start = row["start"]

            items = [
                QTableWidgetItem(name),
                QTableWidgetItem(title),
                QTableWidgetItem(room),
                QTableWidgetItem(online),
                QTableWidgetItem(start),
            ]

            for col, item in enumerate(items):
                item.setTextAlignment(Qt.AlignmentFlag.AlignCenter)
                self.table.setItem(i, col, item)

        self.table.resizeRowsToContents()

    def selected_rooms(self):
        rows = sorted({index.row() for index in self.table.selectionModel().selectedRows()})
        rooms = []
        seen = set()

        for row in rows:
            room_item = self.table.item(row, 2)
            if not room_item:
                continue

            room = room_item.text().strip()
            if not room or room in seen:
                continue

            seen.add(room)
            rooms.append(room)

        return rooms

    def on_click(self, row, _col):
        room_item = self.table.item(row, 2)
        if not room_item:
            return

        try:
            launch_room(room_item.text(), DEFAULT_COMMAND)
        except (FileNotFoundError, ValueError) as exc:
            QMessageBox.critical(self, "Failed", f"Unable to launch: {exc}")

    def launch_selected(self):
        rooms = self.selected_rooms()
        if not rooms:
            QMessageBox.information(self, "Not Selected", "Please select at least one live stream to launch.")
            return

        errors = []

        for room in rooms:
            try:
                launch_room(room, DEFAULT_COMMAND)
            except (FileNotFoundError, ValueError) as exc:
                errors.append(f"{room}: {exc}")

        if errors:
            QMessageBox.critical(self, "Failed", "\n".join(errors))


if __name__ == "__main__":
    load_config()

    app = QApplication(sys.argv)
    win = Main()
    win.show()
    sys.exit(app.exec())
