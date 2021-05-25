clear()
clc()

width = 300;
height = 550;
plot_w = 600;
plot_h = height;
margin_x = 15;
margin_y = 15;

defaultfont = "ariel";
axes_w = 3*margin_x + width + plot_w;
axes_h = 2*margin_y + height;

data=csvRead("BLDC_Data_Log.csv",[],[],"double");
[n1,n2] = size(data);

UI = scf(100);
UI.background = -2;
UI.figure_position = [100 100];
UI.figure_name = gettext("BLDC Controller");

UI.axes_size = [axes_w axes_h];

delmenu(UI.figure_id,gettext("&File"));
delmenu(UI.figure_id,gettext("&Tools"));
delmenu(UI.figure_id,gettext("&Edit"));
delmenu(UI.figure_id,gettext("&Edit"));
delmenu(UI.figure_id,gettext("&?"));
delmenu(UI.figure_id,"off");

command_frame = uicontrol("parent",UI, "relief","groove", ...
    "style","frame","units","pixels",...
    "position",[ margin_x margin_y width/2 height], ...
    "horizontalalignment","center","background",[1 1 1], ...
    "tag","frame_control");
    
//command_frame_title = uicontrol("parent",UI, "style","text", ...
//"string","BLDC Control", "units","pixels", ...
//"position",[axes_w/2 margin_y width-60 20], ...
//"fontname",defaultfont, "fontunits","points", ...
//"fontsize",16, "horizontalalignment","center", ...
//"background",[1 1 1], "tag","title_frame_control"); 

loc_y = 530
size_y = 25
rb1 = uicontrol(UI, "style", "radiobutton", "string", "Commutation Period", "position", [30 loc_y-(size_y*0) 130 size_y], "groupname", "group1");
rb2 = uicontrol(UI, "style", "radiobutton", "string", "Duty Cycle", "position", [30 loc_y-(size_y*1) 100 size_y], "groupname", "group1");
rb3 = uicontrol(UI, "style", "radiobutton", "string", "VSystem", "position", [30 loc_y-(size_y*2) 100 size_y], "groupname", "group1");
rb4 = uicontrol(UI, "style", "radiobutton", "string", "Back EMF Rising", "position", [30 loc_y-(size_y*3) 100 size_y], "groupname", "group1");
rb5 = uicontrol(UI, "style", "radiobutton", "string", "Back EMF Falling", "position", [30 loc_y-(size_y*4) 100 size_y], "groupname", "group1");
rb6 = uicontrol(UI, "style", "radiobutton", "string", "UI Speed", "position", [30 loc_y-(size_y*5) 100 size_y], "groupname", "group1");



huibutton1 = uicontrol(UI, "style","pushbutton", ...
"Position",[30 loc_y-(size_y*6) 100 20], "String","Plot", ...
"BackgroundColor",[.9 .9 .9], "fontsize",14, ...
"Callback","plot_graph");

function plot_graph()
    drawlater();
    newaxes();
    calculate_graph();
    drawnow();
    
endfunction

function calculate_graph()
    delete(gca());
    set(gca(),"auto_clear","on");
    my_plot_axes = gca();
    
    if rb1.value == 1 then 
        plot([1:1:n1],data(:,1))
        my_plot_axes.title.text = "Commutation Period";
    elseif rb2.value == 1 then 
        plot([1:1:n1],data(:,2))
        my_plot_axes.title.text = "Duty Cycle";
    elseif rb3.value == 1 then 
        plot([1:1:n1],data(:,3))
        my_plot_axes.title.text = "VSystem";
    elseif rb4.value == 1 then 
        plot([1:1:n1],data(:,4))
        my_plot_axes.title.text = "Back EMF Rising";
    elseif rb5.value == 1 then 
        plot([1:1:n1],data(:,5))
        my_plot_axes.title.text = "Back EMF Falling";
    elseif rb6.value == 1 then 
        plot([1:1:n1],data(:,6))
        my_plot_axes.title.text = "UI Speed";
    end
    
    my_plot_axes.title.font_size = 5;
    my_plot_axes.axes_bounds = [1/10,0,1,1];
    
endfunction
