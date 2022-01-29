function [Min,Max]=MinMax(field,scale)
%% Introduction
% field�� �ִ밪�� �ּҰ��� ã�� �Լ��̴�. cell type�̴�.
% color range�� �����ϱ� ���� ��
% scale : linear �Ǵ� log scale����
% written by KHM
% 2014-12-29
% rlagnlals@kaist.ac.kr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size_field=size(field);
size_field=size_field(1); %cell�� ����

maximum=zeros(size_field,1);
minimum=zeros(size_field,1);

%% Code
for i=1:size_field
    maximum(i,1) = max(max(field{i}));
    minimum(i,1) = min(min(field{i}));  
end

maximum = max(maximum);
minimum = min(minimum);
switch scale
    case 'linear'
    % Set color bar range
        if abs(maximum)>=abs(minimum) % eg. maximum:12  minimum:-6
            maximum=maximum;
            minimum=-abs(maximum);
        %minimum=minimum;
        else % eg. maximum:6  minimum:-12
            maximum=abs(minimum);
            minimum=minimum;
        end
            Min=minimum;
            Max=maximum; 
            
        if Min==0 && Max==0
        Min=-1;
        Max=1;
        else
        end
    case 'log'
    Min=minimum;
    Max=maximum;    
        if isinf(Min) % minimum ���� -Inf�� ��� -Inf�� ������ ���� �߿��� �ּҰ��� ã�´�. �׸��� �� ���� Min�� ����
            for i=1:size_field
            % �� cell���� -Inf�� ���� �ִ밪�� ���Խ�Ų��.
                s=size(field{i});
                for j=1:s(1)
                    for k=1:s(2)
                        if isinf(field{i}(j,k))
                            field{i}(j,k)=Max;
                        else 
                        end
                    end
                end
            end
            % �� ������ �ٽ� min, max�� ���Ѵ�.
            for i=1:size_field
                maximum(i,1) = max(max(field{i}));
                minimum(i,1) = min(min(field{i}));  
            end
            Max = max(maximum);
            Min = min(minimum);
            
        else
            Min=minimum;
            Max=maximum; % set colorbar limits to max value of field    
        end
        
        if Max==0 && Min==0
        Min=-1;
        Max=1;
        else
        end
    end

% Min=minimum;
% Max=maximum; % set colorbar limits to max value of field

% if minimum==0 && maximum==0
% Min=-1;
% Max=1;
% else
% end

end
