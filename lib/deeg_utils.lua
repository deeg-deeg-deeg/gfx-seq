function update_notes()
  
  for i = 1, 64/looplength do
    for j=1,looplength do
      seq_array[(i-1)*looplength+j] = params:get("seqnote"..j)
    end
  end

end



function send_notes(note)

        osc.send(osc_dest,"/notes",{note})
        osc.send(osc_dest,"/velo",{math.random(0,100)})

end


function build_scale()
  notes_nums = MusicUtil.generate_scale(params:get("root_note"), params:get("note_scale"), 10) 
end


function mapping(num,n1,n2)
  
  new_num = math.floor((num / 127 * (n2-n1)) + n1)
  return new_num

end


function midi_to_hz(note)
  local hz = (440 / 32) * (2 ^ ((note - 9) / 12))
  return hz
end


function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function wait(seconds)
    local start = os.clock()
    repeat until os.clock() > start + seconds
end

function rnd_slots()
  for i=1,64 do
    params:set("seqnote"..i,math.random(-1,127))
    update_notes()
  end
end
