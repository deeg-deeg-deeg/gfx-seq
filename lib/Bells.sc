// CroneEngine_Bells

Engine_Bells : CroneEngine {
  var pg;
    var amp=0.3;
    var release=0.5;
    var pw=0.5;
    var cutoff=1000;
    var gain=2;
    var pan = 0;

  *new { arg context, doneCallback;
    ^super.new(context, doneCallback);
  }

  alloc {
    pg = ParGroup.tail(context.xg);
    SynthDef("Bells", {
      arg out, freq = 440, pw=pw, amp=amp, cutoff=cutoff, gain=gain, release=release, pan=pan;
      var snd = Mix.fill(10, {SinOsc.ar(rrand(freq,freq+pw), 0, amp,0)});
      var filt = MoogFF.ar(snd,cutoff,gain);
      var env = Env.perc(level: amp, releaseTime: release).kr(2);
      Out.ar(out, Pan2.ar((filt*env), pan));
    }).add;

    this.addCommand("hz", "f", { arg msg;
      var val = msg[1];
      Synth("Bells", [\out, context.out_b, \freq,val,\pw,pw,\amp,amp,\cutoff,cutoff,\gain,gain,\release,release,\pan,pan], target:pg);
    });

    this.addCommand("amp", "f", { arg msg;
      amp = msg[1];
    });

    this.addCommand("pw", "f", { arg msg;
      pw = msg[1];
    });
    
    this.addCommand("release", "f", { arg msg;
      release = msg[1];
    });
    
    this.addCommand("cutoff", "f", { arg msg;
      cutoff = msg[1];
    });
    
    this.addCommand("gain", "f", { arg msg;
      gain = msg[1];
    });
    
    this.addCommand("pan", "f", { arg msg;
      postln("pan: " ++ msg[1]);
      pan = msg[1];
    });
  }

  free { 
    pg.free;
  }
}