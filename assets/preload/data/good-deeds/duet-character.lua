--configs

local character = 'characters/version2/spidey-hybrid' --put the name of the character's spritesheet here
--add mods/images behind characters if you are gonna use characters in the mods folder instead

--the offsets
local posX = 200
local posY = 300

local xidleoffs = 0 --X
local yidleoffs = 10 --Y

local xleftoffs = -51 --X
local yleftoffs = 10 --Y

local xdownoffs = -21 --X
local ydownoffs = 10 --Y

local xupoffs = -6 --X
local yupoffs = 10 --Y

local xrightoffs = 10 --X
local yrightoffs = 10 --Y

--the poses in the xml

local idle = 'spidey-hybrid Idle Dance' --idle

local left = 'spidey-hybrid Sing Note RIGHT' --left

local down = 'spidey-hybrid Sing Note DOWN' --down

local up = 'spidey-hybrid Sing Note UP' --up

local right = 'spidey-hybrid Sing Note LEFT' --right

--miss poses (optional)

local togglemisseanims = false --set this to true if you want miss animations, false to not


local leftmiss = 'BF NOTE LEFT' --left miss

local downmiss = 'BF NOTE DOWN' --down miss

local upmiss = 'BF NOTE UP' --up miss

local rightmiss = 'BF NOTE RIGHT' --right miss

--mislacious

local fps = 24 --24 is the default fps

--the cool script by @Betopia#5677 (and some edits by me, @tek no#6260) on discord

local idling = true
function onCreatePost()
    makeAnimatedLuaSprite('player3', character, 0, 0)
    setProperty('player3.flipX', true)
    setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
    setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
    addAnimationByPrefix('player3', 'idle', idle, fps, false)

    --regular animations

    addAnimationByPrefix('player3', 'left', left, fps, false) 
    addAnimationByPrefix('player3', 'down', down, fps, false)
    addAnimationByPrefix('player3', 'up', up, fps, false) 
    addAnimationByPrefix('player3', 'right', right, fps, false)

    --miss animations

    addAnimationByPrefix('player3', 'leftmiss', leftmiss, fps, false) 
    addAnimationByPrefix('player3', 'downmiss', downmiss, fps, false)
    addAnimationByPrefix('player3', 'upmiss', upmiss, fps, false) 
    addAnimationByPrefix('player3', 'rightmiss', rightmiss, fps, false)

    addLuaSprite('player3', true)
end
function goodNoteHit(id, noteData, noteType, isSustainNote)

    if noteType == 'No Animation' then
        idling = false
        if noteData == 0 then
            objectPlayAnimation('player3', 'left', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xleftoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + yleftoffs)
        end

        if noteData == 1 then
            objectPlayAnimation('player3', 'down', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xdownoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + ydownoffs)
        end

        if noteData == 2 then
            objectPlayAnimation('player3', 'up', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xupoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + yupoffs)
        end

        if noteData == 3 then
            objectPlayAnimation('player3', 'right', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xrightoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + yrightoffs)
        end
    end
    
    if noteType == 'Duet' then
        idling = false
        if noteData == 0 then
            objectPlayAnimation('player3', 'left', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xleftoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + yleftoffs)
        end

        if noteData == 1 then
            objectPlayAnimation('player3', 'down', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xdownoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + ydownoffs)
        end

        if noteData == 2 then
            objectPlayAnimation('player3', 'up', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xupoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + yupoffs)
        end

        if noteData == 3 then
            objectPlayAnimation('player3', 'right', true)
            setProperty('player3.x', getProperty('boyfriend.x') + posX + xrightoffs)
            setProperty('player3.y', getProperty('boyfriend.y') - posY + yrightoffs)
        end
    end
    
    runTimer('idle-transition', 1)
end

function noteMiss(id, noteData, noteType, isSustainNote)
    idling = false
    if togglemisseanims == true then
    if noteData == 0 then
        objectPlayAnimation('player3', 'leftmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
    end

    if noteData == 1 then
        objectPlayAnimation('player3', 'downmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
    end

    if noteData == 2 then
        objectPlayAnimation('player3', 'upmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
    end

    if noteData == 3 then
        objectPlayAnimation('player3', 'rightmiss', true)
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
    end

    runTimer('idle-transition', 1)

end
end

function onCountdownTick(c)
    if idling and c % 2 == 0 and not string.find(string.lower(getProperty('player3.animation.curAnim.name')), 'left' or 'down' or 'up' or 'right')then
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
        objectPlayAnimation('player3', 'idle')
        idling = true
    end
end
function onBeatHit()
    if idling and curBeat % 2 == 0 and not string.find(string.lower(getProperty('player3.animation.curAnim.name')), 'left' or 'down' or 'up' or 'right') then
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
        objectPlayAnimation('player3', 'idle', true)
        idling = true
    end
end
function onTimerCompleted(t, l, ll)
    if t == 'idle-transition' then
        idling = true
        setProperty('player3.x', getProperty('boyfriend.x') + posX + xidleoffs)
        setProperty('player3.y', getProperty('boyfriend.y') - posY + yidleoffs)
        objectPlayAnimation('player3', 'idle')
    end
end