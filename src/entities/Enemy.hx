package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

import scenes.MainScene;

class Enemy extends Entity
{
    private static var _width:Int = 32;
    private static var _height:Int = 32;

    public function new(x:Float, y:Float)
    {
        super(x, y);

        graphic = new Image("graphics/enemy.png");//Image.createRect(_width, _height, 0x6c0c0c);

        cast(graphic, Image).centerOrigin();

        setHitbox(_width, _height, Std.int(_width / 2), Std.int(_height / 2));
        type = "enemy";
        layer = 0;

        _xTarget = randomMinMax(MainScene._player.x - 320, MainScene._player.x + 320);
        _xOffset = _xTarget - MainScene._player.x;
        _yTarget = randomMinMax(MainScene._player.y - 128, MainScene._player.y + 128);
    }

    public override function moveCollideY(e:Entity)
    {
        if (e.type == "player")
        {
            MainScene._player.takeDamage(1);
        }
        var exp:Explosion = scene.add(new entities.Explosion());
        exp.enemyDeath(x + width / 2, y + height / 2);
        scene.remove(this);
        //graphic.destroy();

        if (!MainScene._player.dead && e.type != "enemy")
            MainScene.score += 10;

        return true;
    }

    public function checkBounds()
    {
        if (y < -64 || y > HXP.screen.height)
        {
            scene.remove(this);
            //graphic.destroy();
        }
        if (x < -64 || x > HXP.screen.width + 64)
        {
            scene.remove(this);
            //graphic.destroy();
        }
    }

    public function addTrail()
    {
        scene.add(new Trail(x - 4, y - halfHeight, 0xf37349));
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
            shoot();
        }
        moveBy(0, 5, ["bullet", "player", "electricity", "enemy"]);

        moveTowards(MainScene._player.x - _xOffset, _yTarget, 6);

        shootTimer -= HXP.elapsed;

        checkBounds();
        super.update();
    }

    function randomMinMax(min:Float, max:Float):Float
    {
        return min + (max - min) * Math.random();
    }

    private var _xTarget:Float;
    private var _xOffset:Float;
    private var _finalXTarget:Float;
    private var _yTarget:Float;
    private var shootTimer:Float = 0.1;
}