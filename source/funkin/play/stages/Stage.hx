/*package funkin.play.stages;

import funkin.play.objs.BGSprite;
import funkin.play.PlayState;

class Stage extends BGSprite
{
    //PlayState.defaultCamZoom = 0.9;
    var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stages/week1/stageback'));
    bg.antialiasing = true;
    bg.scrollFactor.set(0.9, 0.9);
    bg.active = false;
    add(bg);

    var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stages/week1/stagefront'));
    stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
    stageFront.updateHitbox();
    stageFront.antialiasing = true;
    stageFront.scrollFactor.set(0.9, 0.9);
    stageFront.active = false;
    add(stageFront);

    var stageLight:FlxSprite = new FlxSprite(-125, -100).loadGraphic(Paths.image('stages/week1/stage_light'));
    stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
    stageLight.antialiasing = true;
    stageLight.updateHitbox();
    add(stageLight);

    var stageLight:FlxSprite = new FlxSprite(1225, -100).loadGraphic(Paths.image('stages/week1/stage_light'));
    stageLight.setGraphicSize(Std.int(stageLight.width * 1.1));
    stageLight.antialiasing = true;
    stageLight.updateHitbox();
    stageLight.flipX = true;
    add(stageLight);

    var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stages/week1/stagecurtains'));
    stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
    stageCurtains.updateHitbox();
    stageCurtains.antialiasing = true;
    stageCurtains.scrollFactor.set(1.3, 1.3);
    stageCurtains.active = false;
    add(stageCurtains);
}*/