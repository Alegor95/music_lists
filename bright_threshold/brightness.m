clear all;
img = imread('../test.png');
bw = (~img) * 255;
stave_size = 5;

borders = getborders(bw);
    
for k = 1:size(borders)    
    part = bw(borders(k,1):1:borders(k, 2), :);
    if isstave(part, stave_size) == stave_size
        imwrite(part, ['stave' num2str(k) '.png']);
        %figure(k); imshow(part);
    end;
end