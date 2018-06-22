% INPUT:   wav_type - wavelet to be used in transform (actually, it has to be db4)
%          T - 3rd-level "wave_type" wavelet decomposition of "img" tiled
%              as a 512x512 matrix
% OUTPUT:  img - 506x506 image, the inverse wavelet transform of T
% NOTE: This code along with wav3tile.m DOES NOT give PR!  Edges are lost in order
%       to conform to dimension requirements.  

function[img] = w3i(T)
  img=idwt2(T(1:64,1:64),T(1:64,65:128),T(65:128,1:64),T(65:128,65:128),'db4','mode','per');
A=img;
img=idwt2(A,T(1:128,129:256),T(129:256,1:128),T(129:256,129:256),'db4','mode','per');
A=img;
img=idwt2(A,T(1:256,257:512),T(257:512,1:256),T(257:512,257:512),'db4','mode','per');
