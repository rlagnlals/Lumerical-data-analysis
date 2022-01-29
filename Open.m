function varargout = Open(varargin)
% OPEN MATLAB code for Open.fig
%      OPEN, by itself, creates a new OPEN or raises the existing
%      singleton*.
%
%      H = OPEN returns the handle to a new OPEN or the handle to
%      the existing singleton*.
%
%      OPEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPEN.M with the given input arguments.
%
%      OPEN('Property','Value',...) creates a new OPEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Open_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Open_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Open

% Last Modified by GUIDE v2.5 23-Jan-2015 01:06:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Open_OpeningFcn, ...
                   'gui_OutputFcn',  @Open_OutputFcn, ...
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


% --- Executes just before Open is made visible.
function Open_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Open (see VARARGIN)

% Choose default command line output for Open
handles.output = hObject;
handles.filename=0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Open wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Open_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in Overrite.
function Overrite_Callback(hObject, eventdata, handles)
% hObject    handle to Overrite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selected_list=get(handles.Filelist,'Value');

[filename, pathname]=uigetfile({'*.*'},'File selector');
fullpath=[pathname filename];
if filename==0
    handles.load=0;
    return
end
contents=get(handles.Filelist,'String')
contents{selected_list}=fullpath;
set(handles.Filelist,'String',contents);

% --- Executes on button press in Add.
function Add_Callback(hObject, eventdata, handles)
% hObject    handle to Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%clearvars -global *;
global data;
[filename, pathname]=uigetfile({'*.*'},'File selector');
fullpath=[pathname filename];
if filename==0
    handles.load=0;
    return
end
contents=get(handles.Filelist,'String');
s=length(contents);
contents{s+1}=fullpath;
set(handles.Filelist,'String',contents);
% data.fullpath=handles.fullpath;
% data.load=handles.load;
%handles.load=1; % 데이터를 load했는지 확인하는 인자
guidata(hObject, handles);

% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
% filename=handles.filename;
% if filename==0 
%     handles.load=0;
%     return
% end
%data.load=handles.load;

data.filelist=get(handles.Filelist,'String');
guidata(hObject, handles);
delete(handles.figure1);

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


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);
