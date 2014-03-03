package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import scenes.MainScene;

class Trail extends Entity
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        graphic = Image.createRect(2, 16, 0xff3ce3);
        setHitbox(2, 16);
        type = "trail";
    }

    public override function moveCollideY(e:Entity)
    {
        scene.remove(e);
        var exp:Explosion = scene.add(new entities.Explosion());
        exp.explode(e.x + e.width / 2, e.y + e.height / 2);
        return true;
    }

    public function checkBounds()
    {
        if (y < -16 || y > HXP.screen.height)
        {
            scene.remove(this);
        }
    }

    public override function update()
    {
        moveBy(0, -16, "electricity");
        checkBounds();
        super.update();
    }
}