package entities;

//import com.haxepunk.Entity;
//import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

class Trail extends com.haxepunk.Entity
{
    public function new(x:Float, y:Float, t:Image)
    {
        super(x, y);
        graphic = t;
        layer = 1;
    }

    // private inline function checkBounds()
    // {
    //     if (y < -32 || y > HXP.screen.height)
    //     {
    //         /*graphic.destroy();
    //         graphic = null;*/
    //         scene.remove(this);
    //     }
    // }

    public override function update()
    {
        moveBy(0, -32);
        //checkBounds();

        if (y < -32) scene.remove(this);

        super.update();
    }

    public override function removed()
    {

    }
}