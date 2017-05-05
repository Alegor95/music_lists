clear all;
img = imread('../test.png');
threshold = 1;
peakCount = 100;
thetaThreshold = 1;
groupColors = {[1 0 1], [0 1 0], [0 0 1], [1 1 0]};

bw = (~img) * 255;
figure(1), imshow(bw);
[N, M, ~] = size(bw);
bw = edge(bw);

[H,T,R] = hough(bw);

H = horzcat(H(:, 1:1:thetaThreshold), zeros(length(R), 180 - 2 * thetaThreshold), H(:, (180 - thetaThreshold + 1):1:180));

nhood = ceil([N/40 thetaThreshold]);
nhood = nhood - ~rem(nhood, 2);

peakThreshold = ceil(0.25*max(H(:)));

P  = houghpeaks(H, peakCount, 'threshold', peakThreshold, 'nhood',nhood);
x = T(P(:,2)); y = R(P(:,1));

lines = houghlines(bw,T,R,P,'FillGap',M,'MinLength',M / 2);
grupped = groupByY(lines, 5);
figure(2), imshow(bw), hold on
max_len = 0;
for k = 1:length(lines)   
   xy = [lines(k).point1; lines(k).point2];   
   if (grupped(k) > 0)
    plot(xy(:,1),xy(:,2),'LineWidth',1,'Color',groupColors{grupped(k)});
   else
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color', [1 0 0]);   
   end;
end
hold off