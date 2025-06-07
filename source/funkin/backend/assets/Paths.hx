package funkin.backend.assets;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.system.System;
import openfl.utils.Assets as OpenFlAssets;
import flixel.graphics.FlxGraphic;

class Paths
{
	inline public static var SOUND_EXT = #if web "mp3" #else "ogg" #end;

	static var currentLevel:String;

	static public function setCurrentLevel(name:String)
	{
		currentLevel = name.toLowerCase();
	}
	public static function getPath(file:String, ?type:AssetType = TEXT, ?library:Null<String> = null, ?modsAllowed:Bool = false):String
		{
			#if MODS_ALLOWED
			if(modsAllowed)
			{
				var customFile:String = file;
				if (library != null)
					customFile = '$library/$file';
	
				var modded:String = modFolders(customFile);
				if(FileSystem.exists(modded)) return modded;
			}
			#end
	
			if (library != null)
				return getLibraryPath(file, library);
	
			if (currentLevel != null)
			{
				var levelPath:String = '';
				if(currentLevel != 'shared') {
					levelPath = getLibraryPathForce(file, 'week_assets', currentLevel);
					if (OpenFlAssets.exists(levelPath, type))
						return levelPath;
				}
			}
	
			return getSharedPath(file);
		}

	public static function excludeAsset(key:String) 
	{
		if (!dumpExclusions.contains(key))
			dumpExclusions.push(key);
	}

	public static var dumpExclusions:Array<String> =
	[
		'assets/music/menus/freakyMenu.$SOUND_EXT',
		'assets/music/breakfast.$SOUND_EXT',
	];

	public static var currentTrackedAssets:Map<String, FlxGraphic> = [];
	public static var localTrackedAssets:Array<String> = [];
	public static function clearUnusedMemory() 
	{
		for (key in currentTrackedAssets.keys()) 
		{
			if (!localTrackedAssets.contains(key) && !dumpExclusions.contains(key)) 
			{
				var obj = currentTrackedAssets.get(key);
				@:privateAccess
				
				if (obj != null) 
				{
					openfl.Assets.cache.removeBitmapData(key);
					FlxG.bitmap._cache.remove(key);
					obj.destroy();
					currentTrackedAssets.remove(key);
				}
			}
		}

		// run the garbage collector for good measure lmfao
		System.gc();
	}

	public static function clearStoredMemory(?cleanUnused:Bool = false) 
	{
		// clear anything not in the tracked assets list
		@:privateAccess
		for (key in FlxG.bitmap._cache.keys())
		{
			var obj = FlxG.bitmap._cache.get(key);
			if (obj != null && !currentTrackedAssets.exists(key)) 
			{
				openfl.Assets.cache.removeBitmapData(key);
				FlxG.bitmap._cache.remove(key);
				obj.destroy();
			}
		}

		// flags everything to be cleared out next unused memory clear
		localTrackedAssets = [];
		#if !html5 openfl.Assets.cache.clear("songs"); #end
	}

	static public function getLibraryPath(file:String, library = "shared")
	{
		return if (library == "shared") getSharedPath(file); else getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:String, ?level:String)
		{
			if(level == null) level = library;
			var returnPath = '$library:assets/$level/$file';
			return returnPath;
		}

	inline static function getSharedPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT, ?library:String)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:String)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:String)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:String)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:String)
	{
		return getPath('sounds/$key.$SOUND_EXT', SOUND, library);
	}

	inline static public function soundRandom(key:String, min:Int, max:Int, ?library:String)
	{
		return sound(key + FlxG.random.int(min, max), library);
	}

	inline static public function music(key:String, ?library:String)
	{
		return getPath('music/$key.$SOUND_EXT', MUSIC, library);
	}

	inline static public function voices(song:String)
	{
		return 'songs:assets/music/songs/${song.toLowerCase()}/Voices.$SOUND_EXT';
	}

	inline static public function inst(song:String)
	{
		return 'songs:assets/music/songs/${song.toLowerCase()}/Inst.$SOUND_EXT';
	}

	inline static public function image(key:String, ?library:String)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function video(key:String, ?library:String)
	{
		return getPath('videos/$key.mp4', TEXT, library);
	}

	inline static public function getSparrowAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:String)
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}
}
