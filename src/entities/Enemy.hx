package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;

class Enemy extends Entity
{
    private static var _width:Int;
    private static var _height:Int;
    private var _player:Player;
    private var _trailImage:Image;

    public function new(x:Float, y:Float, p:Player, e:Image, t:Image)
    {
        super(x, y);

        _width = 32;
        _height = 32;
        _player = p;
        shootTimer = 0.1;

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
        if (e.type == "dead")
            return false;
        if (e.type == "player")
        {
            _player.takeDamage(1);
        }

        scene.remove(this);

        if (!_player.dead && e.type != "enemy")
            scenes.MainScene.score += 10;

        return true;
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

    public function shoot()
    {
        scene.add(new Bullet(x - 1, y));
        shootTimer = 0.1;
    }

    public override function update()
    {
        addTrail();
        if (shootTimer < 0)
        {
            //shoot();
        }
        moveBy(0, 5, ["bullet", "electricity", "enemy", "trail"]);

        moveTowards(_player.x - _xOffset, _yTarget, 6);

        if (_player.x - _xOffset < _player.x)
        {
            if (_player.x - _xOffset < 128)
            {
                // BLAH
            }
        }
        else if (_player.x - _xOffset > _player.x)
        {

        }

        //shootTimer -= HXP.elapsed;

        checkBounds();
        super.update();
    }

    public override function removed()
    {
        _player = null;
    }

    private var _xTarget:Float;
    private var _xOffset:Float;
    private var _finalXTarget:Float;
    private var _yTarget:Float;
    private var shootTimer:Float;
}