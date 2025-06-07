//Discord API
#if DISCORD_ALLOWED
import funkin.backend.Discord;
#end

//Flixel
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
using StringTools;
import flxanimate.*;

//Funkin
import funkin.backend.assets.*;
import funkin.backend.data.*;
import funkin.backend.settings.*;
import funkin.backend.shaders.*;
import funkin.backend.system.*;
import funkin.menus.*;
import funkin.objects.*;
import funkin.play.*;
import funkin.play.cutscenes.*;
import funkin.play.editors.*;
import funkin.play.notes.*;
import funkin.play.stages.*;