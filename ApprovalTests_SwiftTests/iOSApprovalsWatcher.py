#! /usr/bin/env python
import datetime
import os
import stat
import subprocess
import sys

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

def watchlist(relative_path):
    absolute_path = os.path.abspath(relative_path)
    directories = directories_in(absolute_path)
    date = datetime.datetime(2000,1,1)
    return [(os.path.join(dir, 'command.sh'), date) for dir in directories]

def directories_in(root):
    paths = []
    for file in os.listdir(root):
        path = os.path.join(root, file)
        if os.path.isdir(path):
            paths.append(path)
            directories_in(path)
    return paths

if __name__ == "__main__":
    relative_path = sys.argv[1]
    print(watchlist(relative_path))
#    monitor_file("command.sh")
