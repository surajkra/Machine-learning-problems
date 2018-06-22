% INPUT:  img - 512x512 image to be processed
%         wav_type - wavelet to be used in transform
% OUTPUT: T - 3rd-level "wave_type" wavelet decomposition of "img" tiled
%             as a 512x512 matrix

function[T] = w3t(img)

% dwtmode('per')

    [A,B,C,D]=dwt2(img,'db4','mode','per');

[A1,B1,C1,D1]=dwt2(A,'db4','mode','per');

[A2,B2,C2,D2]=dwt2(A1,'db4','mode','per');

T=[A2 B2;C2 D2];
T=[T B1;C1 D1];
T=[T B;C D];
