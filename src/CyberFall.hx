import com.haxepunk.Engine;
import com.haxepunk.HXP;

class CyberFall extends Engine
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

	public static function main() { new CyberFall(60.0, true); }

}