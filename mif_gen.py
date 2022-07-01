import math
import matplotlib.pyplot as plt
import numpy as np
import struct

def coeff(n):
    return math.cos(-2 * math.pi / 1024 * (n)), math.sin(-2 * math.pi / 1024 * (n))

coeffs = []

def data_generator(delta_x, sample_size):
    data = []
    for i in [x * delta_x for x in range(int(sample_size))]:
        data.append(4 + 2 * math.cos(6 * math.pi * i - math.pi / 2) - math.cos(100 * math.pi * i))
    return data

data = data_generator(0.001, 2 ** 10)
reversed = [0 for _ in data]
for i in range(2 ** 10):
    reversed_i = int(format(i, "010b")[::-1], 2)
    reversed[reversed_i] = data[i]

with open("FFT.mif", "w+") as file:
    file.write("WIDTH=64;\n")
    file.write("DEPTH=2048;\n")
    file.write("ADDRESS_RADIX=UNS;\n")
    file.write("DATA_RADIX=HEX;\n")
    file.write("CONTENT BEGIN\n")

    for i in range(len(reversed)):
        datum = reversed[i]
        print(datum)
        f32 = hex(struct.unpack('<I', struct.pack('<f', datum))[0])[2:] + "00000000"
        file.write(str(i) + " : " + f32 + ";\n")
    for i in range(512):
        cos, sin = coeff(i)
        coeffs += [cos, sin]
        twiddle = hex(struct.unpack('<I', struct.pack('<f', cos))[0])[2:] + hex(struct.unpack('<I', struct.pack('<f', sin))[0])[2:]
        file.write(str(i + 1024) + " : " + twiddle + ";\n")
    file.write("[1536..2047] : 0;\n")
    file.write("END;")

plt.plot(coeffs)
plt.show()
