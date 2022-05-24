import os
import requests
from multiprocessing import Pool
import time

headers = {"Content-Type": "application/json"}
url = 'someurl'
json_directory = 'json_err'
abspath = os.path.abspath(json_directory)
files = [os.path.join(abspath, file) for file in os.listdir(json_directory)]


def xt(file):
    file_name = os.path.basename(file)
    with open(file, "rb") as json_file:
        x = requests.post(url + '?requestId=' + file_name, data = json_file , headers=headers)
    if x.status_code != 200:
        print(file,x.status_code)
    return x.status_code


if __name__ == "__main__":
    timer = time.time()
    with Pool(6) as pool:
        result = pool.map(xt,files)
    print('elapsed %.6f seconds' % (time.time() - timer))
    




