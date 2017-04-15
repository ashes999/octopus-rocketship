package;

import flixel.FlxG;
import flixel.math.FlxRandom;
import turbo.ecs.TurboState;
import turbo.ecs.Entity;

class CatchFishState extends TurboState
{
	private static inline var NUM_FISH:Int = 5;
	private var random = new FlxRandom();

	override public function create():Void
	{
		super.create();

		var octopus = new Entity().colour(255, 0, 0).size(64, 64).moveWithKeyboard(250);
		this.entities.push(octopus);

		for (i in 0...NUM_FISH)
		{
			var fish = new Entity().colour(255, 128, 255).size(70, 32);
			trace(FlxG.stage.width);
			var x = random.int(0, Std.int(FlxG.stage.stageWidth));
			var y = random.int(0, Std.int(FlxG.stage.stageHeight));

			fish.move(x, y);
			this.entities.push(fish);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
