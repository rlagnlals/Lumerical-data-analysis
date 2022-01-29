function [Field,Epsilon,nC1,nC2,neC1,neC2,Clim] = Interpolation(field,epsilon,C1,C2,eC1,eC2,clim,interpol)
%field, xyz are cell data type
%on_off ; 'on' or 'off'
%% Input
%phi = linspace(0,cycle*2*pi,cycle*frame+1); 

%% Interpolation from freq moniton
s=size(field);
s=s(3); %cellÀÇ °¹¼ö
Field=cell(s,1);

[Field1,nC1,nC2] = Interpolation_Field(field,C1,C2,interpol); % option = interpolation number
[Epsilon,neC1,neC2] = Interpolation_Index(epsilon,eC1,eC2,interpol);

[minimum, maximum]=MinMax(field);
Clim=[minimum,maximum];

end