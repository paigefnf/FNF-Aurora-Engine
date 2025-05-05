@echo off
color 0a
cd ..
@echo on
echo Installing dependencies.
haxelib install lime 8.1.2
haxelib install openfl 9.2.2
haxelib install flixel 
haxelib install flixel-tools
haxelib install flixel-addons
haxelib install flixel-ui
haxelib git flxanimate https://github.com/CodenameCrew/cne-flxanimate
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git
haxelib install hscript
echo Finished!
pause