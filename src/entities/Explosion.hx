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
		_emitter = new Emitter("graphics/block.png", 12, 12);
		_emitter.newType("explode", [0]);
		_emitter.setMotion("explode", 0, 75, 0.1, 180, -4, 1, Ease.quadOut);
		_emitter.setAlpha("explode", 20, 0.1);
        _emitter.setGravity("explode", 15, 1);
		graphic = _emitter;
		layer = -1;
    }

    public function checkBounds()
    {
        if (y > HXP.screen.height)
        {
            scene.remove(this);
        }
    }

    public override function update()
    {
        //moveBy(0, 5, "player");
        checkBounds();
        super.update();
    }

    public function explode(_x:Float, _y:Float)
    {
    	for(i in 0...80) {
			_emitter.emit("explode", _x, _y);
		}
    }

    private var _emitter:Emitter;
}