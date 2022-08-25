-- "GFX-SEQ" v1.01
--  Graphic-Pattern Sequencer 
--  by deeg
--
-- @deeg_deeg_deeg
--
-- github.com/deeg-deeg-deeg
--
-- ENC 1: assignable via 
--        parameter
--        "ENC 01 FUNCT"
-- ENC 2: choose parameter
-- ENC 3: change selected 
--        parameter
--
-- KEY 2: switch between
--        screens
-- KEY 3: reset "y" value to 0
--          
--
--
--
--
include "gfx-seq/lib/gfx"
include "gfx-seq/lib/deeg_utils"
include "gfx-seq/lib/deeg_lfo"

MusicUtil = require("musicutil")
engine.name = 'Bells'

--////// MIDI / OSC SETUP /////

midi_chan = 1
osc_dest =  {"192.168.1.3",9001}

--////// MIDI / OSC SETUP /////


-- VARIABLES --

gfx = {}

 for x=0,127 do
   gfx[x] = {}
    for y=0,64 do
     gfx[x][y] = 0
    end
 end

se_mode = 1
  
whereamI = 1
divider = 44
modifier = 1
scale = 1
move_y = 1
move_x = 0
speed = 30
row = 1
selections = 30
gfxmode = 1
osc_on = 1
min_note = 0
max_note = 127
screen_change = 1
midi_send = 1
midi_sleep = 1

lfo02_amount = 1
lfo01_amount = 0

notemiss = 1
note_count = 1
tick = 1

x_arr_03 = {}

for i=1, 127 do
      x_arr_03[i] = 0
end

y_arr_03 = {}

for i=1, 64 do
      y_arr_03[i] = 0
end

time_counter = 0
time_ping = 0

s_mode = {"MUSICBOX","GRID"}

-- LFO VARIABLES

sine_val = 0
period = 1
period_delta = 0.2
freq = 0.01
amplitude = 40

sine_valb = 0
periodb = 1
period_deltab = 0.1
freqb = 0.01
amplitudeb = 40

lfotype1 = 1
lfotype2 = 1

whereamI2 = 1

scr3_y = {15,49,49}
scr3_x = {25,25,93}
scr3_i = {"-", "-", "o"}

menu_a = {":", ".", ".:", ":", ".", ".:"}
menu_names = {"LABEL","LABEL","LABEL","LABEL","LABEL","LABEL","LABEL","LABEL"}
lfo_labels = {"SIN", "TRI", "SQR", "S&H","TAN"}
para_labels = {"lfot1", "peri1", "ampl1","lfot2", "peri2", "ampl2"}
para_deltas2 = {1,0.01,1,1,0.01,1}


y_arr = {}

for i=1, 50 do
      y_arr[i] = 0
end

y_arr2 = {}

for j=1, 50 do
      y_arr2[j] = 0
end

seq_array = {}

for j=1, 64 do
      seq_array[j] = 0
end

-- LFO VARIABLES END
-- INTRO VAR

gfx_intro = {}

 for x=0,127 do
   gfx_intro[x] = {}
    for y=0,64 do
     gfx_intro[x][y] = 0
    end
 end

firsttime = true 
dist = 0
radius = 1


-- INTRO VAR END

-- SECOND SEQ MODE VARS
pot = 1
pot_b = 1
sel = 1
se_x = 30
se_y = 30
x_cnt = 1
y_cnt = 1
re_cnt = 1
se_counter = 0
loop_cnt = 1

gfx_update = true
rnd_lvl = {}
for i=1,10 do
  rnd_lvl[i] = math.random(1,12)
end


------ MIDI

midi_device = {} -- container for connected midi devices
midi_device_names = {}
target = 1


  for i = 1,#midi.vports do -- query all ports
    midi_device[i] = midi.connect(i) -- connect each device
    table.insert( -- register its name:
      midi_device_names, -- table to insert to
      "port "..i..": "..util.trim_string_to_width(midi_device[i].name,80) -- value to insert
    )
  end
  
------



se_para_labels = {"se_length", "se_mode"}
mode_dis = {"A","B"}
mode_dir = {"HORIZ","VERTIC"}
-- END

para_names = {"divider","modi", "scaler", "xoff", "xrow", "minn", "maxn", "loss", "speedval","noteleave","gfx_mode", "osc_on", "root_note", "note_scale", "scale_on", "lfo01target","lfo01amnt", "lfo02target","lfo02amnt","midisend", "midisleep", "wwidth", "woff", "encone", "scandir", "yheight", "se_on", "e_on", "e_release", "e_pw"
  }


screen_names = {"PATTERN", "MODIFY", "SCALING",  "X-OFFSET", "SCAN ROW", "MIN NOTE", "MAX NOTE", "NOTE LOSS CHANCE", "SPEED", "PLAY EVERY NTH NOTE","GFX MODE", "SEND VIA OSC", "ROOT", "SCALE", "SCALE ACTIVE", "LFO 01 TARGET", "LFO 01 AMOUNT",  "LFO 02 TARGET","LFO 02 AMOUNT", "SEND MIDI", "MIDI SLEEP",
  "WIDTH", "WIDTH OFFSET", "ENC 01 FUNCT", "SCAN DIRECTION","Y-HEIGHT", "MODE", "ENGINE", "ENGINE RELEASE", "ENGINE WIDTH"
               }
               
menu_of = {"OFF", "ON"}               

para_deltas ={ 1, 1, 1, 0.1, 1, 1, 1, 1, 1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0.01,10,1}

lfo1_target_list = {0,0,0,0,0,0,0,0,0,0,0}
lfo2_target_list = {0,0,0,0,0,0,0,0,0,0,0}
lfo1_target_names = {"PATTERN","MODIFY","SCALING","X-OFFSET","SCAN ROW","MIN NOTE","MAX NOTE", "NOTE LOSS", "SPEED","WIDTH OFF","PLAY Nth NOTE"}
lfo1_target = 0
lfo2_target = 0
lfo_val = 1
lfo_val2 = 1

mode = {"gfx_mode01","gfx_mode02","gfx_mode03","gfx_mode04","gfx_mode05","gfx_mode06","gfx_mode07","gfx_mode08","gfx_mode09","gfx_mode10","gfx_mode11","gfx_mode12","gfx_mode13","gfx_mode14","gfx_mode15","gfx_mode16","gfx_mode17","gfx_mode18","gfx_mode19","gfx_mode20"}

scale_names = {}
for i = 1, #MusicUtil.SCALES do
  table.insert(scale_names, MusicUtil.SCALES[i].name)
end


function init()

  params:add_separator("MIDI SETUP")
  params:add_option("midi target", "midi target",midi_device_names,1)
  params:set_action("midi target", function(x) target = x end)
  params:add_control("midi_chan", "send on midi channel", controlspec.new(1, 100, "lin", 1, 1, ""))

  params:add_separator("")
  params:add_option("se_on","Mode",{"MUSICBOX", "GRID"},1)  
  params:add_separator("")
  params:add_control("divider", "DIV", controlspec.new(1, 1000, "lin", 0, 36, ""))
  params:add_control("scaler", "Scale", controlspec.new(1, 1000, "lin", 0, 1, ""))
  params:add_control("modi", "Modifier", controlspec.new(1, 1000, "lin", 0, 1, ""))
  params:add_control("speedval", "Speed", controlspec.new(1, 500, "lin", 0, 30, ""))  
  params:add_control("xoff", "X-Offset", controlspec.new(-1000, 1000, "lin", 0, 0, ""))
  params:add_control("xrow", "Scan Row", controlspec.new(0, 64, "lin", 1, 0, ""))
  
  params:add_control("minn", "Min Note", controlspec.new(0, 127, "lin", 1, 30, ""))
  params:add_control("maxn", "Max Note", controlspec.new(0, 127, "lin", 1, 100, ""))  
  
  params:add_control("loss", "Note Loss Chance", controlspec.new(0, 100, "lin", 0, 0, ""))  
  
  params:add_option("gfx_mode","GFX Algorithm",{"01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12","13", "14","15", "16","17","18","19","20"},1)  
  params:add_option("osc_on","Send OSC",{"ON", "OFF"},1)  
  
  params:add_control("lfo01target", "LFO01 Target", controlspec.new(1, 11, "lin", 1, 4, ""))
  params:add_control("lfo01amnt", "LFO01 Amount", controlspec.new(0, 100, "lin", 0, 0, ""))
  params:add_control("lfo02target", "LFO02 Target", controlspec.new(1, 11, "lin", 1, 9, ""))
  params:add_control("lfo02amnt", "LFO02 Amount", controlspec.new(0, 100, "lin", 0, 0, ""))
  
  params:add_option("midisend","Send MIDI",{"ON", "OFF"},1)  
  params:add_control("midisleep", "MIDI Note sleep", controlspec.new(0, 10, "lin", 0, 0, ""))
  
  params:add_control("wwidth", "X-Width", controlspec.new(0, 127, "lin", 1, 127, ""))
  params:add_control("woff", "Width Offset", controlspec.new(-64, 64, "lin", 1, 0, ""))
  
  
  params:add{type = "number", id = "root_note", name = "root note",
    min = 0, max = 127, default = 7, formatter = function(param) return MusicUtil.note_num_to_name(param:get(), true) end,
    action = function() build_scale() end} 

  
  params:add{type = "option", id = "note_scale", name = "note_scale",
    options = scale_names, default = 3,
    action = function() build_scale() end}
  
  params:add_option("scale_on","Scale on",{"OFF", "ON"},1)  
  
  params:add_option("lfot1","LFO 01 Type",{"SIN", "TRI", "SQR", "S&H","TAN"},1)  
  params:add_control("peri1", "Period 01", controlspec.new(0.001, 10, "lin", 0, 0.1, ""))  
  params:add_control("ampl1", "Amplitude 01", controlspec.new(-100, 100, "lin", 0, 20, ""))  
  params:add_control("freq1", "Frequency 01", controlspec.new(0.01, 1, "lin", 0, 0.01, ""))  
  
  params:add_option("lfot2","LFO 02 Type",{"SIN", "TRI", "SQR", "S&H","TAN"},1)  
  params:add_control("peri2", "Period 02", controlspec.new(0.001, 10, "lin", 0, 0.1, ""))  
  params:add_control("ampl2", "Amplitude 02", controlspec.new(-100, 100, "lin", 0, 20, ""))  
  params:add_control("freq2", "Frequency 02", controlspec.new(0.01, 1, "lin", 0, 0.01, ""))   
  
  params:add_control("noteleave", "Play every X note", controlspec.new(1, 1000, "lin", 0, 1, ""))
  params:add_option("encone","ENC 1 function",{"PATTERN", "MODIFY", "SCALING",  "X-OFFSET", "SCAN ROW", "MIN NOTE", "MAX NOTE", "NOTE LOSS CHANCE", "SPEED", "PLAY EVERY NTH NOTE","GFX MODE", "SEND VIA OSC", "ROOT", "SCALE", "SCALE ACTIVE", "LFO 01 TARGET", "LFO 01 AMOUNT",  "LFO 02 TARGET","LFO 02 AMOUNT", "SEND MIDI", "MIDI SLEEP",
  "WIDTH", "WIDTH OFFSET"},11)  

  params:add_option("e_on","Engine on",{"OFF", "ON"},1)  
  params:add_control("e_release", "Engine release", controlspec.new(0.01, 10, "lin", 0, 0.1, ""))
  params:add_control("e_pw", "Engine PW", controlspec.new(0, 1000, "lin", 0, 100, ""))

  -- SECOND SEQ MODE PARAS

  params:add_separator("SECOND MODE PARAMETERS")
  
  params:add_control("se_length", "Looplength", controlspec.new(1, 8, "lin", 1, 2, ""))
  params:add_option("se_mode","Mode",{"A", "B"},1) 
  params:add_option("scandir","Scan Direction",{"horiz", "vert"},1) 
  params:add_control("yheight", "Y-height", controlspec.new(0, 63, "lin", 1, 0, ""))

  for k = 1,64 do
    params:add_control("seqnote"..k, "SeqNote"..k, controlspec.new(-1, 127, "lin", 1, math.random(1,127), ""))
  end
  



  
  
  params:bang()
  build_scale()
  engine.cutoff(22000)
  engine.amp(0.2)
  intro()
  
  


  my_clock = clock.run(gfx_calc)
  
  --clock.run(gfx_calc)

end



function intro()
  
  for i=1,72 do
  screen.clear()
  
  if firsttime then
    gfx_intro_ani()
    firsttime = not firsttime
      screen.font_face(1)
      screen.font_size(8)
      screen.level(15)
  end

      for a=0,127 do
        for b=0,64 do
          
          dist = math.sqrt( (a-64)^2 + (b-32)^2 )
          
          if gfx_intro[a][b] == 1 and dist <= radius then 
     
          screen.move(a,b)
          screen.text(".")
          
            end
          end
      end
      radius = radius + 1
      

    screen.update()
    wait(0.005)

end

  for i=1,50 do
        local width_a = math.floor(i/40*40)
        screen.level(0)
        screen.rect(64-width_a/2,13,width_a,40)
        screen.fill()
        screen.update()
        wait(0.01)
  end

    screen.font_face(1)
    screen.font_size(24)
    screen.level(15)
    screen.move(62,33)
    screen.text_center("GFX")
    screen.move(64,42)
    screen.font_size(8)
    screen.text_center("SEQUENCER")
    screen.move(63,48)
    screen.font_size(8)
    screen.text_center(". . . . . . .")    
    
    screen.update()
  wait(1)
  screen.clear()
  screen.update()
  wait(0.2)
  
end



function gfx_calc()
  while true do
    
    clock.sync(0.01)
    
    lfo1_target = params:get(para_names[16])

    
    for j = 1, 11 do
      
      if lfo1_target == math.floor(j) then
        lfo1_target_list[j] = 1
      else
        lfo1_target_list[j] = 0
      end
    end
    
    lfo2_target = params:get(para_names[18])
    
    for j = 1, 11 do
      
      if lfo2_target == math.floor(j) then
        lfo2_target_list[j] = 1
      else
        lfo2_target_list[j] = 0
      end
    end
    
    lfo01_amount = params:get(para_names[17])
    lfo02_amount = params:get(para_names[19])
    
    lfo_val = math.floor(sine_val/100*lfo01_amount)
    lfo_val2 = math.floor(sine_valb/100*lfo02_amount)
    
    divider = params:get(para_names[1]) + lfo_val * lfo1_target_list[1] + lfo_val2 * lfo2_target_list[1]
    modifier = params:get(para_names[2])  + lfo_val * lfo1_target_list[2] + lfo_val2 * lfo2_target_list[2]
    scale = params:get(para_names[3]) + lfo_val * lfo1_target_list[3] + lfo_val2 * lfo2_target_list[3]
    
    move_x = math.floor(params:get(para_names[4])) + lfo_val * lfo1_target_list[4] + lfo_val2 * lfo2_target_list[4]
    
    row = params:get(para_names[5]) + lfo_val * lfo1_target_list[5] + lfo_val2 * lfo2_target_list[5]
    min_note = params:get(para_names[6]) + lfo_val * lfo1_target_list[6] + lfo_val2 * lfo2_target_list[6]
    max_note = params:get(para_names[7]) + lfo_val * lfo1_target_list[7] + lfo_val2 * lfo2_target_list[7]
    note_chance = params:get(para_names[8])+ lfo_val * lfo1_target_list[8] + lfo_val2 * lfo2_target_list[8]
    speed = params:get(para_names[9]) + lfo_val * lfo1_target_list[9] + lfo_val2 * lfo2_target_list[9]
    gfxmode = params:get(para_names[11])
    

    midi_send = params:get(para_names[20])
    midi_sleep = params:get(para_names[21])
    x_width = params:get(para_names[22])
    x_w_off = params:get(para_names[23]) + lfo_val * lfo1_target_list[10] + lfo_val2 * lfo2_target_list[10]
    notemiss = math.floor(params:get("noteleave")) + lfo_val * lfo1_target_list[11] + lfo_val2 * lfo2_target_list[11]
    
    ngine = params:get("e_on")
    ngine_rel = params:get("e_release")
    ngine_pw = params:get("e_pw")
    
    midi_chan = params:get("midi_chan")

  ---- SECOND MODE 
  
    se_mode = params:get("se_mode")
    looplength = params:get(se_para_labels[1])*8
    se_on = params:get("se_on")
    scan_d = params:get("scandir")
    y_height = params:get("yheight")
    
  ----
    
  time_ping = speed
    
    if timer() == 1 then

        lfo01()
        lfo02()
        
        if se_on ~= 2 then 
          move_y = move_y + 1 
        else
          move_y = 97
        end
        
        a = move_x
        b = 127+move_x
        c = move_y
        d = 64+move_y

        width_lower = a + 64 - x_width/2 + x_w_off
        width_higher = a + 64 + x_width/2 + x_w_off

        if se_on == 1 then
          _G[mode[gfxmode]]()
          play_notes(row)
        else
          if gfx_update == true then 
            update_notes()
            _G[mode[gfxmode]]() 
          end
          play_notes_b()
        end

    end

    redraw()
  end
    



end

function timer()

    if time_counter < 0 then time_counter = 0 end

    time_counter = time_counter + 1

    if time_counter >= time_ping then

        time_counter = 0
        return 1

    else 
        return 0
    end

end


function play_notes(row)
    osc_on = params:get("osc_on")
    tick = notemiss    
    
    engine.pw(ngine_pw)
    engine.release(ngine_rel)
    
    for x=0,127 do
      

          if gfx[x][row] == 1 and math.random(0,100) > note_chance then
            
            if note_count == tick then
        
              note_count = 1

            
              local note = mapping(x,min_note,max_note)
              
              if params:get("scale_on") == 2 then
              note = MusicUtil.snap_note_to_array(note,notes_nums)
              end
              
              if ngine == 2 then
                engine.hz(midi_to_hz(note))
              end
              
            
              if midi_send == 2 then
                local rnd = math.random(0,100)
                --m:note_on(note,rnd,1) 
                midi_device[target]:note_on(note,rnd,midi_chan) 
                clock.sleep(0.01*midi_sleep)
                midi_device[target]:note_off(note,rnd,midi_chan)  
              end
              
              if osc_on == 2 then send_notes(note) end
            
            else
          
              note_count = note_count + 1
              if note_count > tick then note_count = tick end
              if note_count < 0 then note_count = 1 end

          
            end
            
          end
          

    end
  
end

function se_count ()

 if scan_d == 1 then
 
  if x_cnt == 64 and y_cnt < 64-y_height then
    x_cnt = 1
    y_cnt = y_cnt + 1
  end
  
  if x_cnt == 64 and y_cnt == 64-y_height then
    x_cnt = 1
    y_cnt = 1
      
  end
  
  x_cnt = x_cnt + 1
 
 elseif scan_d == 2 then
 
 
  if x_cnt < 64 and y_cnt == 64-y_height then
    x_cnt = x_cnt + 1
    y_cnt = 1
  end
  
  if x_cnt == 64 and y_cnt == 64-y_height then
    x_cnt = 1
    y_cnt = 1
      
  end
  
  y_cnt = y_cnt + 1
  
  end
  
  if y_cnt > 64-y_height or y_cnt < 0 then y_cnt = 1 end
  
end



function loop_count()
  
  if loop_cnt >= looplength then loop_cnt = 0 end
  loop_cnt = loop_cnt+1
  
end



function play_notes_b()
    osc_on = params:get("osc_on")
    tick = notemiss    
    
    engine.pw(ngine_pw)
    engine.release(ngine_rel)    
    
    
    if note_count == tick then
      
        note_count = 1
        
        if math.floor(se_mode) == 1 then -- play corresponding note where light is
          
            if gfx[x_cnt][y_cnt] == 1 and math.random(0,100) > note_chance then

        
                local note = mapping(seq_array[x_cnt],min_note,max_note)
                
                if params:get("scale_on") == 2 then
                  note = MusicUtil.snap_note_to_array(note,notes_nums)
                end
                      

                if ngine == 2 then
                  engine.hz(midi_to_hz(note))
                end
                
                
                if midi_send == 2 then
                  local rnd = math.random(20,100)
                  --m:note_on(note,rnd,1) 
                  midi_device[target]:note_on(note,rnd,midi_chan) 
                  clock.sleep(0.01*midi_sleep)
                  midi_device[target]:note_off(note,rnd,midi_chan)  
                end
                        
                if osc_on == 2 then send_notes(note) end
                
                
            end
            
            se_count()
       
        elseif se_mode == 2 then -- play next note when light is
          
          if gfx[x_cnt][y_cnt] == 1 and math.random(0,100) > note_chance then
            

                print(loop_cnt)
                local note = mapping(seq_array[loop_cnt],min_note,max_note)
                
                if params:get("scale_on") == 2 then
                  note = MusicUtil.snap_note_to_array(note,notes_nums)
                end
                      

                if ngine == 2 then
                  engine.hz(midi_to_hz(note))
                end 
                           

                      
                if midi_send == 2 then
                  local rnd = math.random(0,100)
                  --m:note_on(note,rnd,1) 
                  midi_device[target]:note_on(note,rnd,midi_chan) 
                  clock.sleep(0.01*midi_sleep)
                  midi_device[target]:note_off(note,rnd,midi_chan)  
                end
                        
                if osc_on == 2 then send_notes(note) end
                
                loop_count()
            end
          
          se_count()
          
        end
          
    else
          
        note_count = note_count + 1
        if note_count > tick then note_count = tick end
        if note_count < 0 then note_count = 1 end
        
    end
            
  
end



  
function enc(n,d)
  
   if n == 1 then
     if screen_change == 3 then
       sel  = util.clamp(sel + d, 1, 2)
     else
       local change = params:get(para_names[params:get("encone")]) + d * para_deltas[params:get("encone")]
       params:set(para_names[params:get("encone")], change)
       
        if params:get("encone") < 4 or params:get("encone") == 11 then
          gfx_update = true
        end
      
     end
     

  elseif n == 2 then
  
    if screen_change == 1 then
      whereamI = util.clamp(whereamI + d, 1, selections)
    elseif screen_change == 2 then
      whereamI2 = util.clamp(whereamI2 + d, 1, 6)
    elseif screen_change == 3 then
      if sel == 1 then
        pot = util.clamp(pot + d, 1, 64)
        
        redraw()
      elseif sel == 2 then
        pot_b = util.clamp(pot_b + d, 1, 3)
        redraw()
      end
      
    end
  
  elseif n == 3 then

    if screen_change == 1 then
      local change = params:get(para_names[whereamI]) + d * para_deltas[whereamI]
      params:set(para_names[whereamI], change)
      gfx_update = true
      

    elseif screen_change == 2 then
      local change = params:get(para_labels[whereamI2]) + d * para_deltas2[whereamI2]
      params:set(para_labels[whereamI2], change)
    elseif screen_change == 3 then
       if sel == 1 then
        params:set("seqnote"..pot,util.clamp(params:get("seqnote"..pot) + d, -1, 127))
        update_notes()
        redraw()
       elseif sel == 2 then
        if pot_b ~= 3 then
          local change = params:get(se_para_labels[pot_b]) + d
          params:set(se_para_labels[pot_b], change)
          x_cnt = 0
          y_cnt = 1
        else
          rnd_slots()  
        end
       end
    end
      
 
  end
  
end




function clock.transport.start()
    clock.cancel(my_clock)
    my_clock = clock.run(gfx_calc)
end

function clock.transport.stop()
  clock.cancel(my_clock)
end


function key(n,z)
  
  if n == 3 and z == 1 then
    
    move_y = 1

  end
  
  if n == 2 and z == 1 then
    
    screen_change = screen_change +1
    if screen_change >=4 then
      screen_change=1
    end
      redraw()

  end
end







function redraw()

  screen.clear()
  screen.aa(0)
  screen.font_face(1)
  screen.font_size(8)

  screen.line_width(1)
  screen.stroke()
  
  screen.level(12) 

if screen_change == 1 then
  
  if se_on == 1 then
      for x=0,127 do
        for y=0,64 do
          
    
           
         if gfx[x][y] == 1 then 
     
          screen.pixel(x,y)
          screen.fill()
          
          end
        end
      end
    
    
  elseif se_on == 2 then
    
    --screen.level(7)
      for x=1,64 do
        for y=1,64-y_height do
          
    
           
         if gfx[x][y] == 1 then 
     
          
          if y > 56 then screen.level(1) else screen.level(12) end
          
          screen.pixel(x+32,y+y_height/2)
          screen.fill()
          
          end
        end
      end
    screen.level(15)
    screen.move(x_cnt+32, y_cnt+y_height/2)
    screen.text(".")
    screen.level(1)
        
    end
    
    
    
    
    if se_on == 1 then
     screen.level(0)
     screen.rect(0,56,128,8)
    end
   
     screen.fill()
     screen.level(10)
     screen.move(0,64)
     screen.text(screen_names[whereamI])
    
     screen.move(127,64)
     if whereamI == 14 then
      
      screen.text_right(scale_names[params:get("note_scale")]) 
      
     elseif 
      
      whereamI == 13 then
      screen.text_right(MusicUtil.note_num_to_name(params:get("root_note"),true)) 
     
      elseif 
     
      whereamI == 16 then
      screen.text_right(lfo1_target_names[params:get("lfo01target")]) 
     
      elseif
     
      whereamI == 18 then
      screen.text_right(lfo1_target_names[params:get("lfo02target")]) 
     
     elseif
      
      whereamI == 15 then
        
        screen.text_right(menu_of[params:get("scale_on")]) 
        
     elseif 
      
      whereamI == 12 then
        
        screen.text_right(menu_of[params:get("osc_on")]) 
        
     elseif 
      
      whereamI == 20 then
        
        screen.text_right(menu_of[params:get("midisend")]) 
        
    elseif 
      
      whereamI == 23 then
        
        screen.text_right(math.floor(params:get(para_names[whereamI]) + lfo_val * lfo1_target_list[10] + lfo_val2 * lfo2_target_list[10] )) 
    elseif 
      
      whereamI == 10 then
        
        screen.text_right(math.floor(params:get("noteleave") + lfo_val * lfo1_target_list[11] + lfo_val2 * lfo2_target_list[11] )) 
        
    elseif 
      
      whereamI == 24 then
        
        screen.text_right(screen_names[params:get("encone")])

    elseif 
      
      whereamI == 25 then
        
        screen.text_right(mode_dir[params:get("scandir")])
                                    
                            
  elseif 
      
      whereamI == 27 then
        
        screen.text_right(s_mode[params:get("se_on")])
                                    
   elseif 
      
      whereamI == 28 then
        
        screen.text_right(menu_of[params:get("e_on")])
                                            
     elseif 
      
      whereamI <= 9 then    
      
      if whereamI == 6 or whereamI == 7 then
        
        screen.text_right(MusicUtil.note_num_to_name((math.floor(params:get(para_names[whereamI]) + lfo_val * lfo1_target_list[whereamI] + lfo_val2 * lfo2_target_list[whereamI] )),true)) 
        
        else
        
        screen.text_right(math.floor(params:get(para_names[whereamI]) + lfo_val * lfo1_target_list[whereamI] + lfo_val2 * lfo2_target_list[whereamI] )) 
      end
      
        
     else
         
     screen.text_right(params:get(para_names[whereamI])) 
     end

---- SCREEN No 2 --------------------------------------------------------------------------------

elseif screen_change == 2 then  -- LFO SCREEN
  
   screen.level(12)
  


scr2_y = {12,19,26,44,51,58}

  
  for o = 1,6 do
      if whereamI2 == o then
        screen.level(15)
      else
        screen.level(3)
      end

    screen.move(100,scr2_y[o])
    if o == 1 or o == 4 then
      screen.text(lfo_labels[params:get(para_labels[o])])
    else
      screen.text(params:get(para_labels[o]))
    end
    
 


screen.level(1)
for i=1,21 do
  screen.move(3+(i-1)*8.5,34)
  screen.text(".")
end

 
 screen.level(15)  
  
  
  screen.move(35,36)  
  screen.text("+")
  
  screen.move(87,36)  
  screen.text("+")  
  
  screen.move(35,3)  
  screen.text(".")
  
  screen.move(87,3)  
  screen.text(".")  

  screen.move(35,63)  
  screen.text(".")
  
  screen.move(87,63)  
  screen.text(".")
    
  end
 screen.level(12)
 screen.font_size(16)
 screen.move(15,20)
 screen.text_center(math.floor(sine_val))
 
 screen.move(15,54)
 screen.text_center(math.floor(sine_valb))
 
  screen.font_size(8)
  screen.level(1)
  
  
 
  screen.level(12) 
  for i=1,50 do
    
  screen.move(i+36,16+util.clamp((y_arr[i]/10),-20,20))
  screen.text(".")
  end
  
  for j=1,50 do
    
  screen.move(j+36,50+util.clamp((y_arr2[j]/10),-20,20))
  screen.text(".")
  end  

---- SCREEN No 3 --------------------------------------------------------------------------------  

elseif screen_change == 3 then
  
  local no_ch = params:get("seqnote"..pot)
  
  screen.clear()
  screen.aa(0)
  screen.font_face(1)
  screen.font_size(8)
  screen.level(12)
  
  screen.move(120,20)
  screen.font_size(16)
  if no_ch == -1 then
    screen.text_right("-")
  else
    screen.text_right(MusicUtil.note_num_to_name(no_ch,true))
  end
  
  screen.font_size(8)
  screen.level(6)
  screen.move(0,15)
  screen.text("SIZE")
  screen.level(12)
  screen.move(0,21)

  screen.text(math.floor(looplength))
  screen.level(6)
  screen.move(0,49)
  screen.text("MODE")
  screen.level(12)
  screen.move(0,55)
  screen.text(mode_dis[params:get(se_para_labels[2])])
  
  screen.level(6)
  screen.move(100,49)
  screen.text("RND")
  screen.move(100,55)
  screen.text("NOTES")

  screen.level(12)  
  
  if sel == 2 then
    screen.move(scr3_x[pot_b],scr3_y[pot_b])
    screen.text(scr3_i[pot_b])
  end
  

  
  for i=1,8 do
    for j=1,8 do
      
      if j+8*(i-1) > looplength and pot ~= j+8*(i-1) then
        
        screen.move(j*6+1+32,i*6+7)
        screen.level(1)
        screen.text(".")
      
      elseif pot == j+8*(i-1) and sel == 1 then
        screen.level(12)
        screen.rect(j*6+32,i*6+5,3,3)
        screen.fill()        
      else
        screen.move(j*6+1+32,i*6+7)
        screen.level(12)
        screen.text(".")
      end

    end
  end


  
end


  
  screen.update()

end
