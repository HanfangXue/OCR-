%% Declare the function
function S = im2segment(bild)
%% Global-wide Gaussian filtering and binarization
gaussian_filter = fspecial('gaussian',[3,3], 0.5);  % create a predefined gaussian filter
bild_gaussian = imfilter(bild, gaussian_filter, 'replicate');  % process the input image using the gaussian filter defined above
bild_binary = imbinarize(bild_gaussian, 41);  % binarization with a global threlshold

%% Segmentation the digits in accordance to column number
nrofsegment = 5;

% compute the summary of each column and store in an array
column_intensity_sum = sum(bild_binary);

% size of the input image
[m, n] = size(bild);

% search for the starting column and ending column of each digit
digit_startend = zeros(1, 2*nrofsegment)
i = 0;
for j = 2 : n
    if (column_intensity_sum(j) ~= 0 && column_intensity_sum(j - 1) == 0 || column_intensity_sum(j) == 0 && column_intensity_sum(j - 1) ~= 0)
        i = i + 1;
        digit_startend(i) = j;
    end
end

S = cell(1, nrofsegment);  % create a cell to store the digit sequence
% substitue the zero-valued pixels with the binarized pixels 
for i = 1 : nrofsegment
    S{i} = zeros(m, n);
    S{i}(:, digit_startend(2*i-1) : digit_startend(2*i)) = bild_binary(:, digit_startend(2*i-1) : digit_startend(2*i));
end

