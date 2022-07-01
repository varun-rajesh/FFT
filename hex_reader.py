import math
import numpy as np
import matplotlib.pyplot as plt
import struct

x = []
y = []

with open("RAM.hex") as file:
    for i in range(1024):
        line = file.readline()
        temp_x = struct.unpack('!f', bytes.fromhex(line[9 : 17]))[0]
        temp_y = struct.unpack('!f', bytes.fromhex(line[17 : 25]))[0]
        x.append(temp_x)
        y.append(temp_y)

data = []
for data_x, data_y in zip(x, y):
    data.append(math.hypot(data_x / 512, data_y / 512))

plt.plot(data)
plt.show()
