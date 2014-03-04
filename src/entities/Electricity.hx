package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Electricity extends Entity
{

    private var _player:Player;
    //private var exp:Explosion;

    public function new(x:Float, y:Float, p:Player, e:Image)
    {
        super(x, y);

        _player = p;

        graphic = e;//new Image("graphics/electricity.png");
        setHitbox(128, 32);
        type = "electricity";
        layer = 0;
    }

    public override function moveCollideY(e:Entity)
    {
        if (e.type == "player")
        {
            _player.takeDamage(1);
        }
        /*exp = scene.add(new entities.Explosion());
        exp.explode(x + width / 2, y + height / 2);*/
        scene.remove(this);
        return true;
    }

    public function checkBounds()
    {
        if (y < -64)
        {
            graphic.destroy();
            graphic = null;
            scene.remove(this);
        }
    }

    public override function update()
    {
        moveBy(0, -10, ["player"]);
        checkBounds();
        super.update();
    }

    public override function removed()
    {
        _player = null;
    }
}