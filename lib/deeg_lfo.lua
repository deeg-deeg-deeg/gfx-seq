
function lfo01()

    
    period = period+period_delta
  
    lfotype1 = params:get(para_labels[1])
    period_delta = params:get(para_labels[2])
    amplitude = params:get(para_labels[3])
    
    local s_h_val = math.floor(100-period_delta*10)+1
    
    if lfotype1 == 1 then
      sine_val = math.sin(period)*amplitude 
    elseif lfotype1 == 2 then  
      sine_val =( math.acos(math.sin(period))-math.pi/2)*amplitude 
    elseif lfotype1 == 3 then  
      sine_val = (math.sin(period) >= 0 and 1 or -1)*amplitude
    elseif lfotype1 == 4 then  
      if math.random(0,s_h_val) == 1 then
      sine_val = (math.random() * (math.random(0, 1) == 0 and 1 or -1))*amplitude
      end
    elseif lfotype1 == 5 then  
      sine_val = 10*math.log(math.abs(math.tan(period)*amplitude)) 
    elseif lfotype1 == 6 then
     sine_val = math.sin(((math.pi*2 / 100) * period*10) - (math.pi*2 / 0.01)) * 100
    end
        
        table.insert(y_arr, sine_val)
        table.remove(y_arr, 1)    
    
  
end


function lfo02()

    lfotype2 = params:get(para_labels[4])
    period_deltab = params:get(para_labels[5])
    amplitudeb = params:get(para_labels[6])
    
    local s_h_val = math.floor(100-period_deltab*10)+1
    
    periodb = periodb+period_deltab
    
    if lfotype2 == 1 then
      sine_valb = math.sin(periodb)*amplitudeb 
    elseif lfotype2 == 2 then  
      sine_valb =( math.acos(math.sin(periodb))-math.pi/2)*amplitudeb 
    elseif lfotype2 == 3 then  
      sine_valb = (math.sin(periodb) >= 0 and 1 or -1)*amplitudeb
    elseif lfotype2 == 4 then  
      if math.random(0,s_h_val) == 1 then
      sine_valb = (math.random() * (math.random(0, 1) == 0 and 1 or -1))*amplitudeb
      end
    elseif lfotype2 == 5 then  
      sine_valb = 10*math.log(math.abs(math.tan(periodb)*amplitudeb)) 
    end
        
        table.insert(y_arr2, sine_valb)
        table.remove(y_arr2, 1)    
  
end
