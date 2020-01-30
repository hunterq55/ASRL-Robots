function varargout = ar2_kinematics(varargin)
% AR2_KINEMATICS MATLAB code for ar2_kinematics.fig
%      AR2_KINEMATICS, by itself, creates a new AR2_KINEMATICS or raises the existing
%      singleton*.
%
%      H = AR2_KINEMATICS returns the handle to a new AR2_KINEMATICS or the handle to
%      the existing singleton*.
%
%      AR2_KINEMATICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AR2_KINEMATICS.M with the given input arguments.
%
%      AR2_KINEMATICS('Property','Value',...) creates a new AR2_KINEMATICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ar2_kinematics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ar2_kinematics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ar2_kinematics

% Last Modified by GUIDE v2.5 01-Mar-2019 14:39:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ar2_kinematics_OpeningFcn, ...
                   'gui_OutputFcn',  @ar2_kinematics_OutputFcn, ...
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


% --- Executes just before ar2_kinematics is made visible.
function ar2_kinematics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ar2_kinematics (see VARARGIN)

% Choose default command line output for ar2_kinematics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ar2_kinematics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ar2_kinematics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function theta_1_Callback(hObject, eventdata, handles)
% hObject    handle to theta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_1 as text
%        str2double(get(hObject,'String')) returns contents of theta_1 as a double


% --- Executes during object creation, after setting all properties.
function theta_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_2_Callback(hObject, eventdata, handles)
% hObject    handle to theta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_2 as text
%        str2double(get(hObject,'String')) returns contents of theta_2 as a double


% --- Executes during object creation, after setting all properties.
function theta_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_3_Callback(hObject, eventdata, handles)
% hObject    handle to theta_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_3 as text
%        str2double(get(hObject,'String')) returns contents of theta_3 as a double


% --- Executes during object creation, after setting all properties.
function theta_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function theta_4_Callback(hObject, eventdata, handles)
% hObject    handle to theta_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_4 as text
%        str2double(get(hObject,'String')) returns contents of theta_4 as a double


% --- Executes during object creation, after setting all properties.
function theta_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_5_Callback(hObject, eventdata, handles)
% hObject    handle to theta_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_5 as text
%        str2double(get(hObject,'String')) returns contents of theta_5 as a double


% --- Executes during object creation, after setting all properties.
function theta_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function theta_6_Callback(hObject, eventdata, handles)
% hObject    handle to theta_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of theta_6 as text
%        str2double(get(hObject,'String')) returns contents of theta_6 as a double


% --- Executes during object creation, after setting all properties.
function theta_6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to theta_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_forward.
function btn_forward_Callback(hObject, eventdata, handles)
% hObject    handle to btn_forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
th_1 = str2double(handles.theta_1.String)*pi/180;
th_2 = str2double(handles.theta_2.String)*pi/180;
th_3 = str2double(handles.theta_3.String)*pi/180;
th_4 = str2double(handles.theta_4.String)*pi/180;
th_5 = str2double(handles.theta_5.String)*pi/180;
th_6 = str2double(handles.theta_6.String)*pi/180;

Qf = [th_1 th_2 th_3-(90*pi/180) th_4 th_5 th_6+(180*pi/180)];

L(1) = Link([0 169.77 64.2 -1.5707], 'R');
L(2) = Link([0 0 305 0], 'R');
L(3) = Link([-1.5707 0 0 1.5707], 'R');
L(4) = Link([0 -222.63 0 -1.5707], 'R');
L(5) = Link([0 0 0 1.5707], 'R');
L(6) = Link([pi -36.25 0 0], 'R');

Robot = SerialLink(L);
Robot.name = 'AR2';

% Qi = [0 0 0 0 0 0];
% t = 0:0.1:2;
% q = jtraj(Qi, Qf, t);

Robot.plot(Qf);

T = manipFK(Qf);
% Orientation = tr2rpy(T,'deg');

handles.pos_x.String = num2str(T(1));
handles.pos_y.String = num2str(T(2));
handles.pos_z.String = num2str(T(3));
handles.att_1.String = num2str(T(4)*pi/180);
handles.att_2.String = num2str(T(5)*pi/180);
handles.att_3.String = num2str(T(6)*pi/180);

function pos_x_Callback(hObject, eventdata, handles)
% hObject    handle to pos_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_x as text
%        str2double(get(hObject,'String')) returns contents of pos_x as a double


% --- Executes during object creation, after setting all properties.
function pos_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_y_Callback(hObject, eventdata, handles)
% hObject    handle to pos_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_y as text
%        str2double(get(hObject,'String')) returns contents of pos_y as a double


% --- Executes during object creation, after setting all properties.
function pos_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pos_z_Callback(hObject, eventdata, handles)
% hObject    handle to pos_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pos_z as text
%        str2double(get(hObject,'String')) returns contents of pos_z as a double


% --- Executes during object creation, after setting all properties.
function pos_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pos_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_inverse.
function btn_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to btn_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
px = str2double(handles.pos_x.String);
py = str2double(handles.pos_y.String);
pz = str2double(handles.pos_z.String);
phi = str2double(handles.att_1.String);
theta = str2double(handles.att_2.String);
psi = str2double(handles.att_3.String);

% L_1 = 20;
% L_2 = 50;
% L_3 = 40;
% 
% L(1) = Link([0 L_1 0 pi/2]);
% L(2) = Link([0 0 L_2 0]);
% L(3) = Link([0 0 L_3 0]);

L(1) = Link([0 169.77 64.2 -1.5707], 'R');
L(2) = Link([0 0 305 0], 'R');
L(3) = Link([-1.5707 0 0 1.5707], 'R');
L(4) = Link([0 -222.63 0 -1.5707], 'R');
L(5) = Link([0 0 0 1.5707], 'R');
L(6) = Link([pi -36.25 0 0], 'R');

Robot = SerialLink(L);
Robot.name = 'AR2_Robot';


% T = [1 0 0 px;
%      0 1 0 py;
%      0 0 1 pz;
%      0 0 0 1];
%  
% T = transl(px,py,pz) * rpy2tr(phi, theta, psi, 'deg');
% 
% %our bot inverts end effector rotation frame
% T(1,1) = T(1,1)*-1;
% T(3,3) = T(3,3)*-1;

pos=[px,py,pz,phi*pi/180,theta*pi/180,psi*pi/180];
th_1 = str2double(handles.theta_1.String)*pi/180;
th_2 = str2double(handles.theta_2.String)*pi/180;
th_3 = str2double(handles.theta_3.String)*pi/180;
th_4 = str2double(handles.theta_4.String)*pi/180;
th_5 = str2double(handles.theta_5.String)*pi/180;
th_6 = str2double(handles.theta_6.String)*pi/180;

cur=[th_1 th_2 th_3 th_4 th_5 th_6];

% J = Robot.ikine(T, [1 1 1 0 0 0]) * 180/pi;
% J=invkine(Robot,pos,cur);
J=trajectoryIK(pos,cur);
J=J';
handles.theta_1.String = num2str(J(1));
handles.theta_2.String = num2str(J(2));
handles.theta_3.String = num2str(J(3));
handles.theta_4.String = num2str(J(4));
handles.theta_5.String = num2str(J(5));
handles.theta_6.String = num2str(J(6));

Robot.plot(J*pi/180);



% th_1 = str2double(handles.theta_1.String)*pi/180;
% th_2 = str2double(handles.theta_2.String)*pi/180;
% th_3 = str2double(handles.theta_3.String)*pi/180;
% th_4 = str2double(handles.theta_4.String)*pi/180;
% th_5 = str2double(handles.theta_5.String)*pi/180;
% th_6 = str2double(handles.theta_6.String)*pi/180;
% 
% Qf = [th_1 th_2 th_3 th_4 th_5 th_6];
% 
% 
% 
% L(1) = Link([0 169.77 64.2 -1.5707], 'R');
% L(2) = Link([0 0 305 0], 'R');
% L(3) = Link([0 0 0 1.5707], 'R');
% L(4) = Link([0 -222.63 0 -1.5707], 'R');
% L(5) = Link([0 0 0 1.5707], 'R');
% L(6) = Link([0 -36.25 0 0], 'R');
% 
% Robot = SerialLink(L);
% Robot.name = "AR2";
% 
% Qi = [0 0 0 0 0 0];
% t = 0:0.1:2;
% 
% 
% q = jtraj(Qi, Qf, t);
% Robot.plot(q);
% 
% T = Robot.fkine(Qf);
% 
% handles.pos_x.String = num2str(T.t(1));
% handles.pos_y.String = num2str(T.t(2));
% handles.pos_z.String = num2str(T.t(3));





function att_1_Callback(hObject, eventdata, handles)
% hObject    handle to att_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of att_1 as text
%        str2double(get(hObject,'String')) returns contents of att_1 as a double


% --- Executes during object creation, after setting all properties.
function att_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to att_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function att_2_Callback(hObject, eventdata, handles)
% hObject    handle to att_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of att_2 as text
%        str2double(get(hObject,'String')) returns contents of att_2 as a double


% --- Executes during object creation, after setting all properties.
function att_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to att_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function att_3_Callback(hObject, eventdata, handles)
% hObject    handle to att_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of att_3 as text
%        str2double(get(hObject,'String')) returns contents of att_3 as a double


% --- Executes during object creation, after setting all properties.
function att_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to att_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
