from math import sin, pi

input = 8
output = 8

f=open("sine_lut.txt", "w")
for i in range(2**input):
    newline = "{}'d{}: amp_out<={}'d{};".format(input, i, output, round((2**output - 1)*(1+sin(i*2*pi/2**input))/2))
    f.write("\t" + newline + "\n")
f.close();