#! /usr/bin/env python
import datetime
import os
import subprocess

def monitor_file(file_name):
    date = datetime.datetime(2000,1,1)
    while (True):
        if os.path.exists(file_name):
            current_date = datetime.datetime.fromtimestamp(os.stat(file_name).st_mtime)
            if date < current_date:
                print("date: " + str(current_date))
                date = current_date
                subprocess.call("./" + file_name, shell=True)

if __name__ == "__main__":
    monitor_file("command.sh")
