function Field=Phase(field,phi)
%% Introduction
% field에 0부터 2pi까지의 phase를 곱한다.
% color range를 결정하기 위한 것
% written by KHM
% 2014-12-29
% rlagnlals@kaist.ac.kr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Code
step=length(phi);
Field=cell(step,1);

for i=1:step
   Field{i}=exp(-1i*phi(i))*field;
end

end