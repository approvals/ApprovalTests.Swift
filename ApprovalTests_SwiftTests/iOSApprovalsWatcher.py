#! /usr/bin/env python
import datetime
import os
import stat
import subprocess
import sys


class WatchedFile:
    path = ''
    date = datetime.datetime(2000, 1, 1)
    
    def __init__(self, path):
        self.path = path
 
    def __repr__(self):
        return 'WatchedFile(path=' + self.path + ', date=' + str(self.date) + ')'
    
    def monitor(self):
        if os.path.exists(self.path):
            current_date = datetime.datetime.fromtimestamp(os.stat(self.path).st_mtime)
            if self.date < current_date:
                print(self)
                self.date = current_date
                os.chmod(self.path, os.stat(self.path).st_mode | stat.S_IEXEC) 
                subprocess.Popen(self.path)


def monitor_files(files):
    while True:
        files[0].monitor()


def directories_in(root):
    paths = [root]
    for dir_path in os.listdir(root):
        path = os.path.join(root, dir_path)
        if os.path.isdir(path):
            paths.append(path)
            directories_in(path)
    return paths


def watchlist(relative_path, search_for):
    absolute_path = os.path.abspath(relative_path)
    directories = directories_in(absolute_path)
    return [WatchedFile(os.path.join(directory, search_for)) for directory in directories]


if __name__ == "__main__":
    path_to_watch = sys.argv[1]
    watched_files = watchlist(path_to_watch, 'command.sh')
    monitor_files(watched_files)
