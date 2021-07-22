function [datamat]=open_dat_file(path,width)  
% Input: 
% path         path to dat file
% width  channels of intrest could be sclar or vector
          
% Output:
% datamat       data as int16 matrix

m = memmapfile(path, 'format', 'int16' );                     % opening dat file in matlab
len=size(m.Data,1);
datamat = reshape( m.Data, [ width,  len / width ] )';         % organizing m into a matrix...
end