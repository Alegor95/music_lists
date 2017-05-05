function [ borders ] = getborders( bw )
    [H, ~, ~] = size(bw);
    line_size = H/50;%Magic number - обосновать
    expand_coeff = 0.5;%Аналогично

    se = strel('line',line_size,90);
    dilated = imdilate(bw,se);
    image_middle = mean(dilated(:));
    threshold = image_middle;
    row_middle = mean(dilated, 2);

    %Ищем яркость больше порога
    %Находим градиент полученного вектора
    %Извлекаем индексы ненулевых элементов
    rows_gradient = diff(row_middle > threshold);
    starts = find(rows_gradient > 0);
    ends = find(rows_gradient < 0);
    if starts(1) > ends(1)
        ends = ends(2:1:length(ends));
    end;
    sizes = ends - starts;
    starts = ceil(starts - sizes * expand_coeff);
    starts(starts<1) = 1;
    ends = ceil(ends + sizes * expand_coeff);
    ends(ends>H) = H;
    borders = [starts, ends];
end

