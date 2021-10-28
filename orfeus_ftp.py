import pysftp
import time
import shutil
from pathlib import Path
import pandas as pd
import zipfile

def main():
    host  = 'sftp2.scovilleriskpartners.com'
    # dummy username and pw
    user  = 'orfeus'
    pword = 'RLjPwvBrvHebzn59'

    knownhosts = 'known_hosts'
    cnopts = pysftp.CnOpts(knownhosts=knownhosts)
    sconn = pysftp.Connection(host=host,username=user,password=pword,cnopts=cnopts)
    time.sleep(1)   # this seems to be necessary
    # change the directory below as needed
    sconn.chdir('/SimDrop/TX_SolarWindLoad/CSV/IntraDay1')
    # change the output directory below as needed
    path = "/projects/PERFORM/Scoville_Scenarios/Intraday/Intraday_1_6/"

    remfiles = sconn.listdir()
    for ff in remfiles:
        print(f'Getting: {ff}')
        locfile = Path(path, ff)
        path_new = path + ff
        sconn.get(ff, path_new)
        newdir = Path(path_new[:-4])  # Directory to extract to
        # kind of hacky - makes sure we don't grab the .zip as part of the directory name
        try:
            shutil.unpack_archive(locfile,newdir)
        except:
            print("Couldn't unzip " +str(locfile))
        break

if __name__ == '__main__':
    main()
