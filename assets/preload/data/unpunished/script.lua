function onUpdate(elapsed)   

    if curStep == 0 then
        started = true
    end

    songPos = getSongPosition()
    local currentBeat = (songPos/5000)*(curBpm/60)

    doTweenY('opponentmove', 'dad', -100 - 150*math.sin((currentBeat+12*12)*math.pi), 2)
    doTweenX('disruptor2', 'disruptor2.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 6)
    doTweenY('disruptor2', 'disruptor2.scale', 0 - 31*math.sin((currentBeat+1*1)*math.pi), 6)
end

function onCreate()
    
    makeAnimatedLuaSprite('spidey', 'characters/ded-spidey', defaultBoyfriendX + 250, defaultBoyfriendY + 250);
    addAnimationByPrefix('spidey', 'idle', 'ded-spidey idle', 24, false);
    addAnimationByPrefix('spidey', 'fuck u', 'ded-spidey fuck u', 24, false);

    objectPlayAnimation('spidey', 'idle'); 
	addLuaSprite('spidey', true);
end

isFlipOff = false

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % 2 == 0 and not isFlipOff then
		objectPlayAnimation('spidey', 'idle');
	end

    if curBeat == 226 then
        isFlipOff = true
        objectPlayAnimation("spidey", 'fuck u')

    elseif curBeat == 230 then
        isFlipOff = false
        
    end

end
