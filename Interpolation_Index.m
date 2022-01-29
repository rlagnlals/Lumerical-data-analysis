function [Field,nC1,nC2] = Interpolation_Index(field,C1,C2,interpol)

%%%%%%%%input%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input : filename, field, plane, interpol, index
% index : "n" or "no" 
% "n" : interpolate index  "no":do not interpolate index
% filename, field, plane should be "string"
% interpol : larger than 0
% it returns interpolated Field, coordinate1, coordinate2
% Field, coordinate1, coordinate2 are Matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% catch wrong inputs of this function
% if not(strcmp(index,'n') || strcmp(index,'no'))
%     error('you shoud type n or no for index');  %check index is n or no
% elseif not(exist('n','var'))
%     disp('index information does not exist');
% elseif not(exist(ffield,'var'))
%     error('field does not exist'); %check whether field exist or not
% elseif not(strcmp(plane,'xy') || strcmp(plane,'xz') || strcmp(plane,'yz'));
%     error('you input wrong plane');
% elseif not(interpol>=1)
%     error('interpol should be larger than 1');
% end
  

    [sx,sy]=size(field); %sz : number of slices
    Field=zeros(sy*interpol,sx*interpol);
   
    % interpolate onto linearly spaced position
    % vectors as requried by imagesc function
    nC1 = linspace(C1(1),C1(length(C1)),length(C1)*interpol);         % create linearly spaced position vectors
    nC2 = linspace(C2(1),C2(length(C2)),length(C2)*interpol);
    [X,Y] = meshgrid(C2,C1);
    [X2,Y2] = meshgrid(nC2,nC1);
    %field2 = flipud(transpose(field(:,:,i)));  % convert matrix order from FDTD form to matlab form
                                        % These matrices will be used for the image plots of the fields 
    %field2 = rot90(field(:,:,i));
    field2 = interp2(X,Y,field,X2,Y2);  % interpolate data onto linearly spaced position vectors, as required by imagesc
    Field=field2;  %return interpolated field
    
    
end