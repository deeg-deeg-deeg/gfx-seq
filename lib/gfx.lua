
function gfx_intro_ani()

    for x=1,127 do
      for y=1,64 do
        if (((((1-(x))^2 + (((y))^2)))^2)%9) == 1 then
          gfx_intro[x][y] = 1
        else
          gfx_intro[x][y] = 0
        end
      end
    end
    
 
  
end


function gfx_mode01()

    for x=a,b do

      for y=c,d do
  
        if ((( ((1-(x))^2 + (((y)*modifier)^2)) / scale )^2)%divider) == 1 then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
    
          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
    gfx_update = false
  
end


function gfx_mode02()
  
    for x=a,b do
      for y=c,d do
        
       
          if ((( ((1-(x+move_x))^2 & (((y+move_y)*round(modifier,0))^2)) / scale )^2)%divider) == 1 then 
          
  
          if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
           else
          gfx[x-a][y-c] = 0
           end
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
    gfx_update = false
  
end


function gfx_mode03()
  

    for x=a,b do
       
      for y=c,d do
        
        if ((math.floor((modifier/((x*scale)^-2))^2 + 1/((y*scale)^-4)))%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
      
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  
  gfx_update = false
end


function gfx_mode04()
  

    for x=a,b do
       
      for y=c,d do
 
         if ((math.floor((1/((x)^-4))*modifier + 1/((y)^-2)*(modifier-1))/scale )%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
      
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end

    gfx_update = false
  
end


function gfx_mode05()
  
    for x=a,b do
       
      for y=c,d do
       
         if ((math.floor(((x)/((x)^-4))*modifier + 1/((y)^-2)*(modifier-2))/scale )%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
      
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end


function gfx_mode06()
  
for x=a,b do
       
      for y=c,d do
        
         if ((math.floor(((x)^3/((x)^-4))*modifier + 1/((y)^-2)*(modifier-2))/scale )%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
      
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end


function gfx_mode07()
  

    for x=a,b do
       
      for y=c,d do
        
         if ((math.floor((x+y)^2*modifier  +  ((y-x)^2)*modifier)/scale)%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
      
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end




function gfx_mode08()
  

    for x=a,b do
       
      for y=c,d do
 
         if ((math.floor((x+y)^4*modifier  +  ((y-x)^4)*modifier)/scale)%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
        
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end



function gfx_mode09()

    for x=a,b do
       
      for y=c,d do
         
         if ((math.floor((x+y+(1/2))^(4/3)  +  ((y+(1/2)-(x))^(4/3) + move_y/modifier)/scale)%divider)) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
        
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
    gfx_update = false
end





function gfx_mode10()

    for x=a,b do
       
      for y=c,d do
       
        
        
         if ((math.floor((x*scale)^2 * (1^math.cos(x)*100*scale) + (y^2*modifier)))%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
        
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
    gfx_update = false
end



function gfx_mode11()
  

    for x=a,b do
       
      for y=c,d do

        if ((math.floor(math.floor((x*y)^modifier) * (y)^-modifier)*scale)%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
        
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
    gfx_update = false
end




function gfx_mode12()
  

    for x=a,b do
       
      for y=c,d do

      if ((math.floor((1/((x*scale)^-4))^2 + modifier/((y*scale)^-2)))%divider) == 1 then
      
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end      
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
    gfx_update = false
end


function gfx_mode13()

    for x=a,b do

      for y=c,d do

        if (((y~x + y )/scale)%divider) == modifier then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end

          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end


function gfx_mode14()

    for x=a,b do

      for y=c,d do

       if ( math.abs( math.floor(math.cos(x)*modifier+math.sin(y)*modifier + (math.cos(x/y))*(scale-1)))) == divider then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end

          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end

function gfx_mode15()

    for x=a,b do

      for y=c,d do

      
       if ((math.floor(scale*math.cos((y + ((-1/10)*(20*x+10*x+5*y) *modifier)))))) == divider then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end

          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end



function gfx_mode16()

    for x=a,b do

      for y=c,d do

      
       if ((( y~x>>1&x + y - modifier)/scale)%divider) == 1 then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end

          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end



function gfx_mode17()

    for x=a,b do

      for y=c,d do

      
       if (((x*modifier+x^2 )/scale)%divider) == math.floor(math.cos(y)*20) then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end

          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end


function gfx_mode18()

    for x=a,b do

      for y=c,d do
       
       local rnd_v = math.random(1,100)
        
       if rnd_v <= divider  then
       
           if x >= width_lower and x <= width_higher then
              gfx[x-a][y-c] = 1
            else
              gfx[x-a][y-c] = 0
            end

           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end



function gfx_mode19()

    for x=a,b do

      for y=c,d do

       if (((modifier*x^4 ))%divider) == math.floor(math.cos(y)*scale*(x^2/500)) then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
          
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end



function gfx_mode20()

    for x=a,b do

      for y=c,d do


       if (((y^4/x + y^2/modifier )/scale)%divider) == 1 then
        
        if x >= width_lower and x <= width_higher then
          gfx[x-a][y-c] = 1
        else
          gfx[x-a][y-c] = 0
        end
           
        else
          
          gfx[x-a][y-c] = 0
  
        end
      end
    end
  gfx_update = false
end

