package funkin.backend.assets;

import haxe.io.Path;
import openfl.utils.Assets;

class Paths
{
	public static var weekDirectory:String;

	public static var SOUND_EXT:String = Globals.DEFAULT_SOUND_EXT;
	public static var VIDEO_EXT:String = Globals.DEFAULT_VIDEO_EXT;

	inline public static function getPath(key:String, ?library:String)
	{
		var level:String = weekDirectory != null ? weekDirectory : library;
		var path:String = '$level:assets/$level/$key';
		path = Assets.exists(path) ? path : 'assets/$level/$key'; // if theres no actual library check for parent folder
		return Assets.exists(path) ? path : 'assets/$key';
	}

	inline public static function removeExt(key:String)
		return Path.withoutExtension(key);

	inline public static function file(key:String, ?library:String)
		return getPath(key, library);

	inline public static function dataFile(key:String, ?library:String)
		return getPath('data/$key', library);

	inline public static function txt(key:String, ?library:String)
		return dataFile('$key.txt', library);

	inline public static function xml(key:String, ?library:String)
		return dataFile('$key.xml', library);

	inline public static function json(key:String, ?library:String)
		return dataFile('$key.json', library);

	inline public static function font(key:String, ?library:String)
		return getPath('fonts/$key', library);

	inline public static function image(key:String, ?library:String)
		return getPath('images/$key.png', library);

	inline public static function sound(key:String, ?library:String)
		return getPath('sounds/$key.$SOUND_EXT', library);

	inline public static function music(key:String, ?library:String)
		return getPath('music/$key.$SOUND_EXT', library);

	inline public static function video(key:String, ?library:String)
		return getPath('videos/$key.$VIDEO_EXT', library);

	inline public static function vert(key:String, ?library:String)
		return getPath('shaders/$key.vert', library);

	inline public static function frag(key:String, ?library:String)
		return getPath('shaders/$key.frag', library);
}