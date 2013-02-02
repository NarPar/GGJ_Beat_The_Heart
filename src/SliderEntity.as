package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class SliderEntity extends MenuEntity
	{
		[Embed(source = '../assets/button.png')] private const BUTTON:Class;
		public var value:Number = .5;
		
		private var sliderName:TextEntity;
		private var sliderTab:SliderTabEntity;
		private var selectEffect:SelectEffectEntity;
		
		private var tabMoveDistance:Number;
		
		public function SliderEntity(name:String, xPos:Number, yPos:Number) 
		{
			x = xPos;
			y = yPos;
			
			sliderName = new TextEntity(name, x - 175, y, 22);
			sliderTab = new SliderTabEntity(x, y);
			selectEffect = new SelectEffectEntity(x - 175, y, .70);
			
			// Initialize graphic and size
			graphic = new Image(BUTTON);
			Image(graphic).scaleX = 3;
			Image(graphic).scaleY = .5;
			Image(graphic).centerOrigin(); 
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
			
			tabMoveDistance = width / 10;
		}
		override public function update():void
		{
			sliderTab.update();
			sliderName.update();
			selectEffect.update();
			
			//sliderTab.x = x;
			sliderTab.y = y;
			
			sliderName.x = x - 175 - sliderName.offsetX;
			sliderName.y = y - sliderName.offsetY;
			
			selectEffect.x = x - 175;
			selectEffect.y = y;
		}
		
		public function ShiftTab(dir:int):void // 0 = left, 1 = right
		{
			if (dir == 0)
				sliderTab.x -= tabMoveDistance;
			else
				sliderTab.x += tabMoveDistance;
			
			if (sliderTab.x < x - width / 2 + tabMoveDistance)
					sliderTab.x = x - width / 2 + tabMoveDistance;
			if (sliderTab.x > x + width / 2 - tabMoveDistance)
					sliderTab.x = x + width / 2 - tabMoveDistance;
			
			var max:Number = width - 2 * tabMoveDistance;
					
			value = (sliderTab.x - (x - width / 2 + tabMoveDistance)) / max;
		}
		
		override public function render():void
		{
			if (isSelected)
				selectEffect.render();
			
			super.render();
			sliderTab.render();
			sliderName.render();
		}
	}
}