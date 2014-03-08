package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;
import com.haxepunk.HXP;

class Electricity extends Entity
{

    private var _player:Player;
    private var _emitter:Emitter;

    public function new(x:Float, y:Float, player:Player, e:Image)
    {
        super(x, y);

        _player = player;
        _emitter = new Emitter(scenes.MainScene.atlas.getRegion("electricityDeath.png"), 12, 12);
        _emitter.newType("explode", [0]);
        _emitter.setMotion("explode",
                            0,
                            75,
                            0.1,
                            180,
                            -4,
                            1,
                            Ease.quadOut
                            );
        _emitter.setAlpha("explode", 20, 0.1);
        _emitter.setGravity("explode", 10, 1);

        var _image:Image = new Image(scenes.MainScene.atlas.getRegion("electricity.png"));
        graphic = _image;

        setHitbox(128, 32);
        type = "electricity";
        layer = 0;
    }

    public override function moveCollideY(e:Entity)
    {
        if (type != "dead" && e.type != "dead")
        {
            if (e.type == "player")
            {
                _player.takeDamage(1);
            }
            type = "dead";
            graphic = _emitter;
            for(i in 0...80)
            {
                _emitter.emit("explode", width / 2, height / 2);
            }
            return true;
        } else {
            return false;
        }
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
        if (type == "dead")
        {
            if (_emitter.particleCount <= 0)
                scene.remove(this);
        }
        else
        {
            moveBy(0, -10, ["player"]);
        }
        
        checkBounds();
        super.update();
    }
}
