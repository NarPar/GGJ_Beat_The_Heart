package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class TransitionBlock extends Entity
	{
		[Embed(source = '../assets/transition_block.png')] private const TRANSITIONBLOCK:Class;
		public var state:int = 1; // 0 = transition on, 1 = transition off, 2 = completed
		
		private var speed:Number = 40;
		private var worldwidth:int;
		private var targetX:Number;
		private var targetY:Number;
		
		public function TransitionBlock(xPos:Number, yPos:Number, width:int, transitionstate:int) 
		{
			targetX = xPos;
			targetY = yPos;
			worldwidth = width;
			state = transitionstate;
			SetState(state);

			// Initialize graphic and size
			graphic = new Image(TRANSITIONBLOCK);
			Image(graphic).scale = 800;
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
			Image(graphic).color = 0xFF0000;
		}
		
		public function SetState(transitionstate:int):void {
			
			state = transitionstate;
			if (transitionstate == 0) {
				trace("Set state to 0");
				x = Image(graphic).scaledWidth * -1.0;
				y = targetY;
			} else if (transitionstate == 1) {
				trace("Set state to 1");
				x = targetX;
				y = targetY;
			}
		}
		
		override public function update():void 
		{
			switch(state)
			{
				case(0):
					x += speed;
					if (x >= targetX) {
						x = targetX;
						state = 2;
					}
					break;
				case(1):
					x += speed;
					if (x >= worldwidth) {
						x = worldwidth;
						state = 2;
					}
					break;
				case(2):
					break;
			}
			super.update();
		}
		
		override public function render():void 
		{
			if(state != 3)
				super.render();
		}
		
		
	}

}