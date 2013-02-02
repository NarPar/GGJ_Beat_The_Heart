package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class LightEntity extends Entity
	{
		[Embed(source = '../assets/light.png')] private const LIGHT:Class;
		
		public var isActive:Boolean = false;
		
		public function LightEntity(posX:Number, posY:Number, origX:Number, origY:Number, rot:Number, col:uint) 
		{
			

			// Initialize graphic and size
			graphic = new Image(LIGHT);
			Image(graphic).scale = .2;
			width = (Image(graphic).scaledWidth);
			height = (Image(graphic).scaledHeight);
			
			
			Image(graphic).centerOrigin();
			
			
			
			Image(graphic).originX = posX;
			Image(graphic).originY = posY;
			x = origX;
			y = origY;
			Image(graphic).angle = rot;
			Image(graphic).color = col;
		}
		
		public function Activate(col:uint):void {
			isActive = true;
			Image(graphic).color = col;
		}
		
	}

}