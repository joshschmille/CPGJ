package scenes;

import com.haxepunk.Scene;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Touch;
import com.haxepunk.graphics.Text;
import com.haxepunk.Entity;

class MenuScene extends Scene
{
	//private var touches:Map<Int,Touch>;
	private var startText:Text;
	private var creditText:Text;

	public function new()
	{
		super();
		addGraphic(new Image("graphics/menuBg.png"));
		addGraphic(new Image("graphics/title.png"), (HXP.screen.width / 2) - (590 / 2), 200);

		startText = new Text("", 0, 0, HXP.screen.width, 0, {color:0x000000, size:32, align:"center"});

		if (Input.multiTouchSupported)
			startText.text = "Tap to Start";
		else
			startText.text = "Press SPACE to Start";

		var startTextEntity:Entity = new Entity(0, HXP.halfHeight, startText);
		add(startTextEntity);

		creditText = new Text("Design by Christine Callahan\nProgramming & Art by Josh Schmille\nFeaturing Music by Matthew Pablo - www.matthewpablo.com", 0, 0, HXP.screen.width, 0, {color:0x000000, size:16, align:"center"});

		var creditTextEntity:Entity = new Entity(0, HXP.screen.height - 50, creditText);
		add(creditTextEntity);

		Input.define("start", [Key.SPACE]);
	}

	public override function begin()
	{
		
	}

	private function onTouch(touch:com.haxepunk.utils.Touch)
	{
		/*var _x:Float = touch.sceneX;
		var _y:Float = touch.sceneY;

		if (_x > creditButtonLeft && _x < creditButtonRight && _y > creditButtonTop && _y < creditButtonBottom)
			Go to credits scene.
		else*/
			HXP.scene = new scenes.MainScene();
	}

	public override function update()
	{
		super.update();

		if (Input.check("start"))
        {
            HXP.scene = new scenes.MainScene();
        }

		if (Input.multiTouchSupported)
		{
			Input.touchPoints(onTouch);
		}
		/*else
		{
			if (Input.mousePressed)
			{
				var _x:Int = Input.mouseX;
				var _y:Int = Input.mouseY;

				if (_x > 275 && _x < 365 && _y > 600 && _y < 660)
					HXP.scene = new scenes.MainScene();
			}
		}*/
	}

	public override function end()
	{
		removeAll();
	}
}