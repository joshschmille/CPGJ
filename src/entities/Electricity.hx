package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

import scenes.MainScene;

class Electricity extends Entity
{
    public function new(x:Float, y:Float)
    {
        super(x, y);
        graphic = new Image("graphics/electricity.png");//Image.createRect(128, 32, 0xa7cce9);
        setHitbox(128, 32);
        type = "electricity";
        layer = 0;
    }

    public override function moveCollideY(e:Entity)
    {
        if (e.type == "player")
        {
            MainScene._player.takeDamage(1);
        }
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
            //graphic.destroy();
        }
    }

    public override function update()
    {
        moveBy(0, -10, ["player"]);
        checkBounds();
        super.update();
    }

    function randomMinMax(min:Float, max:Float):Float
    {
        return min + (max - min) * Math.random();
    }
}