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
	public class ButtonEntity extends MenuEntity
	{
		[Embed(source = '../assets/button.png')] private const BUTTON:Class;
		
		// Keep track of sub entities so we can animate them
		private var selectEntity:SelectEffectEntity;
		private var text:TextEntity;
		
		public function ButtonEntity(buttonText:String, xPos:Number, yPos:Number) 
		{
			// Initialize position
			x = xPos;
			y = yPos;
			
			// Initialize graphic and size
			graphic = new Image(BUTTON);
			Image(graphic).scale = 2; 
			Image(graphic).centerOrigin(); 
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
			
			// Initialize text and selection effect entities
			selectEntity = new SelectEffectEntity(x, y, 2.1);
			text = new TextEntity(buttonText, x, y, 22);
			
			//addGraphic(Graphic(text)); doesn't work?!
		}
		
		override public function update():void
		{
			if (isSelected)
				selectEntity.update();
			
			selectEntity.x = x;
			selectEntity.y = y;
			
			text.x = x - text.offsetX;
			text.y = y - text.offsetY;
		}
		
		override public function render():void
		{
			if(isSelected) // Only draw effect when selected
				selectEntity.render();
			super.render();
			text.render();
		}
		
	}

}