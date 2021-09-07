s.meter;
s.boot;
x = {[SinOsc.ar(300), SinOsc.ar(500)]}.play;
x.free;
Platform.userExtensionDir
x = {SinOsc.ar([300, 500])}.play;

(
SynthDef.new(\multi, {
	var sig, amp;
	amp = SinOsc.kr([7, 1, 2, 0.2, 6]).range(0, 1);
	sig = SinOsc.ar([300, 500, 700, 900, 1100]);
	sig = sig * amp;
	//Mix.new(sig).dup(2) * 0.15;
	// Mix.new(sig)!(2) * 0.15;
	Splay.ar(sig)* 0.15;
	Out.ar(0, sig);
}).add;
)
x = Synth.new(\multi)
x.set(\amp, 0.1)
x.free;

x = {PinkNoise.ar(0.5!2)*0.6}.play
x.free;
(
SynthDef.new(\pulseTest, {
	arg ampHz = 4, fund=40, maxPartial=4, width = 0.5;
	var amp1, amp2, freq1, freq2, sig1, sig2;
	amp1 = LFPulse.kr(ampHz, 0, 0.12) * 0.75;
	amp2 = LFPulse.kr(ampHz, 0.5, 0.12) * 0.75;
	freq1 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq2 = LFNoise0.kr(4).exprange(fund, fund*maxPartial).round(fund);
	freq1 = freq1 * LFPulse.kr(8, add:1);
	freq2 = freq1 * LFPulse.kr(6, add:1);
	sig1 = Pulse.ar(freq1, width, amp1);
	sig2 = Pulse.ar(freq2, width, amp2);
	sig1 = FreeVerb.ar(sig1, 0.7, 0.8, 0.25);
	sig2 = FreeVerb.ar(sig2, 0.7, 0.8, 0.25);
	Out.ar(0, sig1);
	Out.ar(1, sig2);
}).add;
)

x = Synth.new(\pulseTest, [4, 40, 4, 0.5]);
x.set([5, 40, 4, 0.5]);
x.set(\width, 0.25);
x.set(\fund, 40);
x.set(\ampHz, 1);
x.free;
