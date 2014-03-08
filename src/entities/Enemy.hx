package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;

class Enemy extends Entity
{
    private static inline var _width:Int = 32;
    private static var _height:Int = 32;

    private var _player:Player;
    private var _trailImage:Image;
    private var _emitter:Emitter;

    private var _xTarget:Float;
    private var _xOffset:Float;
    private var _finalXTarget:Float;
    private var _yTarget:Float;

    public function new(x:Float, y:Float, p:Player, e:Image, t:Image)
    {
        super(x, y);

        _player = p;

        _emitter = new Emitter(scenes.MainScene.atlas.getRegion("enemyDeath.png"), 5, 5);
        _emitter.newType("explode", [0]);
        _emitter.setMotion("explode",
                            0,
                            150,
                            0.1,
                            360,
                            -4,
                            1,
                            Ease.quadOut
                            );
        _emitter.setAlpha("explode", 20, 0.1);
        _emitter.setGravity("explode", 5, 1);

        var _image:Image = new Image(scenes.MainScene.atlas.getRegion("enemy.png"));
        graphic = _image;

        _trailImage = t;

        cast(graphic, Image).centerOrigin();

        setHitbox(_width, _height, Std.int(_width / 2), Std.int(_height / 2));
        type = "enemy";
        layer = 0;

        _xTarget = Math.random() * 640;
        _xOffset = _xTarget - _player.x;
        _yTarget = HXP.clamp(Math.random() * 407, 251, 407);
    }

    public override function moveCollideY(e:Entity)
    {
        if (type != "dead")
        {
            if (e.type == "dead")
                return false;

            if (e.type == "player")
                _player.takeDamage(1);

            if (e.type != "dead" && e.type != "enemy")
                scenes.MainScene.score += 10;

            type = "dead";
            graphic = _emitter;
            for(i in 0...80)
            {
                _emitter.emit("explode", width / 2, height / 2);
            }
            return true;
        } else {
            return false;
        }
    }

    public function checkBounds()
    {
        if (y < -64 || y > HXP.screen.height)
        {
            graphic.destroy();
            graphic = null;
            scene.remove(this);
        }
        if (x < -64 || x > HXP.screen.width + 64)
        {
            graphic.destroy();
            graphic = null;
            scene.remove(this);
        }
    }

    public function addTrail()
    {
        scene.add(new Trail(x - 4, y - halfHeight, _trailImage));
    }

    public override function update()
    {
        if (type == "dead")
        {
            if (_emitter.particleCount <= 0)
                scene.remove(this);
        }
        else
        {
            addTrail();
            moveBy(0, 5, ["bullet", "electricity", "enemy", "player"]);
            moveTowards(_player.x - _xOffset, _yTarget, 6);
        }

        checkBounds();
        super.update();
    }

    public override function removed()
    {
        _player = null;
    }
}