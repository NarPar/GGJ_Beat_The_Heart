package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class RingPieceEntity extends Entity
	{
		[Embed(source = '../assets/ringbits/ring_piece_0.png')] private const RINGPIECE0:Class;
		[Embed(source = '../assets/ringbits/ring_piece_1.png')] private const RINGPIECE1:Class;
		[Embed(source = '../assets/ringbits/ring_piece_2.png')] private const RINGPIECE2:Class;
		[Embed(source = '../assets/ringbits/ring_piece_3.png')] private const RINGPIECE3:Class;
		[Embed(source = '../assets/ringbits/ring_piece_4.png')] private const RINGPIECE4:Class;
		[Embed(source = '../assets/ringbits/ring_piece_5.png')] private const RINGPIECE5:Class;
		
		var speedX:Number = 0.0;
		var speedY:Number = 0.0;
		var rotationSpeed:Number = 0;
		
		public function RingPieceEntity(xPos:Number, yPos:Number, piece:int, rot:Number) 
		{
			x = xPos;
			y = yPos;
			rotationSpeed = rot;
			
			switch(piece)
			{
				case(0):
					graphic = new Image(RINGPIECE0);
					speedX = -20;
					speedY = -10;
					x -= Image(graphic).width;
					y -= Image(graphic).height / 2;
					break;
				case(1):
					graphic = new Image(RINGPIECE1);
					speedX = 0;
					speedY = -20;
					y -= Image(graphic).height / 2;
					break;
				case(2):
					graphic = new Image(RINGPIECE2);
					speedX = 20;
					speedY = -10;
					x += Image(graphic).width;
					y -= Image(graphic).height / 2;
					break;
				case(3):
					graphic = new Image(RINGPIECE3);
					speedX = -20;
					speedY = 10;
					x -= Image(graphic).width;
					y += Image(graphic).height / 2;
					break;
				case(4):
					graphic = new Image(RINGPIECE4);
					speedX = 0;
					speedY = 20;
					y += Image(graphic).height / 2;
					break;
				case(5):
					graphic = new Image(RINGPIECE5);
					speedX = 20;
					speedY = 10;
					x += Image(graphic).width;
					y += Image(graphic).height / 2;
					break;
			}
			// Initialize graphic and size
			Image(graphic).centerOrigin();
		}
		
		override public function update():void 
		{
			x += speedX;
			y += speedY;
			Image(graphic).angle += rotationSpeed;
			super.update();
		}
		
		public function ChangeScale(diff:Number):void
		{
			
			Image(graphic).scale += diff;
			if (Image(graphic).scale < 0)
				Image(graphic).scale = 0;
		}
	}

}