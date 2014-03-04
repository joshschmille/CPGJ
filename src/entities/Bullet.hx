package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Bullet extends Entity
{
    private var exp:Explosion;

    public function new(x:Float, y:Float)
    {
        super(x, y);
        graphic = new Image("graphics/bullet.png");
        setHitbox(2, 16);
        type = "bullet";
    }

    public override function moveCollideY(e:Entity)
    {
        scene.remove(e);
        exp = scene.add(new entities.Explosion());
        exp.explode(e.x + e.width / 2, e.y + e.height / 2);
        return true;
    }

    public function checkBounds()
    {
        if (y < -8 || y > HXP.screen.height + 8)
        {
            scene.remove(this);
        }
    }

    public override function update()
    {
        moveBy(0, -32, "electricity");
        checkBounds();
        super.update();
    }

    public override function removed()
    {
        exp = null;
        graphic.destroy();
    }
}