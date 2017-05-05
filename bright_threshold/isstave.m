function [ peaksCount ] = isstave( img, lines_count )
[H, W, ~] = size(img);

edges = edge(img);

houghTransform = hough(edges);
peakCount = lines_count;
peakThreshold = W / 4;
nhood = [ceil(H/10) 179];
nhood = nhood + ~rem(nhood, 2);
peaks = houghpeaks(houghTransform, peakCount, 'threshold', peakThreshold, 'nhood',nhood);

peaksCount = length(peaks);
end

