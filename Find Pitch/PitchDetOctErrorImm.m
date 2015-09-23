clear all;close all;
[in,fs] = audioread('G_3_8k.wav'); bloque=in(20001:22048);

frec_Ffund = FindPitch(bloque,fs);