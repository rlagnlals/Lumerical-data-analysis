function [Field,clim,phi,phase]=Operation(field,eh,xyz,scalar,f,op,scale)
% Field1, xyz are cell data type
% phi : 0 ~ 2pi
% f : frequency or time index
% op : timemonitor인지 frequency monitor인지 구별하는 인자
% scalar : abs or imag or abs...
% scale : linear, log scale인지 확인
% field{1}=Ex field{2}=Ey field{3}=Ez
% field{4}=Hx field{5}=Hy field{6}=Hz
% Field에 phase를 곱해주고 가장 세기가 셀 때의 phase위치를 찾아준다. 그리고 그것을 phase에 저장

switch op
    case 0 %frequency monitor일때
%% Input
cycle=1;
frame=40;
phi = linspace(0,cycle*2*pi,cycle*frame+1); 
Field = cell(length(phi),1);
saturation=1;
[s1,s2,s3]=size(field{1});

if s3==1 % frequency가 딱 1개일때
    f=1;
else
end

temp=[eh,xyz]; %eh=E 이고 xyz=x이면 temp는 Ex가 된다.
switch (temp)
    case 'Ex'
        %Field1=field{1}(:,:,f); Field2=field{2}(:,:,f);  Field3=field{3}(:,:,f);
        Field1=squeeze(field{1}(:,:,f)); Field2=zeros(s1,s2);  Field3=zeros(s1,s2);
    case 'Ey'
        %Field1=field{2}(:,:,f); Field2=field{1}(:,:,f);  Field3=field{3}(:,:,f);
        Field1=squeeze(field{2}(:,:,f)); Field2=zeros(s1,s2);  Field3=zeros(s1,s2);
    case 'Ez'
        %Field1=field{3}(:,:,f); Field2=field{1}(:,:,f);  Field3=field{2}(:,:,f);
        Field1=squeeze(field{3}(:,:,f)); Field2=zeros(s1,s2);  Field3=zeros(s1,s2);
    case 'Hx'
        %Field1=field{4}(:,:,f); Field2=field{5}(:,:,f);  Field3=field{6}(:,:,f);
        Field1=squeeze(field{4}(:,:,f)); Field2=zeros(s1,s2);  Field3=zeros(s1,s2);
    case 'Hy'
        %Field1=field{5}(:,:,f); Field2=field{4}(:,:,f);  Field3=field{6}(:,:,f);
        Field1=squeeze(field{5}(:,:,f)); Field2=zeros(s1,s2);  Field3=zeros(s1,s2);
    case 'Hz'
        %Field1=field{6}(:,:,f); Field2=field{4}(:,:,f);  Field3=field{5}(:,:,f);
        Field1=squeeze(field{6}(:,:,f)); Field2=zeros(s1,s2);  Field3=zeros(s1,s2);
    case 'Emagnitude'
        Field1=squeeze(field{1}(:,:,f)); Field2=squeeze(field{2}(:,:,f));  Field3=squeeze(field{3}(:,:,f));
    case 'Hmagnitude'
        Field1=squeeze(field{4}(:,:,f)); Field2=squeeze(field{5}(:,:,f));  Field3=squeeze(field{6}(:,:,f));
    case 'Px'
        Field1=real(squeeze(field{2}(:,:,f))).*real(squeeze(field{6}(:,:,f)))-real(squeeze(field{3}(:,:,f))).*real(squeeze(field{5}(:,:,f)));
        Field2=zeros(s1,s2,f);
        Field3=zeros(s1,s2,f);
    case 'Py'
        Field1=real(squeeze(field{3}(:,:,f))).*real(squeeze(field{4}(:,:,f)))-real(squeeze(field{1}(:,:,f))).*real(squeeze(field{6}(:,:,f)));
        Field2=zeros(s1,s2,f);
        Field3=zeros(s1,s2,f);
    case 'Pz'
        Field1=real(squeeze(field{1}(:,:,f))).*real(squeeze(field{5}(:,:,f)))-real(squeeze(field{2}(:,:,f))).*real(squeeze(field{4}(:,:,f)));
        Field2=zeros(s1,s2,f);
        Field3=zeros(s1,s2,f);
end

%% 모드가 진동할 때 모드의 profile을 보기 위해 밝기가 가장 셀 때의 frame을 찾는다. 
% Field^2 값을 phase 별로 기록 그리고 최대가 되는 순간(phase)을 찾는다. 
% 그 값을 Index에 저장한다.
Temp=zeros(length(phi),1);

        for i=1:length(phi)
            Temp(i,1)=sum(sum(real(exp(-1i*phi(i))*Field1).^2))+sum(sum(real(exp(-1i*phi(i))*Field2).^2))+sum(sum(real(exp(-1i*phi(i))*Field3).^2));
        end
        
Max=max(Temp);
Index=find(Temp==Max,1,'first');
phase=Index;
%figure, plot(Temp)
%title('Field1^2 depend on frame');

%% Index에서의 모드 profile 을 볼것인가 아니면 임의의 phase에서 모드 profile을 볼것인가
% Field1=exp(-1i*phi(Index))*Field1;
% Field2=exp(-1i*phi(Index))*Field2;
% Field3=exp(-1i*phi(Index))*Field3;
%%%%%or%%%%%%
% phase=1.5*pi/4; %phase factor
% Field1x=exp(-1i*phase)*Field1x;
% Field1y=exp(-1i*phase)*Field1y;
% Field1z=exp(-1i*phase)*Field1z;
%% Select scalar operation and set color bar range
temp1=cell(length(phi),1);
temp2=cell(length(phi),1);
temp3=cell(length(phi),1);
temp=cell(length(phi),1);

    for i=1:length(phi)
        temp1{i}=exp(-1i*phi(i))*Field1;
        temp2{i}=exp(-1i*phi(i))*Field2;
        temp3{i}=exp(-1i*phi(i))*Field3;
        temp{i}=exp(-1i*phi(i))*Field1;
    end

if strcmp(xyz,'magnitude')
    switch (scalar)
%         case 'real'
%             if strcmp(scale,'linear') % linear scale일때
%                 for i=1:length(phi)
%                     Field{i}=(real(temp1{i})).^2+(real(temp2{i})).^2+(real(temp3{i})).^2;
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             else % log scale일때
%                 for i=1:length(phi)
%                     Field{i}=log10((real(temp1{i})).^2+(real(temp2{i})).^2+(real(temp3{i})).^2);
%                 end
%              [minimum, maximum]=MinMax(Field,scale);
%             clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             end
            
      
%         case 'imag'
%             if strcmp(scale,'linear') % linear scale일때
%                 for i=1:length(phi)
%                     Field{i}=(imag(temp1{i})).^2+(imag(temp2{i})).^2+(imag(temp3{i})).^2;
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             else % log scale일때
%                 for i=1:length(phi)
%                     Field{i}=log10((imag(temp1{i})).^2+(imag(temp2{i})).^2+(imag(temp3{i})).^2);
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             end
        
        
%         case 'abs'
%             if strcmp(scale,'linear') % linear scale일때
%                 for i=1:length(phi)
%                     Field{i}=(real(temp1{i})).^2+(real(temp2{i})).^2+(real(temp3{i})).^2;
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             else % log scale일때
%                 for i=1:length(phi)
%                     Field{i}=log10((real(temp1{i})).^2+(real(temp2{i})).^2+(real(temp3{i})).^2);
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             end
        
        case 'abs^2'
            if strcmp(scale,'linear') % linear scale일때
                for i=1:length(phi)
                    Field{i}=(real(temp1{i})).^2+(real(temp2{i})).^2+(real(temp3{i})).^2;
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            else % log scale일때
                for i=1:length(phi)
                    Field{i}=log10((real(temp1{i})).^2+(real(temp2{i})).^2+(real(temp3{i})).^2);
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            end
        
    end
    
else

    switch (scalar)
        case 'real'
            if strcmp([eh,xyz],'Px') 
                for i=1:length(phi)
                Field{i}=real(squeeze(field{2}(:,:,f))*exp(-1i*phi(i))).*real(squeeze(field{6}(:,:,f))*exp(-1i*phi(i)))-real(squeeze(field{3}(:,:,f))*exp(-1i*phi(i))).*real(squeeze(field{5}(:,:,f))*exp(-1i*phi(i))); % real(Field)가 안되서 각각 real을 해줘야 함
                end
            elseif strcmp([eh,xyz],'Py') 
                for i=1:length(phi)
                Field{i}=real(squeeze(field{3}(:,:,f))*exp(-1i*phi(i))).*real(squeeze(field{4}(:,:,f))*exp(-1i*phi(i)))-real(squeeze(field{1}(:,:,f))*exp(-1i*phi(i))).*real(squeeze(field{6}(:,:,f))*exp(-1i*phi(i)));
                end
            elseif strcmp([eh,xyz],'Pz') 
                for i=1:length(phi)
                Field{i}=real(squeeze(field{1}(:,:,f))*exp(-1i*phi(i))).*real(squeeze(field{5}(:,:,f))*exp(-1i*phi(i)))-real(squeeze(field{2}(:,:,f))*exp(-1i*phi(i))).*real(squeeze(field{4}(:,:,f))*exp(-1i*phi(i)));
                end
            else 
                for i=1:length(phi)
                Field{i}=real(temp{i}); % real(Field)가 안되서 각각 real을 해줘야 함
                end
            end
        % Field=real(Field1);
        % Set color bar range
        [minimum, maximum]=MinMax(Field,scale);
        clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
        case 'imag'
            for i=1:length(phi)
                Field{i}=imag(temp{i});
            end
        % Set color bar range
        [minimum, maximum]=MinMax(Field,scale);
        clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
        case 'abs'
            if strcmp(scale,'linear') % linear scale일때
                for i=1:length(phi)
                    Field{i}=abs(real(temp{i}));
                end   
            [minimum, maximum]=MinMax(Field,scale);
            clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            else % log scale일때
                for i=1:length(phi)
                    Field{i}=log10(abs(real(temp{i})));
                end  
            [minimum, maximum]=MinMax(Field,scale);
            clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            end
        
        % Set color bar range
%         [minimum, maximum]=MinMax(Field,scale);
%         clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
        case 'abs^2'
            if strcmp(scale,'linear') % linear scale일때
                for i=1:length(phi)
                    Field{i}=abs(real(temp{i})).^2;
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            else % log scale일때
                for i=1:length(phi)
                    Field{i}=log10(abs(real(temp{i})).^2);
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            end
        
        % Set color bar range
%         [minimum, maximum]=MinMax(Field.^2);
%         clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
    end
end

    case 1 %time monitor일때
        
[s1,s2,s3]=size(field{1});
phi=linspace(0,s3,s3); %time step의 갯수이다.
phase=f;
saturation=1;

Field = cell(length(phi),1);

temp=[eh,xyz];
    
switch (temp)
    case 'Ex'
        Field1=field{1}; Field2=zeros(s1,s2,s3);  Field3=zeros(s1,s2,s3);
    case 'Ey'
        Field1=field{2}; Field2=zeros(s1,s2,s3);  Field3=zeros(s1,s2,s3);  
    case 'Ez'
        Field1=field{3}; Field2=zeros(s1,s2,s3);  Field3=zeros(s1,s2,s3);
    case 'Hx'
        Field1=field{4}; Field2=zeros(s1,s2,s3);  Field3=zeros(s1,s2,s3);
    case 'Hy'
        Field1=field{5}; Field2=zeros(s1,s2,s3);  Field3=zeros(s1,s2,s3);
    case 'Hz'
        Field1=field{6}; Field2=zeros(s1,s2,s3);  Field3=zeros(s1,s2,s3);
    case 'Emagnitude'
        Field1=field{1}; Field2=field{2};  Field3=field{3};
    case 'Hmagnitude'
        Field1=field{4}; Field2=field{5};  Field3=field{6};
end

if strcmp(xyz,'magnitude')
    switch (scalar)
%         case 'real'
%             if strcmp(scale,'linear') % linear scale일때
%                 for i=1:length(phi)
%                     Field{i}=Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2;
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             else % log scale일때
%                 for i=1:length(phi)
%                     Field{i}=log10(Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2);
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             end
        
%         case 'imag'
%             if strcmp(scale,'linear') % linear scale일때
%                 for i=1:length(phi)
%                     Field{i}=Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2;
%                 end     
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             else % log scale일때
%                 for i=1:length(phi)
%                     Field{i}=log10(Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2);
%                 end     
%              [minimum, maximum]=MinMax(Field,scale);
%             clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             end
%          
%         case 'abs'
%             if strcmp(scale,'linear') % linear scale일때
%                 for i=1:length(phi)
%                     Field{i}=Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2;
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             else % log scale일때
%                 for i=1:length(phi)
%                     Field{i}=log10(Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2);
%                 end
%             [minimum, maximum]=MinMax(Field,scale);
%             clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
%             end
        
        case 'abs^2'
            if strcmp(scale,'linear') % linear scale일때
                for i=1:length(phi)
                    Field{i}=Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2;
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            else % log scale일때
                for i=1:length(phi)
                    Field{i}=log10(Field1(:,:,i).^2+Field2(:,:,i).^2+Field3(:,:,i).^2);
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            end
        
    end
    
else

    switch (scalar)
        case 'real'
            for i=1:length(phi)
                Field{i}=Field1(:,:,i); 
            end
        % Field=real(Field1);
        % Set color bar range
        [minimum, maximum]=MinMax(Field,scale);
        clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
        case 'imag'
            for i=1:length(phi)
                Field{i}=Field1(:,:,i);
            end
        % Set color bar range
        [minimum, maximum]=MinMax(Field,scale);
        clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
        case 'abs'
            if strcmp(scale,'linear') % linear scale일때
                for i=1:length(phi)
                    Field{i}=abs(Field1(:,:,i));
                end 
            [minimum, maximum]=MinMax(Field,scale);
            clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            else % log scale일때
                for i=1:length(phi)
                    Field{i}=log10(abs(Field1(:,:,i)));
                end 
            [minimum, maximum]=MinMax(Field,scale);
            clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            end
        
        % Set color bar range
%         [minimum, maximum]=MinMax(Field,scale);
%         clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
        case 'abs^2'
            if strcmp(scale,'linear') % linear scale일때
                for i=1:length(phi)
                    Field{i}=abs(Field1(:,:,i)).^2;
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            else % log scale일때
                for i=1:length(phi)
                    Field{i}=log10(abs(Field1(:,:,i)).^2);
                end
            [minimum, maximum]=MinMax(Field,scale);
            clim=[minimum/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
            end
        
        % Set color bar range
%         [minimum, maximum]=MinMax(Field.^2);
%         clim=[0/saturation,maximum/saturation]; % set colorbar limits to max value of Field1
        
    end
end
        
end