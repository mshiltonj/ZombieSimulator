/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 3/21/11
 * Time: 9:16 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxGroup;
import org.flixel.FlxRect;

public class ZombiePack extends FlxGroup {

    // hidden box around point where the group was first created.
    private var rectBorder:FlxRect;

    private static var MAX_MEMBERS:int = 50;

    public function ZombiePack(x:int, y:int) {
        super();
        var top:int = x - 25;
        var left:int = y - 25;
        this.rectBorder = new FlxRect(left, top, left + 50, top + 50);
    }

    public function isFull():Boolean {
        return this.members.length >= MAX_MEMBERS;
    }
}
}
