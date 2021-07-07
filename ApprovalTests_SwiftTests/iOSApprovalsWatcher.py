#! /usr/bin/env python
import datetime
import os
import stat
import subprocess

def monitor_file(file_name):
    date = datetime.datetime(2000,1,1)
    while (True):
        if os.path.exists(file_name):
            current_date = datetime.datetime.fromtimestamp(os.stat(file_name).st_mtime)
            if date < current_date:
                print("date: " + str(current_date))
                date = current_date
                os.chmod(file_name, os.stat(file_name).st_mode | stat.S_IEXEC) 
                subprocess.Popen("./" + file_name)

if __name__ == "__main__":
    monitor_file("command.sh")
