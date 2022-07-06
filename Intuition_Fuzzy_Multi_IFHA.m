function varargout = Intuition_Fuzzy_Multi_IFHA(varargin)
% INTUITION_FUZZY_MULTI_IFHA MATLAB code for intuition_fuzzy_multi_ifha.fig
%      INTUITION_FUZZY_MULTI_IFHA, by itself, creates a new INTUITION_FUZZY_MULTI_IFHA or raises the existing
%      singleton*.
%
%      H = INTUITION_FUZZY_MULTI_IFHA returns the handle to a new INTUITION_FUZZY_MULTI_IFHA or the handle to
%      the existing singleton*.
%
%      INTUITION_FUZZY_MULTI_IFHA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTUITION_FUZZY_MULTI_IFHA.M with the given input arguments.
%
%      INTUITION_FUZZY_MULTI_IFHA('Property','Value',...) creates a new INTUITION_FUZZY_MULTI_IFHA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before intuition_fuzzy_multi_ifha_openingfcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to intuition_fuzzy_multi_ifha_openingfcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".

% 赛尔网络下一代互联网技术创新项目(NGII20180502)
% 直觉模糊多属性决策问题处理步骤：
% 1:列出各个专家偏好的属性权重，做标准化；
% 2:列出各个视频（方案）的评估值（直觉模糊数）；
% 3:加权并乘以平衡系数n，得到加权后的直觉模糊决策矩阵；
% 4:每个方案的加权属性的得分值按从大到小排序；
% 5:由正态分布法确定算子的加权向量；
% n=3时，wj=0.2429,0.5142,0.2429
% n=5时，wj= 0.112,0.236,0.304,0.236,0.112
% n=6时，wj=0.0865,0.1716,0.2419,0.2419,0.1716,0.0865
% 6:计算IFHA(IFHG)算子综合属性值；
% 7:计算算子的得分和精确度，根据得分排序；
% 其中，属性权重标准化（结合专家）时，如是效益型，可取消这步。

% Modified by hankun,chenyaojing,zhangwensheng,chenpanyan,chenpeiying v1.0 21-Jun-2022 10:23:12
% Last Modified by hankun,chenyaojing,zhangwensheng,chenpanyan,chenpeiying v1.0 6-Jul-2022 10:54:12
% email:383589954@qq.com
% References:
% Xu, Z. (2007). Intuitionistic fuzzy aggregation operators. IEEE Transactions on fuzzy systems, 15(6), 1179-1187.
% Xu, Z. (2005). An overview of methods for determining OWA weights. International journal of intelligent systems, 20(8), 843-865.
% Xu, Z., & Yager, R. R. (2006). Some geometric aggregation operators based on intuitionistic fuzzy sets. International journal of general systems, 35(4), 417-433.
% Herrera, F., & Martinez, L. (2000). An approach for combining linguistic and numerical information based on the 2-tuple fuzzy linguistic representation model in decision-making. International Journal of Uncertainty, Fuzziness and Knowledge-Based Systems, 8(05), 539-562.

% 初始化
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HESITANT_Fuzzy_Multi_OpeningFcn, ...
                   'gui_OutputFcn',  @HESITANT_Fuzzy_Multi_OutputFcn, ...
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

% --- Executes just before intuition_fuzzy_multi_ifha is made visible.
function HESITANT_Fuzzy_Multi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to intuition_fuzzy_multi_ifha (see VARARGIN)

% Choose default command line output for intuition_fuzzy_multi_ifha
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes intuition_fuzzy_multi_ifha wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HESITANT_Fuzzy_Multi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function edit67_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Save.
function pushbutton_Save_Callback(hObject, eventdata, handles)
% 存入文件
% xuhao,a11,a12,a13,a14,a15,a16
% s(11),s(12),s(13),s(14),s(15),s(16)
% thi(11),thi(12),thi(13),thi(14),thi(15),thi(16)
% i1,i2,i3,i4
outfile='./out/data.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    
    newCell_title={'xuhao','x1','x2','x3','x4','x5','x6',...
                 'x1_w','x2_w','x3_w','x4_w','x5_w','x6_w',...
               's_x1_w','s_x2_w','s_x3_w','s_x4_w','s_x5_w','s_x6_w',...
               'thi_1','thi_2','thi_3','thi_4','thi_5','thi_6',...
               'i','s_i','thi_i'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end

% 第1行    
a1=handles.a1;
a1_de=handles.a1_de;
a11=num2str(a1(:,1)');
a12=num2str(a1(:,2)');
a13=num2str(a1(:,3)');
a14=num2str(a1(:,4)');
a15=num2str(a1(:,5)');
a16=num2str(a1(:,6)');
a11_w=num2str(a1_de(:,1)');
a12_w=num2str(a1_de(:,2)');
a13_w=num2str(a1_de(:,3)');
a14_w=num2str(a1_de(:,4)');
a15_w=num2str(a1_de(:,5)');
a16_w=num2str(a1_de(:,6)');
s_11=handles.edit_s_11.String;
s_12=handles.edit_s_12.String;
s_13=handles.edit_s_13.String;
s_14=handles.edit_s_14.String;
s_15=handles.edit_s_15.String;
s_16=handles.edit_s_16.String;
thi_11=handles.edit_thi_11.String;
thi_12=handles.edit_thi_12.String;
thi_13=handles.edit_thi_13.String;
thi_14=handles.edit_thi_14.String;
thi_15=handles.edit_thi_15.String;
thi_16=handles.edit_thi_16.String;
i1=handles.listbox_i1.String;
s_i1=handles.edit_s_i1.String;
thi_i1=str2num(handles.edit_thi_i1.String);

newCell_title={'xuhao','x1','x2','x3','x4','x5','x6',...
                 'x1_w','x2_w','x3_w','x4_w','x5_w','x6_w',...
               's_x1_w','s_x2_w','s_x3_w','s_x4_w','s_x5_w','s_x6_w',...
               'thi_1','thi_2','thi_3','thi_4','thi_5','thi_6',...
               'i','s_i','thi_i'};
newCell_zhi={1,a11,a12,a13,a14,a15,a16...
             a11_w,a12_w,a13_w,a14_w,a15_w,a16_w...
             s_11,s_12,s_13,s_14,s_15,s_16,...
             thi_11,thi_12,thi_13,thi_14,thi_15,thi_16,...
             i1,s_i1,thi_i1};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第2行     
a2=handles.a2;
a2_de=handles.a2_de;
a21=num2str(a2(:,1)');
a22=num2str(a2(:,2)');
a23=num2str(a2(:,3)');
a24=num2str(a2(:,4)');
a25=num2str(a2(:,5)');
a26=num2str(a2(:,6)');
a21_w=num2str(a2_de(:,1)');
a22_w=num2str(a2_de(:,2)');
a23_w=num2str(a2_de(:,3)');
a24_w=num2str(a2_de(:,4)');
a25_w=num2str(a2_de(:,5)');
a26_w=num2str(a2_de(:,6)');
s_21=handles.edit_s_21.String;
s_22=handles.edit_s_22.String;
s_23=handles.edit_s_23.String;
s_24=handles.edit_s_24.String;
s_25=handles.edit_s_25.String;
s_26=handles.edit_s_26.String;
thi_21=handles.edit_thi_21.String;
thi_22=handles.edit_thi_22.String;
thi_23=handles.edit_thi_23.String;
thi_24=handles.edit_thi_24.String;
thi_25=handles.edit_thi_25.String;
thi_26=handles.edit_thi_26.String;
i2=handles.listbox_i2.String;
s_i2=handles.edit_s_i2.String;
thi_i2=str2num(handles.edit_thi_i2.String);

newCell_title={'xuhao','x1','x2','x3','x4','x5','x6',...
                 'x1_w','x2_w','x3_w','x4_w','x5_w','x6_w',...
               's_x1_w','s_x2_w','s_x3_w','s_x4_w','s_x5_w','s_x6_w',...
               'thi_1','thi_2','thi_3','thi_4','thi_5','thi_6',...
               'i','s_i','thi_i'};
newCell_zhi={2,a21,a22,a23,a24,a25,a26...
             a21_w,a22_w,a23_w,a24_w,a25_w,a26_w...
             s_21,s_22,s_23,s_24,s_25,s_26,...
             thi_21,thi_22,thi_23,thi_24,thi_25,thi_26,...
             i2,s_i2,thi_i2};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第3行    
a3=handles.a3;
a3_de=handles.a3_de;
a31=num2str(a3(:,1)');
a32=num2str(a3(:,2)');
a33=num2str(a3(:,3)');
a34=num2str(a3(:,4)');
a35=num2str(a3(:,5)');
a36=num2str(a3(:,6)');
a31_w=num2str(a3_de(:,1)');
a32_w=num2str(a3_de(:,2)');
a33_w=num2str(a3_de(:,3)');
a34_w=num2str(a3_de(:,4)');
a35_w=num2str(a3_de(:,5)');
a36_w=num2str(a3_de(:,6)');
s_31=handles.edit_s_31.String;
s_32=handles.edit_s_32.String;
s_33=handles.edit_s_33.String;
s_34=handles.edit_s_34.String;
s_35=handles.edit_s_35.String;
s_36=handles.edit_s_36.String;
thi_31=handles.edit_thi_31.String;
thi_32=handles.edit_thi_32.String;
thi_33=handles.edit_thi_33.String;
thi_34=handles.edit_thi_34.String;
thi_35=handles.edit_thi_35.String;
thi_36=handles.edit_thi_36.String;
i3=handles.listbox_i3.String;
s_i3=handles.edit_s_i3.String;
thi_i3=str2num(handles.edit_thi_i3.String);

newCell_title={'xuhao','x1','x2','x3','x4','x5','x6',...
                 'x1_w','x2_w','x3_w','x4_w','x5_w','x6_w',...
               's_x1_w','s_x2_w','s_x3_w','s_x4_w','s_x5_w','s_x6_w',...
               'thi_1','thi_2','thi_3','thi_4','thi_5','thi_6',...
               'i','s_i','thi_i'};
newCell_zhi={3,a31,a32,a33,a34,a35,a36...
             a31_w,a32_w,a33_w,a34_w,a35_w,a36_w...
             s_31,s_32,s_33,s_34,s_35,s_36,...
             thi_31,thi_32,thi_33,thi_34,thi_35,thi_36,...
             i3,s_i3,thi_i3};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第4行    
a4=handles.a4;
a4_de=handles.a4_de;
a41=num2str(a4(:,1)');
a42=num2str(a4(:,2)');
a43=num2str(a4(:,3)');
a44=num2str(a4(:,4)');
a45=num2str(a4(:,5)');
a46=num2str(a4(:,6)');
a41_w=num2str(a4_de(:,1)');
a42_w=num2str(a4_de(:,2)');
a43_w=num2str(a4_de(:,3)');
a44_w=num2str(a4_de(:,4)');
a45_w=num2str(a4_de(:,5)');
a46_w=num2str(a4_de(:,6)');
s_41=handles.edit_s_41.String;
s_42=handles.edit_s_42.String;
s_43=handles.edit_s_43.String;
s_44=handles.edit_s_44.String;
s_45=handles.edit_s_45.String;
s_46=handles.edit_s_46.String;
thi_41=handles.edit_thi_41.String;
thi_42=handles.edit_thi_42.String;
thi_43=handles.edit_thi_43.String;
thi_44=handles.edit_thi_44.String;
thi_45=handles.edit_thi_45.String;
thi_46=handles.edit_thi_46.String;
i4=handles.listbox_i4.String;
s_i4=handles.edit_s_i4.String;
thi_i4=str2num(handles.edit_thi_i4.String);

newCell_title={'xuhao','x1','x2','x3','x4','x5','x6',...
                 'x1_w','x2_w','x3_w','x4_w','x5_w','x6_w',...
               's_x1_w','s_x2_w','s_x3_w','s_x4_w','s_x5_w','s_x6_w',...
               'thi_1','thi_2','thi_3','thi_4','thi_5','thi_6',...
               'i','s_i','thi_i'};
newCell_zhi={4,a41,a42,a43,a44,a45,a46...
             a41_w,a42_w,a43_w,a44_w,a45_w,a46_w...
             s_41,s_42,s_43,s_44,s_45,s_46,...
             thi_41,thi_42,thi_43,thi_44,thi_45,thi_46,...
             i4,s_i4,thi_i4};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 写入完成。
disp('demo数据写入完成。');


function edit_a21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a21 as text
%        str2double(get(hObject,'String')) returns contents of edit_a21 as a double


% --- Executes during object creation, after setting all properties.
function edit_a21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a31 as text
%        str2double(get(hObject,'String')) returns contents of edit_a31 as a double


% --- Executes during object creation, after setting all properties.
function edit_a31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a41 as text
%        str2double(get(hObject,'String')) returns contents of edit_a41 as a double


% --- Executes during object creation, after setting all properties.
function edit_a41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a12 as text
%        str2double(get(hObject,'String')) returns contents of edit_a12 as a double


% --- Executes during object creation, after setting all properties.
function edit_a12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a22 as text
%        str2double(get(hObject,'String')) returns contents of edit_a22 as a double


% --- Executes during object creation, after setting all properties.
function edit_a22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a32 as text
%        str2double(get(hObject,'String')) returns contents of edit_a32 as a double


% --- Executes during object creation, after setting all properties.
function edit_a32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a42 as text
%        str2double(get(hObject,'String')) returns contents of edit_a42 as a double


% --- Executes during object creation, after setting all properties.
function edit_a42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a13 as text
%        str2double(get(hObject,'String')) returns contents of edit_a13 as a double


% --- Executes during object creation, after setting all properties.
function edit_a13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a23 as text
%        str2double(get(hObject,'String')) returns contents of edit_a23 as a double


% --- Executes during object creation, after setting all properties.
function edit_a23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a33 as text
%        str2double(get(hObject,'String')) returns contents of edit_a33 as a double


% --- Executes during object creation, after setting all properties.
function edit_a33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a43 as text
%        str2double(get(hObject,'String')) returns contents of edit_a43 as a double


% --- Executes during object creation, after setting all properties.
function edit_a43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_22 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_22 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_23 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_23 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_31 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_31 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_32 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_32 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_33 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_33 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_11 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_11 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_13 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_13 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wi as text
%        str2double(get(hObject,'String')) returns contents of edit_wi as a double


% --- Executes during object creation, after setting all properties.
function edit_wi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wj_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wj as text
%        str2double(get(hObject,'String')) returns contents of edit_wj as a double


% --- Executes during object creation, after setting all properties.
function edit_wj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Modify_thi.
function pushbutton_Modify_thi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Modify_thi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox("请手动输入调整大小顺序。");


function edit_thi_41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_41 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_41 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_42 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_42 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_43 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_43 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i1 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i1 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i2 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i2 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i3 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i3 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i4 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i4 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_s_h.
function pushbutton_Caculate_s_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A1
a11=str2num(handles.edit_a11.String);
a12=str2num(handles.edit_a12.String);
a13=str2num(handles.edit_a13.String);
a14=str2num(handles.edit_a14.String);
a15=str2num(handles.edit_a15.String);
a16=str2num(handles.edit_a16.String);
s_11=a11(1)-a11(2);
s_12=a12(1)-a12(2);
s_13=a13(1)-a13(2);
s_14=a14(1)-a14(2);
s_15=a15(1)-a15(2);
s_16=a16(1)-a16(2);
set(handles.edit_s_11,'string',s_11);
set(handles.edit_s_12,'string',s_12);
set(handles.edit_s_13,'string',s_13);
set(handles.edit_s_14,'string',s_14);
set(handles.edit_s_15,'string',s_15);
set(handles.edit_s_16,'string',s_16);

% A2
a21=str2num(handles.edit_a21.String);
a22=str2num(handles.edit_a22.String);
a23=str2num(handles.edit_a23.String);
a24=str2num(handles.edit_a24.String);
a25=str2num(handles.edit_a25.String);
a26=str2num(handles.edit_a26.String);
s_21=a21(1)-a21(2);
s_22=a22(1)-a22(2);
s_23=a23(1)-a23(2);
s_24=a24(1)-a24(2);
s_25=a25(1)-a25(2);
s_26=a26(1)-a26(2);
set(handles.edit_s_21,'string',s_21);
set(handles.edit_s_22,'string',s_22);
set(handles.edit_s_23,'string',s_23);
set(handles.edit_s_24,'string',s_24);
set(handles.edit_s_25,'string',s_25);
set(handles.edit_s_26,'string',s_26);

% A3
a31=str2num(handles.edit_a31.String);
a32=str2num(handles.edit_a32.String);
a33=str2num(handles.edit_a33.String);
a34=str2num(handles.edit_a34.String);
a35=str2num(handles.edit_a35.String);
a36=str2num(handles.edit_a36.String);
s_31=a31(1)-a31(2);
s_32=a32(1)-a32(2);
s_33=a33(1)-a33(2);
s_34=a34(1)-a34(2);
s_35=a35(1)-a35(2);
s_36=a36(1)-a36(2);
set(handles.edit_s_31,'string',s_31);
set(handles.edit_s_32,'string',s_32);
set(handles.edit_s_33,'string',s_33);
set(handles.edit_s_34,'string',s_34);
set(handles.edit_s_35,'string',s_35);
set(handles.edit_s_36,'string',s_36);

% A4
a41=str2num(handles.edit_a41.String);
a42=str2num(handles.edit_a42.String);
a43=str2num(handles.edit_a43.String);
a44=str2num(handles.edit_a44.String);
a45=str2num(handles.edit_a45.String);
a46=str2num(handles.edit_a46.String);
s_41=a41(1)-a41(2);
s_42=a42(1)-a42(2);
s_43=a43(1)-a43(2);
s_44=a44(1)-a44(2);
s_45=a45(1)-a45(2);
s_46=a46(1)-a46(2);
set(handles.edit_s_41,'string',s_41);
set(handles.edit_s_42,'string',s_42);
set(handles.edit_s_43,'string',s_43);
set(handles.edit_s_44,'string',s_44);
set(handles.edit_s_45,'string',s_45);
set(handles.edit_s_46,'string',s_46);


function edit_thi_i1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i1 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i1 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_i2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i2 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i2 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_i3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i3 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i3 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_i4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i4 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i4 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_thi.
function pushbutton_Caculate_thi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_thi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i1=str2num(handles.listbox_i1.String);
i2=str2num(handles.listbox_i2.String);
i3=str2num(handles.listbox_i3.String);
i4=str2num(handles.listbox_i4.String);

thi_i1=i1(1)+i1(2);
thi_i2=i2(1)+i2(2);
thi_i3=i3(1)+i3(2);
thi_i4=i4(1)+i4(2);
set(handles.edit_thi_i1,'string',thi_i1);
set(handles.edit_thi_i2,'string',thi_i2);
set(handles.edit_thi_i3,'string',thi_i3);
set(handles.edit_thi_i4,'string',thi_i4);


function edit_s_i1_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i1_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i1_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i1_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i2_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i2_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i2_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i2_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i3_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i3_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i3_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i3_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_i4_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_i4_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_i4_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_i4_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_i4_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_i4_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_s_L.
function pushbutton_Caculate_s_h_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit_thi_i1_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i1_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i1_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i1_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_i2_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i2_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i2_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i2_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_i3_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i3_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i3_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i3_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_i4_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_i4_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_i4_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_i4_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_i4_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_i4_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_s_h.
function pushbutton_Caculate_s_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A1
a11=str2num(handles.edit_a11_L.String);
a12=str2num(handles.edit_a12_L.String);
a13=str2num(handles.edit_a13_L.String);
s_11=a11(1)-a11(2);
s_12=a12(1)-a12(2);
s_13=a13(1)-a13(2);
set(handles.edit_s_11_L,'string',s_11);
set(handles.edit_s_12_L,'string',s_12);
set(handles.edit_s_13_L,'string',s_13);

% A2
a21=str2num(handles.edit_a21_L.String);
a22=str2num(handles.edit_a22_L.String);
a23=str2num(handles.edit_a23_L.String);
s_21=a21(1)-a21(2);
s_22=a22(1)-a22(2);
s_23=a23(1)-a23(2);
set(handles.edit_s_21_L,'string',s_21);
set(handles.edit_s_22_L,'string',s_22);
set(handles.edit_s_23_L,'string',s_23);

% A3
a31=str2num(handles.edit_a31_L.String);
a32=str2num(handles.edit_a32_L.String);
a33=str2num(handles.edit_a33_L.String);
s_31=a31(1)-a31(2);
s_32=a32(1)-a32(2);
s_33=a33(1)-a33(2);
set(handles.edit_s_31_L,'string',s_31);
set(handles.edit_s_32_L,'string',s_32);
set(handles.edit_s_33_L,'string',s_33);

% A4
a41=str2num(handles.edit_a41_L.String);
a42=str2num(handles.edit_a42_L.String);
a43=str2num(handles.edit_a43_L.String);
s_41=a41(1)-a41(2);
s_42=a42(1)-a42(2);
s_43=a43(1)-a43(2);
set(handles.edit_s_41_L,'string',s_41);
set(handles.edit_s_42_L,'string',s_42);
set(handles.edit_s_43_L,'string',s_43);


% --- Executes on button press in pushbutton_Caculate_thi_L.
function pushbutton_Caculate_thi_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_thi_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i1=str2num(handles.listbox_i1_L.String);
i2=str2num(handles.listbox_i2_L.String);
i3=str2num(handles.listbox_i3_L.String);
i4=str2num(handles.listbox_i4_L.String);

thi_i1=i1(1)+i1(2);
thi_i2=i2(1)+i2(2);
thi_i3=i3(1)+i3(2);
thi_i4=i4(1)+i4(2);

set(handles.edit_thi_i1_L,'string',thi_i1);
set(handles.edit_thi_i2_L,'string',thi_i2);
set(handles.edit_thi_i3_L,'string',thi_i3);
set(handles.edit_thi_i4_L,'string',thi_i4);


function edit_a11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a11_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a11_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a11_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a11_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a11_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a11_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a21_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a21_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a21_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a21_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a21_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a21_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a31_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a31_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a31_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a31_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a31_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a31_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a41_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a41_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a41_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a41_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a41_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a41_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a12_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a12_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a12_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a12_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a12_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a12_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a22_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a22_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a22_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a22_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a22_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a22_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a32_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a32_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a32_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a32_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a32_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a32_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a42_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a42_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a42_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a42_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a42_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a42_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a13_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a13_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a13_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a13_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a13_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a13_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a23_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a23_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a23_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a23_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a23_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a23_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a33_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a33_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a33_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a33_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a33_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a33_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a43_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a43_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a43_L as text
%        str2double(get(hObject,'String')) returns contents of edit_a43_L as a double


% --- Executes during object creation, after setting all properties.
function edit_a43_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a43_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Save_L.
function pushbutton_Save_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Save_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 存入文件
% xuhao,a11,a12,a13,
% s(11),s(12),s(13),
% thi(11),thi(12),thi(13),...
% i1,i2,i3,i4
outfile='./out/data_L.csv';
if exist(string(outfile),'file')
    disp(['Error. \n This file already exists: ',string(outfile)]);
else
    mkdir('./out');
    newCell_title={'xuhao','x1','x2','x3',...
                 'x1_w','x2_w','x3_w',...
               's_x1_w','s_x2_w','s_x3_w',...
               'thi_1','thi_2','thi_3',...
               'i','s_i','thi_i'};
    disp(newCell_title);
    newTable = cell2table(newCell_title);
    disp(newTable)
    writetable(newTable,outfile);
end

% 第1行
a1_L=handles.a1_L;
a1_de_L=handles.a1_de_L;
a11=num2str(a1_L(:,1)');
a12=num2str(a1_L(:,2)');
a13=num2str(a1_L(:,3)');
a11_w=num2str(a1_de_L(:,1)');
a12_w=num2str(a1_de_L(:,2)');
a13_w=num2str(a1_de_L(:,3)');
s_11=handles.edit_s_11_L.String;
s_12=handles.edit_s_12_L.String;
s_13=handles.edit_s_13_L.String;
thi_11=handles.edit_thi_11_L.String;
thi_12=handles.edit_thi_12_L.String;
thi_13=handles.edit_thi_13_L.String;
i1=handles.listbox_i1_L.String;
s_i1=handles.edit_s_i1_L.String;
thi_i1=str2num(handles.edit_thi_i1_L.String);

newCell_title={'xuhao','x1','x2','x3',...
                 'x1_w','x2_w','x3_w',...
               's_x1_w','s_x2_w','s_x3_w',...
               'thi_1','thi_2','thi_3',...
               'i','s_i','thi_i'};
newCell_zhi={1,a11,a12,a13,...
             a11_w,a12_w,a13_w,...
             s_11,s_12,s_13,...
             thi_11,thi_12,thi_13,...
             i1,s_i1,thi_i1};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第2行           
a2_L=handles.a2_L;
a2_de_L=handles.a2_de_L;
a21=num2str(a2_L(:,1)');
a22=num2str(a2_L(:,2)');
a23=num2str(a2_L(:,3)');
a21_w=num2str(a2_de_L(:,1)');
a22_w=num2str(a2_de_L(:,2)');
a23_w=num2str(a2_de_L(:,3)');
s_21=handles.edit_s_21_L.String;
s_22=handles.edit_s_22_L.String;
s_23=handles.edit_s_23_L.String;
thi_21=handles.edit_thi_21_L.String;
thi_22=handles.edit_thi_22_L.String;
thi_23=handles.edit_thi_23_L.String;
i2=handles.listbox_i2_L.String;
s_i2=handles.edit_s_i2_L.String;
thi_i2=str2num(handles.edit_thi_i2_L.String);

newCell_title={'xuhao','x1','x2','x3',...
                 'x1_w','x2_w','x3_w',...
               's_x1_w','s_x2_w','s_x3_w',...
               'thi_1','thi_2','thi_3',...
               'i','s_i','thi_i'};
newCell_zhi={2,a21,a22,a23,...
             a21_w,a22_w,a23_w,...
             s_21,s_22,s_23,...
             thi_21,thi_22,thi_23,...
             i2,s_i2,thi_i2};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第3行         
a3_L=handles.a3_L;
a3_de_L=handles.a3_de_L;
a31=num2str(a3_L(:,1)');
a32=num2str(a3_L(:,2)');
a33=num2str(a3_L(:,3)');
a31_w=num2str(a3_de_L(:,1)');
a32_w=num2str(a3_de_L(:,2)');
a33_w=num2str(a3_de_L(:,3)');
s_31=handles.edit_s_31_L.String;
s_32=handles.edit_s_32_L.String;
s_33=handles.edit_s_33_L.String;
thi_31=handles.edit_thi_31_L.String;
thi_32=handles.edit_thi_32_L.String;
thi_33=handles.edit_thi_33_L.String;
i3=handles.listbox_i3_L.String;
s_i3=handles.edit_s_i3_L.String;
thi_i3=str2num(handles.edit_thi_i3_L.String);

newCell_title={'xuhao','x1','x2','x3',...
                 'x1_w','x2_w','x3_w',...
               's_x1_w','s_x2_w','s_x3_w',...
               'thi_1','thi_2','thi_3',...
               'i','s_i','thi_i'};
newCell_zhi={3,a31,a32,a33,...
             a31_w,a32_w,a33_w,...
             s_31,s_32,s_33,...
             thi_31,thi_32,thi_33,...
             i3,s_i3,thi_i3};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 第4行  
a4_L=handles.a4_L;
a4_de_L=handles.a4_de_L;
a41=num2str(a4_L(:,1)');
a42=num2str(a4_L(:,2)');
a43=num2str(a4_L(:,3)');
a41_w=num2str(a4_de_L(:,1)');
a42_w=num2str(a4_de_L(:,2)');
a43_w=num2str(a4_de_L(:,3)');
s_41=handles.edit_s_41_L.String;
s_42=handles.edit_s_42_L.String;
s_43=handles.edit_s_43_L.String;
thi_41=handles.edit_thi_41_L.String;
thi_42=handles.edit_thi_42_L.String;
thi_43=handles.edit_thi_43_L.String;
i4=handles.listbox_i4_L.String;
s_i4=handles.edit_s_i4_L.String;
thi_i4=str2num(handles.edit_thi_i4_L.String);

newCell_title={'xuhao','x1','x2','x3',...
                 'x1_w','x2_w','x3_w',...
               's_x1_w','s_x2_w','s_x3_w',...
               'thi_1','thi_2','thi_3',...
               'i','s_i','thi_i'};
newCell_zhi={4,a41,a42,a43,...
             a41_w,a42_w,a43_w,...
             s_41,s_42,s_43,...
             thi_41,thi_42,thi_43,...
             i4,s_i4,thi_i4};
disp(newCell_zhi);
newTable = cell2table(newCell_zhi);
newTable.Properties.VariableNames=newCell_title;
nasdaq=readtable(outfile);
nasdaq.Properties.VariableNames=newCell_title;
 
newNasdaq =[nasdaq;newTable];  
writetable(newNasdaq,outfile);

% 写入完成。
disp('数据写入完成。');


function edit_wi_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wi_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wi_L as text
%        str2double(get(hObject,'String')) returns contents of edit_wi_L as a double


% --- Executes during object creation, after setting all properties.
function edit_wi_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wi_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_wj_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wj_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wj_L as text
%        str2double(get(hObject,'String')) returns contents of edit_wj_L as a double


% --- Executes during object creation, after setting all properties.
function edit_wj_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wj_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_wj_L.
function pushbutton_Caculate_wj_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_wj_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox("由正态分布赋权法给出。");


% --- Executes on button press in pushbutton_Caculate_I_L.
function pushbutton_Caculate_I_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_I_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp("开始计算：");
wj=str2num(handles.edit_wj_L.String);
% i1,A1 2-2-2
a=handles.a1_de_L;
disp(a);
thi_11=str2num(handles.edit_thi_11_L.String);
thi_12=str2num(handles.edit_thi_12_L.String);
thi_13=str2num(handles.edit_thi_13_L.String);
% 这里交换数据
a_de(:,thi_11)=a(:,1);
a_de(:,thi_12)=a(:,2);
a_de(:,thi_13)=a(:,3);
disp(a_de);
a1_de=a_de(:,1);
a2_de=a_de(:,2);
a3_de=a_de(:,3);

% n=3,wj= 0.2429,0.5142,0.2429
% n=6,wj= 0.0865,0.1716,0.2419,0.2419,0.1716,0.0865
I(1)=1-((1-a1_de(1))^wj(1))*((1-a2_de(1))^wj(2))*((1-a3_de(1))^wj(3));
I(2)=(a1_de(2)^wj(1))*(a2_de(2)^wj(2))*(a3_de(2)^wj(3));
disp(I);
set(handles.listbox_i1_L,'string',num2str(I));

% i2,A2 2-2-2
a=handles.a2_de_L;
disp(a);
thi_11=str2num(handles.edit_thi_21_L.String);
thi_12=str2num(handles.edit_thi_22_L.String);
thi_13=str2num(handles.edit_thi_23_L.String);
% 这里交换数据
a_de(:,thi_11)=a(:,1);
a_de(:,thi_12)=a(:,2);
a_de(:,thi_13)=a(:,3);
disp(a_de);
a1_de=a_de(:,1);
a2_de=a_de(:,2);
a3_de=a_de(:,3);

I(1)=1-((1-a1_de(1))^wj(1))*((1-a2_de(1))^wj(2))*((1-a3_de(1))^wj(3));
I(2)=(a1_de(2)^wj(1))*(a2_de(2)^wj(2))*(a3_de(2)^wj(3));
disp(I);
set(handles.listbox_i2_L,'string',num2str(I));

% i3,A3 2-2-2
a=handles.a3_de_L;
disp(a);
thi_11=str2num(handles.edit_thi_31_L.String);
thi_12=str2num(handles.edit_thi_32_L.String);
thi_13=str2num(handles.edit_thi_33_L.String);
% 这里交换数据
a_de(:,thi_11)=a(:,1);
a_de(:,thi_12)=a(:,2);
a_de(:,thi_13)=a(:,3);
disp(a_de);
a1_de=a_de(:,1);
a2_de=a_de(:,2);
a3_de=a_de(:,3);

I(1)=1-((1-a1_de(1))^wj(1))*((1-a2_de(1))^wj(2))*((1-a3_de(1))^wj(3));
I(2)=(a1_de(2)^wj(1))*(a2_de(2)^wj(2))*(a3_de(2)^wj(3));
disp(I);
set(handles.listbox_i3_L,'string',num2str(I));

% i4,A4 2-2-2
a=handles.a4_de_L;
disp(a);
thi_11=str2num(handles.edit_thi_41_L.String);
thi_12=str2num(handles.edit_thi_42_L.String);
thi_13=str2num(handles.edit_thi_43_L.String);
% 这里交换数据
a_de(:,thi_11)=a(:,1);
a_de(:,thi_12)=a(:,2);
a_de(:,thi_13)=a(:,3);
disp(a_de);
a1_de=a_de(:,1);
a2_de=a_de(:,2);
a3_de=a_de(:,3);

I(1)=1-((1-a1_de(1))^wj(1))*((1-a2_de(1))^wj(2))*((1-a3_de(1))^wj(3));
I(2)=(a1_de(2)^wj(1))*(a2_de(2)^wj(2))*(a3_de(2)^wj(3));
disp(I);
set(handles.listbox_i4_L,'string',num2str(I));


% --- Executes on selection change in listbox_i2_L.
function listbox_i2_L_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i2_L contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i2_L


% --- Executes during object creation, after setting all properties.
function listbox_i2_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_i1_L.
function listbox_i1_L_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i1_L contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i1_L


% --- Executes during object creation, after setting all properties.
function listbox_i1_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_i3_L.
function listbox_i3_L_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i3_L contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i3_L


% --- Executes during object creation, after setting all properties.
function listbox_i3_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_i4_L.
function listbox_i4_L_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i4_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i4_L contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i4_L


% --- Executes during object creation, after setting all properties.
function listbox_i4_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i4_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_21_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_21_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_21_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_21_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_21_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_21_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_22_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_22_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_22_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_22_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_22_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_22_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_23_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_23_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_23_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_23_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_23_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_23_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_21_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_21_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_21_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_21_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_21_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_21_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_22_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_22_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_22_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_22_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_22_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_22_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_23_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_23_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_23_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_23_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_23_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_23_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_31_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_31_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_31_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_31_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_31_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_31_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_32_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_32_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_32_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_32_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_32_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_32_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_33_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_33_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_33_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_33_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_33_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_33_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_31_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_31_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_31_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_31_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_31_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_31_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_32_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_32_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_32_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_32_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_32_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_32_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_33_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_33_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_33_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_33_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_33_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_33_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_11_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_11_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_11_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_11_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_12_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_12_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_12_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_12_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_12_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_12_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_13_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_13_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_13_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_13_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_13_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_13_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_11_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_11_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_11_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_11_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_11_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_12_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_12_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_12_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_12_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_12_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_12_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_13_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_13_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_13_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_13_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_13_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_13_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Modify_thi_L.
function pushbutton_Modify_thi_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Modify_thi_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox("请手动输入调整大小顺序。");


function edit_s_41_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_41_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_41_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_41_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_41_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_41_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_42_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_42_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_42_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_42_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_42_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_42_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_43_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_43_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_43_L as text
%        str2double(get(hObject,'String')) returns contents of edit_s_43_L as a double


% --- Executes during object creation, after setting all properties.
function edit_s_43_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_43_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_41_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_41_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_41_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_41_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_41_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_41_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_42_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_42_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_42_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_42_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_42_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_42_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_43_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_43_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_43_L as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_43_L as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_43_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_43_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a14 as text
%        str2double(get(hObject,'String')) returns contents of edit_a14 as a double


% --- Executes during object creation, after setting all properties.
function edit_a14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a24_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a24 as text
%        str2double(get(hObject,'String')) returns contents of edit_a24 as a double


% --- Executes during object creation, after setting all properties.
function edit_a24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a34_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a34 as text
%        str2double(get(hObject,'String')) returns contents of edit_a34 as a double


% --- Executes during object creation, after setting all properties.
function edit_a34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a44_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a44 as text
%        str2double(get(hObject,'String')) returns contents of edit_a44 as a double


% --- Executes during object creation, after setting all properties.
function edit_a44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a15_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a15 as text
%        str2double(get(hObject,'String')) returns contents of edit_a15 as a double


% --- Executes during object creation, after setting all properties.
function edit_a15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a25_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a25 as text
%        str2double(get(hObject,'String')) returns contents of edit_a25 as a double


% --- Executes during object creation, after setting all properties.
function edit_a25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a35_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a35 as text
%        str2double(get(hObject,'String')) returns contents of edit_a35 as a double


% --- Executes during object creation, after setting all properties.
function edit_a35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a45_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a45 as text
%        str2double(get(hObject,'String')) returns contents of edit_a45 as a double


% --- Executes during object creation, after setting all properties.
function edit_a45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit233_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wj as text
%        str2double(get(hObject,'String')) returns contents of edit_wj as a double


% --- Executes during object creation, after setting all properties.
function edit233_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_wj.
function pushbutton_Caculate_wj_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_wj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox("由正态分布赋权法给出。");


% --- Executes on selection change in listbox_i2.
function listbox_i2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i2


% --- Executes during object creation, after setting all properties.
function listbox_i2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_i1.
function listbox_i1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i1


% --- Executes during object creation, after setting all properties.
function listbox_i1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_i3.
function listbox_i3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i3


% --- Executes during object creation, after setting all properties.
function listbox_i3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_i4.
function listbox_i4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_i4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_i4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_i4


% --- Executes during object creation, after setting all properties.
function listbox_i4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_i4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_I.
function pushbutton_Caculate_I_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_I (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp("开始计算：");
wj=str2num(handles.edit_wj.String);
% i1,A1 3-2-3
a1=handles.a1_de;
disp(a1);
thi_11=str2num(handles.edit_thi_11.String);
thi_12=str2num(handles.edit_thi_12.String);
thi_13=str2num(handles.edit_thi_13.String);
thi_14=str2num(handles.edit_thi_14.String);
thi_15=str2num(handles.edit_thi_15.String);
thi_16=str2num(handles.edit_thi_16.String);

% 这里交换数据
a1_de(:,thi_11)=a1(:,1);
disp(a1_de);
a1_de(:,thi_12)=a1(:,2);
a1_de(:,thi_13)=a1(:,3);
a1_de(:,thi_14)=a1(:,4);
a1_de(:,thi_15)=a1(:,5);
a1_de(:,thi_16)=a1(:,6);
disp(a1_de);

a11_de=a1_de(:,1);
a12_de=a1_de(:,2);
a13_de=a1_de(:,3);
a14_de=a1_de(:,4);
a15_de=a1_de(:,5);
a16_de=a1_de(:,6);

% I1(1)=1-((1-a11_de(1))^0.112)*((1-a12_de(1))^0.236)*((1-a13_de(1))^0.304)*((1-a14_de(1))^0.23)*((1-a15_de(1))^0.112);
% I1(2)=(a11_de(2)^0.112)*(a12_de(2)^0.236)*(a13_de(2)^0.304)*(a14_de(2)^0.236)*(a15_de(2)^0.112);
% 0.0865,0.1716,0.2419,0.2419,0.1716,0.0865
I1(1)=1-((1-a11_de(1))^wj(1))*((1-a12_de(1))^wj(2))*((1-a13_de(1))^wj(3))*((1-a14_de(1))^wj(4))*((1-a15_de(1))^wj(5))*((1-a16_de(1))^wj(6));
I1(2)=(a11_de(2)^wj(1))*(a12_de(2)^wj(2))*(a13_de(2)^wj(3))*(a14_de(2)^wj(4))*(a15_de(2)^wj(5))*(a16_de(2)^wj(6));
disp(I1);
set(handles.listbox_i1,'string',num2str(I1));

% i2,A1 3-2-3
a2=handles.a2_de;
thi_21=str2num(handles.edit_thi_21.String);
thi_22=str2num(handles.edit_thi_22.String);
thi_23=str2num(handles.edit_thi_23.String);
thi_24=str2num(handles.edit_thi_24.String);
thi_25=str2num(handles.edit_thi_25.String);
thi_26=str2num(handles.edit_thi_26.String);

% 这里交换数据
a2_de(:,thi_21)=a2(:,1);
a2_de(:,thi_22)=a2(:,2);
a2_de(:,thi_23)=a2(:,3);
a2_de(:,thi_24)=a2(:,4);
a2_de(:,thi_25)=a2(:,5);
a2_de(:,thi_26)=a2(:,6);
disp(a2_de);

a21_de=a2_de(:,1);
a22_de=a2_de(:,2);
a23_de=a2_de(:,3);
a24_de=a2_de(:,4);
a25_de=a2_de(:,5);
a26_de=a2_de(:,6);

I2(1)=1-((1-a21_de(1))^wj(1))*((1-a22_de(1))^wj(2))*((1-a23_de(1))^wj(3))*((1-a24_de(1))^wj(4))*((1-a25_de(1))^wj(5))*((1-a26_de(1))^wj(6));
I2(2)=(a21_de(2)^wj(1))*(a22_de(2)^wj(2))*(a23_de(2)^wj(3))*(a24_de(2)^wj(4))*(a25_de(2)^wj(5))*(a26_de(2)^wj(6));
disp(I2);
set(handles.listbox_i2,'string',num2str(I2));

% i3,A1 3-2-3
a3=handles.a3_de;
thi_31=str2num(handles.edit_thi_31.String);
thi_32=str2num(handles.edit_thi_32.String);
thi_33=str2num(handles.edit_thi_33.String);
thi_34=str2num(handles.edit_thi_34.String);
thi_35=str2num(handles.edit_thi_35.String);
thi_36=str2num(handles.edit_thi_36.String);

% 这里交换数据
a3_de(:,thi_31)=a3(:,1);
a3_de(:,thi_32)=a3(:,2);
a3_de(:,thi_33)=a3(:,3);
a3_de(:,thi_34)=a3(:,4);
a3_de(:,thi_35)=a3(:,5);
a3_de(:,thi_36)=a3(:,6);
disp(a3_de);

a31_de=a3_de(:,1);
a32_de=a3_de(:,2);
a33_de=a3_de(:,3);
a34_de=a3_de(:,4);
a35_de=a3_de(:,5);
a36_de=a3_de(:,6);

I3(1)=1-((1-a31_de(1))^wj(1))*((1-a32_de(1))^wj(2))*((1-a33_de(1))^wj(3))*((1-a34_de(1))^wj(4))*((1-a35_de(1))^wj(5))*((1-a36_de(1))^wj(6));
I3(2)=(a31_de(2)^wj(1))*(a32_de(2)^wj(2))*(a33_de(2)^wj(3))*(a34_de(2)^wj(4))*(a35_de(2)^wj(5))*(a36_de(2)^wj(6));
disp(I3);
set(handles.listbox_i3,'string',num2str(I3));

% i4,A4 2-2-2-2-2
a4=handles.a4_de;
thi_41=str2num(handles.edit_thi_41.String);
thi_42=str2num(handles.edit_thi_42.String);
thi_43=str2num(handles.edit_thi_43.String);
thi_44=str2num(handles.edit_thi_44.String);
thi_45=str2num(handles.edit_thi_45.String);
thi_46=str2num(handles.edit_thi_46.String);

% 这里交换数据
a4_de(:,thi_41)=a4(:,1);
a4_de(:,thi_42)=a4(:,2);
a4_de(:,thi_43)=a4(:,3);
a4_de(:,thi_44)=a4(:,4);
a4_de(:,thi_45)=a4(:,5);
a4_de(:,thi_46)=a4(:,6);
disp(a4_de);

a41_de=a4_de(:,1);
a42_de=a4_de(:,2);
a43_de=a4_de(:,3);
a44_de=a4_de(:,4);
a45_de=a4_de(:,5);
a46_de=a4_de(:,6);

I4(1)=1-((1-a41_de(1))^wj(1))*((1-a42_de(1))^wj(2))*((1-a43_de(1))^wj(3))*((1-a44_de(1))^wj(4))*((1-a45_de(1))^wj(5))*((1-a46_de(1))^wj(6));
I4(2)=(a41_de(2)^wj(1))*(a42_de(2)^wj(2))*(a43_de(2)^wj(3))*(a44_de(2)^wj(4))*(a45_de(2)^wj(5))*(a46_de(2)^wj(6));
disp(I4);
set(handles.listbox_i4,'string',num2str(I4));


% --- Executes on button press in Caculate_IFDM_wi.
function Caculate_IFDM_wi_Callback(hObject, eventdata, handles)
% hObject    handle to Caculate_IFDM_wi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%wi
wi=str2num(handles.edit_wi.String);
disp(wi(1));

% A1
a11=str2num(handles.edit_a11.String);
a12=str2num(handles.edit_a12.String);
a13=str2num(handles.edit_a13.String);
a14=str2num(handles.edit_a14.String);
a15=str2num(handles.edit_a15.String);
a16=str2num(handles.edit_a16.String);
a11_de(1)=1-(1-a11(1))^(6*wi(1));
a11_de(2)=a11(2)^(6*wi(1));
a12_de(1)=1-(1-a12(1))^(6*wi(2));
a12_de(2)=a12(2)^(6*wi(2));
a13_de(1)=1-(1-a13(1))^(6*wi(3));
a13_de(2)=a13(2)^(6*wi(3));
a14_de(1)=1-(1-a14(1))^(6*wi(4));
a14_de(2)=a14(2)^(6*wi(4));
a15_de(1)=1-(1-a15(1))^(6*wi(5));
a15_de(2)=a15(2)^(6*wi(5));
a16_de(1)=1-(1-a16(1))^(6*wi(6));
a16_de(2)=a16(2)^(6*wi(6));
set(handles.edit_a11,'string',num2str(a11_de));
set(handles.edit_a12,'string',num2str(a12_de));
set(handles.edit_a13,'string',num2str(a13_de));
set(handles.edit_a14,'string',num2str(a14_de));
set(handles.edit_a15,'string',num2str(a15_de));
set(handles.edit_a16,'string',num2str(a16_de));

handles.a1=[a11',a12',a13',a14',a15',a16'];
handles.a1_de=[a11_de',a12_de',a13_de',a14_de',a15_de',a16_de'];

% A2
a21=str2num(handles.edit_a21.String);
a22=str2num(handles.edit_a22.String);
a23=str2num(handles.edit_a23.String);
a24=str2num(handles.edit_a24.String);
a25=str2num(handles.edit_a25.String);
a26=str2num(handles.edit_a26.String);
a21_de(1)=1-(1-a21(1))^(6*wi(1));
a21_de(2)=a21(2)^(6*wi(1));
a22_de(1)=1-(1-a22(1))^(6*wi(2));
a22_de(2)=a22(2)^(6*wi(2));
a23_de(1)=1-(1-a23(1))^(6*wi(3));
a23_de(2)=a23(2)^(6*wi(3));
a24_de(1)=1-(1-a24(1))^(6*wi(4));
a24_de(2)=a24(2)^(6*wi(4));
a25_de(1)=1-(1-a25(1))^(6*wi(5));
a25_de(2)=a25(2)^(6*wi(5));
a26_de(1)=1-(1-a26(1))^(6*wi(6));
a26_de(2)=a26(2)^(6*wi(6));
set(handles.edit_a21,'string',num2str(a21_de));
set(handles.edit_a22,'string',num2str(a22_de));
set(handles.edit_a23,'string',num2str(a23_de));
set(handles.edit_a24,'string',num2str(a24_de));
set(handles.edit_a25,'string',num2str(a25_de));
set(handles.edit_a26,'string',num2str(a26_de));
handles.a2=[a21',a22',a23',a24',a25',a26'];
handles.a2_de=[a21_de',a22_de',a23_de',a24_de',a25_de',a26_de'];

% A3
a31=str2num(handles.edit_a31.String);
a32=str2num(handles.edit_a32.String);
a33=str2num(handles.edit_a33.String);
a34=str2num(handles.edit_a34.String);
a35=str2num(handles.edit_a35.String);
a36=str2num(handles.edit_a36.String);
a31_de(1)=1-(1-a31(1))^(6*wi(1));
a31_de(2)=a31(2)^(6*wi(1));
a32_de(1)=1-(1-a32(1))^(6*wi(2));
a32_de(2)=a32(2)^(6*wi(2));
a33_de(1)=1-(1-a33(1))^(6*wi(3));
a33_de(2)=a33(2)^(6*wi(3));
a34_de(1)=1-(1-a34(1))^(6*wi(4));
a34_de(2)=a34(2)^(6*wi(4));
a35_de(1)=1-(1-a35(1))^(6*wi(5));
a35_de(2)=a35(2)^(6*wi(5));
a36_de(1)=1-(1-a36(1))^(6*wi(6));
a36_de(2)=a36(2)^(6*wi(6));
set(handles.edit_a31,'string',num2str(a31_de));
set(handles.edit_a32,'string',num2str(a32_de));
set(handles.edit_a33,'string',num2str(a33_de));
set(handles.edit_a34,'string',num2str(a34_de));
set(handles.edit_a35,'string',num2str(a35_de));
set(handles.edit_a36,'string',num2str(a36_de));
handles.a3=[a31',a32',a33',a34',a35',a36'];
handles.a3_de=[a31_de',a32_de',a33_de',a34_de',a35_de',a36_de'];

% A4
a41=str2num(handles.edit_a41.String);
a42=str2num(handles.edit_a42.String);
a43=str2num(handles.edit_a43.String);
a44=str2num(handles.edit_a44.String);
a45=str2num(handles.edit_a45.String);
a46=str2num(handles.edit_a46.String);
a41_de(1)=1-(1-a41(1))^(6*wi(1));
a41_de(2)=a41(2)^(6*wi(1));
a42_de(1)=1-(1-a42(1))^(6*wi(2));
a42_de(2)=a42(2)^(6*wi(2));
a43_de(1)=1-(1-a43(1))^(6*wi(3));
a43_de(2)=a43(2)^(6*wi(3));
a44_de(1)=1-(1-a44(1))^(6*wi(4));
a44_de(2)=a44(2)^(6*wi(4));
a45_de(1)=1-(1-a45(1))^(6*wi(5));
a45_de(2)=a45(2)^(6*wi(5));
a46_de(1)=1-(1-a46(1))^(6*wi(6));
a46_de(2)=a46(2)^(6*wi(6));
set(handles.edit_a41,'string',num2str(a41_de));
set(handles.edit_a42,'string',num2str(a42_de));
set(handles.edit_a43,'string',num2str(a43_de));
set(handles.edit_a44,'string',num2str(a44_de));
set(handles.edit_a45,'string',num2str(a45_de));
set(handles.edit_a46,'string',num2str(a46_de));
handles.a4=[a41',a42',a43',a44',a45',a46'];
handles.a4_de=[a41_de',a42_de',a43_de',a44_de',a45_de',a46_de'];

guidata(hObject, handles);
disp("加权完成。");


% --- Executes on button press in pushbutton_Display_IFDM.
function pushbutton_Display_IFDM_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Display_IFDM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1=handles.a1;
set(handles.edit_a11,'string',num2str(a1(:,1)'));
set(handles.edit_a12,'string',num2str(a1(:,2)'));
set(handles.edit_a13,'string',num2str(a1(:,3)'));
set(handles.edit_a14,'string',num2str(a1(:,4)'));
set(handles.edit_a15,'string',num2str(a1(:,5)'));
set(handles.edit_a16,'string',num2str(a1(:,6)'));

a2=handles.a2;
set(handles.edit_a21,'string',num2str(a2(:,1)'));
set(handles.edit_a22,'string',num2str(a2(:,2)'));
set(handles.edit_a23,'string',num2str(a2(:,3)'));
set(handles.edit_a24,'string',num2str(a2(:,4)'));
set(handles.edit_a25,'string',num2str(a2(:,5)'));
set(handles.edit_a26,'string',num2str(a2(:,6)'));

a3=handles.a3;
set(handles.edit_a31,'string',num2str(a3(:,1)'));
set(handles.edit_a32,'string',num2str(a3(:,2)'));
set(handles.edit_a33,'string',num2str(a3(:,3)'));
set(handles.edit_a34,'string',num2str(a3(:,4)'));
set(handles.edit_a35,'string',num2str(a3(:,5)'));
set(handles.edit_a36,'string',num2str(a3(:,6)'));

a4=handles.a4;
set(handles.edit_a41,'string',num2str(a4(:,1)'));
set(handles.edit_a42,'string',num2str(a4(:,2)'));
set(handles.edit_a43,'string',num2str(a4(:,3)'));
set(handles.edit_a44,'string',num2str(a4(:,4)'));
set(handles.edit_a45,'string',num2str(a4(:,5)'));
set(handles.edit_a46,'string',num2str(a4(:,6)'));

disp("还原完成。");


function edit_s_11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_11 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_11 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_13_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_13 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_13 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_14 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_14 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_15_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_15 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_15 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_14_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_14 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_14 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_14_CreateFcn(hObject, ~, handles)
% hObject    handle to edit_thi_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_thi_15_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_15 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_15 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_22 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_22 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_23 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_23 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_24_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_24 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_24 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_25_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_25 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_25 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_24_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_24 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_24 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_25_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_25 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_25 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s_31_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_31 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_31 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_32_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_32 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_32 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_33_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_33 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_33 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_34_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_34 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_34 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_35_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_35 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_35 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_34_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_34 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_34 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_35_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_35 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_35 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_41_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_41 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_41 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_42_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_42 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_42 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_43_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_43 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_43 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_44_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_44 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_44 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_45_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_45 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_45 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_44_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_44 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_44 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_45_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_45 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_45 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_s_de.
function pushbutton_Caculate_s_de_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s_de (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i1=str2num(handles.listbox_i1.String);
i2=str2num(handles.listbox_i2.String);
i3=str2num(handles.listbox_i3.String);
i4=str2num(handles.listbox_i4.String);

s_i1=i1(1)-i1(2);
disp(s_i1);
s_i2=i2(1)-i2(2);
s_i3=i3(1)-i3(2);
s_i4=i4(1)-i4(2);
set(handles.edit_s_i1,'string',s_i1);
set(handles.edit_s_i2,'string',s_i2);
set(handles.edit_s_i3,'string',s_i3);
set(handles.edit_s_i4,'string',s_i4);


function edit_a16_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a16 as text
%        str2double(get(hObject,'String')) returns contents of edit_a16 as a double


% --- Executes during object creation, after setting all properties.
function edit_a16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a26_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a26 as text
%        str2double(get(hObject,'String')) returns contents of edit_a26 as a double


% --- Executes during object creation, after setting all properties.
function edit_a26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a36_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a36 as text
%        str2double(get(hObject,'String')) returns contents of edit_a36 as a double


% --- Executes during object creation, after setting all properties.
function edit_a36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_a46_Callback(hObject, ~, handles)
% hObject    handle to edit_a46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a46 as text
%        str2double(get(hObject,'String')) returns contents of edit_a46 as a double


% --- Executes during object creation, after setting all properties.
function edit_a46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_16_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_16 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_16 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_16_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_16 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_16 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_26_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_26 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_26 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_26_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_26 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_26 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_36_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_36 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_36 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_36_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_36 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_36 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_s_46_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s_46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s_46 as text
%        str2double(get(hObject,'String')) returns contents of edit_s_46 as a double


% --- Executes during object creation, after setting all properties.
function edit_s_46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s_46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_thi_46_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thi_46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thi_46 as text
%        str2double(get(hObject,'String')) returns contents of edit_thi_46 as a double


% --- Executes during object creation, after setting all properties.
function edit_thi_46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thi_46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Caculate_IFDM_wi_L.
function pushbutton_Caculate_IFDM_wi_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_IFDM_wi_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%wi
wi=str2num(handles.edit_wi_L.String);
disp(wi(1));

% A1
a11=str2num(handles.edit_a11_L.String);
a12=str2num(handles.edit_a12_L.String);
a13=str2num(handles.edit_a13_L.String);
a11_de(1)=1-(1-a11(1))^(3*wi(1));
a11_de(2)=a11(2)^(3*wi(1));
a12_de(1)=1-(1-a12(1))^(3*wi(2));
a12_de(2)=a12(2)^(3*wi(2));
a13_de(1)=1-(1-a13(1))^(3*wi(3));
a13_de(2)=a13(2)^(3*wi(3));
set(handles.edit_a11_L,'string',num2str(a11_de));
set(handles.edit_a12_L,'string',num2str(a12_de));
set(handles.edit_a13_L,'string',num2str(a13_de));

handles.a1_L=[a11',a12',a13'];
handles.a1_de_L=[a11_de',a12_de',a13_de'];

% A2
a21=str2num(handles.edit_a21_L.String);
a22=str2num(handles.edit_a22_L.String);
a23=str2num(handles.edit_a23_L.String);
a21_de(1)=1-(1-a21(1))^(3*wi(1));
a21_de(2)=a21(2)^(3*wi(1));
a22_de(1)=1-(1-a22(1))^(3*wi(2));
a22_de(2)=a22(2)^(3*wi(2));
a23_de(1)=1-(1-a23(1))^(3*wi(3));
a23_de(2)=a23(2)^(3*wi(3));
set(handles.edit_a21_L,'string',num2str(a21_de));
set(handles.edit_a22_L,'string',num2str(a22_de));
set(handles.edit_a23_L,'string',num2str(a23_de));
handles.a2_L=[a21',a22',a23'];
handles.a2_de_L=[a21_de',a22_de',a23_de'];

% A3
a31=str2num(handles.edit_a31_L.String);
a32=str2num(handles.edit_a32_L.String);
a33=str2num(handles.edit_a33_L.String);
a31_de(1)=1-(1-a31(1))^(3*wi(1));
a31_de(2)=a31(2)^(3*wi(1));
a32_de(1)=1-(1-a32(1))^(3*wi(2));
a32_de(2)=a32(2)^(3*wi(2));
a33_de(1)=1-(1-a33(1))^(3*wi(3));
a33_de(2)=a33(2)^(3*wi(3));
set(handles.edit_a31_L,'string',num2str(a31_de));
set(handles.edit_a32_L,'string',num2str(a32_de));
set(handles.edit_a33_L,'string',num2str(a33_de));
handles.a3_L=[a31',a32',a33'];
handles.a3_de_L=[a31_de',a32_de',a33_de'];

% A4
a41=str2num(handles.edit_a41_L.String);
a42=str2num(handles.edit_a42_L.String);
a43=str2num(handles.edit_a43_L.String);
a41_de(1)=1-(1-a41(1))^(3*wi(1));
a41_de(2)=a41(2)^(3*wi(1));
a42_de(1)=1-(1-a42(1))^(3*wi(2));
a42_de(2)=a42(2)^(3*wi(2));
a43_de(1)=1-(1-a43(1))^(3*wi(3));
a43_de(2)=a43(2)^(3*wi(3));
set(handles.edit_a41_L,'string',num2str(a41_de));
set(handles.edit_a42_L,'string',num2str(a42_de));
set(handles.edit_a43_L,'string',num2str(a43_de));
handles.a4_L=[a41',a42',a43'];
handles.a4_de_L=[a41_de',a42_de',a43_de'];

guidata(hObject, handles);
disp("加权完成。");


% --- Executes on button press in pushbutton_Display_IFDM_L.
function pushbutton_Display_IFDM_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Display_IFDM_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1=handles.a1_L;
set(handles.edit_a11_L,'string',num2str(a1(:,1)'));
set(handles.edit_a12_L,'string',num2str(a1(:,2)'));
set(handles.edit_a13_L,'string',num2str(a1(:,3)'));

a2=handles.a2_L;
set(handles.edit_a21_L,'string',num2str(a2(:,1)'));
set(handles.edit_a22_L,'string',num2str(a2(:,2)'));
set(handles.edit_a23_L,'string',num2str(a2(:,3)'));

a3=handles.a3_L;
set(handles.edit_a31_L,'string',num2str(a3(:,1)'));
set(handles.edit_a32_L,'string',num2str(a3(:,2)'));
set(handles.edit_a33_L,'string',num2str(a3(:,3)'));

a4=handles.a4_L;
set(handles.edit_a41_L,'string',num2str(a4(:,1)'));
set(handles.edit_a42_L,'string',num2str(a4(:,2)'));
set(handles.edit_a43_L,'string',num2str(a4(:,3)'));

% guidata(hObject, handles);
disp(a1);
disp(a2);
disp(a3);
disp(a4);
disp("原始数据还原完成。");


% --- Executes on button press in pushbutton_Caculate_s_de_L.
function pushbutton_Caculate_s_de_L_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Caculate_s_de_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i1=str2num(handles.listbox_i1_L.String);
i2=str2num(handles.listbox_i2_L.String);
i3=str2num(handles.listbox_i3_L.String);
i4=str2num(handles.listbox_i4_L.String);

s_i1=i1(1)-i1(2);
disp(s_i1);
s_i2=i2(1)-i2(2);
s_i3=i3(1)-i3(2);
s_i4=i4(1)-i4(2);
set(handles.edit_s_i1_L,'string',s_i1);
set(handles.edit_s_i2_L,'string',s_i2);
set(handles.edit_s_i3_L,'string',s_i3);
set(handles.edit_s_i4_L,'string',s_i4);

