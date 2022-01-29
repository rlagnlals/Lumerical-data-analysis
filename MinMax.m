function [Min,Max]=MinMax(field,scale)
%% Introduction
% field의 최대값과 최소값을 찾는 함수이다. cell type이다.
% color range를 결정하기 위한 것
% scale : linear 또는 log scale인지
% written by KHM
% 2014-12-29
% rlagnlals@kaist.ac.kr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
size_field=size(field);
size_field=size_field(1); %cell의 갯수

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
        if isinf(Min) % minimum 값이 -Inf일 경우 -Inf를 제외한 값들 중에서 최소값을 찾는다. 그리고 그 값을 Min에 저장
            for i=1:size_field
            % 각 cell마다 -Inf인 곳에 최대값을 대입시킨다.
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
            % 그 다음에 다시 min, max를 구한다.
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
