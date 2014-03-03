package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Gui extends Entity
{
    public function new(x:Float, y:Float, t:String)
    {
        super(x, y);
        type = t;

        switch (t) {
            case "upButton":
                graphic = new Image("graphics/upButton.png");
            case "rightButton":
                graphic = new Image("graphics/rightButton.png");
            case "downButton":
                graphic = new Image("graphics/downButton.png");
            case "leftButton":
                graphic = new Image("graphics/leftButton.png");
            case "aButton":
                graphic = new Image("graphics/aButton.png");
        }
    }

    public override function update()
    {
        super.update();
    }
}