local cry_sound = Sound("scp096/crying.wav")
local freak_sound = Sound("scp096/freak.wav")
local scream_sound = Sound("scp096/scream.wav")

sound.Add({
    name = "scp_096_cry",
    channel = CHAN_VOICE,
    volume = 1,
    sound = cry_sound
})

sound.Add({
    name = "scp_096_freak",
    channel = CHAN_VOICE,
    volume = 1,
    sound = freak_sound
})

sound.Add({
    name = "scp_096_scream",
    channel = CHAN_VOICE,
    volume = 1,
    sound = scream_sound
})