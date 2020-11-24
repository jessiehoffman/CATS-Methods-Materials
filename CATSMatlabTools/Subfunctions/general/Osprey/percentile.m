function y = percentile(x, pct)
% y = PERCENTILE(x, pct)
%   Example: percentile(x, 0.10) is the value that is greater than 10%
%   of the elements of x, and less than the remaining 90%.
%   If the length of x is such that there is no element of x exactly
%   corresponding to the 'pct' position, a linear interpolation of the
%   two adjacent values is used.  pct must be between 0 and 1 inclusive.
%
%     percentile(x, 1)   is a slow way to get max(x).  
%     percentile(x, 0.5) is the median of x.
%     percentile(x, 0)   is a slow way to get min(x).  
%
%   If x is a matrix, percentile operates on columns, returning multiple 
%   columns. If pct is a vector, multiple rows are returned, one per 
%   element of pct.
%
%   If x is 3-or-more-dimensional, operates on the first dimension.  This 
%   hasn't been tested very much.
%
% See also median, sort, max, min.

if (size(x,1) == 1 & length(size(x)) < 3), x = x.'; end
s = size(x);

if (version4)
  x = sort(x);
else
  x = sort(x, 1);
end
n = ((size(x,1) - 1) * pct(:) + 1);
r = rem(n, 1);
r1 = r * ones(1, prod(s(2:length(s))));
y = (1-r1) .* x(n-r,:);
ix = find(r);			% when n=size(x,1), x(n+1,:) doesn't exist

if (size(y,2) > 0)
  y(ix,:) = y(ix,:) + r1(ix,:) .* x(n(ix)-r(ix)+1,:);
end

if (length(s) >= 3)
  y = reshape(y, [length(pct) s(2:length(s))]);
end
