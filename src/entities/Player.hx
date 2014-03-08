package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.utils.Ease;

class Player extends Entity
{
    private static inline var _width:Int = 16;
    private static inline var _height:Int = 32;
    private static inline var maxVelocity:Float = 6;
    private static inline var speed:Float = 2.0;
    private static inline var drag:Float = 0.4;

    private var touches:Map<Int,Touch>;
    private var trailImage:Image;
    private var _image:Image;
    private var _emitter:Emitter;
    private var velocity:Float;
    private var acceleration:Float;
    private var damageTimer:Float = 0;
    private var deathTimer:Float = 0;
    private var _health:Int = 3;

	public function new(x:Float, y:Float, p:Image)
	{
		super(x, y);

        _emitter = new Emitter(scenes.MainScene.atlas.getRegion("playerDeath.png"), 8, 8);
        _emitter.newType("explode", [0]);
        _emitter.setMotion("explode",
                            0,
                            300,
                            0.1,
                            360,
                            -32,
                            1,
                            Ease.quadOut
                            );
        _emitter.setAlpha("explode", 20, 0.1);
        _emitter.setGravity("explode", 5, 1);

		_image = new Image(scenes.MainScene.atlas.getRegion("player.png"));
        graphic = _image;

        trailImage = new Image("graphics/playerTrail.png");

        cast(graphic, Image).centerOrigin();

        setHitbox(_width, _height, Std.int(_width / 2), Std.int(_height / 2));

        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);

        velocity = 0;

        type = "player";
	}

	private function handleInput()
    {
        acceleration = 0;

        if (Input.check("left"))
        {
            acceleration = -1;
        }

        if (Input.check("right"))
        {
            acceleration = 1;
        }

        touches = Input.touches;
        for(elem in touches){
            if (collideRect(elem.x, elem.y, 0, 0, HXP.halfWidth, HXP.screen.height))
            {
                acceleration = -1;
            }
            if (collideRect(elem.x, elem.y, HXP.halfWidth, 0, HXP.halfWidth, HXP.screen.height))
            {
                acceleration = 1;
            }
        }
    }

    public function addTrail()
    {
        scene.add(new Trail(x - 4, y - halfHeight, trailImage));
    }

    private function move()
    {
        velocity += acceleration * speed;
        if (Math.abs(velocity) > maxVelocity)
        {
            velocity = maxVelocity * HXP.sign(velocity);
        }

        if (velocity < 0)
        {
            velocity = Math.min(velocity + drag, 0);
        }
        else if (velocity > 0)
        {
            velocity = Math.max(velocity - drag, 0);
        }
    }

    public function takeDamage(a:Int)
    {
        if (type != "dead")
        {
            _health -= a;
            cast(graphic, Image).color = 0xaa101e;
            cast(graphic, Image).scale = 1.5;
            damageTimer = 0.05;

            if (_health < 1)
            {
                die();
            }
        }
    }

    public function getHealth():Int
    {
        return _health;
    }

    public function die()
    {
        graphic = _emitter;
        for(i in 0...320)
        {
            _emitter.emit("explode", width / 2, height / 2);
        }
        type = "dead";
    }

    private function checkBounds()
    {
        if (x < 0)
            x = 0;
        if (x > HXP.screen.width)
            x = HXP.screen.width;
    }

	public override function update()
	{
        if (type != "dead")
        {
            handleInput();
            move();
            moveBy(velocity, 0);
            checkBounds();
            addTrail();
        } else {
            deathTimer += HXP.elapsed;
        }

        damageTimer -= HXP.elapsed;
        if (damageTimer < 0 && type != "dead")
        {
            cast(graphic, Image).color = 0x11101e;
            cast(graphic, Image).scale = 1;
        }

        if (deathTimer > 3)
        {
            deathTimer = 0;
            _health = 3;
            scenes.MainScene.score = 0;
            graphic = _image;
            type = "player";

            // TODO: Reset.
            //scene.remove(this);
            //HXP.scene = new scenes.MainScene();
        }

        super.update();
    }

    public override function removed()
    {
        touches = null;
        graphic.destroy();
    }
}