package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Touch;
import com.haxepunk.utils.Key;
import com.haxepunk.debug.Console;

class Player extends Entity
{
    private var _width:Int = 16;
    private var _height:Int = 32;

	public function new(x:Float, y:Float)
	{
		super(x, y);

		graphic = Image.createRect(_width, _height, 0x11101e);

        cast(this.graphic, Image).centerOrigin();

        setHitbox(16, 32, Std.int(_width / 2), Std.int(_height / 2));

        Input.define("left", [Key.LEFT, Key.A]);
        Input.define("right", [Key.RIGHT, Key.D]);
        Input.define("down", [Key.DOWN, Key.S]);
        Input.define("up", [Key.UP, Key.W]);
        Input.define("shoot", [Key.SPACE]);
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

        var touches:Map<Int,Touch> = Input.touches;
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

    public function shoot()
    {
        scene.add(new Trail(x - 1, y - halfHeight));
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
        shoot();
        super.update();
    }

	private var velocity:Float;
    private var acceleration:Float;

    private static inline var maxVelocity:Float = 6;
    private static inline var speed:Float = 2.0;
    private static inline var drag:Float = 0.4;
}