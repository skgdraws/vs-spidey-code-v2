--easy script configs
IntroTextSize = 20	--Size of the text for the Now Playing thing.
IntroSubTextSize = 30 --size of the text for the Song Name.
IntroAuthorTextSize = 20
local IntroTagColor = 'e61717'	--Color of the tag at the end of the box.
IntroTagWidth = 40	--Width of the box's tag thingy.
--easy script configs

--actual script
function onCreatePost()
	
	IntroTagColor = 'e61717'	-- Default color of the tag at the end of the box.

	if getPropertyFromClass('SONG.player2') == 'spiderman' then
		-- the colour of the tag
		IntroTagColor = '862320';

	end
	if getPropertyFromClass('PlayState', 'SONG.player2') == 'mysterio' then
		-- the colour of the tag
		IntroTagColor = '8c46b4';
	end
	if getPropertyFromClass('PlayState', 'SONG.player2') == 'venom' then
		-- the colour of the tag
		IntroTagColor = '1e2171';
	end
	if getPropertyFromClass('PlayState', 'SONG.player2') == 'doc-ock' then
		-- the colour of the tag
		IntroTagColor = 'f06d00';
	end
	if getPropertyFromClass('PlayState', 'SONG.player2') == 'electro' then
		-- the colour of the tag
		IntroTagColor = 'd7af50';
	end
	if getPropertyFromClass('PlayState', 'SONG.player2') == 'green-goblin' then
		-- the colour of the tag
		IntroTagColor = '168240';
	end

	--the tag at the end of the box
	makeLuaSprite('JukeBoxTag', 'empty', -300-IntroTagWidth, 15)
	makeGraphic('JukeBoxTag', 300+IntroTagWidth, 150, IntroTagColor)
	setObjectCamera('JukeBoxTag', 'other')
	addLuaSprite('JukeBoxTag', true)

	--the box
	makeLuaSprite('JukeBox', 'empty', -320-IntroTagWidth, 15)
	makeGraphic('JukeBox', 320, 150, '000000')
	setObjectCamera('JukeBox', 'other')
	addLuaSprite('JukeBox', true)
	
	--the text for the "Now Playing" bit
	makeLuaText('JukeBoxText', 'Now Playing:', 350, -305-IntroTagWidth, 30)
	setTextAlignment('JukeBoxText', 'left')
	setObjectCamera('JukeBoxText', 'other')
	setTextSize('JukeBoxText', IntroTextSize)
	addLuaText('JukeBoxText')
	
	--text for the song name
	makeLuaText('JukeBoxSubText', songName, 350, -305-IntroTagWidth, 60)
	setTextAlignment('JukeBoxSubText', 'left')
	setObjectCamera('JukeBoxSubText', 'other')
	setTextSize('JukeBoxSubText', IntroSubTextSize)
	addLuaText('JukeBoxSubText')

	makeLuaText('JukeBoxAuthor', songName, 300, -305-IntroTagWidth, 100)
	setTextAlignment('JukeBoxAuthor', 'left')
	setObjectCamera('JukeBoxAuthor', 'other')
	setTextSize('JukeBoxAuthor', IntroAuthorTextSize)
	addLuaText('JukeBoxAuthor')
end

--motion functions
function onEvent(n,v,b)
	if n == 'Intro' then
		if v ~= '' then
			setTextString('JukeBoxSubText',v)
		end
		if b ~= '' then
			setTextString('JukeBoxAuthor',b)
		end
		-- Inst and Vocals start playing, songPosition = 0
		doTweenX('MoveInOne', 'JukeBoxTag', 0, 1, 'CircInOut')
		doTweenX('MoveInTwo', 'JukeBox', 0, 1, 'CircInOut')
		doTweenX('MoveInThree', 'JukeBoxText', 10, 1, 'CircInOut')
		doTweenX('MoveInFour', 'JukeBoxSubText', 10, 1, 'CircInOut')
		doTweenX('MoveInFive', 'JukeBoxAuthor', 10, 1, 'CircInOut')
		
		runTimer('JukeBoxWait', 3, 1)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	-- A loop from a timer you called has been completed, value "tag" is it's tag
	-- loops = how many loops it will have done when it ends completely
	-- loopsLeft = how many are remaining
	if tag == 'JukeBoxWait' then
		doTweenX('MoveOutOne', 'JukeBoxTag', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutTwo', 'JukeBox', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutThree', 'JukeBoxText', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutFour', 'JukeBoxSubText', -450, 1.5, 'CircInOut')
		doTweenX('MoveOutFive', 'JukeBoxAuthor', -450, 1.5, 'CircInOut')
	end
end