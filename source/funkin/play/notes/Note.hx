package funkin.play.notes;

import flixel.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.*;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.*;
import flixel.math.FlxMath;
import flixel.system.*;
import flixel.text.*;
import flixel.util.*;
import flixel.util.FlxColor;
import lime.utils.Assets;

class Note extends FlxSprite
{
	public var strumTime:Float = 0;

	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var ignoreNote = false;
	public var notePos:Int = 0;
	public var noteHit:Bool = true;

	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noAnim:Bool = false;
	public var modifiedNote:Bool = false;
	public var isPixelNote:Bool = false;

	public static var swagWidth:Float = 160 * 0.7;

	public var parentNote:Note = null;
	public var susNotes:Array<Note> = [];
	public var stopHit:Bool = false;

	/* Strums */
	public var strumLeft:FlxGraphic = 'objects/notes/base/strumLeft';
	public var strumDown:FlxGraphic = 'objects/notes/base/strumDown';
	public var strumUp:FlxGraphic = 'objects/notes/base/strumUp';
	public var strumRight:FlxGraphic = 'objects/notes/base/strumRight';

	/* Notes & End Tails */
	public var notes(default, set):String = 'objects/notes/base/notes';
	public var noteTails(default, set):String = 'objects/notes/base/tails';

	/* Note Tails Animations*/
	public function loadAnimations(isPixel:Bool = false)
	{
		if (isPixel)
		{
			if (isSustainNote)
			{
				animation.add('purpleholdend', [4]);
				animation.add('greenholdend', [6]);
				animation.add('redholdend', [7]);
				animation.add('blueholdend', [5]);

				animation.add('purplehold', [0]);
				animation.add('greenhold', [2]);
				animation.add('redhold', [3]);
				animation.add('bluehold', [1]);
			}
			else
			{
				animation.add('greenScroll', [6]);
				animation.add('redScroll', [7]);
				animation.add('blueScroll', [5]);
				animation.add('purpleScroll', [4]);
			}
		}
		else
		{
			animation.addByPrefix('greenScroll', 'green0');
			animation.addByPrefix('redScroll', 'red0');
			animation.addByPrefix('blueScroll', 'blue0');
			animation.addByPrefix('purpleScroll', 'purple0');

			animation.addByPrefix('purpleholdend', 'purple hold end');
			animation.addByPrefix('greenholdend', 'green hold end');
			animation.addByPrefix('redholdend', 'red hold end');
			animation.addByPrefix('blueholdend', 'blue hold end');

			animation.addByPrefix('purplehold', 'purple hold piece');
			animation.addByPrefix('greenhold', 'green hold piece');
			animation.addByPrefix('redhold', 'red hold piece');
			animation.addByPrefix('bluehold', 'blue hold piece');
		}

		if (isSustainNote)
		{
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
				default:
					animation.play('purpleholdend');
			}

			if (prevNote != null && prevNote.isSustainNote)
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
			}
		}
	}
}