package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.HXP;
import com.haxepunk.utils.Ease;

class Explosion extends Entity
{
    public function new()
    {
        super(x, y);

        _emitter = new Emitter("graphics/death.png", 4, 4);
        _emitter.newType("death", [0]);
        _emitter.setMotion("death",                     // Name
                            0,                          // Angle
                            150,                         // Distance
                            0.1,                        // Duration
                            360,      // ? Angle Range (180)
                            randomMinMax(-12, 4),       // ? Distance Range (-4)
                            1,                          // ? Duration Range
                            Ease.quadOut                // ? Easing
                        );
        _emitter.setAlpha("death", 20, 0.1);
        _emitter.setGravity("death", 5, 1);
        graphic = _emitter;
        layer = -1;
    }

    public function checkBounds()
    {
        if (y < 0 || y > HXP.screen.height)
        {
            scene.remove(this);
        }
    }

    public override function update()
    {
        moveBy(0, 1);
        checkBounds();
        super.update();
    }

    public function explode(_x:Float, _y:Float)
    {
        _emitter = new Emitter("graphics/block.png", 12, 12);
        _emitter.newType("explode", [0]);
        _emitter.setMotion("explode",                   // Name
                            0,                          // Angle
                            75,                         // Distance
                            0.1,                        // Duration
                            randomMinMax(90, 270),      // ? Angle Range (180)
                            randomMinMax(-12, 4),       // ? Distance Range (-4)
                            1,                          // ? Duration Range
                            Ease.quadOut                // ? Easing
                        );
        _emitter.setAlpha("explode", 20, 0.1);
        _emitter.setGravity("explode", 10, 1);
        graphic = _emitter;
        layer = -1;

    	for(i in 0...80)
        {
            _emitter.emit("explode", _x, _y);
		}
    }

    public function enemyDeath(_x:Float, _y:Float)
    {
        _emitter = new Emitter("graphics/death.png", 4, 4);
        _emitter.newType("death", [0]);
        _emitter.setMotion("death",                     // Name
                            0,                          // Angle
                            150,                         // Distance
                            0.1,                        // Duration
                            360,      // ? Angle Range (180)
                            randomMinMax(-12, 4),       // ? Distance Range (-4)
                            1,                          // ? Duration Range
                            Ease.quadOut                // ? Easing
                        );
        _emitter.setAlpha("death", 20, 0.1);
        _emitter.setGravity("death", 5, 1);
        graphic = _emitter;
        layer = -1;

        for(i in 0...160)
        {
            _emitter.emit("death", _x, _y);
        }
    }

    public function playerDeath(_x:Float, _y:Float)
    {
        _emitter = new Emitter("graphics/playerDeath.png", 8, 8);
        _emitter.newType("death", [0]);
        _emitter.setMotion("death",                     // Name
                            0,                          // Angle
                            300,                        // Distance
                            0.1,                        // Duration
                            360,                        // ? Angle Range (180)
                            -32,                        // ? Distance Range (-4)
                            1,                          // ? Duration Range
                            Ease.quadOut                // ? Easing
                        );
        _emitter.setAlpha("death", 20, 0.1);
        _emitter.setGravity("death", 3, 1);
        graphic = _emitter;
        layer = -1;

        for(i in 0...320)
        {
            _emitter.emit("death", _x, _y);
        }
    }

    /*public override function removed()
    {
        _emitter = null;
        trace("emitter destroyed");
        graphic.destroy();
    }*/

    function randomMinMax(min:Float, max:Float):Float
    {
        return min + (max - min) * Math.random();
    }

    private var _emitter:Emitter;
}