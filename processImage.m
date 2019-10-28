## Copyright (C) 2019 Carter Ithier
##
## This program is free software: you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see
## <https://www.gnu.org/licenses/>.


## Author: Carter Ithier <ithier@Carters-MacBook-Pro.local>
## Created: 2019-09-22

function I = processImage(original, name)
  pkg load image
  s = size(original);
  % convert to greyscale if colored image
  if (length(s)) == 3
    original = rgb2gray(original);
  end

  h = figure('Name', name);
  subplot(2, 3, 1)
  imshow(original)
  title('Original')

  I = medfilt2(original);
  subplot(2, 3, 2)
  imshow(I)
  title('Median Filter')

  level = graythresh(I);
  subplot(2, 3, 3)
  I = im2bw(I);
  imshow(I)
  title('Thresholded Image')

  se = strel(ones(7,7));
  Io = imopen(I, se);
  subplot(2,3,4)
  imshow(Io)
  title('Erosion Followed by Dilation')

  % tumor = imoverlay(original, Io, 'yellow');
  color = cat(3, original, original, original);
  [row, col] = find(Io);
  for i = 1:size(row)
    color(row(i), col(i), :)= [0, 255, 0];
  end

  I = color;

  color(1:10, 1:10, :)
  subplot(2, 3, 5)
  imshow(color)
  title('Tumor Highlighted')

  k = strfind(name, '.');
  file = substr(name, 1, k - 1);
  s = strcat('Week_2/yes_processed/', file, '.png');
  saveas(h, s);

endfunction
