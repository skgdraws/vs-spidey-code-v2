local turnvalue = 20

function onBeatHit()

    --Default Angle
    turnvalue = 20

    -- Every other beats it changes the angle
    if curBeat % 2 == 0 then
        turnvalue = -20
    end

    -- Sets the angle of the icons oposite of each other
    setProperty('iconP2.angle',-turnvalue)
    setProperty('iconP1.angle',turnvalue)

    -- Tweens the icons back to an angle of 0
    doTweenAngle('iconTween1','iconP1',0,crochet/1000,'circOut')
    doTweenAngle('iconTween2','iconP2',0,crochet/1000,'circOut')

end