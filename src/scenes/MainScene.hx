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

		score = 0;

		backdrop = new Backdrop("graphics/back.png", true, true);
		addGraphic(backdrop, 20);

		backdrop2 = new Backdrop("graphics/back2.png", true, true);
		addGraphic(backdrop2, 20);
	}

	public override function begin()
	{
		_player = new entities.Player(HXP.halfWidth, 379);
		add(_player);
		spawn();
		text = new Text("CPGJ | Josh Schmille | FPS: " + _fps + " | Entities: " + count, 0, 0, 0, 0, { color:0x000000, size:16 } );
		var textEnt:Entity = new Entity(0, HXP.screen.height - 40, text);
		add(textEnt);

		scoreText = new Text("Score: " + score, 0, 0, HXP.screen.width, 0, {color:0x000000, size:32, align:"right"});
		var scoreEnt:Entity = new Entity(0, 24, scoreText);
		add(scoreEnt);
		scoreEnt.layer = -2;

		healthText = new Text("Health: " + _player.getHealth(), 0, 0, HXP.screen.width, 0, {color:0x000000, size:32, align:"left"});
		var healthEnt:Entity = new Entity(0, 24, healthText);
		add(healthEnt);
		healthEnt.layer = -2;
	}

	public override function update()
	{
		scoreText.text = "Score: " + Std.string(score);
		healthText.text = "Health: " + _player.getHealth();
		_fps = Std.string(Math.floor(HXP.frameRate));
		text.text = "CPGJ | Josh Schmille | FPS: " + _fps + " | Entities: " + count;
		backdrop.y -= 10;
		backdrop2.y -= 15;

		spawnTimer -= HXP.elapsed;
		if (spawnTimer < 0)
		{
			spawn();
		}

		super.update();
	}

	private function spawn()
	{
		_x = HXP.clamp(Math.random() * HXP.width, 32, HXP.screen.width - 32);
		add(new entities.Electricity(_x, HXP.screen.height + 64));
		add(new entities.Enemy(_x, -32));
		spawnTimer = 0.75;
	}

	public override function end()
	{
		removeAll();
	}

	public static var _player:entities.Player;
	private var _fps:String;
	private var _x:Float;

	private var spawnTimer:Float;
	private var text:Text;
	private var backdrop:Backdrop;
	private var backdrop2:Backdrop;

	public static var score:Int = 0;
	private var scoreText:Text;

	private var healthText:Text;
}