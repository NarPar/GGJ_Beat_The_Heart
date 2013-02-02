package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class ExplodeRingEntity extends Entity
	{

		
		
		private var pieces:Array = new Array(); // the pieces of the ring
		
		public function ExplodeRingEntity(xPos:Number, yPos:Number) 
		{	
			x = xPos;
			y = yPos;
			for (var i:int = 0; i < 6; i++)
			{
				pieces.push(new RingPieceEntity(x, y, i, FP.random * 12));
			}
		}
		
		override public function update():void 
		{
			for (var i:int = 0; i < pieces.length; i++)
			{
				pieces[i].update();
			}
			super.update();
		}
		
		public function ChangeScale(diff:Number)
		{
			for (var i:int = 0; i < pieces.length; i++)
			{
				pieces[i].ChangeScale(diff);
			}
		}
		
		override public function render():void
		{
			for (var i:int = 0; i < pieces.length; i++)
			{
				pieces[i].render();
			}
			super.render();
		}
		
	}

}