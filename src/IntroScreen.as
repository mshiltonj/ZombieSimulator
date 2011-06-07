/**
 * Created by IntelliJ IDEA.
 * User: mshiltonj
 * Date: 6/3/11
 * Time: 6:42 AM
 * To change this template use File | Settings | File Templates.
 */
package {
import org.flixel.FlxButton;
import org.flixel.FlxG;
import org.flixel.FlxSprite;
import org.flixel.FlxState
import org.flixel.FlxText;

public class IntroScreen extends FlxState {

    private const WIDTH:int = 480;
    private const HEIGHT:int = 320;
    private const COLOR:int = 0xFF009933;
    private const INSTRUCTION1:String = "Press 'R' to restart";
    private const INSTRUCTION2:String = "Press 'Q' to quit to main screen";
    private const BUTTON_TEXT:String = "Begin Simulation";
    private const INFESTATION_TEXT:String = "Infestation";
    private const ZOMBIE_TEXT:String = "Zombie";
    private const SIMULATION_TEXT:String = "Simulation";


    override public function create():void {
        init();
    }

    private function init():void {
        addBox()
        addTitleText();
        addStartButton();
        addInstructions();
    }

    private function addInstructions():void {
    }

    private function addStartButton():void {
        var btnText:FlxText = new FlxText(4, 4, 150, BUTTON_TEXT);
        //button.loadGraphic(new FlxSprite().createGraphic(160, 50, 0xff000000));
        btnText.setFormat(null, 12, 0xffA52A2A, null, 0xff000000);

        var btnHandler:Function = function():void {
            FlxG.state = new ZombieSeige1();
        };
        var button:BetterButton = new BetterButton(380, 300, btnHandler, 135, 25);
        button.loadText(btnText);

        add(button);
    }

    private function addTitleText():void {        var zombieText:FlxText = new FlxText(95, 95, 300, ZOMBIE_TEXT);
        zombieText.setFormat(null, 40, 0xffA52A2A, null, 0xff000000);
        var infestationText:FlxText = new FlxText(95, 143, 300, INFESTATION_TEXT);
        infestationText.setFormat(null, 40, 0xffA52A2A, null, 0xff000000);
        var simulationText:FlxText = new FlxText(95, 193, 300, SIMULATION_TEXT)
        simulationText.setFormat(null, 40, 0xffA52A2A, null, 0xff000000);
        add(zombieText);
        add(infestationText);
        add(simulationText);
    }

    private function addBox():void {        var box:FlxSprite = new FlxSprite(80, 80);
        box.createGraphic(WIDTH, HEIGHT, COLOR);
        box.color = COLOR;
        add(box);
    }

}
}
