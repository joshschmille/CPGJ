package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Enemy extends Entity
{
    private var _width:Int;
    private var _height:Int;
    private var _player:Player;
    private var exp:Explosion;
    private var trailImage:Image;

    private var collidables:Array<String>;

    public function new(x:Float, y:Float, p:Player, e:Image)
    {
        super(x, y);

        _width = 32;
        _height = 32;
        _player = p;
        shootTimer = 0.1;

        collidables = ["bullet", "player", "electricity", "enemy"];

        graphic = e;//new Image("graphics/enemy.png");
        trailImage = new Image("graphics/enemyTrail.png");

        cast(graphic, Image).centerOrigin();

        setHitbox(_width, _height, Std.int(_width / 2), Std.int(_height / 2));
        type = "enemy";
        layer = 0;

        _xTarget = Math.random() * 640;//(_player.x - 320, _player.x + 320);
        _xOffset = _xTarget - _player.x;
        _yTarget = HXP.clamp(Math.random() * 407, 251, 407);//randomMinMax(_player.y - 128, _player.y + 128);
    }

    public override function moveCollideY(e:Entity)
    {
        if (e.type == "player")
        {
            _player.takeDamage(1);
        }
        /*exp = scene.add(new entities.Explosion());
        exp.enemyDeath(x + width / 2, y + height / 2);*/
        scene.remove(this);

        /*if (!_player.dead && e.type != "enemy")
            scenes.MainScene.score += 10;*/

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
        scene.add(new Trail(x - 4, y - halfHeight, trailImage));
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
        moveBy(0, 5, /*["bullet", "player", "electricity", "enemy"]*/ collidables);

        moveTowards(_player.x - _xOffset, _yTarget, 6);

        //shootTimer -= HXP.elapsed;

        checkBounds();
        super.update();
    }

    /*public override function removed()
    {
        _player = null;
        collidables = null;
    }*/

    private var _xTarget:Float;
    private var _xOffset:Float;
    private var _finalXTarget:Float;
    private var _yTarget:Float;
    private var shootTimer:Float;
}