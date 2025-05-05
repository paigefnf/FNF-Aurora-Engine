package funkin.backend.system;

import flixel.system.FlxAssets;
import flixel.system.ui.FlxSoundTray;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import haxe.io.Bytes;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import openfl.utils.Assets;
#if sys
import sys.FileSystem;
import sys.io.File;
#end

class FunkinSoundTray extends FlxSoundTray
{
	var graphicScale:Float = 0.30;
	var lerpYPos:Float = 0;
	var alphaTarget:Float = 0;

	var volumeMaxSound:String;

	public function new()
	{
		super();

		removeChildren();

		var bg:Bitmap = new Bitmap(getPathImage("objects/soundtray/volumebox"));
		bg.scaleX = graphicScale;
		bg.scaleY = graphicScale;
		addChild(bg);

		y = -height;
		visible = false;

		var backingBar:Bitmap = new Bitmap(getPathImage('objects/soundtray/bars_10'));
		backingBar.x = 9;
		backingBar.y = 5;
		backingBar.scaleX = graphicScale;
		backingBar.scaleY = graphicScale;
		addChild(backingBar);
		backingBar.alpha = 0.4;

		_bars = [];

		for (i in 1...11)
		{
			var bar:Bitmap = new Bitmap(getPathImage('objects/soundtray/bars_$i'), false);
			bar.x = 9;
			bar.y = 5;
			bar.scaleX = graphicScale;
			bar.scaleY = graphicScale;
			addChild(bar);
			_bars.push(bar);
		}

		y = -height;
		screenCenter();

		volumeUpSound = 'Volup';
		volumeDownSound = 'Voldown';
		volumeMaxSound = 'VolMAX';
	}

	function getPathImage(path:String):Dynamic
	{
		final ext = 'png';
		final file = Paths.getPath('images/$path.$ext');

		return Assets.getBitmapData(file);
	}

	override public function update(MS:Float):Void
	{
		y = CoolUtil.coolLerp(y, lerpYPos, 0.1);
		alpha = CoolUtil.coolLerp(alpha, alphaTarget, 0.25);

		if (_timer > 0)
		{
			_timer -= (MS / 1000);
			alphaTarget = 1;
		}
		else if (y >= -height)
		{
			lerpYPos = -height - 10;
			alphaTarget = 0;
		}

		if (y <= -height)
		{
			visible = false;
			active = false;

			#if FLX_SAVE
			if (FlxG.save.isBound)
			{
				FlxG.save.data.mute = FlxG.sound.muted;
				FlxG.save.data.volume = FlxG.sound.volume;
				FlxG.save.flush();
			}
			#end
		}
	}

	override public function show(up:Bool = false):Void
	{
		_timer = 1;
		lerpYPos = 10;
		visible = true;
		active = true;
		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

		if (FlxG.sound.muted)
		{
			globalVolume = 0;
		}

		if (!silent)
		{
			var sound = null;
			final path = 'assets/sounds/game/soundtray/';
			sound = FlxAssets.getSound(path + (up ? volumeUpSound : volumeDownSound));

			if (globalVolume == 10)
				sound = FlxAssets.getSound('assets/sounds/game/soundtray/$volumeMaxSound');

			if (sound != null)
				FlxG.sound.load(sound).play();
		}

		for (i in 0..._bars.length)
		{
			if (i < globalVolume)
				_bars[i].visible = true;
			else
				_bars[i].visible = false;
		}
	}
}