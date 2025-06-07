package funkin.backend.system;

import flixel.graphics.FlxGraphic;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import flixel.FlxG;
import funkin.backend.system.framerate.FPSCounter;
import funkin.backend.settings.Options.Option;
import funkin.backend.system.FunkinSoundTray;
import funkin.menus.TitleState;

#if html5
import lime.graphics.Image;
#end



class Main extends Sprite
{
	public static final game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		}
		else
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
			{
				var ratioX:Float = stageWidth / game.width;
				var ratioY:Float = stageHeight / game.height;
				game.zoom = Math.min(ratioX, ratioY);
				game.width = Math.ceil(stageWidth / game.zoom);
				game.height = Math.ceil(stageHeight / game.zoom);
			}
		

		#if !debug
		initialState = TitleState;
		#end

		addChild(new FlxGame(game.width, game.height, game.initialState, #if (flixel < "5.0.0") game.zoom, #end game.framerate, game.framerate, game.skipSplash, game.startFullscreen));

		#if !mobile
		fpsCounter = new FPSCounter(10, 3, 0xFFFFFF);
		addChild(fpsCounter);

		if(FlxG.save.data.fps == null)
			FlxG.save.data.fps = true;

		toggleFPS(FlxG.save.data.fps);
		#end

		#if html5
		var icon = Image.fromFile("icon.png");
		#end

		Option.setupSaveData();
		Conductor.offset = FlxG.save.data.notesOffset;
	}

	var fpsCounter:FPSCounter;

	public function toggleFPS(fpsEnabled:Bool):Void 
	{
		fpsCounter.visible = fpsEnabled;
	}
}