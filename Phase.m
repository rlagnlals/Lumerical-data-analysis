function Field=Phase(field,phi)
%% Introduction
% field�� 0���� 2pi������ phase�� ���Ѵ�.
% color range�� �����ϱ� ���� ��
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