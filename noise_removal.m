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

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} noise_removal (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Carter Ithier <ithier@Carters-MacBook-Pro.local>
## Created: 2019-09-22

function I = noise_removal (original, name)
  pkg load image
  s = size(original);
  % convert to greyscale if colored image
  if (length(s)) == 3
    original = rgb2gray(original);
  end

  H = -1 * ones(3, 3);
  H(2,2) = 8;

  I = conv2(original, H);

  I = histeq(I);
  I = medfilt2(I);

  figure('Name', name);
  subplot(1, 2, 1)
  imshow(original)
  title('Original')
  subplot(1, 2, 2)
  imshow(I)
  title('New Image')

endfunction
