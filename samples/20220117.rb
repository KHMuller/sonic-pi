# 15 Minutes
# 17th of January 2022
# I like it ;)

use_debug false
use_scale = :augmented # Use this for more free-jazz variant
use_scale = :minor_pentatonic # this for non-risky business
use_scale = :minor #my preferred choice :major is also a valid one


#scale :c2, :chromatic

a = (ring 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1).mirror

# Sounds Okay ... more airy like a pan flute
define :flute do |note, length=1, amp=1, pan=0.5|
  use_synth :pretty_bell
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.5
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end

# Sounds Okay
# Use with long notes > 0.5 bpm 60
define :cello do |note, length=1, amp=1, pan=0.5|
  use_synth :fm
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.125
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end

# Sounds Okay alterantively use :tri, :tech_saws, :prophet, :pretty_bell, :pulse
# Use bpm 1200
define :organ do |note, length=1, amp=1, pan=0.5|
  use_synth :tri
  if length < 0.5 then
    att = rrand(0, length)
  else
    att = 0.25
  end
  with_fx :reverb, room: 0.5, mix: 0.5 do
    play note, attack: att, release: length-att, pan: pan, cutoff: note+1, amp: amp
    play note+12, attack: att, release: length-att, pan: pan, cutoff: note+13, amp: amp/2
    play note+24, attack: att, release: length-att, pan: pan, cutoff: note+25, amp: amp/4
  end
end

live_loop :base do
  #use_bpm 600 #change to 1200
  use_bpm 600
  
  l = (ring 1, 1, 1, 1).tick(:backmotif)
  l = l * 2
  
  bs = (scale :c2, use_scale, num_octaves: 2)
  drift = (ring 0, 0, 0, 0, 3, 3, 0, 0, 4, 3, 0, 0).tick(:riff)
  
  4.times do
    shift = (ring 0, 2, 4, 7).choose #tick(:basenotes)
    cello(bs[shift+drift], l/2, 1.5, rrand(0.25,-0.25))
    sleep l
  end
end

live_loop :choir do
  use_bpm 75
  sleep 1
end

load_sample :drum_heavy_kick
load_sample :bd_tek

live_loop :drums do
  use_bpm 75
  sample :bd_tek, amp: 1, release: 0.125, pitch: 0
  sleep 0.25
  sample :drum_heavy_kick, rate: 0.75
  sleep 0.25
  sample :drum_heavy_kick, rate: 0.5
  sleep 1.5
end

slowdown = (ramp *(range 1200, 590, step=10))
speedup = (ramp *(range 60, 1210, step=10))



live_loop :master do
  use_bpm 1200 #speedup.tick(:speeding)
  
  a = (ring 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1).mirror
  l = (ring 1, 1, 2, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1).tick(:basemotif)
  l = l*2
  n_f = (scale :c1, use_scale, num_octaves: 4).choose
  n_n = (scale :c2, use_scale, num_octaves: 2).choose
  n_1 = (scale :c1, use_scale, num_octaves: 1).choose
  n_2 = (scale :c2, use_scale, num_octaves: 1).choose
  n_3 = (scale :c3, use_scale, num_octaves: 1).choose
  n_4 = (scale :c4, use_scale, num_octaves: 1).choose
  #flute(n_n+7, l, 0.5+a.choose, -0.25) if (spread 5, 8).tick(:organobeat1)
  organ(n_f+7, l, 0.5+a.choose, 0.25) if (spread 5, 8).tick(:organobeat1)
  organ(n_f, l, 0.5+a.choose, 0.25) if (spread 8, 8).tick(:organobeat1)
  sleep l
  
end


