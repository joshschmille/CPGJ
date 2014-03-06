package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.utils.Key;

class Player extends Entity
{
    private static inline var _width:Int = 16;
    private static inline var _height:Int = 32;

    private var touches:Map<Int,Touch>;
    private var trailImage:Image;

    private var _health:Int = 3;

	public function new(x:Float, y:Float, p:Image)
	{
		super(x, y);

		var _image:Image = new Image(scenes.MainScene.atlas.getRegion("player.png"));
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
            if (collideRect(elem.x, elem.y, 0, HXP.halfHeight, HXP.halfWidth, HXP.halfHeight))
            {
                acceleration = -1;
            }
            if (collideRect(elem.x, elem.y, HXP.halfWidth, HXP.halfHeight, HXP.halfWidth, HXP.halfHeight))
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
        if (!dead)
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
        if (!dead)
        {
            cast(graphic, Image).alpha = 0;
        }
        dead = true;
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
		handleInput();
        move();
        moveBy(velocity, 0);
        checkBounds();

        if (!dead)
        {
            addTrail();
        }

        damageTimer -= HXP.elapsed;
        if (damageTimer < 0)
        {
            cast(graphic, Image).color = 0x11101e;
            cast(graphic, Image).scale = 1;
        }

        if (dead)
        {
            deathTimer += HXP.elapsed;
        }

        if (deathTimer > 3)
        {
            deathTimer = 0;
            dead = false;
            cast(graphic, Image).alpha = 1;

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

	private var velocity:Float;
    private var acceleration:Float;
    private var damageTimer:Float = 0;
    private var deathTimer:Float = 0;
    public var dead:Bool = false;

    private static inline var maxVelocity:Float = 6;
    private static inline var speed:Float = 2.0;
    private static inline var drag:Float = 0.4;
}