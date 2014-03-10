import com.haxepunk.Engine;
import com.haxepunk.HXP;

class MyProject extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.scene = new scenes.MenuScene();
		HXP.screen.scaleX = 1;
		HXP.screen.scaleY = 1;
	}

	public static function main() { new MyProject(60.0, true); }

}