import tkinter as tk
import subprocess
import webbrowser
import time
import threading
import os

def open_dashboard():

    def run_dashboard():

        dashboard_path = os.path.join(
            os.path.dirname(__file__),
            "bi_dashboard.py"
        )

        subprocess.Popen(
            [
                "python",
                "-m",
                "streamlit",
                "run",
                dashboard_path
            ],
            creationflags=subprocess.CREATE_NEW_CONSOLE
        )

        time.sleep(5)

        webbrowser.open("http://localhost:8501")

    threading.Thread(target=run_dashboard).start()

root = tk.Tk()

root.title("Dooper Healthcare")

root.geometry("500x300")

title = tk.Label(
    root,
    text="Dooper Healthcare BI Dashboard",
    font=("Arial", 16, "bold")
)

title.pack(pady=30)

description = tk.Label(
    root,
    text="Click the button below to launch the dashboard.",
    font=("Arial", 10)
)

description.pack(pady=10)

launch_button = tk.Button(
    root,
    text="Open Dashboard",
    font=("Arial", 12),
    width=20,
    height=2,
    command=open_dashboard
)

launch_button.pack(pady=20)

root.mainloop()