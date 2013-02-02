package  
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class MenuEntity extends Entity
	{
		public var isSelected:Boolean = false;
		
		public function MenuEntity() 
		{
			
		}
		
		public function HandleInput():void {
			
		}
		
		public function IsDone():Boolean {
			return true;
		}
	}

}