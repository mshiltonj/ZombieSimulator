/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/16/11
 * Time: 10:32 PM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxG;
import org.flixel.FlxSprite;

public class Building extends FlxSprite {

    private const BUILDING_COLOR:uint = 0xFF444444;

    public function Building():void {
        super(Math.random() * FlxG.width - 25, Math.random() * FlxG.height - 25);

        createGraphic(Math.random() * 35 + 35, Math.random() * 35 + 35, BUILDING_COLOR);
        
    }
}
}
