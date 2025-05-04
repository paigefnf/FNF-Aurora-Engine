@echo off
color 0a
cd ..
@echo on
echo Installing dependencies.
haxelib install lime 8.1.2
haxelib install openfl 9.2.2
haxelib git flixel https://github.com/CodenameCrew/cne-flixel
haxelib git flixel-addons https://github.com/CodenameCrew/cne-flixel-addons
haxelib git flxanimate https://github.com/CodenameCrew/cne-flxanimate
haxelib git hxdiscord_rpc https://github.com/MAJigsaw77/hxdiscord_rpc
haxelib git funkin.vis https://github.com/FunkinCrew/funkVis 22b1ce089dd924f15cdc4632397ef3504d464e90
haxelib git grig.audio https://gitlab.com/haxe-grig/grig.audio.git cbf91e2180fd2e374924fe74844086aab7891666
echo Finished!
pause