from matplotlib import pyplot as plt
import numpy as np
import serial
import threading
from guizero import App, Window, Text, TextBox, Slider, PushButton
import time
import csv
import subprocess

ser = serial.Serial ("/dev/ttyS0", 38400)

Flag = False
#Plot_Flag = False
commutation_buffer = []
duty_cycle_buffer = []
vsystem_buffer = []
back_emf_rising_buffer = []
back_emf_falling_buffer = []
ui_speed_buffer = []
analog_slider_buffer = []
data_buffer = [commutation_buffer, duty_cycle_buffer, vsystem_buffer,
               back_emf_rising_buffer, back_emf_falling_buffer, ui_speed_buffer,
               analog_slider_buffer]

class dataThread(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)

    def run(self):
        global Flag
        
        while True:
            if Flag:
                
                collect_data()
                #Flag = False #ONE SHOT FLAG
            else:
                time.sleep(.02) #free up processor time by sleeping the thread

thread1 = dataThread()

thread1.start()

#THREAD FUNTIONS

def collect_data():
    global Plot_Flag
    
    find_frame()
    load_data_buffer()
    #if(Plot_Flag):
    #    update_plot()
        
    display_data()
    log_data()

def set_up_data_log():
    with open("BLDC_Data_Log.csv",'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(["Commutation Period", "Duty Cycle", "VSystem",
                         "Back EMF Rising", "Back EMF Falling", "UI Speed"])
        
def log_data():
    global data_buffer
    with open("BLDC_Data_Log.csv",'a', newline='') as f:
        #counter = 1
        buffer = []
        writer = csv.writer(f)
        for x in data_buffer:
            buffer.append(x[-1])
        writer.writerow(buffer)
        #for x in data_buffer:
        #    f.write(str(x[-1]) + ', ')
        #f.write('\n')
        
def find_frame():
    frame_flag = True
    SOF = 165 #hex 0xA5
    
    ser.flushInput()
    while(frame_flag):
        value = ord(ser.read())
        if(value == SOF):
            frame_flag = 0

def load_data_buffer():
    global data_buffer
    key_index = 0
    read = 0
    value = 0
 
    data_key = [2,2,2,2,2,2,2]
    
    for x in data_buffer:
        for k in range(data_key[key_index] - 1, -1, -1): 
            read = ord(ser.read())
            read = read << (k * 8)
            value += read
        x.append(value)
        if (len(x) > int(text_box_data_window.value)):
            x.pop(0)
        key_index += 1
        value = 0
        

def display_data():
    global data_buffer
    global text_box_array

    count = 0
    for x in text_box_array:
        x.value = data_buffer[count][-1]
        #x.value = data_buffer[count]
        count += 1

#def update_plot():
#    plt.draw()

#GUI FUNCTIONS

def start_log():
    global Flag
    print("Start Log")
    set_up_data_log()
    Flag = True

def stop_log():
    global Flag
    Flag = False
    subprocess.run(["scp", "BLDC_Data_Log.csv", "pi@192.168.254.22:/home/pi"])
    subprocess.run(["scp", "BLDC_Data_Log.csv", "jshearer@FWA002523:C:"])
    print("Stop Log")

def change_slider():
    ser.flushOutput()
    ser.write(slider_analog_slider.value.to_bytes(1,'big'))

def plot_data(title, name, value):
    #global Plot_Flag
    
    x_indexes = np.arange(len(data_buffer[value]))
    
    plt.plot(x_indexes, data_buffer[value])
    
    plt.xlabel('Data Sample')
    plt.ylabel(name)
    plt.title(title)

    plt.grid(True)

    #Plot_Flag = True
    
    plt.show()

def clear_data():
    global commutation_buffer
    global duty_cycle_buffer
    global vsystem_buffer
    global back_emf_rising_buffer
    global ui_speed_buffer
    global analog_slider_buffer

    commutation_buffer.clear()
    duty_cycle_buffer.clear()
    vsystem_buffer.clear()
    back_emf_rising_buffer.clear()
    back_emf_falling_buffer.clear()
    ui_speed_buffer.clear()
    analog_slider_buffer.clear()
    
app = App(title="BLDC Data Logger", layout="grid")

#Setup text
text_commutation = Text(app, text="Commutation Period", grid=[0,1])
text_duty_cycle = Text(app, text="Duty Cycle", grid=[0,2])
text_vsystem = Text(app, text="V System", grid=[0,3])
text_back_emf_rising = Text(app, text="Back EMF Rising", grid=[0,4])
text_back_emf_falling = Text(app, text="Back EMF Falling", grid=[0,5])
text_ui_speed = Text(app, text="UI Speed", grid=[0,6])
text_analog_slider = Text(app, text="Analog Slider", grid=[0,7])

text_data_window = Text(app, text="Data Window: ", grid=[0,8])

#Setup textbox
text_box_commutation = TextBox(app, text = "0", width = 5, grid=[1,1])
text_box_duty_cycle = TextBox(app, text = "0", width = 5, grid=[1,2])
text_box_vsystem = TextBox(app, text = "0", width = 5, grid=[1,3])
text_box_back_emf_rising = TextBox(app, text = "0", width = 5, grid=[1,4])
text_box_back_emf_falling = TextBox(app, text = "0", width = 5, grid=[1,5])
text_box_ui_speed = TextBox(app, text = "0", width = 5, grid=[1,6])
text_box_analog_slider = TextBox(app, text = "0", width = 5, grid=[1,7])

text_box_data_window = TextBox(app, text = "100",command=clear_data, width = 5, grid=[1,8])

text_box_array = [text_box_commutation, text_box_duty_cycle, text_box_vsystem,
                  text_box_back_emf_rising, text_box_back_emf_falling,
                  text_box_ui_speed, text_box_analog_slider]

#Setup slider
slider_analog_slider = Slider(app, start=0, end=8,grid=[2,7], command=change_slider)

#Setup pushbutton
push_button_start = PushButton(app, text = "Start", command=start_log, grid=[0,9])
push_button_stop = PushButton(app, text = "Stop", command=stop_log, grid=[1,9])
push_button_clear_data = PushButton(app, text = "Clear Data", command=clear_data, grid=[2,9])

push_button_commutation_plot = PushButton(app, text = "Plot", args = ["Commutation Period Plot", "Commutation Period", 0], command=plot_data, grid=[2,1])
push_button_duty_cycle_plot = PushButton(app, text = "Plot", args = ["Duty Cycle Plot", "Duty Cycle", 1], command=plot_data, grid=[2,2])
push_button_vsystem_plot = PushButton(app, text = "Plot", args = ["V System Plot", "V System", 2], command=plot_data, grid=[2,3])
push_button_back_emf_rising_plot = PushButton(app, text = "Plot", args = ["Back EMF Rising Plot", "Back EMF Rising", 3], command=plot_data, grid=[2,4])
push_button_back_emf_falling_plot = PushButton(app, text = "Plot", args = ["Back EMF Falling Plot", "Back EMF Falling", 4], command=plot_data, grid=[2,5])

app.display()
