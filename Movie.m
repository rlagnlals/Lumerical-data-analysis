function varargout = Movie(varargin)
% MOVIE MATLAB code for Movie.fig
%      MOVIE, by itself, creates a new MOVIE or raises the existing
%      singleton*.
%
%      H = MOVIE returns the handle to a new MOVIE or the handle to
%      the existing singleton*.
%
%      MOVIE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIE.M with the given input arguments.
%
%      MOVIE('Property','Value',...) creates a new MOVIE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Movie_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      play.  All inputs are passed to Movie_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Movie

% Last Modified by GUIDE v2.5 26-Jan-2015 16:42:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Movie_OpeningFcn, ...
                   'gui_OutputFcn',  @Movie_OutputFcn, ...
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


% --- Executes just before Movie is made visible.
function Movie_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Movie (see VARARGIN)

% Choose default command line output for Movie
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Movie wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Movie_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Cycle_Callback(hObject, eventdata, handles)
% hObject    handle to Cycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cycle as text
%        str2double(get(hObject,'String')) returns contents of Cycle as a double
var=get(hObject,'String');
var=str2double(var);

% --- Executes during object creation, after setting all properties.
function Cycle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cycle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','1');

% --- Executes on button press in Make.
function Make_Callback(hObject, eventdata, handles)
% hObject    handle to Make (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

GUI1=getappdata(0,'MyStruct');
%fieldnames(GUI1)
if GUI1.interpolation==1 %interpolation 한 데이터로 movie만들때
    Field=GUI1.nField;
    phi=GUI1.phi;
    %phase=GUI1.phase;
    C1=GUI1.nC1;
    C2=GUI1.nC2;
else  %interpolation 하지 않은 데이터로 movie만들때
    Field=GUI1.Field;
    phi=GUI1.phi;
    %phase=GUI1.phase;
    C1=GUI1.C1;
    C2=GUI1.C2;
end

onoff=GUI1.option;
%% Colorbar range
% clim=GUI1.clim;
% str=get(GUI1.Legend_cmax,'String');
% if clim(1)==0
% clim(2)=str2double(str);    
% else
% clim(2)=str2double(str);
% clim(1)=-clim(2);
% end
clim(1)=GUI1.nlim(1);
clim(2)=GUI1.nlim(2);
%% Movie
%M = moviein(length(phi));	
% h = waitbar(0,'Loading...',...
%             'Name','Matlabvn_waitbar',...
%             'CreateCancelBtn',...
%             'setappdata(gcbf,''cancel_callback'',1)');
%         setappdata(h,'cancel_callback',0);
%         
% temp=0;
        
switch onoff
    case 'on'
        %h = waitbar(0,'Making movie');
        if GUI1.interpolation==1
            eC1=GUI1.neC1;
            eC2=GUI1.neC2;
            Epsilon=GUI1.nepsilon;
        else
            eC1=GUI1.eC1;
            eC2=GUI1.eC2;
            Epsilon=GUI1.epsilon;
        end
        
        for j=1:length(phi)
%        waitbar(j/(length(phi)+1),h);
%             if getappdata(h,'cancel_callback')
%                 temp=1;
%                 break; 
%             else
            axes(handles.axes1);         
            imagesc(C1,C2,rot90(Field{j}),clim); % plot field, multiplied by e^(i*phi)    
            axis image
            axis off
            hold on
            axes(handles.axes1); 
            contour(eC1,eC2,rot90(Epsilon),1,'k')			% plot index coutour
            g = findobj('Type','line');
            set(g,'LineWidth',1)        
            M(j) = getframe;	% record frame
            hold off
            %end
        end
%        waitbar(1,h,'Complete');
%        delete(h)
%         if temp==1
%             msgbox('Canceled')
%         else
        %movie(handles.axes1,M);   
        handles.M=M;
%         end
        
    case 'off'
        for j=1:length(phi)
%        waitbar(j/(length(phi)+1),h);
%            if getappdata(h,'cancel_callback')
%                temp=1;
%                break;
%            else
            axes(handles.axes1);         
            imagesc(C1,C2,rot90(Field{j}),clim); % plot field, multiplied by e^(i*phi)  
            colormap('jet');
            %set(h,'Visible','off');
            %zoom(2);
            axis image
            axis off
            M(j) = getframe;				% record frame
 %           end
        end
 %       waitbar(1,h,'Complete');
 %       delete(h)
 %       if temp==1
 %           msgbox('Canceled')
 %       else
        %movie(handles.axes1,M);   
        handles.M=M;
 %        end
end
        
msgbox('Finished')
guidata(hObject, handles);


% --- Executes on button press in SaveMovie.
function SaveMovie_Callback(hObject, eventdata, handles)
% hObject    handle to SaveMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uiputfile({'*.avi','AVI (*.avi)'},'Save');
if filename==0, return, end
M=handles.M;
movie2avi(M,[pathname filename],'COMPRESSION','None');

guidata(hObject, handles);


% --- Executes on button press in Play.
function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
var=get(handles.Cycle,'String');
cycle=str2double(var);
var=get(handles.fps,'String');
fps=str2double(var);
movie(handles.axes1,handles.M,cycle,fps);

guidata(hObject, handles);


% --- Executes on button press in Stop.
function Stop_Callback(hObject, eventdata, handles)
% hObject    handle to Stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function fps_Callback(hObject, eventdata, handles)
% hObject    handle to fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fps as text
%        str2double(get(hObject,'String')) returns contents of fps as a double


% --- Executes during object creation, after setting all properties.
function fps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','12');
