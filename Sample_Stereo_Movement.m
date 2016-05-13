clc;

input = audioread('Trombone.wav');
fs = 44100;
ele = 10;

hrtfmodel(input, 0, ele, fs);
pause
hrtfmodel(input, 30, ele, fs);
pause
hrtfmodel(input, 60, ele, fs);
pause
hrtfmodel(input, 90, ele, fs);
