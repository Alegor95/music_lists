img = imread('stave9.png');

[H, W, ~] = size(img);
lines_count = ceil(H/10); % Magic number

se = strel('line',W/50,0); % Magic number
erodedBW = imerode(img,se);
img = img - erodedBW;

figure(1); imshow(erodedBW);

figure(2); imshow(img);

figure(3); imshow(medfilt2(img, [3 1])); %check filter

% [houghTransform, T, R] = hough(erodedBW);
% peakCount = lines_count;
% peakThreshold = W / 6;
% nhood = [1 1];
% nhood = nhood + ~rem(nhood, 2);
% peaks = houghpeaks(houghTransform, peakCount, 'threshold', peakThreshold, 'nhood',nhood);
% filteredPeaks = peaks;%peaks(find(peaks(:, 2)<90), :);
% lines = houghlines(erodedBW,T,R,filteredPeaks,'FillGap',W);
% 
% figure(2), imshow(img); hold on;
% for k = 1:length(lines)
%     xy = [lines(k).point1; lines(k).point2];
%     %img(xy(1, 2):1:xy(2,2), :) = 0;
%      if filteredPeaks(k, 2) == 1
%          plot(xy(:,1),xy(:,2), 'LineWidth',1,'Color', [0 1 0]);
%      else
%          plot(xy(:,1),xy(:,2), 'LineWidth',1,'Color', [1 0 0]);
%      end;
% end;
% hold off;
%figure(3), imshow(img);