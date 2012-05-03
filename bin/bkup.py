#!/usr/bin/env python

import os
import subprocess
import sys

def main(argv):
    volume_path = '/Volumes'
    ls = os.listdir(volume_path)
    backup_dirs = filter(lambda s: 'backup' in s.lower(), ls)
    for d in backup_dirs:
        backup_target = d.split(' Backup', 1)[0]
        if backup_target:
            command = "/opt/local/bin/rsync -vaxAX --delete --exclude-from=/Users/cameronh/.backup/excluded-system --delete-excluded --ignore-errors {volume_path}/{0} {volume_path}/{1}" \
                .format(backup_target.replace(' ', '\ '),
                        d.replace(' ', '\ '), volume_path=volume_path)
            print command
            return_code = subprocess.call(command, shell=True)
            return return_code

if __name__ == "__main__":
    sys.exit(main(sys.argv))
