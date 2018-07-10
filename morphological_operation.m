clc
clear all
close all 
A = imread('Text.bmp');
count = zeros(256,1);
B = uint8(zeros(600,800));
kernel = false(3);
q = 1;
D = uint8(zeros(600,800));
E = uint8(zeros(600,800));
G = uint8(zeros(600,800));
H = uint8(zeros(600,800));
for i = 0:255  % for counting the pixel values in the image
    s = 0;
    for j = 1:600
        for k = 1:800
            if (A(j,k) == i)
                s = s + 1 ;
                count(q) = s;
            end
        end
    end
    q = q + 1;
end
% for displaying the image
imshow(A);
title('ORIGINAL IMAGE');

% for plotting histogram
figure
plot (0:255,count,'r');
title ('HISTOGRAM');
xlabel ('Pixel intensity');
ylabel ('Pixel count');

% for thresholding
for i = 1:600
    for j = 1:800
        if (A(i,j)>= 83)
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
    end
end
figure
imshowpair(A,B,'montage');
title('THRESHOLDED IMAGE');

% for erosion
A1 = padarray(B, [1 1], 1);
for k = 1:5
    random = padarray(D,[1 1],1);
    for i = 1:600
        for j = 1:800
            if (k == 1)
                temp = A1(i:i+2,j:j+2);
                if (temp == kernel)
                    D(i,j) = 0;
                else 
                    D(i,j) = 1;
                end
            else
                temp = random(i:i+2,j:j+2);
                if (temp == kernel)
                    D(i,j) = 0;
                else 
                    D(i,j) = 1;
                end
            end
        end
    end
end
figure
imshowpair(A,D,'montage')
title('5 TIMES ERODED IMAGE')

% for dilation
kernel1 = true(3);
A2 = padarray(D,[1 1],1);
for k = 1:5
    random = padarray(E,[1 1],1);
    for i = 1:600
        for j = 1:800
            if (k == 1)
                temp = A2(i:i+2,j:j+2);
                if (temp == kernel1)
                    E(i,j) = 1;
                else 
                    E(i,j) = 0;
                end
            else
                temp = random(i:i+2,j:j+2);
                if (temp == kernel1 )
                    E(i,j) = 1;
                else 
                    E(i,j) = 0;
                end
            end
        end
    end
end
figure
imshowpair(A,E,'montage')
title('5 TIMES DILATED IMAGE');

figure
imshowpair(B,E,'montage')

% difference image
F = abs(E-B);
figure
imshowpair(B,F,'montage')
title('DIFFERENCE IMAGE')

A3 = padarray(B, [1 1], 1);
for k = 1:10
    random1 = padarray(G,[1 1],1);
    for i = 1:600
        for j = 1:800
            if (k == 1)
                temp1 = A3(i:i+2,j:j+2);
                if (temp1 == kernel)
                    G(i,j) = 0;
                else 
                    G(i,j) = 1;
                end
            else
                temp1 = random1(i:i+2,j:j+2);
                if (temp1 == kernel)
                    G(i,j) = 0;
                else 
                    G(i,j) = 1;
                end
            end
        end
    end
end
figure
imshowpair(A,G,'montage')
title('10 TIMES ERODED IMAGE')

%for 10 times dilation
A4 = padarray(G,[1 1],1);
for k = 1:10
    random1 = padarray(H,[1 1],1);
    for i = 1:600
        for j = 1:800
            if (k == 1)
                temp1 = A4(i:i+2,j:j+2);
                if (temp1 == kernel1)
                    H(i,j) = 1;
                else 
                    H(i,j) = 0;
                end
            else
                temp1 = random1(i:i+2,j:j+2);
                if (temp1 == kernel1)
                    H(i,j) = 1;
                else 
                    H(i,j) = 0;
                end
            end
        end
    end
end
figure
imshowpair(A,H,'montage')
title('10 TIMES DILATED IMAGE');

%difference image
I = abs(H-B);
figure 
imshowpair(B,I,'montage')