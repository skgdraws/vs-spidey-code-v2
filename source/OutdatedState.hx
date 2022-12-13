package;

import flixel.tweens.FlxEase;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class OutdatedState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	var logo:FlxSprite;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 100, FlxG.width,
			"Welcome to Vs. Spider-man V2: Enhanced Edition!" +

			"\n\nThis is a patched version of the second update that we posted" +
			"\nback at the end of July. Sorry that we took so long" +
			"\nWe've been working on the 3rd and last version of this mod!" +
			"\nso, Stay tuned for that!",
			25);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(X);
		add(warnText);

		logo = new FlxSprite(0, 100, Paths.image('logo-v2', 'preload'));
		logo.setGraphicSize(Std.int(logo.width * 0.5));
		logo.screenCenter(X);
		FlxTween.angle(logo, -10, 10, 3, { type: PINGPONG, ease: FlxEase.quadInOut } );
		add(logo);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT || controls.BACK) {
				leftState = true;
				// CoolUtil.browserLoad("https://github.com/ShadowMario/FNF-PsychEngine/releases");
				FlxG.sound.play(Paths.sound('confirmMenu'));
				FlxTween.tween(logo, {alpha: 0}, 1);
				FlxTween.tween(warnText, {alpha: 0}, 1, {
					onComplete: function (twn:FlxTween) {
						MusicBeatState.switchState(new MainMenuState());
					}
				});
			}
		}
		super.update(elapsed);
	}
}
