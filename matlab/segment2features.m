%% Declare the function
function features = segment2features(bild)
%% Find the minimum bounding rectangle of a single digit
[m,n] = size(bild);
sum_col = sum(bild); % number of white pixels in a column
sum_row = sum(bild,2); % number of white pixels in a row
% find the upper boundary 
for i = 1:m
    if sum_row(i) > 0
        upper = i;
        break
    end
end
% find the lower boundary
for i = m:-1:1
    if sum_row(i) > 0
        lower = i;
        break
    end
end
% find the left boundary
for i = 1:n
    if sum_col(i) > 0
        left = i;
        break
    end
end
% find the right boundary
for i = n:-1:1
    if sum_col(i) > 0
        right = i;
        break
    end
end
disp([upper, lower, left, right]);
%% Get the image of a single digit and place it onto the center of a 28*28 blackboard
nrofsegment = 5;
digit_matting = bild(upper:lower, left:right); % a digit in a minimum bounding rectangle
digit = zeros(m, n/nrofsegment); 

% adjust the up and down position of a digit
x = floor((m - upper - lower + 1)/2);
upper = upper + x; 
lower = lower + x; 
% adjust the left and right position of a digit
y = floor((n/nrofsegment - left - right + 1)/2);
left = left + y; 
right = right + y;
disp([upper, lower, left, right]);
% the pattern of the digit is exactly in the center of blackboard
digit(upper:lower, left:right) = digit_matting;

%% feature extraction
stats = regionprops(digit, 'all');
% imagesc(digit);
% colormap(gray);
[matting_size_rows, matting_size_columns] = size(digit_matting);
matting_size = matting_size_rows*matting_size_columns; % the area of the minimum bounding rectangle

features = ones(16, 1);
features(1, 1) = (stats.Area) / matting_size;
features(2, 1) = (stats.MajorAxisLength) / matting_size_columns;
features(3, 1) = (stats.MinorAxisLength) / matting_size_columns;
features(4, 1) = stats.Eccentricity;
features(5, 1) = stats.Orientation / (2 * pi);
features(6, 1) = (stats.ConvexArea) / matting_size;
features(7, 1) = stats.Circularity;
features(8, 1) = (stats.FilledArea) / matting_size;
features(9, 1) = stats.EulerNumber;
features(10, 1) = stats.Solidity;
features(11, 1) = stats.Extent;
features(12, 1) = (stats.MaxFeretDiameter) / matting_size_columns;
features(13, 1) = stats.MaxFeretAngle / (2 * pi);
features(14, 1) = (stats.MinFeretDiameter) / matting_size_columns;
features(15, 1) = stats.MinFeretAngle / (2 * pi);
features(16, 1) = matting_size_columns / matting_size_rows;
disp(features);
