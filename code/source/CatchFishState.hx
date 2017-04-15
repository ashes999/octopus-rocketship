package;

import flixel.FlxG;
import flixel.math.FlxRandom;
import turbo.ecs.TurboState;
import turbo.ecs.Entity;

class CatchFishState extends TurboState
{
	private static inline var NUM_FISH:Int = 5;
	private var random = new FlxRandom();
	private var width = Std.int(FlxG.stage.stageWidth);
	private var height = Std.int(FlxG.stage.stageHeight);

	override public function create():Void
	{
		super.create();

		var octopus = new Entity().colour(255, 0, 0).size(64, 64).moveWithKeyboard(250);
		this.entities.push(octopus);

		for (i in 0...NUM_FISH)
		{
			var fish = new Entity().colour(255, 128, 255).size(70, 32);
			var x = random.int(0, this.width);
			var y = random.int(0, this.height);

			fish.move(x, y);

			var vx = random.int(500, 1000) * (x >= width/2 ? -1 : 1);
			var vy = random.int(100, 200) * (y >= height/2 ? -1 : 1);
			fish.velocity(vx, vy);

			this.entities.push(fish);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
