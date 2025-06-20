package funkin.play.notes;

import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxG;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end

using StringTools;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var willMiss:Bool = false;
	public var altNote:Bool = false;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;

	public static var swagWidth:Float = 160 * 0.7;
	public static var PURP_NOTE:Int = 0;
	public static var GREEN_NOTE:Int = 2;
	public static var BLUE_NOTE:Int = 1;
	public static var RED_NOTE:Int = 3;

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false)
	{
		super();

		if (prevNote == null)
			prevNote = this;

		this.prevNote = prevNote;
		isSustainNote = sustainNote;

		x += (FlxG.save.data.middlescroll) + 50;
		// MAKE SURE ITS DEFINITELY OFF SCREEN?
		y -= 2000;
		this.strumTime = strumTime;

		this.noteData = noteData;

		var daStage:String = PlayState.curStage;

		switch (daStage)
		{
			case 'school' | 'schoolEvil':
				/* Assets */
				frames = Paths.getSparrowAtlas('game/notes/pixel/strums');
	
				/* Notes */
				animation.addByPrefix('purple', 'noteLeft');
				animation.addByPrefix('blue', 'noteDown');
				animation.addByPrefix('green', 'noteUp');
				animation.addByPrefix('red', 'noteRight');

				if (isSustainNote)
				{
					loadGraphic(Paths.image('game/notes/pixel/tails'), true, 7, 6);

					animation.add('purpleholdend', [4]);
					animation.add('greenholdend', [6]);
					animation.add('redholdend', [7]);
					animation.add('blueholdend', [5]);

					animation.add('purplehold', [0]);
					animation.add('greenhold', [2]);
					animation.add('redhold', [3]);
					animation.add('bluehold', [1]);
				}

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

			default:
				/* Assets */
				frames = Paths.getSparrowAtlas('game/notes/notes');
				frames = Paths.getSparrowAtlas('game/notes/tails');
	
				/* Notes */
				animation.addByPrefix('purple', 'noteLeft');
				animation.addByPrefix('blue', 'noteDown');
				animation.addByPrefix('green', 'noteUp');
				animation.addByPrefix('red', 'noteRight');

				/* Holds */
				animation.addByPrefix('purpleholdend', 'purple hold end');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');
	
				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');
	
				setGraphicSize(Std.int(width * 0.7));
				updateHitbox();
				antialiasing = true;
		}

		/**
		 * Code originally from psych engine; with tweaks from FNF' Definitive Edition
		 * Doing this 'if' check to fix the warnings on Senpai songs
		 */
		x += swagWidth * (noteData % 4);
		if (!isSustainNote) 
		{
			var animToPlay:String = '';	
			switch (noteData % 4)
			{
				case 0:
					animToPlay = 'purple';
				case 1:
					animToPlay = 'blue';
				case 2:
					animToPlay = 'green';
				case 3:
					animToPlay = 'red';
			}
			animation.play(animToPlay + 'Scroll');
		}

		if (isSustainNote && prevNote != null)
		{
			alpha = 0.6;

			if (FlxG.save.data.downscroll)
				angle = 180;

			x += width / 2;

			switch (noteData)
			{
				case 2:
					animation.play('greenholdend');
				case 3:
					animation.play('redholdend');
				case 1:
					animation.play('blueholdend');
				case 0:
					animation.play('purpleholdend');
			}

			updateHitbox();

			x -= width / 2;

			if (PlayState.curStage.startsWith('school'))
				x += 30;

			if (prevNote.isSustainNote)
			{
				switch (prevNote.noteData)
				{
					case 0:
						prevNote.animation.play('purplehold');
					case 1:
						prevNote.animation.play('bluehold');
					case 2:
						prevNote.animation.play('greenhold');
					case 3:
						prevNote.animation.play('redhold');
				}

				prevNote.scale.y *= Conductor.stepCrochet / 100 * 1.5 * PlayState.SONG.speed;
				prevNote.updateHitbox();
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (mustPress)
		{
			if (willMiss && !wasGoodHit)
			{
				tooLate = true;
				canBeHit = false;
			}
			else
			{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset)
				{
					if (strumTime < Conductor.songPosition + 0.7 * Conductor.safeZoneOffset)
						canBeHit = true;
				}
				else
				{
					willMiss = true;
					canBeHit = true;
				}
			}		
		}
		else
		{
			canBeHit = false;

			if (strumTime <= Conductor.songPosition)
				wasGoodHit = true;
		}

		if (tooLate)
		{
			if (alpha > 0.3)
				alpha = 0.3;
		}
	}
}
