package funkin.play.notes;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class NoteSplash extends FlxSprite // Updated Code a lil bit, Code originally take from tr1angle engine.
{
	public function new(x:Float, y:Float, ?notedata:Int = 0)
	{
		super(x, y);

		/*case 'school' | 'schoolEvil':
			frames = Paths.getSparrowAtlas('game/splashes/pixel/splashes');

			animation.addByPrefix('note0-0', 'purple1', 24, false);
			animation.addByPrefix('note1-0', 'blue1', 24, false);
			animation.addByPrefix('note2-0', 'green1', 24, false);
			animation.addByPrefix('note3-0', 'red1', 24, false);
	
			animation.addByPrefix('note0-1', 'purple2', 24, false);
			animation.addByPrefix('note1-1', 'blue2', 24, false);
			animation.addByPrefix('note2-1', 'green2', 24, false);
			animation.addByPrefix('note3-1', 'red2', 24, false);

			animation.addByPrefix('note0-2', 'purple3', 24, false);
			animation.addByPrefix('note1-2', 'blue3', 24, false);
			animation.addByPrefix('note2-2', 'green3', 24, false);
			animation.addByPrefix('note3-2', 'red3', 24, false);
			setupNoteSplash(x, y, notedata);
			
		default: */
		frames = Paths.getSparrowAtlas('game/splashes/base/splashes');

		animation.addByPrefix('note0-0', 'purple splash 1', 24, false);
		animation.addByPrefix('note1-0', 'blue splash 1', 24, false);
		animation.addByPrefix('note2-0', 'green splash 1', 24, false);
		animation.addByPrefix('note3-0', 'red splash 1', 24, false);

		animation.addByPrefix('note0-1', 'purple splash 2', 24, false);
		animation.addByPrefix('note1-1', 'blue splash 2', 24, false);
		animation.addByPrefix('note2-1', 'green splash 2', 24, false);
		animation.addByPrefix('note3-1', 'red splash 2', 24, false);
		setupNoteSplash(x, y, notedata);
	}

	public function setupNoteSplash(x:Float, y:Float, ?notedata:Int = 0)
	{
		setPosition(x, y);
		alpha = 0.6;

		animation.play('note' + notedata + '-' + FlxG.random.int(0, 1), true);
		updateHitbox();

		offset.set(width * 0.3, height * 0.3);
	}

	override public function update(elapsed:Float)
	{
		if (animation.curAnim.finished)
			kill();
			
		super.update(elapsed);
	}
}