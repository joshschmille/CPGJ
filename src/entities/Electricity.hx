package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Electricity extends Entity
{
    public function new(x:Float, y:Float)
    {
        super(x, y);

        graphic = Image.createRect(128, 32, 0xa7cce9);
        setHitbox(128, 32);
        type = "electricity";
    }

    public override function moveCollideY(e:Entity)
    {
        var exp:Explosion = scene.add(new entities.Explosion());
        exp.explode(x + width / 2, y + height / 2);
        scene.remove(this);
        return true;
    }

    public function checkBounds()
    {
        if (y < -64)
        {
            scene.remove(this);
        }
    }

    public override function update()
    {
        moveBy(0, -5, "player");
        checkBounds();
        super.update();
    }
}