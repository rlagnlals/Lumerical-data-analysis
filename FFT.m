function varargout = FFT(varargin)
% FFT MATLAB code for FFT.fig
%      FFT, by itself, creates a new FFT or raises the existing
%      singleton*.
%
%      H = FFT returns the handle to a new FFT or the handle to
%      the existing singleton*.
%
%      FFT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FFT.M with the given input arguments.
%
%      FFT('Property','Value',...) creates a new FFT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FFT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FFT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FFT

% Last Modified by GUIDE v2.5 05-Mar-2015 21:54:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FFT_OpeningFcn, ...
                   'gui_OutputFcn',  @FFT_OutputFcn, ...
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


% --- Executes just before FFT is made visible.
function FFT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FFT (see VARARGIN)

% Choose default command line output for FFT
handles.output = hObject;
set(handles.rowcolpanel,'Visible','off');
set(handles.Scale,'Value',1);
handles.call=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FFT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FFT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Plot.
function Plot_Callback(hObject, eventdata, handles)
% hObject    handle to Plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.call
if handles.call==0 % 다시 Plot 버튼을 눌렀을 때
    
GUI1=getappdata(0,'MyStruct');
f=GUI1.f;
val=GUI1.fselectedval;
frequency=f(val);
set(handles.frequency,'String',(frequency));
%fieldnames(GUI1)
if GUI1.interpolation==1 %interpolation 한 데이터로 FFT 할때
    Field=(GUI1.nField);
    phi=GUI1.phi;
    %phase=GUI1.phase;
    C1=GUI1.nC1;
    C2=GUI1.nC2;
    %assignin('base','Field',Field)
else  %interpolation 하지 않은 데이터로  FFT 할때
    Field=(GUI1.Field);
    phi=GUI1.phi;
    %phase=GUI1.phase;
    C1=GUI1.C1;
    C2=GUI1.C2;
end


%% Phase(or step)
phase=GUI1.phase;

%% light line on or off
handles.onoff=get(handles.Lightline,'Value');
handles.k_lightline=2*pi*frequency/(3e8);

%% 1D or 2D
handles.type=get(handles.Type,'Value');

roworcol=get(handles.rowcol,'Value'); % 1D 를 선택했을 때 row, 혹은 col을 x 축으로 놓을 것인지 선택

%% FFT

str=get(handles.Scalar,'String');
val=get(handles.Scalar,'Value');
scalar=str{val};

Field=rot90(Field{phase});
s=size(Field);
set(handles.row_info,'String',num2str(s(1)));
set(handles.col_info,'String',num2str(s(2)));
% FFT=fftshift(fft2(Field));
% FFT_R=real(FFT);
% FFT_I=imag(FFT);
% [P,A]=cart2pol(FFT_R,FFT_I);

L1=length(C1);
L2=length(C2);
m=2^nextpow2(L1);
set(handles.col_info,'String',num2str(m+1));
n=2^nextpow2(L2);
set(handles.row_info,'String',num2str(n+1));
FFT_padd=fft2(Field,n,m);

First_FFT_padd=FFT_padd(1:n/2+1,1:m/2+1); % FFT_padd의 결과중에서 1사분면에 있는 값
First_FFT_padd_R=real(First_FFT_padd);
First_FFT_padd_I=imag(First_FFT_padd);
[P,A]=cart2pol(First_FFT_padd_R,First_FFT_padd_I);

delta_x=abs(C1(2)-C1(1));
delta_y=abs(C2(2)-C2(1));
fs_x=(1/delta_x)*2*pi;
fs_y=(1/delta_y)*2*pi;

unit=get(handles.unit,'Value');
if unit==1 % unit:a
    a=str2double(get(handles.a,'String'))*10^-9;
    kx=fs_x/2*linspace(-1,1,m+1)*a/(2*pi);
    ky=fs_y/2*linspace(-1,1,n+1)*a/(2*pi);
    handles.k_lightline=handles.k_lightline*a/(2*pi);
else % unit: m
    kx=fs_x/2*linspace(-1,1,m+1);
    ky=fs_y/2*linspace(-1,1,n+1);
end
Mirrorlr=zeros(n/2+1,m+1);
Mirrorud=zeros(n+1,m+1);
handles.kx=kx;
handles.ky=ky;

switch scalar
    
    case 'amplitude'
        Mirrorlr(1:n/2+1,(m+2)/2:m+1)=abs(First_FFT_padd);
        Mirrorlr(1:n/2+1,1:(m)/2)=fliplr(abs(First_FFT_padd(1:n/2+1,2:m/2+1)));
        Mirrorud((n+2)/2:n+1,1:m+1)=Mirrorlr;
        Mirrorud(1:(n)/2,1:m+1)=flipud(Mirrorlr(2:n/2+1,1:m+1));
        val=get(handles.Scale,'Value');
        if val==1 % linear
            handles.clim(1)=min(min(Mirrorud));
            handles.clim(2)=max(max(Mirrorud));
        else % log            
            Mirrorud=log10(Mirrorud);
            [Min,Max]=MinMax_FFT(Mirrorud,'log');
            handles.clim(1)=Min;
            handles.clim(2)=Max;
        end
    case 'phase'
        FFT=P*180/pi; % unit: 도
        Mirrorlr(1:n/2+1,(m+2)/2:m+1)=P*180/pi;
        Mirrorlr(1:n/2+1,1:(m)/2)=fliplr(P(1:n/2+1,2:m/2+1)*180/pi);
        Mirrorud((n+2)/2:n+1,1:m+1)=Mirrorlr;
        Mirrorud(1:(n)/2,1:m+1)=flipud(Mirrorlr(2:n/2+1,1:m+1));
        
        handles.clim(1)=min(min(Mirrorud));
        handles.clim(2)=max(max(Mirrorud));
    case 'real'    
        Mirrorlr(1:n/2+1,(m+2)/2:m+1)=real(First_FFT_padd);
        Mirrorlr(1:n/2+1,1:(m)/2)=fliplr(real(First_FFT_padd(1:n/2+1,2:m/2+1)));
        Mirrorud((n+2)/2:n+1,1:m+1)=Mirrorlr;
        Mirrorud(1:(n)/2,1:m+1)=flipud(Mirrorlr(2:n/2+1,1:m+1));
        
        handles.clim(1)=min(min(Mirrorud));
        handles.clim(2)=max(max(Mirrorud));
end
handles.Mirrorud=Mirrorud;

%%%% Color range
val=get(handles.Scale,'Value');
if val==1 % linear
    set(handles.Legend, 'Min', handles.clim(1));
    set(handles.Legend, 'Max', handles.clim(2));
    set(handles.Legend, 'Value', handles.clim(2));
    set(handles.Legend_max,'String',num2str(handles.clim(2)));
    set(handles.Legend_min,'String',num2str(handles.clim(1)));
    set(handles.Legend_cmax,'String',num2str(handles.clim(2)));
else % log
    set(handles.Legend, 'Min', handles.clim(1));
    set(handles.Legend, 'Max', handles.clim(2));
    set(handles.Legend, 'Value', handles.clim(1));
    set(handles.Legend_max,'String',num2str(handles.clim(2)));
    set(handles.Legend_min,'String',num2str(handles.clim(1)));
    set(handles.Legend_cmax,'String',num2str(handles.clim(1)));
end

handles.nlim(1)=handles.clim(1);
handles.nlim(2)=handles.clim(2);
%%%%%
else % Legend color range를 바꿨을 때
    val=get(handles.Scale,'Value');
    if val==1 %linear
        handles.nlim(2)=get(handles.Legend,'Value');
        handles.nlim(1)=handles.clim(1);
    else 
        handles.nlim(1)=get(handles.Legend,'Value');
        handles.nlim(2)=handles.clim(2);
    end
end

Mirrorud=handles.Mirrorud;
nlim(1)=handles.nlim(1);
nlim(2)=handles.nlim(2);
kx=handles.kx;
ky=handles.ky;
k_lightline=handles.k_lightline;

switch handles.onoff
    case 1 % light line 그린다
        if handles.type==1; %1D
            if roworcol==1 %row 선택
                row=str2double(get(handles.rowvalue,'String'));
                axes(handles.axes1);
                plot(kx,Mirrorud(row,:))
                
                centerx=0;
                x=[centerx+k_lightline,centerx+k_lightline];
                y=[0,max(Mirrorud(row,:))];
                p=line(x,y); hold on  %draw light line
                set(p,'Color','red','LineStyle','-','LineWidth',2);

                x=[centerx-k_lightline,centerx-k_lightline];
                y=[0,max(Mirrorud(row,:))];
                p=line(x,y); hold on % draw light line
                set(p,'Color','red','LineStyle','-','LineWidth',2);
            else %col 선택
                col=str2double(get(handles.colvalue,'String'));
                axes(handles.axes1);
                plot(ky,Mirrorud(:,col))
                
                centerx=0;
                x=[centerx+k_lightline,centerx+k_lightline];
                y=[0,max(Mirrorud(:,col))];
                p=line(x,y); hold on  %draw light line
                set(p,'Color','red','LineStyle','-','LineWidth',2);

                x=[centerx-k_lightline,centerx-k_lightline];
                y=[0,max(Mirrorud(:,col))];
                p=line(x,y); hold on % draw light line
                set(p,'Color','red','LineStyle','-','LineWidth',2);
            end
            hold off
        else %2D
            val=get(handles.Scale,'Value');
            if val==1 %linear
                axes(handles.axes1);         
                imagesc(kx,ky,(Mirrorud),nlim); % plot field, multiplied by e^(i*phi)  
                colormap('jet');
                axis image
                hold on
                th = 0:pi/50:2*pi;
                r=k_lightline;
                x=0; % x center of lightline
                y=0; % y center of lihgtline
                xunit = r * cos(th) + x;
                yunit = r * sin(th) + y;
                Circle = plot(xunit, yunit,'w--');
                set(Circle,'LineWidth',2);
                hold off
            else
                axes(handles.axes1);         
                imagesc(kx,ky,(Mirrorud),nlim); % plot field, multiplied by e^(i*phi)  
                colormap('jet');
                axis image
                hold on
                th = 0:pi/50:2*pi;
                r=k_lightline;
                x=0; % x center of lightline
                y=0; % y center of lihgtline
                xunit = r * cos(th) + x;
                yunit = r * sin(th) + y;
                Circle = plot(xunit, yunit,'w--');
                set(Circle,'LineWidth',2);
                hold off
            end
        end
        
    case 0 % light line 안그린다
        if handles.type==1 %1D
            if roworcol==1 %row 선택
                row=str2double(get(handles.rowvalue,'String'));
                axes(handles.axes1);
                plot(kx,Mirrorud(row,:)) 
                
            else %col 선택
                col=str2double(get(handles.colvalue,'String'));
                axes(handles.axes1);
                plot(ky,Mirrorud(:,col))    
                
            end
        else %2D
            val=get(handles.Scale,'Value');
            if val==1 %linear
                axes(handles.axes1);         
                imagesc(kx,ky,(Mirrorud),nlim); % plot field, multiplied by e^(i*phi)  
                colormap('jet');
                axis image
            else %log                
                axes(handles.axes1);
                imagesc(kx,ky,(Mirrorud),nlim); % plot field, multiplied by e^(i*phi)  
                colormap('jet');
                axis image
            end
        
        end
end
handles.call=0;
handles.call
guidata(hObject, handles);


% --- Executes on selection change in Scalar.
function Scalar_Callback(hObject, eventdata, handles)
% hObject    handle to Scalar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Scalar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Scalar


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
set(hObject,'String',{'amplitude';'phase';'real'});
set(hObject,'Value',1);
guidata(hObject, handles);

% --- Executes on button press in Lightline.
function Lightline_Callback(hObject, eventdata, handles)
% hObject    handle to Lightline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Lightline


% --- Executes on selection change in Type.
function Type_Callback(hObject, eventdata, handles)
% hObject    handle to Type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Type
type=get(hObject,'Value');
if type==1 % 1D
    set(handles.rowcolpanel,'Visible','on');
    set(handles.Xpopup,'Value',1);
    set(handles.Ypopup,'Value',3);
else % 2D
    set(handles.rowcolpanel,'Visible','off');
    set(handles.Xpopup,'Value',1);
    set(handles.Ypopup,'Value',2);
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
set(hObject,'String',{'1D';'2D'});
set(hObject,'Value',2);
guidata(hObject, handles);


% --- Executes on button press in X.
function X_Callback(hObject, eventdata, handles)
% hObject    handle to X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Y.
function Y_Callback(hObject, eventdata, handles)
% hObject    handle to Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Xpopup.
function Xpopup_Callback(hObject, eventdata, handles)
% hObject    handle to Xpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Xpopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Xpopup


% --- Executes during object creation, after setting all properties.
function Xpopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Xpopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(hObject,'Value',1);
guidata(hObject, handles);

% --- Executes on selection change in Ypopup.
function Ypopup_Callback(hObject, eventdata, handles)
% hObject    handle to Ypopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Ypopup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Ypopup


% --- Executes during object creation, after setting all properties.
function Ypopup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ypopup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'Plot x axis';'Plot y axis';'Slice'});
set(hObject,'Value',1);
guidata(hObject, handles);



function rowvalue_Callback(hObject, eventdata, handles)
% hObject    handle to rowvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rowvalue as text
%        str2double(get(hObject,'String')) returns contents of rowvalue as a double
row_info=str2double(get(handles.row_info,'String'));
col_info=str2double(get(handles.col_info,'String'));

val=str2double(get(hObject,'String'));
if val>row_info || val<1
    return
else    
end

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
row_info=str2double(get(handles.row_info,'String'));
col_info=str2double(get(handles.col_info,'String'));

val=str2double(get(hObject,'String'));
if val>col_info || val<1
    return
else    
end

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
set(hObject,'String',{'row';'col'});
set(hObject,'Value',1);
guidata(hObject, handles);


% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Matlab의 workspace로 데이터를 보낸다.
Mirrorud=handles.Mirrorud;
assignin('base','FFT',Mirrorud);
assignin('base','kx',handles.kx);
assignin('base','ky',handles.ky);


% --- Executes on selection change in unit.
function unit_Callback(hObject, eventdata, handles)
% hObject    handle to unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unit


% --- Executes during object creation, after setting all properties.
function unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String',{'2pi/a';'1/m'});
set(hObject,'Value',2);
guidata(hObject, handles);



function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','450');


% --- Executes on button press in plotnew.
function plotnew_Callback(hObject, eventdata, handles)
% hObject    handle to plotnew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = findobj(gca,'type','axes') % Find the axes object in the GUI
%ax_handle = get(gcf,'CurrentAxes');
ax_pos = get(gca,'Position'); % normalized position of the axis in the figure
x_lim = get(gca,'Xlim');
y_lim = get(gca,'Ylim');

% prompt = {'Enter title:'};
% dlg_title = 'Input';
% num_lines = 1;
% def = {'Title'};
% answer = inputdlg(prompt,dlg_title,num_lines,def);
% t=answer{1};
f1 = figure(); % Open a new figure with handle f1

s=copyobj(h,f1); % Copy axes object h into figure f1
set(s,'Units','normalized','Position',[0.1 0.1 0.8 0.8]);
%set(h, 'OuterPosition', [ax_pos(1), ax_pos(3), (2*x_lim(2)), (2*y_lim(2))]);
k = get(h);
j = get(s);


% --- Executes on selection change in Scale.
function Scale_Callback(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Scale contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Scale
val=get(handles.Scalar,'Value');
if val==1 % amplitude 선택했을 때
else % amplitude 이외의 것을 선택했을 때 log가 작동하지 않도록
    if get(hObject,'Value')==1;
    else
        set(hObject,'Value',1);
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function Scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Legend_Callback(hObject, eventdata, handles)
% hObject    handle to Legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if get(handles.Scale,'Value')==1 % linear
    val=get(hObject,'Value');
    if val<=handles.clim(1)
        set(hObject,'Value',handles.clim(2)*1e-3);
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)*1e-3));
    elseif val>handles.clim(2)
        set(hObject,'Value',handles.clim(2));
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)));
    else
        set(hObject,'Value',val);
        set(handles.Legend_cmax,'String',num2str(val));
    end
else % log 
    val=get(hObject,'Value');
    if val>=handles.clim(2)
        set(hObject,'Value',handles.clim(2)-1);
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)-1));
    elseif val<=handles.clim(1)
        set(hObject,'Value',handles.clim(1));
        set(handles.Legend_cmax,'String',num2str(handles.clim(1)));
    else
        set(hObject,'Value',val);
        set(handles.Legend_cmax,'String',num2str(val));
    end
end

set(handles.Legend_cmax,'String',num2str(val));



handles.call=1;
guidata(hObject, handles);
Plot_Callback(hObject, eventdata, handles);
% Plot_Callback(hObject, eventdata, handles) 와 guidata(hObject, handles)의
% 순서가 중요하다


% --- Executes during object creation, after setting all properties.
function Legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Legend_cmax_Callback(hObject, eventdata, handles)
% hObject    handle to Legend_cmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Legend_cmax as text
%        str2double(get(hObject,'String')) returns contents of Legend_cmax as a double
if get(handles.Scale,'Value')==1 % linear
    val=str2double(get(hObject,'String'));
    if val<=handles.clim(1)
        set(handles.Legend,'Value',handles.clim(2)*1e-3);
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)*1e-3));
    elseif val>handles.clim(2)
        set(handles.Legend,'Value',handles.clim(2));
        set(handles.Legend_cmax,'String',num2str(handles.clim(2)));
    else
        set(handles.Legend,'Value',val);
        set(handles.Legend_cmax,'String',num2str(val));
    end
else % log
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



handles.call=1;
guidata(hObject, handles);
Plot_Callback(hObject, eventdata, handles);

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
