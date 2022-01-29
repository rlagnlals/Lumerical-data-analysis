function varargout = Field(varargin)
% E_H MATLAB code for E_H.fig
%      E_H, by itself, creates a new E_H or raises the existing
%      singleton*.
%
%      H = E_H returns the handle to a new E_H or the handle to
%      the existing singleton*.
%
%      E_H('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in E_H.M with the given input arguments.
%
%      E_H('Property','Value',...) creates a new E_H or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Field_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Field_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help E_H

% Last Modified by GUIDE v2.5 04-Jul-2019 13:37:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Field_OpeningFcn, ...
                   'gui_OutputFcn',  @Field_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before E_H is made visible.
function Field_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to E_H (see VARARGIN)

handles.output = hObject;

handles.load=0;
handles.call1=0;
handles.call2=0;
handles.clickplot=0;
handles.interpolation=0;

set(handles.rowcolpanel,'Visible','off');

%% Set wavelength panel
set(handles.wavelengthpanel,'Position',[0.314 0.017 0.3 0.17]);
set(handles.wavelengthpanel_value,'Position',[0.026 0.333 0.158 0.238]);
set(handles.wavelengthpanel_unit,'Position',[0.026 0.1 0.158 0.238]);
%% Set x panel
set(handles.xpanel,'Position',[0.314 0.017 0.3 0.17]);
set(handles.xpanel_axismin,'Position',[0.044 0.456 0.189 0.208]);
set(handles.xpanel_axismax,'Position',[0.044 0.26 0.189 0.208]);
set(handles.xpanel_currentvalue,'Position',[0.044 0.044 0.189 0.208]);
set(handles.xaxismin,'Position',[0.247 0.528 0.272 0.188]);
set(handles.xaxismax,'Position',[0.247 0.306 0.272 0.188]);
set(handles.xaxiscurrent,'Position',[0.247 0.084 0.272 0.188]);
set(handles.xaxisslider,'Position',[0.075 0.855 0.843 0.13]);
%% Set y panel
set(handles.ypanel,'Position',[0.314 0.017 0.3 0.17]);
set(handles.ypanel_axismin,'Position',[0.044 0.456 0.189 0.208]);
set(handles.ypanel_axismax,'Position',[0.044 0.26 0.189 0.208]);
set(handles.ypanel_currentvalue,'Position',[0.044 0.044 0.189 0.208]);
set(handles.yaxismin,'Position',[0.247 0.528 0.272 0.188]);
set(handles.yaxismax,'Position',[0.247 0.306 0.272 0.188]);
set(handles.yaxiscurrent,'Position',[0.247 0.084 0.272 0.188]);
set(handles.yaxisslider,'Position',[0.075 0.855 0.843 0.13]);
%% Set z panel
set(handles.zpanel,'Position',[0.314 0.017 0.3 0.17]);
set(handles.zpanel_axismin,'Position',[0.044 0.456 0.189 0.208]);
set(handles.zpanel_axismax,'Position',[0.044 0.26 0.189 0.208]);
set(handles.zpanel_currentvalue,'Position',[0.044 0.044 0.189 0.208]);
set(handles.zaxismin,'Position',[0.247 0.528 0.272 0.188]);
set(handles.zaxismax,'Position',[0.247 0.306 0.272 0.188]);
set(handles.zaxiscurrent,'Position',[0.247 0.084 0.272 0.188]);
set(handles.zaxisslider,'Position',[0.075 0.855 0.843 0.13]);

guidata(hObject, handles);

% UIWAIT makes E_H wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Field_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
%varargout{1} = handles.Data;

% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Load file
clearvars -global *; %global 변수를 제거한다. (global변수를 정의하기 전에 청소하는 것)
global data;
global custom_color;
global steelblue;
% execute open gui
opengui=Open; 
handles.opengui=guihandles(opengui);
contents=(get(handles.Filelist,'String')); % File list에 있는 file 목록을 받아온다.
set(handles.opengui.Filelist,'String',contents);
waitfor(opengui) %open gui가 닫힐때 까지 프로그램 실행을 멈춘다.

filelist=data.filelist; % 파일 list 정보를 받아온다.
set(handles.Filelist,'String',filelist);

custom_color=[cmap('steelblue',120,10,0);flipud(cmap('orangered',120,10,0))]; %% 'custom' colormap의 정의
steelblue=cmap('steelblue',255,10,0); %% 'custom' colormap의 정의

guidata(hObject, handles);

% --- Executes on button press in Upload.
function Upload_Callback(hObject, eventdata, handles)
% hObject    handle to Upload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in Plot.
handles.slice_indexx=1;
handles.slice_indexy=1;
handles.slice_indexz=1;
handles.slice_fieldx=1;
handles.slice_fieldy=1;
handles.slice_fieldz=1;
handles.empty=0; % index 데이터가 없다.
handles.timemonitor=0; % 0이면 frequency monitor라는 뜻
set(handles.F,'String','f');
set(handles.wavelengthpanel,'Title','frequency');

selected_item=get(handles.Filelist,'Value');
str=get(handles.Filelist,'String');
if isempty(str)==1 % filelist에 아무것도 없을 때
    msgbox('First, you should load file. push "Load data" ');
    return
else
    selected_file=str{selected_item};
    handles.selected_file=selected_file;
end

Data=load(selected_file);
disp(fieldnames(Data)); % Data에 들어있는 자료들의 목록을 보여준다.
handles.Data=Data;

handles.EH=cell(6,1);
handles.xyz=cell(3,1);
fields = fieldnames(handles.Data);
size_data = size(fields);
size_data = size_data(1); %Data에 들어있는 정보의 개수

set(handles.xpopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(handles.ypopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(handles.zpopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(handles.frequencypopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
%find(ismember(fields,'Ex'))
%find(ismember(fields,'Ey'))
%find(ismember(fields,'Ez'))
%handles.f=handles.Data.f;

% for i = 1:size_data
%      name = char(s(i));
%      %m = handles.Data.(name);
%      %assignin('base', name, m);
% end

if find(ismember(fields,'n'))>0 % n이라는 정보가 있으면 0보다 큰 값이 나옴
    handles.empty=1; % index 데이터가 있다.
else
end
 
if find(ismember(fields,'t'))>0 % t라는 정보가 있으면 0보다 큰 값이 나옴
    disp('larger than 0')
    set(handles.F,'String','t');
    set(handles.wavelengthpanel,'Title','time');
    set(handles.phasepanel,'Title','time');
    handles.f=handles.Data.t;
    handles.timemonitor=1; % time monitor라는 뜻
    t={'s';'ms (1e-3)';'microsecond (1e-6)';'ns (1e-9)';'ps (1e-12)';'fs (1e-15)'};
    set(handles.Unit,'String',t);
    set(handles.Unit,'Value',1);
else
    handles.f=handles.Data.f;    
    set(handles.phasepanel,'Title','phase');
    s={'Hz';'KHz (1e3)';'MHz (1e6)';'GHz (1e9)';'THz (1e12)'};
    set(handles.Unit,'String',s);
    set(handles.Unit,'Value',1);
end

%% Mat file에 들어있는 coordinate, field를 저장한다.

handles.xyz{1}=handles.Data.x; %coordinate of field
handles.xyz{2}=handles.Data.y;
handles.xyz{3}=handles.Data.z;
if find(ismember(fields,'Ex'))>0
    handles.EH{1}=handles.Data.Ex;
    size_EH=size(handles.Data.Ex);
else
    handles.EH{1}=[];
end

if find(ismember(fields,'Ey'))>0
    handles.EH{2}=handles.Data.Ey;
    size_EH=size(handles.Data.Ey);
else
    handles.EH{2}=[];
end

if find(ismember(fields,'Ez'))>0
    handles.EH{3}=handles.Data.Ez;
    size_EH=size(handles.Data.Ez);
else
    handles.EH{3}=[];
end

if find(ismember(fields,'Hx'))>0
    handles.EH{4}=handles.Data.Hx;
    size_EH=size(handles.Data.Hx);
else
    handles.EH{4}=[];
end

if find(ismember(fields,'Hy'))>0
    handles.EH{5}=handles.Data.Hy;
    size_EH=size(handles.Data.Hy);
else
    handles.EH{5}=[];
end

if find(ismember(fields,'Hz'))>0
    handles.EH{6}=handles.Data.Hz;
    size_EH=size(handles.Data.Hz);
else
    handles.EH{6}=[];
end

%% 존재하지 않는 field가 있는경우 모든 값이 0인 matrix를 집어 넣는다.
% assignin('base','EH',handles.EH)
% handles.EH{1}=handles.Data.Ex;
% handles.EH{2}=handles.Data.Ey;
% handles.EH{3}=handles.Data.Ez;
% handles.EH{4}=handles.Data.Hx;
% handles.EH{5}=handles.Data.Hy;
% handles.EH{6}=handles.Data.Hz;
for i=1:6
   if isempty(handles.EH{i}) 
       handles.EH{i}=zeros(size_EH);
   else
   end
end

handles.fmonitortype=handles.Data.fmonitor_type; % eg. 3D, 2D Y-normal
set(handles.fielddimension,'String',handles.fmonitortype);

%% field monitor 2D 인지 3D인지 확인
firstletter=handles.fmonitortype(1);
if strcmp(firstletter,'2') %2D case
    set(handles.fielddimension,'String','2D');
    fourthletter=handles.fmonitortype(4);
    switch fourthletter
        case 'X'
            set(handles.fieldslice,'String',{'X'});
            set(handles.fieldslice,'Value',1);
            panelsetting(handles)
        case 'Y'
            set(handles.fieldslice,'String',{'Y'});
            set(handles.fieldslice,'Value',1);
            panelsetting(handles)
        case 'Z'
            set(handles.fieldslice,'String',{'Z'});
            set(handles.fieldslice,'Value',1);
            panelsetting(handles)
    end
else %3D case
    set(handles.fielddimension,'String','3D');
    set(handles.fieldslice,'String',{'X';'Y';'Z'});
    set(handles.fieldslice,'Value',1);
    panelsetting(handles)
end

%% Index monitor 있는지 & 2D 인지 3D 인지 확인
if handles.empty==0 %index 데이터가 없을 때
    set(handles.indexdimension,'String','No index');
    set(handles.indexslice,'String',{''});
else %index 데이터가 있을 때
    handles.emonitortype=handles.Data.imonitor_type; % eg. 3D, 2D Y-normal
    firstletter=handles.emonitortype(1);
    %set(handles.indexdimension,'String',handles.emonitortype);
    if strcmp(firstletter,'2') % It is 2D monitor
        set(handles.indexdimension,'String','2D');
        fourthletter=handles.emonitortype(4);
        switch fourthletter
            case 'X'
            set(handles.indexslice,'String',{'X'});
            set(handles.indexslice,'Value',1);
            panelsetting(handles)
            case 'Y'
            set(handles.indexslice,'String',{'Y'});
            set(handles.indexslice,'Value',1);
            panelsetting(handles)
            case 'Z'
            set(handles.indexslice,'String',{'Z'});
            set(handles.indexslice,'Value',1);
            panelsetting(handles)
        end
    else % It is 3D monitor
        set(handles.indexdimension,'String','3D');
        set(handles.indexslice,'String',{'X';'Y';'Z'});
        panelsetting(handles)
    end
end

% send available wavelength or time to "wavelength pop up" menu
s = handles.f;
handles.fscaled=handles.f;
set(handles.wavelength,'String',{s});
set(handles.wavelength,'Value',1); % default index of frequency or time
set(handles.frequencystring,'String',s(1));
set(handles.Unit,'Value',1);

%set wavelength slider
if length(s)>1
    set(handles.wavelengthslider, 'Min', 1);
    set(handles.wavelengthslider, 'Max', length(s));
    set(handles.wavelengthslider, 'Value', 1);
    sliderStep = [1,1]/(length(s) - 1); % major and minor steps of 1
else
    set(handles.wavelengthslider, 'Min', 1);
    set(handles.wavelengthslider, 'Max', 1.4);
    set(handles.wavelengthslider, 'Value', 1);
    sliderStep = [1,1];
end
set(handles.wavelengthslider, 'SliderStep', sliderStep); 
 
%set freuquency popup
set(handles.frequencypopup,'Value',3);

msgbox('Upload is success');
handles.load=1; % upload를 했는지 확인하는 인자
guidata(hObject, handles);


function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global custom_color;
global steelblue;

%% Data loading 하지 않은 상태에서 실행되지 않도록 방지
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
else    
end

s=get(handles.Selections,'Data');
%% Field ,Index 선택했을 때 잘못 선택하는 것을 방지
EH=s{1};
handles.plotchoice{1}=EH;
if strcmp(EH,'Index') %Index를 선택했을 때
    if handles.empty==0
        msgbox('no index, you can not plot') %Index가 없으면 실행되지 않도록 하는것
        return
    end
else %Index제외한 field를 선택했을 때
    if handles.empty==0 && s{5}==1 %Index가 없는데 contour를 눌렀을 때 실행되지 않게함
        msgbox('no index, contour is not available')
        return
    else
    end
end
%% Field component selection (eg. Ex, Ey ....)
component=s{2};
handles.plotchoice{2}=component;
%% Scalar selection (real, imag, abs ...)
scalar=s{3};
handles.scalar=scalar;
handles.plotchoice{3}=scalar;
%% 데이터에 포함되어있지 않은 field를 선택한 경우에 실행 되지 않게한다.
% fielddata={'Ex';'Ey';'Ez';'Hx';'Hy';'Hz';'Emagnitude';'Hmagnitude'};
% choice=[EH,component];
% ind=find(ismember(fielddata,choice));
% if ind<=6 % 'Emagnitude' 'Hmagnitude' 을 제외하고 선택한 경우
%     if isempty(handles.EH{ind})
%         msgbox('The field is not available');
%         return
%     else
%     end
% else % 'Emagnitude' 'Hmagnitude' 을 선택한 경우
%     if ind==7 % 'Emagnitude' 선택한 경우
%         if isempty(handles.EH{1}) || isempty(handles.EH{2}) || isempty(handles.EH{3})
%             msgbox('The field is not available');
%             return
%         else
%         end
%     else %'Hmagnitude' 선택한 경우
%         if isempty(handles.EH{4}) || isempty(handles.EH{5}) || isempty(handles.EH{6})
%             msgbox('The field is not available');
%             return
%         else
%         end
%     end
% end

%% Frequency selection
list=get(handles.wavelength,'String');
val=get(handles.wavelength,'Value');
f=val;
handles.fselectedval=val;

%% Color map (bluered, jet, hsv...)
color=s{4};
handles.colormap=color;
%% Contour on & off
temp=s{5};
handles.plotchoice{5}=temp;
if temp==1 %contour의 check가 되어있을 때
    onoff='on';
else %contour의 check가 해제 되어있을 때
    onoff='off';
end    
handles.option=onoff;

%% Contour color
temp=s{7};
switch temp
    case 'black'
        handles.contourcolor='k';
    case 'white'
        handles.contourcolor='w';
    case 'red'
        handles.contourcolor='r';
end
%% Scale
% if strcmp(s{3},'real') || strcmp(s{3},'imag') %log plot은 음수가 포함된 경우 plot할 수 없다.
%     s{6}='linear';
%     handles.scale=s{6};
%     set(handles.Selections,'Data',s);
% else
%     handles.scale=s{6};
% end
handles.scale=s{6};
handles.plotchoice{6}=s{6};
%% Plot types (line, surface, vector)
list=get(handles.Type,'String');
val=get(handles.Type,'Value');
types=list{val};
handles.types=types;

%% Call functions
%[Field,C1,C2,Index]=Interpolation(handles.EH,handles.xyz,handles.index,1);
%[field,clim,phi,phase]=Operation(Field,EH,component,scalar,f);

if handles.call1==1 || handles.call2==1 
    % phase혹은 legend 를 바꿧을때는 Field process, Index process를 굳이 다시 실행하지 않고 바로 Plot section으로 넘어가게 한다.
    % phase를 건드리면 phase callback 함수에 의해서 handles.call1 에 1이 저장된다. 마찬가지로
    % legend를 건드리면 legend callback 함수에 의해서 handles.call2에 1이 저장된다.
else
    if strcmp(EH,'Index') %Index를 선택했을 때
       [handles.epsilon,handles.eC1,handles.eC2]=Indexprocess(handles); %어떤 slice의 index를 볼것인지
       handles.interpolation=0;
       nPlot_Callback(hObject, eventdata, handles)   
       return
        % nPlot_Callback(hObject, eventdata, handles) 을 실행시키고 아래의 코드는 실행하지
        % 않게 한다.
    
    else %Index제외한 field를 선택했을 때
        switch onoff
            case 'on' %contour 활성화
            
                str_f=get(handles.fieldslice,'String');
                val_f=get(handles.fieldslice,'Value');
                direction_f=str_f{val_f};

                str_i=get(handles.indexslice,'String');
                val_i=get(handles.indexslice,'Value');
                direction_i=str_i{val_i};
                
                if strcmp(direction_f,direction_i) % 같은 slice인 경우에 실행
                                
                    [handles.EH,handles.C1,handles.C2]=Fieldprocess(handles); %어떤 slice의 field를 볼것인지
                    [handles.epsilon,handles.eC1,handles.eC2]=Indexprocess(handles); %어떤 slice의 index를 볼것인지
                    [handles.Field,handles.clim,handles.phi,handles.phase]=Operation(handles.EH,EH,component,scalar,f,handles.timemonitor,handles.scale);
                else
                    msgbox('You should choose same direction ');
                    return 
                end
            
            
            case 'off' %contour 비활성화
                
                [handles.EH,handles.C1,handles.C2]=Fieldprocess(handles);
                [handles.Field,handles.clim,handles.phi,handles.phase]=Operation(handles.EH,EH,component,scalar,f,handles.timemonitor,handles.scale);
                %[handles.epsilon,handles.eC1,handles.eC2]=Indexprocess(handles); %어떤 slice의 index를 볼것인지
        end
    end
end


%% set color bar
clim=handles.clim;
if handles.call1==0 % color max 조절하는 slider를 건드리지 않았을 때
    switch s{6}
        case 'linear'
            % set color bar max value
            set(handles.Legend, 'Min', clim(1));
            set(handles.Legend, 'Max', clim(2));
            set(handles.Legend, 'Value', clim(2));
            set(handles.Legend_max,'String',num2str(clim(2)));
            set(handles.Legend_min,'String',num2str(clim(1)));
            set(handles.Legend_cmax,'String',num2str(clim(2)));
            nlim(1)=clim(1);
            nlim(2)=clim(2);
        case 'log'
%             clim(1)
%             clim(2)
            set(handles.Legend, 'Min', clim(1));
            set(handles.Legend, 'Max', clim(2));
            set(handles.Legend, 'Value', clim(1));
            set(handles.Legend_max,'String',num2str(clim(2)));
            set(handles.Legend_min,'String',num2str(clim(1)));
            set(handles.Legend_cmax,'String',num2str(clim(1)));
            nlim(1)=clim(1);
            nlim(2)=clim(2);
    end
else % color max 조절하는 slider를 건드렸을 때
%     if clim(1)==0 % abs 또는 abs^2 의 plot일 경우
    switch s{6}
        case 'linear'
            if strcmp(s{3},'abs') || strcmp(s{3},'abs^2')% abs 또는 abs^2 의 plot일 경우
                nlim(2)=get(handles.Legend,'Value');
                nlim(1)=clim(1);
            else % real 또는 imag 의 plot일 경우
                nlim(2)=get(handles.Legend,'Value');
                nlim(1)=-nlim(2);
            end
        case 'log'
            nlim(2)=clim(2);
            nlim(1)=get(handles.Legend,'Value');
    end
end
handles.nlim=nlim;

%% phase slider
phi=handles.phi;
if handles.call2==0 % phase 조절하는 slider를 건드리지 않았을 때
    % set phase value
    set(handles.Phase, 'Min', 1);
    set(handles.Phase, 'Max', length(phi));
    set(handles.Phase, 'Value', handles.phase);
    sliderStep = [1,1]/(length(phi) - 1); % major and minor steps of 1
    set(handles.Phase, 'SliderStep', sliderStep); 
    set(handles.Phase_current,'String',num2str(handles.phase));
    set(handles.Phase_min,'String',num2str(1));
    set(handles.Phase_max,'String',num2str(length(phi)));
    phase=handles.phase;
else % phase 조절하는 slider를 건드렸을 때
    phase=get(handles.Phase,'Value');
end
%% Plot(Line, surface, vector)
% type=get(handles.Type,'Value');
% if type==1 % line plot
%     Lineplot(handles,phase);
%     disp('lineplot');
%     fieldnames(handles)
%     return
% else %surface, vector plot
% end

%% Plot하기 위한 input value
field=handles.Field;
Field=field{phase}; %particular phase
C1=handles.C1;
C2=handles.C2;


%%
if strcmp(EH,'Index')
else
switch (onoff) %contour 활성화 또는 비활성화
     case 'on' %활성화   
           Epsilon=handles.epsilon;
           eC1=handles.eC1;
           eC2=handles.eC2; 
           
           
            handles.currentfield=Field;    %
            handles.currentaxes1=C1;       %
            handles.currentaxes2=C2;       %
            handles.currentlim=nlim;   
            handles.currentindex=handles.epsilon;
            handles.currentindexaxes1=handles.eC1;
            handles.currentindexaxes2=handles.eC2;
            handles.currentcontourcolor=handles.contourcolor;
            handles.currentcolormap=handles.colormap;
            handles.currentonoff=handles.option;

                if strcmp(color,'bluered')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on 
                elseif strcmp(color,'custom')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on     
                elseif strcmp(color,'steelblue')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(steelblue);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on     
                else
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on 
                end
                %contour(C1,C2,Index,1,'k')			% plot index coutour
                contour(eC1,eC2,real(rot90(Epsilon)),1,handles.contourcolor)
                g = findobj('Type','line');
                set(g,'LineWidth',1)
                axis off
                hold off
%                 axes(handles.axes3)
%                 axis off
%                 colorbar
                
     case 'off' %비활성화
         
            handles.currentfield=Field;    %
            handles.currentaxes1=C1;       %
            handles.currentaxes2=C2;       %
            handles.currentlim=nlim;        
            handles.currentcontourcolor=handles.contourcolor;
            handles.currentcolormap=handles.colormap;
            handles.currentonoff=handles.option;
            
                if strcmp(color,'bluered')
                axes(handles.axes1);
                imagesc(C1,C2,rot90(Field),nlim);
                axis image;
                axis off;
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                elseif strcmp(color,'custom')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim);
                axis image;
                axis off;
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                elseif strcmp(color,'steelblue')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim);
                axis image;
                axis off;
                colormap(steelblue);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                else
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                axis image
                axis off
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                end   
                
   
end
end
handles.call1=0;
handles.call2=0;
handles.clickplot=1;
handles.interpolation=0;
setappdata(0,'MyStruct',handles)
set(handles.Postprocess,'Visible','on');
guidata(hObject, handles);

function [EH,C1,C2]=Fieldprocess(handles)
% Field 데이터가 2D 인지 3D 인지 확인하고
% 어떤 slice의 field를 볼것인지에 대한 정보를 저장한다.
firstletter=handles.fmonitortype(1);
if strcmp(firstletter,'2') %2D case
   str=get(handles.fieldslice,'String');
   val=get(handles.fieldslice,'Value');
   direction=str{val};
       switch direction
            case 'X'
                C1=handles.Data.y;
                C2=handles.Data.z;
            case 'Y'
                C1=handles.Data.x;
                C2=handles.Data.z;                
            case 'Z'
                C1=handles.Data.x;
                C2=handles.Data.y;            
       end
    EH{1}=handles.EH{1};
    EH{2}=handles.EH{2};
    EH{3}=handles.EH{3};
    EH{4}=handles.EH{4};
    EH{5}=handles.EH{5};
    EH{6}=handles.EH{6};
else %3D case   
   str=get(handles.fieldslice,'String');
   val=get(handles.fieldslice,'Value');
   direction=str{val};
   switch direction
            case 'X'
                %slice_index=get(handles.xaxisslider,'Value');
                slice_index=handles.slice_field;
                C1=handles.Data.y;
                C2=handles.Data.z;
                EH{1}=squeeze(handles.EH{1}(slice_index,:,:,:));
                EH{2}=squeeze(handles.EH{2}(slice_index,:,:,:));
                EH{3}=squeeze(handles.EH{3}(slice_index,:,:,:));
                EH{4}=squeeze(handles.EH{4}(slice_index,:,:,:));
                EH{5}=squeeze(handles.EH{5}(slice_index,:,:,:));
                EH{6}=squeeze(handles.EH{6}(slice_index,:,:,:));
            case 'Y'
                %slice_index=get(handles.yaxisslider,'Value');
                slice_index=handles.slice_field;
                C1=handles.Data.x;
                C2=handles.Data.z;    
                EH{1}=squeeze(handles.EH{1}(:,slice_index,:,:));
                EH{2}=squeeze(handles.EH{2}(:,slice_index,:,:));
                EH{3}=squeeze(handles.EH{3}(:,slice_index,:,:));
                EH{4}=squeeze(handles.EH{4}(:,slice_index,:,:));
                EH{5}=squeeze(handles.EH{5}(:,slice_index,:,:));
                EH{6}=squeeze(handles.EH{6}(:,slice_index,:,:));
            case 'Z'
                %slice_index=get(handles.zaxisslider,'Value');
                slice_index=handles.slice_field;
                C1=handles.Data.x;
                C2=handles.Data.y;            
                EH{1}=squeeze(handles.EH{1}(:,:,slice_index,:));
                EH{2}=squeeze(handles.EH{2}(:,:,slice_index,:));
                EH{3}=squeeze(handles.EH{3}(:,:,slice_index,:));
                EH{4}=squeeze(handles.EH{4}(:,:,slice_index,:));
                EH{5}=squeeze(handles.EH{5}(:,:,slice_index,:));
                EH{6}=squeeze(handles.EH{6}(:,:,slice_index,:));
   end
end

function [Slice,eC1,eC2]=Indexprocess(handles)
% Index 데이터가 2D 인지 3D 인지 확인하고
% 어떤 slice의 Index를 볼것인지에 대한 정보를 저장한다.
firstletter=handles.emonitortype(1);
if strcmp(firstletter,'2') % 2D monitor
   str=get(handles.indexslice,'String');
   val=get(handles.indexslice,'Value');
   direction=str{val};
     switch direction
            case 'X'
                eC1=handles.Data.iy;
                eC2=handles.Data.iz;
            case 'Y'
                eC1=handles.Data.ix;
                eC2=handles.Data.iz;                
            case 'Z'
                eC1=handles.Data.ix;
                eC2=handles.Data.iy;
     end
     Slice=squeeze(handles.Data.n); % 200x1x300 => 200x300
%     Epsilon=handles.epsilon;
%     eC1=handles.eC1;
%     eC2=handles.eC2;

else % 3D monitor
    Epsilon=handles.Data.n;
    str=get(handles.indexslice,'String');
    val=get(handles.indexslice,'Value');
    slice=str{val};
        switch slice
            case 'X'
            disp('x');
            %slice_index=get(handles.xaxisslider,'Value');
            slice_index=handles.slice_indexx;
            Slice=squeeze(Epsilon(slice_index,:,:));
            eC1=handles.Data.iy;
            eC2=handles.Data.iz;
            case 'Y'
            %slice_index=get(handles.yaxisslider,'Value');
            slice_index=handles.slice_indexy;
            Slice=squeeze(Epsilon(:,slice_index,:));
            eC1=handles.Data.ix;
            eC2=handles.Data.iz;
            case 'Z'
            %slice_index=get(handles.zaxisslider,'Value');
            slice_index=handles.slice_indexz;
            Slice=squeeze(Epsilon(:,:,slice_index));
            eC1=handles.Data.ix;
            eC2=handles.Data.iy;
        end
end
disp('Indexprocess done');

function panelsetting(handles) %panel을 setting하는 함수

if handles.load==0 % 어떤 데이터도 upload되지 않은 경우 실행되지 않음
   return 
else
end
%panel initialize
set(handles.xpopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(handles.ypopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(handles.zpopup,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(handles.xvalue,'String','');
set(handles.yvalue,'String','');
set(handles.zvalue,'String','');
s=get(handles.Selections,'Data');
index_or_field=s{1};
slice_fx=handles.slice_fieldx;
slice_fy=handles.slice_fieldy;
slice_fz=handles.slice_fieldz;
slice_ix=handles.slice_indexx;
slice_iy=handles.slice_indexy;
slice_iz=handles.slice_indexz;

if strcmp(index_or_field,'Index') %Index가 선택된 경우
    disp('index setting');
    dimension=get(handles.indexdimension,'String');
    firstletter=dimension(1);
    if strcmp(firstletter,'N') %Index가 없을 때
        set(handles.xpopup,'String',{''});
        set(handles.xpopup,'Value',1);
        set(handles.ypopup,'String',{''});
        set(handles.ypopup,'Value',1);
        set(handles.zpopup,'String',{''});
        set(handles.zpopup,'Value',1);
        set(handles.frequencypopup,'String',{''});
        set(handles.frequencypopup,'Value',1);
        set(handles.xvalue,'String','');
        set(handles.xaxismin,'String','');
        set(handles.xaxismax,'String','');
        set(handles.xaxiscurrent,'String','');
        set(handles.yvalue,'String','');
        set(handles.yaxismin,'String','');
        set(handles.yaxismax,'String','');
        set(handles.yaxiscurrent,'String','');
        set(handles.zvalue,'String','');
        set(handles.zaxismin,'String','');
        set(handles.zaxismax,'String','');
        set(handles.zaxiscurrent,'String','');
        set(handles.frequencystring,'String','');
        set(handles.xaxisslider, 'Min', 1);
        set(handles.xaxisslider, 'Max', 1.4);
        set(handles.xaxisslider, 'Value', 1);
        sliderStep = [1,1];
        set(handles.xaxisslider, 'SliderStep', sliderStep); 
        set(handles.yaxisslider, 'Min', 1);
        set(handles.yaxisslider, 'Max', 1.4);
        set(handles.yaxisslider, 'Value', 1);
        sliderStep = [1,1];
        set(handles.yaxisslider, 'SliderStep', sliderStep); 
        set(handles.zaxisslider, 'Min', 1);
        set(handles.zaxisslider, 'Max', 1.4);
        set(handles.zaxisslider, 'Value', 1);
        sliderStep = [1,1];
        set(handles.zaxisslider, 'SliderStep', sliderStep); 
        set(handles.wavelengthslider, 'Min', 1);
        set(handles.wavelengthslider, 'Max', 1.4);
        set(handles.wavelengthslider, 'Value', 1);
        sliderStep = [1,1];
        set(handles.wavelengthslider, 'SliderStep', sliderStep); 
    else %strcmp(firstletter,'2') % 2D & 3D case
        str=get(handles.indexslice,'String');
        val=get(handles.indexslice,'Value');
        direction=str{val};
        switch direction
            case 'X'
                set(handles.xpopup,'String',{'Slice'});
                set(handles.xpopup,'Value',1);
                set(handles.yvalue,'String','');
                set(handles.zvalue,'String','');
                if length(handles.Data.ix)>1
                    set(handles.xvalue,'String',handles.Data.ix(slice_ix));
                    set(handles.xaxiscurrent,'String',handles.Data.ix(slice_ix));
                    set(handles.xaxisslider, 'Min', 1);
                    set(handles.xaxisslider, 'Max', length(handles.Data.ix));
                    set(handles.xaxisslider, 'Value', slice_ix);
                    sliderStep = [1,1]/(length(handles.Data.ix) - 1); % major and minor steps of 1
                    set(handles.xaxisslider, 'SliderStep', sliderStep); 
                else
                    set(handles.xvalue,'String',handles.Data.ix);
                    set(handles.xaxiscurrent,'String',handles.Data.ix);
                    set(handles.xaxisslider, 'Min', 1);
                    set(handles.xaxisslider, 'Max', 1.4);
                    set(handles.xaxisslider, 'Value', 1);
                    sliderStep = [1,1];
                    set(handles.xaxisslider, 'SliderStep', sliderStep); 
                end
                set(handles.ypopup,'Value',1);
                set(handles.zpopup,'Value',2);
                
                set(handles.xaxismin,'String',min(handles.Data.ix));
                set(handles.xaxismax,'String',max(handles.Data.ix));
                set(handles.yaxismin,'String',min(handles.Data.iy));
                set(handles.yaxismax,'String',max(handles.Data.iy));
                set(handles.yaxiscurrent,'String','Range');
                set(handles.zaxismin,'String',min(handles.Data.iz));
                set(handles.zaxismax,'String',max(handles.Data.iz));
                set(handles.zaxiscurrent,'String','Range');
            case 'Y'
                set(handles.ypopup,'String',{'Slice'});
                set(handles.ypopup,'Value',1);
                set(handles.xvalue,'String','');
                set(handles.zvalue,'String','');
                if length(handles.Data.iy)>1
                    set(handles.yvalue,'String',handles.Data.iy(slice_iy));
                    set(handles.yaxiscurrent,'String',handles.Data.iy(slice_iy));
                    set(handles.yaxisslider, 'Min', 1);
                    set(handles.yaxisslider, 'Max', length(handles.Data.iy));
                    set(handles.yaxisslider, 'Value', slice_iy);
                    sliderStep = [1,1]/(length(handles.Data.iy) - 1); % major and minor steps of 1
                    set(handles.yaxisslider, 'SliderStep', sliderStep); 
                    
                else
                    set(handles.yvalue,'String',handles.Data.iy);
                    set(handles.yaxiscurrent,'String',handles.Data.iy);
                    set(handles.yaxisslider, 'Min', 1);
                    set(handles.yaxisslider, 'Max', 1.4);
                    set(handles.yaxisslider, 'Value', 1);
                    sliderStep = [1,1];
                    set(handles.yaxisslider, 'SliderStep', sliderStep); 
                end
                
                set(handles.xpopup,'Value',1);
                set(handles.zpopup,'Value',2);
                set(handles.yaxismin,'String',min(handles.Data.iy));
                set(handles.yaxismax,'String',max(handles.Data.iy));
                set(handles.xaxismin,'String',min(handles.Data.ix));
                set(handles.xaxismax,'String',max(handles.Data.ix));
                set(handles.xaxiscurrent,'String','Range');
                set(handles.zaxismin,'String',min(handles.Data.iz));
                set(handles.zaxismax,'String',max(handles.Data.iz));
                set(handles.zaxiscurrent,'String','Range');
            case 'Z'
                set(handles.zpopup,'String',{'Slice'});
                set(handles.zpopup,'Value',1);
                set(handles.xvalue,'String','');
                set(handles.yvalue,'String','');
                if length(handles.Data.iz)>1
                    set(handles.zvalue,'String',handles.Data.iz(slice_iz));
                    set(handles.zaxiscurrent,'String',handles.Data.iz(slice_iz));
                    set(handles.zaxisslider, 'Min', 1);
                    set(handles.zaxisslider, 'Max', length(handles.Data.iz));
                    set(handles.zaxisslider, 'Value', slice_iz);
                    sliderStep = [1,1]/(length(handles.Data.iz) - 1); % major and minor steps of 1
                    set(handles.zaxisslider, 'SliderStep', sliderStep); 
                else
                    set(handles.zvalue,'String',handles.Data.iz);
                    set(handles.zaxiscurrent,'String',handles.Data.iz);
                    set(handles.zaxisslider, 'Min', 1);
                    set(handles.zaxisslider, 'Max', 1.4);
                    set(handles.zaxisslider, 'Value', 1);
                    sliderStep = [1,1];
                    set(handles.zaxisslider, 'SliderStep', sliderStep); 
                end
                set(handles.xpopup,'Value',1);
                set(handles.ypopup,'Value',2);
                set(handles.xaxismin,'String',min(handles.Data.ix));
                set(handles.xaxismax,'String',max(handles.Data.ix));
                set(handles.xaxiscurrent,'String','Range');
                set(handles.yaxismin,'String',min(handles.Data.iy));
                set(handles.yaxismax,'String',max(handles.Data.iy));
                set(handles.yaxiscurrent,'String','Range');
                set(handles.zaxismin,'String',min(handles.Data.iz));
                set(handles.zaxismax,'String',max(handles.Data.iz));
        end
    
    end

else %field (E,H...)가 선택된 경우
    dimension=get(handles.fielddimension,'String');
    firstletter=dimension(1);
    if strcmp(firstletter,'N') %index가 없는경우
    else %strcmp(firstletter,'2') % 2D & 3D
    str=get(handles.fieldslice,'String');
    val=get(handles.fieldslice,'Value');
    direction=str{val};
        switch direction
            case 'X'
                set(handles.xpopup,'String',{'Slice'});
                set(handles.xpopup,'Value',1);
                set(handles.yvalue,'String','');
                set(handles.zvalue,'String','');
                if length(handles.Data.x)>1
                    set(handles.xvalue,'String',handles.Data.x(slice_fx));
                    set(handles.xaxiscurrent,'String',handles.Data.x(slice_fx));
                    set(handles.xaxisslider, 'Min', 1);
                    set(handles.xaxisslider, 'Max', length(handles.Data.x));
                    set(handles.xaxisslider, 'Value', slice_fx);
                    sliderStep = [1,1]/(length(handles.Data.x) - 1); % major and minor steps of 1
                    set(handles.xaxisslider, 'SliderStep', sliderStep); 
                else
                    set(handles.xvalue,'String',handles.Data.x);
                    set(handles.xaxiscurrent,'String',handles.Data.x);
                    set(handles.xaxisslider, 'Min', 1);
                    set(handles.xaxisslider, 'Max', 1.4);
                    set(handles.xaxisslider, 'Value', 1);
                    sliderStep = [1,1];
                    set(handles.xaxisslider, 'SliderStep', sliderStep); 
                end
                
                set(handles.ypopup,'Value',1);
                set(handles.zpopup,'Value',2);
                set(handles.xaxismin,'String',min(handles.Data.x));
                set(handles.xaxismax,'String',max(handles.Data.x));
                set(handles.yaxismin,'String',min(handles.Data.y));
                set(handles.yaxismax,'String',max(handles.Data.y));
                set(handles.zaxismin,'String',min(handles.Data.z));
                set(handles.zaxismax,'String',max(handles.Data.z));
                set(handles.yaxiscurrent,'String','Range');
                set(handles.zaxiscurrent,'String','Range');
            case 'Y'
                set(handles.ypopup,'String',{'Slice'});
                set(handles.ypopup,'Value',1);
                set(handles.xvalue,'String','');
                set(handles.zvalue,'String','');
                if length(handles.Data.y)>1
                    set(handles.yvalue,'String',handles.Data.y(slice_fy));
                    set(handles.yaxiscurrent,'String',handles.Data.y(slice_fy));
                    set(handles.yaxisslider, 'Min', 1);
                    set(handles.yaxisslider, 'Max', length(handles.Data.y));
                    set(handles.yaxisslider, 'Value', slice_fy);
                    sliderStep = [1,1]/(length(handles.Data.y) - 1); % major and minor steps of 1
                    set(handles.yaxisslider, 'SliderStep', sliderStep); 
                else
                    set(handles.yvalue,'String',handles.Data.y);
                    set(handles.yaxiscurrent,'String',handles.Data.y);
                    set(handles.yaxisslider, 'Min', 1);
                    set(handles.yaxisslider, 'Max', 1.4);
                    set(handles.yaxisslider, 'Value', 1);
                    sliderStep = [1,1];
                    set(handles.yaxisslider, 'SliderStep', sliderStep); 
                end
                
                set(handles.xpopup,'Value',1);
                set(handles.zpopup,'Value',2);
                set(handles.xaxismin,'String',min(handles.Data.x));
                set(handles.xaxismax,'String',max(handles.Data.x));
                set(handles.yaxismin,'String',min(handles.Data.y));
                set(handles.yaxismax,'String',max(handles.Data.y));
                set(handles.zaxismin,'String',min(handles.Data.z));
                set(handles.zaxismax,'String',max(handles.Data.z)); 
                set(handles.xaxiscurrent,'String','Range');
                set(handles.zaxiscurrent,'String','Range');
            case 'Z'
                set(handles.zpopup,'String',{'Slice'});
                set(handles.zpopup,'Value',1);
                set(handles.xvalue,'String','');
                set(handles.yvalue,'String','');
                if length(handles.Data.z)>1
                    set(handles.zvalue,'String',handles.Data.z(slice_fz));
                    set(handles.zaxiscurrent,'String',handles.Data.z(slice_fz));
                    set(handles.zaxisslider, 'Min', 1);
                    set(handles.zaxisslider, 'Max', length(handles.Data.z));
                    set(handles.zaxisslider, 'Value', slice_fz);
                    sliderStep = [1,1]/(length(handles.Data.z) - 1); % major and minor steps of 1
                    set(handles.zaxisslider, 'SliderStep', sliderStep); 
                else
                    set(handles.zvalue,'String',handles.Data.z);
                    set(handles.zaxiscurrent,'String',handles.Data.z);
                    set(handles.zaxisslider, 'Min', 1);
                    set(handles.zaxisslider, 'Max', 1.4);
                    set(handles.zaxisslider, 'Value', 1);
                    sliderStep = [1,1];
                    set(handles.zaxisslider, 'SliderStep', sliderStep); 
                end
                set(handles.xpopup,'Value',1);
                set(handles.ypopup,'Value',2);
                set(handles.xaxismin,'String',min(handles.Data.x));
                set(handles.xaxismax,'String',max(handles.Data.x));
                set(handles.yaxismin,'String',min(handles.Data.y));
                set(handles.yaxismax,'String',max(handles.Data.y));
                set(handles.zaxismin,'String',min(handles.Data.z));
                set(handles.zaxismax,'String',max(handles.Data.z)); 
                set(handles.xaxiscurrent,'String','Range');
                set(handles.yaxiscurrent,'String','Range');
        end
    
    end
end

function handles=Lineplot(handles,phase)
field=handles.Field;
Field=field{phase}; %particular phase
C1=handles.C1;
C2=handles.C2;
Field=rot90(Field);

rowcol=get(handles.rowcol,'Value');
if rowcol==1 %row
    row=str2double(get(handles.rowvalue,'String'));
    axes(handles.axes1)
    plot(C1,Field(row,:))
    ylim([handles.clim(1),handles.clim(2)]);
else %col
    col=str2double(get(handles.colvalue,'String'));
    axes(handles.axes1)
    plot(C2,Field(:,col))
    ylim([handles.clim(1),handles.clim(2)]);
end

function nPlot_Callback(hObject, eventdata, handles)
% Index plot하는 함수
onoff=handles.option;
color=handles.colormap;


%%

if handles.interpolation==1 % Interpolation 선택한 경우
    Epsilon=handles.nepsilon;
    eC1=handles.neC1;
    eC2=handles.neC2; 
    
    handles.currentindex=Epsilon;
    handles.currentindexaxes1=eC1;
    handles.currentindexaxes2=eC2;
    handles.currentcontourcolor=handles.contourcolor;
    handles.currentonoff=onoff;
    handles.currentcolormap=color;
    
    switch (onoff)
    case 'on'
                contour(eC1,eC2,rot90(real(Epsilon)),1,handles.contourcolor)
                g = findobj('Type','line');
                set(g,'LineWidth',1)
                axis off
                axis image
                     
    case 'off'
             if strcmp(color,'bluered')
                axes(handles.axes1)
                imagesc(eC1,eC2,rot90(real(Epsilon)))
                colormap(jet(256)); %% index의 경우 bluered 선택했을 때 자동적으로 jet로 그리게 해 놓음
                colorbar('location','eastoutside')
                axis image  
             else 
                axes(handles.axes1)
                imagesc(eC1,eC2,rot90(real(Epsilon)))
                colormap(color);
                colorbar('location','eastoutside')
                axis image  
             end
    end
    msgbox('Interpolation is success');
    
else % Interpolation 선택하지 않은 경우
    Epsilon=handles.epsilon;
    eC1=handles.eC1;
    eC2=handles.eC2;
    
    handles.currentindex=Epsilon;
    handles.currentindexaxes1=eC1;
    handles.currentindexaxes2=eC2;
    handles.currentcontourcolor=handles.contourcolor;
    handles.currentonoff=onoff;
    handles.currentcolormap=color;
    
    switch (onoff)
    case 'on'
                contour(eC1,eC2,rot90(real(Epsilon)),1,handles.contourcolor)
                g = findobj('Type','line');
                set(g,'LineWidth',1)
                axis off
                axis image
                     
    case 'off'
             if strcmp(color,'bluered')
                axes(handles.axes1)
                imagesc(eC1,eC2,rot90(real(Epsilon)))
                colormap(jet(256));
                colorbar('location','eastoutside')
                axis image  
             else
                 axes(handles.axes1)
                imagesc(eC1,eC2,rot90(real(Epsilon)))
                colormap(color);
                colorbar('location','eastoutside')
                axis image  
             end
    end
    handles.clickplot=1;
    
end

guidata(hObject, handles);

% --- Executes on selection change in E_H.
function E_H_Callback(hObject, eventdata, handles)
% hObject    handle to E_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns E_H contents as cell array
%        contents{get(hObject,'Value')} returns selected item from E_H
% Determine the selected data set.
str = get(hObject, 'String');
val = get(hObject,'Value');
% % Set current data to the selected data set.
switch str{val};
case 'E' % User selects peaks.
   set(hObject,'Value',1);
case 'H' % User selects membrane.
   set(hObject,'Value',2);
end
% Save the handles structure.
get(hObject,'Value')
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function E_H_CreateFcn(hObject, eventdata, handles)
% hObject    handle to E_H (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'E';'H'});
set(hObject,'Value',1); % default value

% --- Executes on selection change in Component.
function Component_Callback(hObject, eventdata, handles)
% hObject    handle to Component (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Component contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Component
str = get(hObject, 'String');
val = get(hObject,'Value');
% % Set current data to the selected data set.
switch str{val};
case 'x' % User selects peaks.
   set(hObject,'Value',1);
case 'y' % User selects membrane.
   set(hObject,'Value',2);
case 'z' % User selects membrane.
   set(hObject,'Value',3);
case 'Magnitude' % User selects membrane.
   set(hObject,'Value',4);
end
% % Save the handles structure.
% handles.Component
get(hObject,'Value')
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Component_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Component (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'x';'y';'z';'magnitude'});
set(hObject,'Value',1); % default value

% --- Executes on selection change in Scalar.
function Scalar_Callback(hObject, eventdata, handles)
% hObject    handle to Scalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Scalar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Scalar
str = get(hObject, 'String');
val = get(hObject,'Value');
% % Set current data to the selected data set.
switch str{val};
case 'abs' % User selects peaks.
   set(hObject,'Value',1);
case 'abs^2' % User selects membrane.
   set(hObject,'Value',2);
case 'real' % User selects membrane.
   set(hObject,'Value',3);
case 'imag' % User selects membrane.
   set(hObject,'Value',4);
end
% % Save the handles structure.
% handles.Scalar
get(hObject,'Value')
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Scalar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'abs';'abs^2';'real';'imag'});
set(hObject,'Value',1); % default value


% % --- Executes on slider movement.
% function slider1_Callback(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine legend of slider
% sliderMin = 1;
% sliderMax = size(handles.f); % this is variable
% sliderMax = sliderMax(1);
% sliderStep = [1,1]/(sliderMax - sliderMin) % major and minor steps of 1
% 
% set(handles.slider1, 'Min', sliderMin);
% set(handles.slider1, 'Max', sliderMax);
% %set(handles.slider1, 'Value', sliderMin); % set to beginning of sequence
% set(handles.slider1, 'SliderStep', sliderStep);
% 
% handles.selected_f = (get(handles.slider1, 'Value'));
% set(handles.wavelength,'String',handles.selected_f);
% 
% % --- Executes during object creation, after setting all properties.
% function slider1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to slider1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end


% --- Executes on selection change in Color.
function Color_Callback(hObject, eventdata, handles)
% hObject    handle to Color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Color contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Color
str = get(hObject,'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
% handles.Color=val;
% switch str{val};
% case 'bluered' % User selects peaks.
%    set(hObject,'Value',1);
% case 'jet' % User selects membrane.
%    set(hObject,'Value',2);
% case 'hot' % User selects membrane.
%    set(hObject,'Value',3);
% end
% Save the handles structure.
% handles.Color
%get(hObject,'Value')
%Initialize_Callback(hObject, eventdata, handles);
%Refresh_Callback(hObject, eventdata, handles);
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'bluered';'jet(256)';'hot(256)';'hsv(256)';'fireice'});
set(hObject,'Value',2);

% --- Executes on selection change in wavelength.
function wavelength_Callback(hObject, eventdata, handles)
% hObject    handle to wavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return
else
str = get(hObject,'String');
val = get(hObject,'Value');
%disp(num2str(f(val)));
%disp(str(val));
set(handles.frequencystring,'String',handles.fscaled(val));
set(handles.wavelengthslider,'Value',val);
%handles.frequency=val;
end
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns wavelength contents as cell array
%        contents{get(hObject,'Value')} returns selected item from wavelength


% --- Executes during object creation, after setting all properties.
function wavelength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%set(hObject,'Value',2);
%set(handles.wavelength,'Value',2); % default value 

% --- Executes on button press in Plotinnew.
function Plotinnew_Callback(hObject, eventdata, handles)
global custom_color;
% hObject    handle to Plotinnew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if handles.load==1
%     
% else
%     msgbox('You did not load any data','Error','error');
%     return;
% end
% 
% h = findobj(gca,'type','axes'); % Find the axes object in the GUI
% ax_pos = get(gca,'Position'); % normalized position of the axis in the figure
% x_lim = get(gca,'Xlim');
% y_lim = get(gca,'Ylim');
% 
% prompt = {'Enter title:'};
% dlg_title = 'Input';
% num_lines = 1;
% def = {'Title'};
% answer = inputdlg(prompt,dlg_title,num_lines,def);
% s=size(answer);
% 
% if s(1)==0 %취소를 눌렀을 때 실행되지 않도록
%     return
% else
% end
% 
% t=answer{1};
% f1 = figure('name',t); % Open a new figure with handle f1
% s=copyobj(h,f1); % Copy axes object h into figure f1
% set(s,'Units','normalized','Position',[0.1 0.1 0.8 0.8]);
% 
% k = get(h);
% j = get(s);
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
else    
end
%% Plot을 먼저 눌러서 이미지를 봐야한다.
if handles.clickplot==0
   msgbox('you shoud plot in advance');
   return 
end

%%
s=get(handles.Selections,'Data');
EH=s{1};

if strcmp(EH,'Index') %Index를 선택했을 때
Field=handles.currentindex;
C1=handles.currentindexaxes1;
C2=handles.currentindexaxes2;
contourcolor=handles.currentcontourcolor;
color=handles.currentcolormap;
onoff=handles.currentonoff;

     switch (onoff) %contour 활성화 또는 비활성화
         case 'on' %활성화
            figure;
            contour(C1,C2,rot90(real(Field)),1,contourcolor)
            g = findobj('Type','line');
            set(g,'LineWidth',1)
            axis off
            axis image
         case 'off' %비활성화         
                if strcmp(color,'bluered')
                figure;
                imagesc(C1,C2,rot90(real(Field)))
                axis image
                axis off
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                elseif strcmp(color,'custom')
                figure;
                imagesc(C1,C2,rot90(real(Field)))
                axis image
                axis off
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                else
                figure;
                imagesc(C1,C2,rot90(real(Field)))
                axis image
                axis off
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                end      
    end    
    
else %Index 제외한 field 선택했을 경우

onoff=handles.currentonoff;
    switch (onoff) %contour 활성화 또는 비활성화
        case 'on' %활성화
Field=handles.currentfield;       
C1=handles.currentaxes1;
C2=handles.currentaxes2;
nlim=handles.currentlim;
Epsilon=handles.currentindex;
eC1=handles.currentindexaxes1;
eC2=handles.currentindexaxes2;
contourcolor=handles.currentcontourcolor;
color=handles.currentcolormap;

                if strcmp(color,'bluered')
                figure;
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on 
                elseif strcmp(color,'custom')
                figure;
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on
                else
                figure;
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on 
                end
                %contour(C1,C2,Index,1,'k')			% plot index coutour
                contour(eC1,eC2,rot90(Epsilon),1,contourcolor,'Linewidth',2)
%                 g = findobj('Type','line');
%                 set(g,'LineWidth',1)
                axis off
                hold off
%                 axes(handles.axes3)
%                 axis off
%                 colorbar
                  
        case 'off' %비활성화
        Field=handles.currentfield;       
        C1=handles.currentaxes1;
        C2=handles.currentaxes2;
        nlim=handles.currentlim;
        %contourcolor=handles.currentcontourcolor;
        color=handles.currentcolormap;
                if strcmp(color,'bluered')
                figure;
                imagesc(C1,C2,rot90(Field),nlim)
                axis image
                axis off
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                elseif strcmp(color,'custom')
                figure;
                imagesc(C1,C2,rot90(Field),nlim)
                axis image
                axis off
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                    
                else
                figure;
                imagesc(C1,C2,rot90(Field),nlim)
                axis image
                axis off
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','white')
                end   
    end
end
guidata(hObject, handles);

% --- Executes on slider movement.
function Legend_Callback(hObject, eventdata, handles)
% hObject    handle to Legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine legend of slider

%sliderMin = 1;
% sliderMax = size(handles.f); % this is variable
% sliderMax = sliderMax(1);
% sliderStep = [1,1]/(sliderMax - sliderMin) % major and minor steps of 1
% 
% set(handles.slider1, 'Min', sliderMin);
% set(handles.slider1, 'Max', sliderMax);
% %set(handles.slider1, 'Value', sliderMin); % set to beginning of sequence
% set(handles.slider1, 'SliderStep', sliderStep);
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
else    
end
s=get(handles.Selections,'Data');
scale=s{6}; % linear인지 log scale인지 확인
switch scale
    case 'linear' % linear scale
    %slider를 0보다 작은 값으로 했을 경우 자동적으로 최대값의 0.001되는 지점으로 이동시킨다.
    val=get(hObject,'Value');
        if strcmp(handles.scalar,'real') || strcmp(handles.scalar,'imag')
            if val<=0 
            set(hObject,'Value',handles.clim(2)*1e-3);
            set(handles.Legend_cmax,'String',num2str(handles.clim(2)*1e-3));
            else
            set(handles.Legend_cmax,'String',num2str(val));
            end
        else % abs
            if val<=0
            set(hObject,'Value',handles.clim(2)*1e-3);
            set(handles.Legend_cmax,'String',num2str(handles.clim(2)*1e-3));
            else
            set(handles.Legend_cmax,'String',num2str(val));
            end
        end
    case 'log' % log scale
        val=get(hObject,'Value');
        if val>=handles.clim(2) || val<handles.clim(1)
        set(hObject,'Value',handles.clim(2)-3);
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)-3));
        else
        %set(hObject,'Value',val);
        set(handles.Legend_cmax,'String',num2str(val));
        end
        
end
handles.call1=1;
handles.call2=1;
guidata(hObject, handles);
%op=handles.interpolation;
if handles.interpolation==0 %Interpolation 하지 않고 slider를 건드렸을 경우
Plot_Callback(hObject, eventdata, handles);
else %Interpolation 하고 slider를 건드렸을 경우   
Interpolation_Callback(hObject, eventdata, handles);    
end

% --- Executes during object creation, after setting all properties.
function Legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in onoff.
function onoff_Callback(hObject, eventdata, handles)
% hObject    handle to onoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns onoff contents as cell array
%        contents{get(hObject,'Value')} returns selected item from onoff
str = get(hObject, 'String');
val = get(hObject,'Value');
% % Set current data to the selected data set.
% switch str{val};
% case 'on' % User selects peaks.
%    set(hObject,'Value',1);
% case 'off' % User selects membrane.
%    set(hObject,'Value',2);
% end
% % Save the handles structure.
% handles.Component
%get(hObject,'Value')
%Refresh_Callback(hObject, eventdata, handles);
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function onoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to onoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'on';'off'});
set(hObject,'Value',1); % default value



function Legend_max_Callback(hObject, eventdata, handles)
% hObject    handle to Legend_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Legend_max as text
%        str2double(get(hObject,'String')) returns contents of Legend_max as a double


% --- Executes during object creation, after setting all properties.
function Legend_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Legend_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Legend_cmax_Callback(hObject, eventdata, handles)
% hObject    handle to Legend_cmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Legend_cmax as text
%        str2double(get(hObject,'String')) returns contents of Legend_cmax as a double
% str=get(hObject,'String');
% set(handles.Legend, 'Value', str2double(str));
% handles.call1=1;
% Plot_Callback(hObject, eventdata, handles);
% guidata(hObject, handles);

if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
else    
end
s=get(handles.Selections,'Data');
scale=s{6}; % linear인지 log scale인지 확인
switch scale
    case 'linear' % linear scale
    %slider를 0보다 작은 값으로 했을 경우 자동적으로 최대값의 0.001되는 지점으로 이동시킨다.
    val=str2double(get(hObject,'String'));
        if strcmp(handles.scalar,'real') || strcmp(handles.scalar,'imag')
            if val<=0
            set(handles.Legend,'Value',handles.clim(2)*1e-3);
            set(handles.Legend_cmax,'String',num2str(handles.clim(2)*1e-3));
            elseif val>handles.clim(2)
            set(handles.Legend,'Value',handles.clim(2));
            set(handles.Legend_cmax,'String',num2str(handles.clim(2)));
            else
            set(handles.Legend,'Value',val);
            set(handles.Legend_cmax,'String',num2str(val));
            end
        else
            if val<=0
            set(handles.Legend,'Value',handles.clim(2)*1e-3);
            set(handles.Legend_cmax,'String',num2str(handles.clim(2)*1e-3));
            elseif val>handles.clim(2)
            set(handles.Legend,'Value',handles.clim(2));
            set(handles.Legend_cmax,'String',num2str(handles.clim(2)));
            else
            set(handles.Legend,'Value',val);
            set(handles.Legend_cmax,'String',num2str(val));
            end
        end
    case 'log' % log scale
        val=str2double(get(hObject,'String'));
        if val>=handles.clim(2) 
        set(handles.Legend,'Value',handles.clim(2)-3);
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)-3));
        elseif val<handles.clim(1)
        set(handles.Legend,'Value',handles.clim(1));
        set(handles.Legend_cmax,'String',num2str(handles.clim(1)));    
        else
        set(handles.Legend,'Value',val);
        set(handles.Legend_cmax,'String',num2str(val));
        end
        
end
handles.call1=1;
handles.call2=1;
guidata(hObject, handles);
%op=handles.interpolation;
if handles.interpolation==0    
Plot_Callback(hObject, eventdata, handles);
else    
Interpolation_Callback(hObject, eventdata, handles);    
end

% --- Executes during object creation, after setting all properties.
function Legend_cmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Legend_cmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function Phase_Callback(hObject, eventdata, handles)
% hObject    handle to Phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
else    
end

current=round(get(hObject,'Value'));
%handles.current=current;
set(handles.Phase_current,'String',num2str(current));
set(hObject,'Value',current);
handles.call1=1;
handles.call2=1;
guidata(hObject, handles);
if handles.interpolation==0
Plot_Callback(hObject, eventdata, handles);
else % interpolation 버튼을 눌렀을 때
Interpolation_Callback(hObject, eventdata, handles);    
end


% --- Executes during object creation, after setting all properties.
function Phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Phase_current_Callback(hObject, eventdata, handles)
% hObject    handle to Phase_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phase_current as text
%        str2double(get(hObject,'String')) returns contents of Phase_current as a double
str=get(hObject,'String');
val=round(str2double(str));
set(handles.Phase,'Value',val);
handles.call1=1;
handles.call2=1;
guidata(hObject, handles);
if handles.interpolation==0
Plot_Callback(hObject, eventdata, handles);
else % interpolation 버튼을 눌렀을 때
Interpolation_Callback(hObject, eventdata, handles);    
end


% --- Executes during object creation, after setting all properties.
function Phase_current_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phase_min_Callback(hObject, eventdata, handles)
% hObject    handle to Phase_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phase_min as text
%        str2double(get(hObject,'String')) returns contents of Phase_min as a double


% --- Executes during object creation, after setting all properties.
function Phase_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phase_max_Callback(hObject, eventdata, handles)
% hObject    handle to Phase_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phase_max as text
%        str2double(get(hObject,'String')) returns contents of Phase_max as a double


% --- Executes during object creation, after setting all properties.
function Phase_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phase_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Movie.
function Movie_Callback(hObject, eventdata, handles)
% hObject    handle to Movie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
elseif handles.clickplot==0
    msgbox('Before making movie, you should plot an image','Error','error');
    return;
end

list=get(handles.Type,'String');
val=get(handles.Type,'Value');
t1=list{val};
t2=handles.types;
Movie; %call Movie GUI

% if strcmp(t2,t1) && strcmp(t2,'surface')
%     Movie; %call Movie GUI
% else
%    msgbox({'It works for surface plot mode, you should change plot types'});
%    return 
% end
guidata(hObject, handles);


% --- Executes when entered data in editable cell(s) in Data.
function Data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Data (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in Type.
function Type_Callback(hObject, eventdata, handles)
% hObject    handle to Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Type
% if handles.load==0
%     msgbox('You did not load any data','Error','error');
% else
%     %set(handles.monitor,'String',handles.fmonitortype);
% end
val=get(hObject,'Value');
if val==1 % line or 1D plot
    set(handles.rowcolpanel,'Visible','on');
else
    set(handles.rowcolpanel,'Visible','off');
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'Value',2);

function monitor_Callback(hObject, eventdata, handles)
% hObject    handle to monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of monitor as text
%        str2double(get(hObject,'String')) returns contents of monitor as a double


% --- Executes during object creation, after setting all properties.
function monitor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to monitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function Selections_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Selections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Column names and column format
columnname = {'Field','Vector operation','Scalar operation','Color map','Contour','Scale','Contour color'};
columnformat = {{'E','H','P','Index'},{'x','y','z','magnitude'},{'real','imag','abs','abs^2'},{'jet(256)' 'bluered' 'hot(256)' 'hsv(256)' 'gray(256)' 'fireice(256)' 'custom' 'steelblue' 'newbluered' 'inferno' 'magma' 'plasma' 'viridis'},'logical',{'linear','log'},{'black','white' 'red'}};

d = {'E'  'y'  'real' 'jet' true 'linear' 'black' };
    
set(hObject,'Data', d,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', [true true true true true true true],...
            'RowName',[]);
guidata(hObject, handles);

function wavelengthslider_Callback(hObject, eventdata, handles)
% hObject    handle to wavelengthslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return
else
current=round(get(hObject,'Value'));
set(hObject,'Value',current);
set(handles.wavelength,'Value',current);

val=get(handles.wavelength,'Value');
set(handles.frequencystring,'String',handles.fscaled(val));
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function wavelengthslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wavelengthslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on selection change in Unit.
function Unit_Callback(hObject, eventdata, handles)
% hObject    handle to Unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Unit
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return
else
end
v=get(hObject,'Value');
%assignin('base', 'f', f);
op=handles.timemonitor;

switch op
    case 0 %frequency 모니터인 경우
    val = get(handles.wavelength,'Value');
    handles.fscaled=handles.f*10^-(3*(v-1));
    set(handles.wavelength,'String',handles.fscaled);
    set(handles.wavelength,'Value',val);
    set(handles.frequencystring,'String',handles.fscaled(val));
    set(handles.wavelengthslider,'Value',val);
    %handles.fscaled=f;
    %wavelength_Callback(hObject, eventdata, handles)
    case 1 %time 모니터인 경우
    val = get(handles.wavelength,'Value');
    handles.fscaled=handles.f*10^(3*(v-1));
    set(handles.wavelength,'String',handles.fscaled);
    set(handles.wavelength,'Value',val);
    set(handles.frequencystring,'String',handles.fscaled(val));
    set(handles.wavelengthslider,'Value',val);
    %handles.fscaled=f;
    %wavelength_Callback(hObject, eventdata, handles)
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

s={'Hz';'KHz (1e3)';'MHz (1e6)';'GHz (1e9)';'THz (1e12)'};
set(hObject,'String',s);
set(hObject,'Value',1); % default index of frequency 
guidata(hObject, handles);


% --- Executes on selection change in ypopup.
function ypopup_Callback(hObject, eventdata, handles)
% hObject    handle to ypopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ypopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ypopup


% --- Executes during object creation, after setting all properties.
function ypopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ypopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Plot x axis';'Plot y axis';'Slice'});
guidata(hObject, handles);

% --- Executes on selection change in zpopup.
function zpopup_Callback(hObject, eventdata, handles)
% hObject    handle to zpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns zpopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from zpopup


% --- Executes during object creation, after setting all properties.
function zpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Plot x axis';'Plot y axis';'Slice'});
guidata(hObject, handles);

% --- Executes on selection change in frequencypopup.
function frequencypopup_Callback(hObject, eventdata, handles)
% hObject    handle to frequencypopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frequencypopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frequencypopup


% --- Executes during object creation, after setting all properties.
function frequencypopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencypopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Plot x axis';'Plot y axis';'Slice'});
guidata(hObject, handles);

% --- Executes on selection change in xpopup.
function xpopup_Callback(hObject, eventdata, handles)
% hObject    handle to xpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns xpopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from xpopup


% --- Executes during object creation, after setting all properties.
function xpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Plot x axis';'Plot y axis';'Slice'});
guidata(hObject, handles);

% --- Executes on button press in F.
function F_Callback(hObject, eventdata, handles)
% hObject    handle to F (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=get(handles.Selections,'Data');
s=s{1};

if handles.empty==0 && strcmp(s,'Index')
    set(handles.wavelengthpanel,'Visible','off');
    set(handles.xpanel,'Visible','off');
    set(handles.ypanel,'Visible','off');
    set(handles.zpanel,'Visible','off');
else
set(handles.wavelengthpanel,'Visible','on');
set(handles.xpanel,'Visible','off');
set(handles.ypanel,'Visible','off');
set(handles.zpanel,'Visible','off');
end
% --- Executes on button press in Z.
function Z_Callback(hObject, eventdata, handles)
% hObject    handle to Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=get(handles.Selections,'Data');
s=s{1};

if handles.empty==0 && strcmp(s,'Index')
    set(handles.wavelengthpanel,'Visible','off');
    set(handles.xpanel,'Visible','off');
    set(handles.ypanel,'Visible','off');
    set(handles.zpanel,'Visible','off');
else
set(handles.wavelengthpanel,'Visible','off');
set(handles.xpanel,'Visible','off');
set(handles.ypanel,'Visible','off');
set(handles.zpanel,'Visible','on');
end
% --- Executes on button press in Y.
function Y_Callback(hObject, eventdata, handles)
% hObject    handle to Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=get(handles.Selections,'Data');
s=s{1};

if handles.empty==0 && strcmp(s,'Index')
    set(handles.wavelengthpanel,'Visible','off');
    set(handles.xpanel,'Visible','off');
    set(handles.ypanel,'Visible','off');
    set(handles.zpanel,'Visible','off');
else
set(handles.wavelengthpanel,'Visible','off');
set(handles.xpanel,'Visible','off');
set(handles.ypanel,'Visible','on');
set(handles.zpanel,'Visible','off');
end
% --- Executes on button press in X.
function X_Callback(hObject, eventdata, handles)
% hObject    handle to X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=get(handles.Selections,'Data');
s=s{1};
if handles.empty==0 && strcmp(s,'Index')
    set(handles.wavelengthpanel,'Visible','off');
    set(handles.xpanel,'Visible','off');
    set(handles.ypanel,'Visible','off');
    set(handles.zpanel,'Visible','off');
else
    set(handles.wavelengthpanel,'Visible','off');
    set(handles.xpanel,'Visible','on');
    set(handles.ypanel,'Visible','off');
    set(handles.zpanel,'Visible','off');
end

function xaxismin_Callback(hObject, eventdata, handles)
% hObject    handle to xaxismin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xaxismin as text
%        str2double(get(hObject,'String')) returns contents of xaxismin as a double


% --- Executes during object creation, after setting all properties.
function xaxismin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xaxismin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xaxismax_Callback(hObject, eventdata, handles)
% hObject    handle to xaxismax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xaxismax as text
%        str2double(get(hObject,'String')) returns contents of xaxismax as a double


% --- Executes during object creation, after setting all properties.
function xaxismax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xaxismax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaxismin_Callback(hObject, eventdata, handles)
% hObject    handle to yaxismin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaxismin as text
%        str2double(get(hObject,'String')) returns contents of yaxismin as a double


% --- Executes during object creation, after setting all properties.
function yaxismin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaxismin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaxismax_Callback(hObject, eventdata, handles)
% hObject    handle to yaxismax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaxismax as text
%        str2double(get(hObject,'String')) returns contents of yaxismax as a double


% --- Executes during object creation, after setting all properties.
function yaxismax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaxismax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zaxismin_Callback(hObject, eventdata, handles)
% hObject    handle to zaxismin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zaxismin as text
%        str2double(get(hObject,'String')) returns contents of zaxismin as a double


% --- Executes during object creation, after setting all properties.
function zaxismin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zaxismin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function zaxismax_Callback(hObject, eventdata, handles)
% hObject    handle to zaxismax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zaxismax as text
%        str2double(get(hObject,'String')) returns contents of zaxismax as a double

% --- Executes during object creation, after setting all properties.
function zaxismax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zaxismax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Filelist.
function Filelist_Callback(hObject, eventdata, handles)
% hObject    handle to Filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Filelist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Filelist


% --- Executes during object creation, after setting all properties.
function Filelist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filelist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
% hObject    handle to Delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents=get(handles.Filelist,'String');
selected_list=get(handles.Filelist,'Value')
if isempty(contents)
    msgbox('No elements to delete');
    return
end
contents(selected_list)=[];
set(handles.Filelist,'Value',1);
set(handles.Filelist,'String',contents);

% --- Executes on button press in arrowup.
function arrowup_Callback(hObject, eventdata, handles)
% hObject    handle to arrowup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in arrowdown.
function arrowdown_Callback(hObject, eventdata, handles)
% hObject    handle to arrowdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in fieldslice.
function fieldslice_Callback(hObject, eventdata, handles)
% hObject    handle to fieldslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fieldslice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fieldslice
s=get(handles.Selections,'Data');
s{1}='E';
set(handles.Selections,'Data',s);
panelsetting(handles)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function fieldslice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fieldslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in indexslice.
function indexslice_Callback(hObject, eventdata, handles)
% hObject    handle to indexslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns indexslice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from indexslice
s=get(handles.Selections,'Data');
s{1}='Index';
set(handles.Selections,'Data',s);
panelsetting(handles)
guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function indexslice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to indexslice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function zaxisslider_Callback(hObject, eventdata, handles)
% hObject    handle to zaxisslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
current=round(get(hObject,'Value'));
s=get(handles.Selections,'Data');
field=s{1};
if strcmp(field,'Index')
    handles.slice_index=round(get(hObject,'Value'));
    set(handles.zaxiscurrent,'String',num2str(handles.Data.iz(current)));
    set(handles.zvalue,'String',num2str(handles.Data.iz(current)));
    handles.slice_indexz=current;
else
    handles.slice_field=round(get(hObject,'Value'));
    set(handles.zaxiscurrent,'String',num2str(handles.Data.z(current)));
    set(handles.zvalue,'String',num2str(handles.Data.z(current)));
    handles.slice_fieldz=current;
end
set(hObject,'Value',current);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function zaxisslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zaxisslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function yaxisslider_Callback(hObject, eventdata, handles)
% hObject    handle to yaxisslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
current=round(get(hObject,'Value'));
s=get(handles.Selections,'Data');
field=s{1};
if strcmp(field,'Index')
    handles.slice_index=round(get(hObject,'Value'));
    set(handles.yaxiscurrent,'String',num2str(handles.Data.iy(current)));
    set(handles.yvalue,'String',num2str(handles.Data.iy(current)));
    handles.slice_indexy=current;
else
    handles.slice_field=round(get(hObject,'Value'));
    set(handles.yaxiscurrent,'String',num2str(handles.Data.y(current)));
    set(handles.yvalue,'String',num2str(handles.Data.y(current)));
    handles.slice_fieldy=current;
end
set(hObject,'Value',current);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function yaxisslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaxisslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function xaxisslider_Callback(hObject, eventdata, handles)
% hObject    handle to xaxisslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
current=round(get(hObject,'Value'));
s=get(handles.Selections,'Data');
field=s{1};
if strcmp(field,'Index')
    handles.slice_index=round(get(hObject,'Value'));
    set(handles.xaxiscurrent,'String',num2str(handles.Data.ix(current)));
    set(handles.xvalue,'String',num2str(handles.Data.ix(current)));
    handles.slice_indexx=current;
else
    handles.slice_field=round(get(hObject,'Value'));
    set(handles.xaxiscurrent,'String',num2str(handles.Data.x(current)));
    set(handles.xvalue,'String',num2str(handles.Data.x(current)));
    handles.slice_fieldx=current;
end
set(hObject,'Value',current);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function xaxisslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xaxisslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function Indexselections_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Indexselections (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
columnname = {'Field','Vector operation','Scalar operation','Color map','Contour'};
columnformat = {{'Index'},{'x','y','z','magnitude'},{'real','imag','abs','abs^2'},{'jet' 'bluered' 'hot' 'hsv'},'logical'};

d = {'Index'  'y'  'real' 'jet' true};
    
set(hObject,'Data', d,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', [true true true true true],...
            'RowName',[]);
guidata(hObject, handles);


% --- Executes when entered data in editable cell(s) in Selections.
function Selections_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to Selections (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
s=get(handles.Selections,'Data'); 
if strcmp(s{1},'P') % 포인팅 벡터를 선택한 경우 자동으로 real로 선택
   s{3}='real';
   set(handles.Selections,'Data',s);
else
end

if strcmp(s{2},'magnitude') % magnitude를 선택한 경우 자동으로 abs^2 선택
   s{3}='abs^2';
   set(handles.Selections,'Data',s);
else
end

if strcmp(s{3},'real') || strcmp(s{3},'imag') %log plot은 음수가 포함된 경우 plot할 수 없다.
    s{6}='linear';
    handles.scale=s{6};
    set(handles.Selections,'Data',s);
else
    handles.scale=s{6};
end
panelsetting(handles);



function zaxiscurrent_Callback(hObject, eventdata, handles)
% hObject    handle to zaxiscurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zaxiscurrent as text
%        str2double(get(hObject,'String')) returns contents of zaxiscurrent as a double


% --- Executes during object creation, after setting all properties.
function zaxiscurrent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zaxiscurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yaxiscurrent_Callback(hObject, eventdata, handles)
% hObject    handle to yaxiscurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yaxiscurrent as text
%        str2double(get(hObject,'String')) returns contents of yaxiscurrent as a double


% --- Executes during object creation, after setting all properties.
function yaxiscurrent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yaxiscurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xaxiscurrent_Callback(hObject, eventdata, handles)
% hObject    handle to xaxiscurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xaxiscurrent as text
%        str2double(get(hObject,'String')) returns contents of xaxiscurrent as a double


% --- Executes during object creation, after setting all properties.
function xaxiscurrent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xaxiscurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FFT.
function FFT_Callback(hObject, eventdata, handles)
% hObject    handle to FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
elseif handles.clickplot==0
    msgbox('Before see FFT, you should plot an image','Error','error');
    return;
end
FFT; %FFT GUI 실행
guidata(hObject, handles);
% --- Executes on button press in Info.
function Info_Callback(hObject, eventdata, handles)
% hObject    handle to Info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.load==0
    msgbox('First, you should load file. push "Upload" ');
    return
else
end

selected_file=handles.selected_file;
Data=load(selected_file);
Dataname=fieldnames(Data);
disp(Dataname);
handles.Data=Data;
s = fieldnames(handles.Data);
size_data = size(s);
size_data = size_data(1); %number of element

infogui=Information; 
handles.infogui=guihandles(infogui);
fieldnames(handles.infogui)
%contents=(get(handles.Filelist,'String')); % File list에 있는 file 목록을 받아온다.
%set(handles.infogui.Filelist,'String',contents);

columnname = {'x','y','z','f'};
columnformat = {{'100'},{'100'},{'100'},{'5'}};

name=cell(size_data,1);
d=cell(size_data,4);
for i = 1:size_data
    n=char(s(i));
    name{i} = n;
    m = handles.Data.(n);
    num=size(m);
    dim=numel(num); % matrix의 dimension확인
    for j=1:dim
        d{i,j}=num(j);
    end
end

set(handles.infogui.Data_information,'Data', d,... 
            'ColumnName', columnname,...
            'ColumnFormat', columnformat,...
            'ColumnEditable', [false false false false],...
            'RowName',name);


% --- Executes on button press in Interpolation.
function Interpolation_Callback(hObject, eventdata, handles)
% hObject    handle to Interpolation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.clickplot=1;

global custom_color;
global steelblue;

%% Interpolation 실행하기 전에 항상 Plot을 먼저 눌러서 Interpolation할 데이터의 이미지를 봐야한다.
if handles.clickplot==0
   msgbox('you shoud plot in advance');
   return 
end

%%

str=get(handles.interpol,'String');
interpol=str2double(str); % intepolation number를 저장 ex) 1 or 2 

s=get(handles.Selections,'Data');
scale=s{6};

if strcmp(handles.plotchoice{1},s{1}) && strcmp(handles.plotchoice{2},s{2}) && strcmp(handles.plotchoice{3},s{3}) && (handles.plotchoice{5}==s{5}) && strcmp(handles.plotchoice{6},s{6})
else
    msgbox('Selections are changed, you should push "Plot" first');
    s{1}=handles.plotchoice{1};
    s{2}=handles.plotchoice{2};
    s{3}=handles.plotchoice{3};
    s{5}=handles.plotchoice{5};
    s{6}=handles.plotchoice{6};
    set(handles.Selections,'Data',s);
    % 원래 선택했던 것들로 다시 셋팅
    return
end

%%
% if handles.call1==1 || handles.call2==1 % phase혹은 legend 를 바꿧을때는 Field process, Index process를 굳이 다시 실행하지 않고 바로 Plot section으로 넘어가게 한다.
% else
%     if handles.empty==0 %index가 없을 때
%     phi=handles.phi;
%     phase=handles.phase;
%     
%     [field2,C1,C2] = Interpolation_Field(handles.Field,handles.C1,handles.C2,interpol);     
%     [minimum, maximum]=MinMax(field2,scale);
%     handles.clim=[minimum,maximum];
%     handles.nField=field2;
%     handles.nC1=C1;
%     handles.nC2=C2;
%     else %index가 있을 때
%         if strcmp(s{1},'Index') %Index 선택했을 때
%         [Epsilon,eC1,eC2] = Interpolation_Index(handles.epsilon,handles.eC1,handles.eC2,interpol);        
%         handles.nepsilon=Epsilon;       
%         handles.neC1=eC1;
%         handles.neC2=eC2;    
%         handles.interpolation=1;
%         nPlot_Callback(hObject, eventdata, handles)   
%         return % nPlot을 실행시키고 밑에는 실행시키지 않는다.
%         
%         else % Index 제외한 field 선택했을 때
%         
%         phi=handles.phi;
%         phase=handles.phase;
%         
%         [field2,C1,C2] = Interpolation_Field(handles.Field,handles.C1,handles.C2,interpol);
%         [minimum, maximum]=MinMax(field2,scale);
%         handles.clim=[minimum,maximum];
%         handles.nField=field2;
%         handles.nC1=C1;
%         handles.nC2=C2;
%         
%         if s{5}==1 % contour 체크되었을 때        
%         [Epsilon,eC1,eC2] = Interpolation_Index(handles.epsilon,handles.eC1,handles.eC2,interpol);        
%         handles.nepsilon=Epsilon;       
%         handles.neC1=eC1;
%         handles.neC2=eC2;
%         else % contour 체크 안되었을 때  
%         [Epsilon,eC1,eC2] = Interpolation_Index(handles.epsilon,handles.eC1,handles.eC2,interpol);        
%         handles.nepsilon=Epsilon;       
%         handles.neC1=eC1;
%         handles.neC2=eC2;
%         end
%         
%         end
%     end
% end

if handles.call1==1 || handles.call2==1 % phase혹은 legend 를 바꿧을때는 Field process, Index process를 굳이 다시 실행하지 않고 바로 Plot section으로 넘어가게 한다.
else
    if strcmp(s{1},'Index') %Index를 선택했을 때
        
        [Epsilon,eC1,eC2] = Interpolation_Index(handles.epsilon,handles.eC1,handles.eC2,interpol);        
        handles.nepsilon=Epsilon;       
        handles.neC1=eC1;
        handles.neC2=eC2;
        handles.interpolation=1;
        nPlot_Callback(hObject, eventdata, handles)   
        return
        
    else % Index 제외한 field 선택했을 때
        switch (s{5})
            case 1
                phi=handles.phi;
                phase=handles.phase;      
                [field2,C1,C2] = Interpolation_Field(handles.Field,handles.C1,handles.C2,interpol);
                [minimum, maximum]=MinMax(field2,scale);
                handles.clim=[minimum,maximum];
                handles.nField=field2;
                handles.nC1=C1;
                handles.nC2=C2;
        
                [Epsilon,eC1,eC2] = Interpolation_Index(handles.epsilon,handles.eC1,handles.eC2,interpol);        
                handles.nepsilon=Epsilon;       
                handles.neC1=eC1;
                handles.neC2=eC2;
            case 0
                phi=handles.phi;
                phase=handles.phase;      
                [field2,C1,C2] = Interpolation_Field(handles.Field,handles.C1,handles.C2,interpol);
                [minimum, maximum]=MinMax(field2,scale);
                handles.clim=[minimum,maximum];
                handles.nField=field2;
                handles.nC1=C1;
                handles.nC2=C2;
        end
    end
    
end




%% Scalar operation
scalar=s{3};
% if strcmp(scalar,'abs') || strcmp(scalar,'abs^2')
%     handles.clim(1)=0;    
% else 
% end
%% Min Max 조정
if strcmp(s{6},'linear') % linear scale일때
    if strcmp(scalar,'abs') || strcmp(scalar,'abs^2')
        handles.clim(1)=0;
    else 
    end
     
else % log scale일때
    
end
%% Color map (bluered, jet, hsv...)
color=s{4};

%% Index on off
temp=s{5};

if temp==1;
    onoff='on';
else
    onoff='off';
end

clim=handles.clim;
%% set color bar
if handles.call1==0 % color max 조절하는 slider를 건드리지 않았을 때
    switch s{6}
        case 'linear'
            % set color bar max value
            set(handles.Legend, 'Min', clim(1));
            set(handles.Legend, 'Max', clim(2));
            set(handles.Legend, 'Value', clim(2));
            set(handles.Legend_min,'String',num2str(clim(1)));
            set(handles.Legend_max,'String',num2str(clim(2)));
            set(handles.Legend_cmax,'String',num2str(clim(2)));
            nlim(1)=clim(1);
            nlim(2)=clim(2);
        case 'log'
            set(handles.Legend, 'Min', clim(1));
            set(handles.Legend, 'Max', clim(2));
            set(handles.Legend, 'Value', clim(1));
            set(handles.Legend_min,'String',num2str(clim(1)));
            set(handles.Legend_max,'String',num2str(clim(2)));
            set(handles.Legend_cmax,'String',num2str(clim(1)));
            nlim(1)=clim(1);
            nlim(2)=clim(2);
    end
else % color max 조절하는 slider를 건드렸을 때
    switch s{6}
        case 'linear'
            if strcmp(s{3},'abs') || strcmp(s{3},'abs^2')% abs 또는 abs^2 의 plot일 경우
                nlim(2)=get(handles.Legend,'Value');
                nlim(1)=clim(1);
            else % real 또는 imag 의 plot일 경우
                nlim(2)=get(handles.Legend,'Value');
                nlim(1)=-nlim(2);
            end
        case 'log'
            nlim(2)=clim(2);
            nlim(1)=get(handles.Legend,'Value');
    end
end
handles.nlim=nlim;

%% phase slider
if handles.call2==0 % phase 조절하는 slider를 건드리지 않았을 때
    % set phase value
    set(handles.Phase, 'Min', 1);
    set(handles.Phase, 'Max', length(phi));
    set(handles.Phase, 'Value', handles.phase);
    sliderStep = [1,1]/(length(phi) - 1); % major and minor steps of 1
    set(handles.Phase, 'SliderStep', sliderStep); 
    set(handles.Phase_current,'String',num2str(phase));
    set(handles.Phase_min,'String',num2str(1));
    set(handles.Phase_max,'String',num2str(length(phi)));
    phase=handles.phase;
else % phase 조절하는 slider를 건드렸을 때
    phase=get(handles.Phase,'Value');
end

%% Plot(Line, surface, vector)
field2=handles.nField;
Field=field2{phase}; %particular phase
C1=handles.nC1;
C2=handles.nC2;
contourcolor=s{7};
color=s{4};

if strcmp(s{1},'Index') % Index선택했을 때

%     Epsilon=handles.nepsilon;       
%     eC1=handles.neC1;
%     eC2=handles.neC2;
%     axes(handles.axes1)
%     imagesc(C1,C2,rot90(Epsilon))
%     colorbar('location','eastoutside','FontSize',12,'Color','w')
%     axis image
else %Index 제외한 것을 선택했을 때
    switch (onoff)
        case 'on'
            
            if handles.empty==0
                msgbox('There is no index data. You shoud uncheck coutour');
                return
            else
                Epsilon=handles.nepsilon;       
                eC1=handles.neC1;
                eC2=handles.neC2;
                
                handles.currentfield=Field;    %
                handles.currentaxes1=C1;       %
                handles.currentaxes2=C2;       %
                handles.currentlim=nlim;   
                handles.currentindex=Epsilon;
                handles.currentindexaxes1=eC1;
                handles.currentindexaxes2=eC2;
                handles.currentcontourcolor=contourcolor;
                handles.currentcolormap=color;
                handles.currentonoff=handles.option;
            
                if strcmp(color,'bluered')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on 
                elseif strcmp(color,'custom')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on     
                elseif strcmp(color,'steelblue')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(steelblue);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on     
                else
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                axis image
                hold on 
                end
                %contour(C1,C2,Index,1,'k')			% plot index coutour
                contour(eC1,eC2,real(rot90(Epsilon)),1,contourcolor)
                g = findobj('Type','line');
                set(g,'LineWidth',1)
                axis off
                hold off
%                 axes(handles.axes3)
%                 axis off
%                 colorbar
            end             
        case 'off'
                handles.currentfield=Field;    %
                handles.currentaxes1=C1;       %
                handles.currentaxes2=C2;       %
                handles.currentlim=nlim;   
                handles.currentcontourcolor=contourcolor;
                handles.currentcolormap=color;
                handles.currentonoff=handles.option;
                
                if strcmp(color,'bluered')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                axis image
                axis off
                colormap(b2r(nlim(1),nlim(2)));
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                elseif strcmp(color,'custom')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim);
                axis image 
                axis off
                colormap(custom_color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                elseif strcmp(color,'steelblue')
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim);
                axis image 
                axis off
                colormap(steelblue);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                else
                axes(handles.axes1)
                imagesc(C1,C2,rot90(Field),nlim)
                axis image
                axis off
                colormap(color);
                colorbar('location','eastoutside','FontSize',12,'Color','w')
                end             
    end
end

if handles.call1==1 || handles.call2==1 % phase혹은 legend 를 바꿧을때는 msgbox 굳이 안떠도 되게함
else
msgbox('Interpolation is success');
end
handles.interpolation=1; % interpolation 버튼을 눌렀다는 것을 확인하는 인자
handles.call1=0;
handles.call2=0;
setappdata(0,'MyStruct',handles)
guidata(hObject, handles);


function interpol_Callback(hObject, eventdata, handles)
% hObject    handle to interpol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interpol as text
%        str2double(get(hObject,'String')) returns contents of interpol as a double


% --- Executes during object creation, after setting all properties.
function interpol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interpol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1');


% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.load==0
    msgbox('You did not load any data','Error','error');
    return;
elseif handles.clickplot==0
    msgbox('Before making movie, you should plot an image','Error','error');
    return;
end

% 필드는 모든 phase의 데이터를 export한다

s=get(handles.Selections,'Data');
a=s{1}; 
b=s{2};
c=s{3};
if strcmp(c,'abs^2')
   c='abs2'; 
end
component=[a,b,c]; % Ex, Ey ....

if handles.interpolation==1 %interpolation된 데이터를 export하는 경우
    if strcmp(s{1},'Index') % Index 데이터를 export하는 경우
    Epsilon=handles.nepsilon;
    eC1=handles.neC1;
    eC2=handles.neC2;       
    %Matlab의 workspace로 데이터를 보낸다.
    assignin('base',component,rot90(Epsilon));
    assignin('base','eC1',eC1);
    assignin('base','eC2',eC2);
    
    else % Index제외한 field를 export하는 경우
    field=handles.nField;
    phase=handles.phase;
    %Field=field{phase};  %특정 phase를 export할때
    Field=field;  %모든 phase를 export할때
    C1=handles.nC1;
    C2=handles.nC2;
    inter='yes';
    %Matlab의 workspace로 데이터를 보낸다.
    assignin('base',component,(Field));
    assignin('base','C1',C1);
    assignin('base','C2',C2);
    assignin('base','interpolation',inter);
    assignin('base','phase',phase);
    %txt 파일로 데이터를 저장한다.
    filename=strcat(component,'.txt');
    dlmwrite(filename,rot90(Field),'delimiter','\t','precision',5);
    end
else  %원래의 데이터를 export하는 경우
    if strcmp(s{1},'Index') % Index 데이터를 export하는 경우
    Epsilon=handles.epsilon;
    eC1=handles.eC1;
    eC2=handles.eC2;    
    %Matlab의 workspace로 데이터를 보낸다.
    assignin('base',component,rot90(Epsilon));
    assignin('base','eC1',eC1);
    assignin('base','eC2',eC2);
    else % Index제외한 field를 export하는 경우
    field=handles.Field;
    phase=handles.phase;
    %Field=field{phase}; %particular phase
    Field=field;  %모든 phase를 export할때
    C1=handles.C1;
    C2=handles.C2;
    inter='no';
    %Matlab의 workspace로 데이터를 보낸다.
    assignin('base',component,rot90(Field));
    assignin('base','C1',C1);
    assignin('base','C2',C2);
    assignin('base','phase',phase);
    assignin('base','interpolation',inter);
    %txt 파일로 데이터를 저장한다.
    filename=strcat(component,'.txt');
    dlmwrite(filename,rot90(Field),'delimiter','\t','precision',5);
    end
end



guidata(hObject, handles);



function rowvalue_Callback(hObject, eventdata, handles)
% hObject    handle to rowvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rowvalue as text
%        str2double(get(hObject,'String')) returns contents of rowvalue as a double


% --- Executes during object creation, after setting all properties.
function rowvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rowvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1');


function colvalue_Callback(hObject, eventdata, handles)
% hObject    handle to colvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colvalue as text
%        str2double(get(hObject,'String')) returns contents of colvalue as a double


% --- Executes during object creation, after setting all properties.
function colvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1');

% --- Executes on selection change in rowcol.
function rowcol_Callback(hObject, eventdata, handles)
% hObject    handle to rowcol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rowcol contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rowcol


% --- Executes during object creation, after setting all properties.
function rowcol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rowcol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes when selected cell(s) is changed in Selections.
function Selections_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to Selections (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
