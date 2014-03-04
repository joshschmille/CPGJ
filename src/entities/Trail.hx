package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import scenes.MainScene;

class Trail extends Entity
{
    public function new(x:Float, y:Float, c:Int)
    {
        super(x, y);
        graphic = new Image("graphics/playerTrail.png");//Image.createRect(8, 33, c);
        //cast(this.graphic, Image).alpha = 0.6;
        setHitbox(8, 16);
        type = "trail";
        layer = 1;
    }

    public override function moveCollideY(e:Entity)
    {
        scene.remove(this);
        //graphic.destroy();
        return true;
    }

    public function checkBounds()
    {
        if (y < -32 || y > HXP.screen.height)
        {
            scene.remove(this);
            //graphic.destroy();
        }
    }

    public override function update()
    {
        moveBy(0, -32);
        checkBounds();
        super.update();
    }

    //private var onLeft:Bool = true;
}