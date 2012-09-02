#!/usr/bin/env python

import os
import subprocess
import sys

WHOLE_DISK_VOLUMES = ['Backup 1', 'Backup 2']

def main(argv):
    if '--debug' in argv:
        debug = True
    else:
        debug = False

    volume_path = '/Volumes'
    ls = os.listdir(volume_path)
    backup_dirs = filter(lambda s: 'backup' in s.lower(), ls)
    if len(backup_dirs) == 0:
        print 'No backup volumes mounted in {0}'.format(volume_path)
        return 0
    for d in backup_dirs:
        backup_target = d.split(' Backup', 1)[0]
        print backup_target
        if backup_target:
            if d in WHOLE_DISK_VOLUMES:
                command = "sudo -s -- '/opt/local/bin/rsync -vaxAX --delete --exclude-from=/Users/cameronh/.backup/excluded-system --delete-excluded --ignore-errors / {volume_path}/{0} ; touch {volume_path}/{0}/.metadata_never_index'" \
                    .format(d.replace(' ', '\ '), volume_path=volume_path)
            else:
                command = "/opt/local/bin/rsync -vaxAX --delete --exclude-from=/Users/cameronh/.backup/excluded-system --delete-excluded --ignore-errors {volume_path}/{0} {volume_path}/{1}" \
                    .format(backup_target.replace(' ', '\ '),
                            d.replace(' ', '\ '), volume_path=volume_path)
            print command
            if not debug:
                return_code = subprocess.call(command, shell=True)
                return return_code
            else: return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv))
