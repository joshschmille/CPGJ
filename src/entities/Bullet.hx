package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import scenes.MainScene;

class Bullet extends Entity
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        graphic = new Image("graphics/bullet.png");//Image.createRect(2, 16, 0x3ce33c);
        setHitbox(2, 16);
        type = "bullet";
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
        if (y < -8 || y > HXP.screen.height + 8)
        {
            scene.remove(this);
            //graphic.destroy();
        }
    }

    public override function update()
    {
        moveBy(0, -32, "electricity");
        checkBounds();
        super.update();
    }
}