package scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Backdrop;

class MainScene extends Scene
{
	public function new()
	{
		super();

		backdrop = new Backdrop("graphics/back.png", true, true);
		addGraphic(backdrop, 20);

		backdrop2 = new Backdrop("graphics/back2.png", true, true);
		addGraphic(backdrop2, 20);

		backdrop3 = new Backdrop("graphics/back2.png", true, true);
		addGraphic(backdrop3, 15);
	}

	public override function begin()
	{
		add(new entities.Player(HXP.halfWidth, 379));
		spawn();
		text = new Text("Work In Progress | Josh Schmille", 0, 0, 0, 0, { color:0x000000, size:16 } );
		var textEnt:Entity = new Entity(0, HXP.screen.height - 16, text);
		add(textEnt);

		/*add(new entities.Gui(200, 398, "upButton"));
		add(new entities.Gui(232, 445, "rightButton"));
		add(new entities.Gui(200, 477, "downButton"));
		add(new entities.Gui(153, 445, "leftButton"));*/
		//add(new entities.Gui(HXP.screen.width - 125, HXP.screen.height - 125, "aButton"));
	}

	public override function update()
	{
		backdrop.y -= 10;
		backdrop2.y -= 15;
		backdrop3.y -= 20;

		spawnTimer -= HXP.elapsed;
		if (spawnTimer < 0)
		{
			spawn();
		}

		super.update();
	}

	private function spawn()
	{
		var x = HXP.clamp(Math.random() * HXP.width, 32, HXP.screen.width - 32);
		add(new entities.Electricity(x, HXP.screen.height + 64));
		spawnTimer = 0.325;
	}

	private var spawnTimer:Float;
	private var text:Text;
	private var backdrop:Backdrop;
	private var backdrop2:Backdrop;
	private var backdrop3:Backdrop;
}