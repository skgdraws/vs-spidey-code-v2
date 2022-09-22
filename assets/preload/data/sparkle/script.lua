
-- Script made by Catbrother Everything with help by NardBruh. Credit is not needed but would be nice! :)

function onCreate()

	makeAnimatedLuaSprite('Dad2', 'characters/spidey-magic-mirror-elec', defaultBoyfriendX + 250, defaultBoyfriendY + 100); -- Change to characters idle in XML
	addAnimationByPrefix('Dad2', 'idle', 'spidey-magic-mirror-elec Idle Dance', 24, false); -- Change to characters idle in XML
    addAnimationByPrefix('Dad2', '0', 'spidey-magic-mirror-elec Sing Note LEFT', 24, false); -- Change to characters leftnote in XML
    addAnimationByPrefix('Dad2', '1', 'spidey-magic-mirror-elec Sing Note DOWN', 24, false); -- Change to characters downnote in XML
    addAnimationByPrefix('Dad2', '2', 'spidey-magic-mirror-elec Sing Note UP', 24, false); -- Change to characters upnote in XML
    addAnimationByPrefix('Dad2', '3', 'spidey-magic-mirror-elec Sing Note RIGHT', 24, false); -- Change to characters rightnote in XML
	objectPlayAnimation('Dad2', 'idle'); 
	addLuaSprite('Dad2', true); -- false = add behind characters, true = add over characters
    setGraphicSize("Dad2", -1)
end
function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 then
		objectPlayAnimation('Dad2', 'idle');
	end
end

lastNote = {0, ""}

function goodNoteHit(id,d,t,s)

    lastNote[1] = d
    lastNote[2] = t
    
    if lastNote[2] == "No Animation" then -- Change "No Animation" to be your note type, usually you can just keep it as no anim assuming you arent using it elsewhere
	objectPlayAnimation('Dad2', lastNote[1]);
    end
    if lastNote[2] == "Duet" then -- Change "No Animation" to be your note type, usually you can just keep it as no anim assuming you arent using it elsewhere
	objectPlayAnimation('Dad2', lastNote[1]);
    end
end

function onUpdate(elapsed)    if curStep == 0 then

        started = true

    end

songPos = getSongPosition()

local currentBeat = (songPos/5000)*(curBpm/60)

doTweenY('opponentmove', 'dad', -100 - 150*math.sin((currentBeat+12*12)*math.pi), 2)

doTweenX('disruptor2', 'disruptor2.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 6)

doTweenY('disruptor2', 'disruptor2.scale', 0 - 31*math.sin((currentBeat+1*1)*math.pi), 6)

end