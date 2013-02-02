package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class HeartEntity extends Entity
	{
		[Embed(source = '../assets/heart_beat.png')] private const HEARTBEAT:Class;
		
		public var sprBeat:Spritemap = new Spritemap(HEARTBEAT, 121, 112);
		public var lives:int = 3;
		
		private const DEFAULTSWELLSPEED:Number = .2;
		
		public var state:int = 0; // 0 = idle, 1 = swelling, 2 = shrinking
		private var isSwelling:Boolean = false;
		private var swellSpeed:Number;
		private var shrinkSpeed:Number = .2;
		private var swellDecceleration:Number = -.09;
		private var scale:Number = 1;
		
		public function HeartEntity(xPos:Number, yPos:Number) 
		{
			// Initialize animations
			sprBeat.add("idle", [0], 10, false);
			sprBeat.add("beat", [0, 1, 2, 3, 4, 5], 10, false);
			sprBeat.add("swell", [3, 4], 10, true);
			graphic = sprBeat;
			Image(graphic).centerOrigin(); 
			Image(graphic).color = Color.Red;
			sprBeat.play("idle");
			swellSpeed = DEFAULTSWELLSPEED;
			
			x = xPos;
			y = yPos;
		}
		
		override public function update():void 
		{
			if (sprBeat.currentAnim == "beat" && sprBeat.complete) {
				sprBeat.play("idle");
			}
			
			switch(state)
			{
				case(1): // swelling
					swellSpeed += swellDecceleration;
					if (swellSpeed < .1)
						swellSpeed = .1;
					scale += swellSpeed;
					
					if (scale >= 5){
						scale = 5;
						state = 2;
						(world as GameWorld).Shrink();
					}
					Image(graphic).scale = scale;
					break;
				case(2): // shrinking
					scale -= shrinkSpeed;
					if (scale <= 1){
						scale = 1;
						state = 0;
					}
					Image(graphic).scale = scale;
					break;
			}
			
			super.update();
		}
		
		public function Pulse():void
		{
			Image(graphic).scale += .2;
			sprBeat.play("beat");
		}
		
		private function Swell():void
		{
			
		}
		
		private function Shrink():void
		{
			
		}
		
		public function ActivateSwell(On:Boolean):void
		{
			
			if (On) {
				sprBeat.play("idle");
				state = 1;
			}
			else {
				state = 2;
				sprBeat.play("idle");
				//Image(graphic).scale = 1;
			}
		}
		
		public function ChangeLife(b:Boolean):void
		{
			if(!b){
				lives--;
				if(lives==2)
					Image(graphic).color = Color.Fuchsia;
				if (lives == 1)
					Image(graphic).color = Color.Purple;
				Image(graphic).scale -= .2;
			} else if(lives < 3) {
				lives++;
				Image(graphic).scale += .2;
				if(lives==3)
					Image(graphic).color = Color.Red;
				if (lives == 2)
					Image(graphic).color = Color.Fuchsia;
			}
		}
		
		
		
		public function Reset():void
		{
			lives = 3;
			Image(graphic).scale = 1;
			Image(graphic).color = Color.Red;
		}
	}
}