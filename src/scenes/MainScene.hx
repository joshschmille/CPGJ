package scenes;

import com.haxepunk.Scene;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.atlas.TextureAtlas;
import com.haxepunk.Sfx;

class MainScene extends Scene
{
	public static var _player:entities.Player;
	public static var atlas:TextureAtlas;
	public static var score:Int = 0;
	public static var bestScore:Int = 0;
	public static var music:Sfx;

	public var electricitySpawnTimer:Float;
	public var enemySpawnTimer:Float;

	private var _fps:String;
	private var text:Text;
	private var backdrop:Backdrop;
	private var backdrop2:Backdrop;
	private var scoreText:Text;
	private var bestScoreText:Text;
	private var healthText:Text;
	private var playerImage:Image;
	private var electricityImage:Image;
	private var enemyImage:Image;
	private var enemyTrailImage:Image;

	public function new()
	{
		super();

		score = 0;

		atlas = TextureAtlas.loadTexturePacker("atlas/sprites.xml");

		backdrop = new Backdrop("graphics/back.png", true, true);
		addGraphic(backdrop, 20);

		backdrop2 = new Backdrop("graphics/back2.png", true, true);
		addGraphic(backdrop2, 20);

		playerImage = new Image("graphics/player.png");

		electricityImage = new Image("graphics/electricity.png");

		enemyImage = new Image("graphics/enemy.png");
		enemyTrailImage = new Image("graphics/enemyTrail.png");

		music = new Sfx("audio/music.ogg");
	}

	public override function begin()
	{
		_player = new entities.Player(HXP.halfWidth, 379, playerImage);
		music.loop(0, 0);
		add(_player);
		spawnElectricity();
		spawnEnemy();
		text = new Text("CPGJ | Josh Schmille | FPS: " + _fps + " | Entities: " + count, 0, 0, 0, 0, {color:0x000000, size:16} );
		var textEnt:Entity = new Entity(90, HXP.screen.height - 40, text);
		add(textEnt);

		scoreText = new Text("Score: " + score, 0, 0, HXP.screen.width, 0, {color:0x000000, size:32, align:"right"});
		var scoreEnt:Entity = new Entity(0, 24, scoreText);
		add(scoreEnt);
		scoreEnt.layer = -2;

		bestScoreText = new Text("Best: " + bestScore, 0, 0, HXP.screen.width, 0, {color:0x000000, size:32, align:"right"});
		var bestScoreEnt:Entity = new Entity(0, 48, bestScoreText);
		add(bestScoreEnt);
		bestScoreEnt.layer = -2;

		healthText = new Text("Health: " + _player.getHealth(), 0, 0, HXP.screen.width, 0, {color:0x000000, size:32, align:"left"});
		var healthEnt:Entity = new Entity(0, 24, healthText);
		add(healthEnt);
		healthEnt.layer = -2;
	}

	public override function update()
	{
		scoreText.text = "Score: " + Std.string(score);
		bestScoreText.text = "Best: " + Std.string(bestScore);
		healthText.text = "Health: " + _player.getHealth();
		_fps = Std.string(Math.floor(HXP.frameRate));
		text.text = "CPGJ | Josh Schmille | FPS: " + _fps + " | Entities: " + count;
		backdrop.y -= 10;
		backdrop2.y -= 15;

		electricitySpawnTimer -= HXP.elapsed;
		enemySpawnTimer -= HXP.elapsed;
		if (electricitySpawnTimer < 0)
			spawnElectricity();
		if (enemySpawnTimer < 0)
			spawnEnemy();

		super.update();
	}

	private function spawnElectricity()
	{
		var _x:Float = HXP.clamp(Math.random() * HXP.width, 32, HXP.screen.width - 32);
		add(new entities.Electricity(_x, HXP.screen.height + 64, _player, electricityImage));
		electricitySpawnTimer = 0.75;
	}

	private function spawnEnemy()
	{
		var _x:Float = HXP.clamp(Math.random() * HXP.width, 32, HXP.screen.width - 32);
		add(new entities.Enemy(_x, -32, _player, enemyImage, enemyTrailImage));
		enemySpawnTimer = 0.5;
	}

	public override function end()
	{
		music.stop();
		removeAll();
	}
}