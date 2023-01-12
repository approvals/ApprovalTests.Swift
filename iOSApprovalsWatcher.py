#! /usr/bin/env python3
import argparse
import datetime
import os
import stat
import subprocess
import sys
import time


class WatchedFile:
    path = ''
    date = datetime.datetime(2000, 1, 1)
    
    def __init__(self, path):
        self.path = path
 
    def __repr__(self):
        return f'{str(self.date)} {self.path}'

    def remove(self):
        if os.path.exists(self.path):
            os.remove(self.path)

    def monitor(self):
        if os.path.exists(self.path):
            current_date = datetime.datetime.fromtimestamp(os.stat(self.path).st_mtime)
            if self.date < current_date:
                self.date = current_date
                print(self)
                os.chmod(self.path, os.stat(self.path).st_mode | stat.S_IEXEC) 
                subprocess.Popen(self.path)


def monitor_files(files):
    while True:
        time.sleep(0.5)
        for watched_file in files:
            watched_file.monitor()


def remove(files):
    for watched_file in files:
        watched_file.remove()


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


def parse_arguments():
    parser = argparse.ArgumentParser(description='Watch for iOS approvals.')
    parser.add_argument('test_directory', type=str, help='Path to test directory')
    return parser.parse_args()


if __name__ == '__main__':
    args = parse_arguments()
    watched_files = watchlist(args.test_directory, 'command.sh')
    remove(watched_files)
    print('Ready for iOS Approval Tests. Control-C to quit.')
    monitor_files(watched_files)
