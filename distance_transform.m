clc
clear all
close all
A = imread('bottle.bmp');
BW = uint8(zeros(600,800));
Dilation = uint8(zeros(600,800));
Processed_image =(zeros(600,800));
count = zeros(256,1);
histo = 1;

% pixel counting
for i = 0:255  
    s = 0;
    for j = 1:600
        for k = 1:800
            if (A(j,k) == i)
                s = s + 1 ;
                count(histo) = s;
            end
        end
    end
    histo = histo + 1;
end
% original image
imshow(A);
title('Image');

% histogram
figure
plot (0:255,count,'r');
title ('Histogram');

% threshold
for i = 1:600
    for j = 1:800
        if (A(i,j)>= 120)
            BW(i,j) = 1;
        else
            BW(i,j) = 0;
        end
    end
end
figure
imshowpair(A,BW,'montage');
title('Image after thresholding');

% for dilation
kernel_D = true(3);
For_dila = padarray(BW,[1 1],1);
for times = 1:5
    random_D = padarray(Dilation,[1 1],1);
    for i = 1:600
        for j = 1:800
            if (times == 1)
                temp_D = For_dila(i:i+2,j:j+2);
                if (temp_D == kernel_D)
                    Dilation(i,j) = 1;
                else 
                    Dilation(i,j) = 0;
                end
            else
                temp_D = random_D(i:i+2,j:j+2);
                if (temp_D == kernel_D )
                    Dilation(i,j) = 1;
                else 
                    Dilation(i,j) = 0;
                end
            end
        end
    end
end


% for erosion
kernel_erosion = false(3);
For_erosion = padarray(Dilation, [1 1], 1);
for times = 1:5
    random_D = padarray(Processed_image,[1 1],1);
    for i = 1:600
        for j = 1:800
            if (times == 1)
                temp_D = For_erosion(i:i+2,j:j+2);
                if (temp_D == kernel_erosion)
                    Processed_image(i,j) = 0;
                else 
                    Processed_image(i,j) = 1;
                end
            else
                temp_D = random_D(i:i+2,j:j+2);
                if (temp_D == kernel_erosion)
                    Processed_image(i,j) = 0;
                else 
                    Processed_image(i,j) = 1;
                end
            end
        end
    end
end
figure
imshowpair(BW,Processed_image,'montage')
title('Processed image')
 
% inverting processed image
for i = 1:600
    for j = 1:800
        if (Processed_image(i,j) == 0)
            Processed_image(i,j)=1;
        else
            Processed_image(i,j)=0;
        end
    end
end

% FP
Distance_transform = padarray(Processed_image,[1 1],0);
for i = 2:602
    for j =2:802
        if (Distance_transform(i,j) ~= 0)
            Northn = Distance_transform(i-1,j);
            Westn = Distance_transform(i,j-1);
            D1 = min((Northn+1),(Westn+1));
            Distance_transform (i,j)= D1;
        end
    end
end

% BP
for i = 601:-1:2
    for j = 801:-1:2
        if (Distance_transform(i,j) ~= 0)
        Eastn = Distance_transform(i,j+1);
        Southn = Distance_transform(i+1,j);
        D1 = min((Southn+1),(Eastn+1));
        D1 = min(Distance_transform(i,j),D1);
        Distance_transform(i,j)= D1;
        end
    end
end

% caluclulating the values
Calculation = Distance_transform(1:600,1:800);
m = max(max(Calculation));
interpole = 256/(m+1);
Calculation = uint8(round(Calculation*interpole));
figure
imshow (Calculation)
title('Distance transform')

Calulations_1 = Distance_transform(1:600,1:800);
Area = 0;
Row_values = 0;
Column_val = 0;
Row_Count = 0;
Column_Count = 0;
peri = 0;
max_count = 0;
for i = 1:600
    for j = 1:800
        if (Calulations_1(i,j) ~= 0)
            Row_Count = Row_Count + 1;
            Column_Count = Column_Count + 1;
            Row_values = Row_values + i;
            Column_val = Column_val + j;
            Area = Area + 1;
        end
        if (Calulations_1(i,j) == 1)
            peri = peri + 1;
        end
        if (Calulations_1(i,j) == 86)
            max_count = max_count+1;
        end
    end
end

peri
Area
x = round (Row_values/Row_Count)
y = round (Column_val/column_count)
max_count
