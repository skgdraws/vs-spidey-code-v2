package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		#if ACHIEVEMENTS_ALLOWED 'awards', #end
		'credits',
		'options'
	];

	var stowyuwu:FlxSprite;
	var playforfree:FlxSprite;
	var awawduwu:FlxSprite;
	var owptionsuwu:FlxSprite;
	var cweditsuwu:FlxSprite;

	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	override function create()
	{
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBGBlue'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();
		
		playforfree = new FlxSprite(0, 5000).loadGraphic(Paths.image('freeplayimage'));
        playforfree.antialiasing = ClientPrefs.globalAntialiasing;
        playforfree.scrollFactor.set(0);
        playforfree.setGraphicSize(Std.int(playforfree.width * .5));
        playforfree.updateHitbox();
		playforfree.screenCenter();
		playforfree.x = playforfree.x + 300;
		playforfree.y = playforfree.y - 50;
		playforfree.visible = false;
		if (curSelected == 1)
			playforfree.visible = true;
		// FlxTween.tween(playforfree, { x: playforfree.x, y: playforfree.y + 100 }, 2, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut});
		add(playforfree);
		
		stowyuwu = new FlxSprite(0, 5000).loadGraphic(Paths.image('storyimage'));
        stowyuwu.antialiasing = ClientPrefs.globalAntialiasing;
        stowyuwu.scrollFactor.set(0);
        stowyuwu.setGraphicSize(Std.int(stowyuwu.width * .5));
        stowyuwu.updateHitbox();
		stowyuwu.screenCenter();
		stowyuwu.x = stowyuwu.x + 300;
		stowyuwu.y = stowyuwu.y - 50;
		stowyuwu.visible = false;
		if (curSelected == 0)
			stowyuwu.visible = true;
		add(stowyuwu);
		// FlxTween.tween(stowyuwu, { x: stowyuwu.x, y: stowyuwu.y + 100 }, 2, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut});
		
		awawduwu = new FlxSprite(0, 5000).loadGraphic(Paths.image('awardsimage'));
        awawduwu.antialiasing = ClientPrefs.globalAntialiasing;
        awawduwu.scrollFactor.set(0);
        awawduwu.setGraphicSize(Std.int(awawduwu.width * .5));
		awawduwu.updateHitbox();
        awawduwu.screenCenter();
		awawduwu.x = awawduwu.x + 300;
		awawduwu.y = awawduwu.y - 50;
		awawduwu.visible = false;
		if (curSelected == 2)
			awawduwu.visible = true;
        add(awawduwu);
		// FlxTween.tween(awawduwu, { x: awawduwu.x, y: awawduwu.y + 100 }, 2, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut});

		cweditsuwu = new FlxSprite(0, 5000).loadGraphic(Paths.image('creditsimage'));
        cweditsuwu.antialiasing = ClientPrefs.globalAntialiasing;
        cweditsuwu.scrollFactor.set(0);
        cweditsuwu.setGraphicSize(Std.int(cweditsuwu.width * .5));
		cweditsuwu.updateHitbox();
		cweditsuwu.screenCenter();
		cweditsuwu.x = cweditsuwu.x + 300;
		cweditsuwu.y = cweditsuwu.y - 50;
		cweditsuwu.visible = false;
		if (curSelected == 3)
			cweditsuwu.visible = true;
        add(cweditsuwu);
		// FlxTween.tween(cweditsuwu, { x: cweditsuwu.x, y: cweditsuwu.y + 100 }, 2, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut});
		
		owptionsuwu = new FlxSprite(0, 5000).loadGraphic(Paths.image('optionsimage'));
        owptionsuwu.antialiasing = ClientPrefs.globalAntialiasing;
        owptionsuwu.scrollFactor.set(0);
        owptionsuwu.setGraphicSize(Std.int(owptionsuwu.width * .5));
		owptionsuwu.updateHitbox();
		owptionsuwu.screenCenter();
		owptionsuwu.x = owptionsuwu.x + 300;
		owptionsuwu.y = owptionsuwu.y - 50;
		owptionsuwu.visible = false;
		if (curSelected == 4)
			owptionsuwu.visible = true;
        add(owptionsuwu);
		// FlxTween.tween(owptionsuwu, { x: owptionsuwu.x, y: owptionsuwu.y + 100 }, 2, { type: FlxTween.PINGPONG, ease: FlxEase.quadInOut});


		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 0.7;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(95, (i * 145)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			// menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		var versionShit:FlxText = new FlxText(1070, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(1000, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
				if (optionShit[curSelected] == 'freeplay')
					{
						playforfree.visible = true;
						owptionsuwu.visible = false;
						stowyuwu.visible = false;
						awawduwu.visible = false;
						cweditsuwu.visible = false;
					}
					if (optionShit[curSelected] == 'story_mode')
					{
						playforfree.visible = false;
						owptionsuwu.visible = false;
						stowyuwu.visible = true;
						awawduwu.visible = false;
						cweditsuwu.visible = false;
					}
	
					if (optionShit[curSelected] == 'awards')
					{
						playforfree.visible = false;
						owptionsuwu.visible = false;
						stowyuwu.visible = false;
						awawduwu.visible = true;
						cweditsuwu.visible = false;
					}
					if (optionShit[curSelected] == 'credits')
					{
						playforfree.visible = false;
						owptionsuwu.visible = false;
						stowyuwu.visible = false;
						awawduwu.visible = false;
						cweditsuwu.visible = true;
					}
					if (optionShit[curSelected] == 'options')
					{
						playforfree.visible = false;
						owptionsuwu.visible = true;
						stowyuwu.visible = false;
						awawduwu.visible = false;
						cweditsuwu.visible = false;
					}
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
				if (optionShit[curSelected] == 'freeplay')
					{
						playforfree.visible = true;
						owptionsuwu.visible = false;
						stowyuwu.visible = false;
						awawduwu.visible = false;
						cweditsuwu.visible = false;
					}
					if (optionShit[curSelected] == 'story_mode')
					{
						playforfree.visible = false;
						owptionsuwu.visible = false;
						stowyuwu.visible = true;
						awawduwu.visible = false;
						cweditsuwu.visible = false;
					}
	
					if (optionShit[curSelected] == 'awards')
					{
						playforfree.visible = false;
						owptionsuwu.visible = false;
						stowyuwu.visible = false;
						awawduwu.visible = true;
						cweditsuwu.visible = false;
					}
					if (optionShit[curSelected] == 'credits')
					{
						playforfree.visible = false;
						owptionsuwu.visible = false;
						stowyuwu.visible = false;
						awawduwu.visible = false;
						cweditsuwu.visible = true;
					}
					if (optionShit[curSelected] == 'options')
					{
						playforfree.visible = false;
						owptionsuwu.visible = true;
						stowyuwu.visible = false;
						awawduwu.visible = false;
						cweditsuwu.visible = false;
					}
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			// spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
