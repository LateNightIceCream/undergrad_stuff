function varargout = noise(varargin)
% NOISE MATLAB code for noise.fig
%      NOISE, by itself, creates a new NOISE or raises the existing
%      singleton*.
%
%      H = NOISE returns the handle to a new NOISE or the handle to
%      the existing singleton*.
%
%      NOISE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE.M with the given input arguments.
%
%      NOISE('Property','Value',...) creates a new NOISE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before noise_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to noise_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help noise

% Last Modified by GUIDE v2.5 01-Oct-2015 14:34:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @noise_OpeningFcn, ...
                   'gui_OutputFcn',  @noise_OutputFcn, ...
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


% --- Executes just before noise is made visible.
function noise_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to noise (see VARARGIN)

% Choose default command line output for noise
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes noise wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = noise_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global weiter

load 'Rauschwert';
y=[y;y;y;y;y];
loop=2;
weiter = 'j';
while weiter == 'j'             % solange button nicht gedrückt
disp('Rauschausgabe...');
  for k=1:loop;
      soundsc(y,44100);
      pause(1)                  % damit der button wahrgenommen wird
  end;
  
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global weiter
weiter = 'nö, aufhören'     % Aktion bei gedrücktem button
