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
## @deftypefn {} {@var{retval} =} final_project (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Carter Ithier <ithier@Carters-MacBook-Pro.local>
## Created: 2019-09-22
clear all
close all
clc

Y = "yes";

% read in image and process it
S = dir(fullfile(Y, '*.JPG'));
for k = 1:numel(S)
% for k = 1:1
  F = fullfile(Y, S(k).name);
  original = imread(F);
  I = processImage(original, S(k).name);
end
