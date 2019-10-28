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
  subplot(2, 2, 1)
  imshow(original)
  title('Original')

  I = wiener2(original, [7,7]);
  subplot(2, 2, 2)
  imshow(I)
  title('Noise Reduction Filter')

  I = histeq(I);
  subplot(2, 2, 3)
  imshow(I)
  title('Histogram Equalization')

  I = medfilt2(I);
  subplot(2, 2, 4)
  imshow(I)
  title('Median Filter')

  k = strfind(name, '.');
  file = substr(name, 1, k - 1);
  s = strcat('Week_1/weiner2/', file, 'k_7.png');
  saveas(h, s);

endfunction
