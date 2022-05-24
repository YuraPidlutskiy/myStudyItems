import os 
import time 

DAYS =5         # maximal age of file to stay 
FOLDERS = [
     "path"
      "path"
       "path"
]

TOTAL_DELETED_SIZE = 0
TOTAL_DELETED_FILE = 0
TOTAL_DELETED_DIR = 0 

nowTime = time.time()
ageTime = nowTime - 60*60*24*DAYS

def delete_old_files(folder):
    global TOTAL_DELETED_FILE
    global TOTAL_DELETED_SIZE
    for path, dirs, files in os.walk(folder):
        for file in files:
            fileName = os.path.join(path, file)     # get full path to file
            fileTime = os.path.getmtime(fileName)
            if fileTime < ageTime:
                sizeFile = os.path.getsize(fileName)
                TOTAL_DELETED_SIZE += sizeFile
                TOTAL_DELETED_FILE += 1
                print("deleting file " + str(fileName))
                os.remove(fileName)

def delete_empty_dir(folder):
    global TOTAL_DELETED_DIR
    empty_folders_in_this_run = 0
    for path ,dirs,files in os.walk(folder):
        if (not dirs) and (not files):
            TOTAL_DELETED_DIR += 1
            empty_folders_in_this_run += 1
            print("Deleting EMPTY dir  " + str(path))
            os.rmdir(path)
    if empty_folders_in_this_run > 0:
        delete_empty_dir(folder)





starttime = time.asctime()
for folder in FOLDERS:
    delete_old_files(folder)
    delete_empty_dir(folder)

finishtime = time.asctime()

print("START TIME  "  + str(starttime))
print('Total delete size  ' + str(int(TOTAL_DELETED_SIZE/1024/1024)))
print("Total delete files:  " + str(TOTAL_DELETED_FILE))
print("Total delete empty folders:  " + str(TOTAL_DELETED_DIR))
print("finish time: " + str(finishtime))