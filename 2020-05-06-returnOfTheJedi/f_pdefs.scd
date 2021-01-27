// Parte de inicializaciones
~t = TempoClock.new;

~n = Array.new(2000);
~regF={{|v|~n.add((\note:(v.note),\dur:v.dur,\mark:v.mark,\time:v.time,\voice: v.voice, \instru: v.instru))}};

~instr =Array.fill(8,{|i| \piano});
~instrumentos.do({|name,i|
	~instr[i]=name;
});

if(~instr.size==0,{
	~instr =Array.fill(8,{|i| \piano});
});

~notas =Array.fill(8,{|i| PatternProxy()});
~durs =Array.fill(8,{|i| PatternProxy()});
~amps =Array.fill(8,{|i| PatternProxy()});

~pdefs=Array.fill(8,{|i|
	Pdef(i.asSymbol,
		Pbind(
			\type, \midi,
			\midicmd, \noteOn,
			\midiout, ~mid,
			\chan, i,

			\instru, ~instr[i],
			\voice,i+1,
			\note, ~notas[i],
			\dur, ~durs[i],
			\amp,~amps[i],
			\mark, Pfunc({|env|
				i = env.amp;
				x = case
				{i >= 0.8} {"[ff]"}
				{(i < 0.8) && (i >= 0.78)} {"[>]"}
				{(i < 0.78) &&(i >= 0.74)} {"[mf] "}
				{(i < 0.74) &&(i >= 0.55)} {" "}
				{(i < 0.55) &&(i >= 0.51)} {"[mp]"}
				{i < 0.51} {"[p]"}; // refinar para todas las dinámicas
			}),
			\time, Pfunc({~t.beats;}),
			\grabar, Pfunc(~regF.value(v))
		)
	);
});


