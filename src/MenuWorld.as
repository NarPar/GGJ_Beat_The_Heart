package  
{
	import net.flashpunk.World;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	public class MenuWorld extends World
	{
		protected const Width:Number = 800;
		protected const Height:Number = 600;
		
		private var entityList:Array = new Array();
		
		protected var transitionState:int = 1; // 0 = On, 1 = Idle, 2 = Off
		private var transitionSpeed:Number = 20;
		private var targetXPositions:Array = new Array();
		private var targetYPositions:Array = new Array();
		private var entityTransitionComplete:Array = new Array();
		
		protected var transitionedOff:Boolean = false;
		protected var selectIndex:int = 0;
		//protected var menuEntities:Array = Array();
		
		public function MenuWorld() 
		{
		}
		
		public function AddEntity(e:Entity):void
		{
			entityList.push(e);
			add(e);
		}
		
		override public function update():void
		{
			// Update Entities
			UpdateEntities();
			switch(transitionState)
			{	
				case(0):
					TransitionOn();
					break;
				case(1): // Idle / has transitioned on
					// Handle keyboard input
					if (Input.pressed(Key.SPACE) || Input.pressed(Key.ENTER)){
						HandleSelect();
					}
					if (Input.pressed(Key.UP))
						HandleNavigation(0); 
					if (Input.pressed(Key.RIGHT))
						HandleNavigation(1);
					if (Input.pressed(Key.DOWN))
						HandleNavigation(2);
					if (Input.pressed(Key.LEFT))
						HandleNavigation(3);
					break;
				case(2):
					TransitionOff();
					break;	
			}
		}
		
		private function UpdateEntities():void
		{
			for(var i:int = 0; i < entityList.length; i++)
			{
				entityList[i].update();
			}
		}
		
		protected function HandleSelect():void 
		{
		}
		protected function HandleNavigation(dir:int):void
		{
			switch(dir)
			{
				// Up and down!
				case(0):
					selectIndex++;
					break;
				case(2):
					break;
			}
		}
		
		protected function ChangeIndex(dir:Boolean):void
		{
			if (dir) {
				
				selectIndex++
			}
				
		}
		
		protected function Transition():void
		{
		}
		
		protected function SetTransitionOn():void
		{
			for (var i:int = 0; i < entityList.length; i++) {
				targetXPositions.push(entityList[i].x);
				targetYPositions.push(entityList[i].y);
				//entityList[i].x = 0;
				entityList[i].y = 0;
				transitionSpeed = 20;
				entityTransitionComplete.push(false);
			}
			
			transitionState = 0;
			
		}
		protected function SetTransitionOff():void
		{
			for (var i:int = 0; i < entityList.length; i++) {
				targetXPositions.push(-100);
				targetYPositions.push(-100);
				transitionSpeed = -20;
				entityTransitionComplete.push(false);
			}
			
			transitionState = 2;
		}
		
		/* All screen contents move downward from top of screen
		 */
		protected function TransitionOn():void
		{
			var count:Number = 0;
			for (var i:int = 0; i < entityList.length; i++) {
				if(!entityTransitionComplete[i]){
					entityList[i].y += transitionSpeed;
					if (entityList[i].y >= targetYPositions[i]) {
						entityList[i].y = targetYPositions[i];
						entityTransitionComplete[i] = true;
					}
				}
				else
					count++;
			}
			
			if (count == entityTransitionComplete.length)
			{
				targetXPositions = new Array();
				targetYPositions = new Array();
				entityTransitionComplete = new Array();
				transitionState = 1;
			}
		}
		
		/* All screen contents move upward to top of screen
		 * 
		 */ 
		private function TransitionOff():void
		{
			var count:Number = 0;
			for (var i:int = 0; i < entityList.length; i++) {
				if(!entityTransitionComplete[i]){
					entityList[i].y += transitionSpeed;
					if (entityList[i].y <= targetYPositions[i]) {
						entityList[i].y = targetYPositions[i];
						entityTransitionComplete[i] = true;
					}
				}
				else
					count++;
			}
			
			if (count == entityTransitionComplete.length)
			{
				targetXPositions = new Array();
				targetYPositions = new Array();
				entityTransitionComplete = new Array();
				transitionState = 1;
				transitionedOff = true;
				Transition();
			}
		}
		
	}

}