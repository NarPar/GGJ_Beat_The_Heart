package  
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Nick Pettyjohn
	 */
	
	 /* To Do: 
		  * Add loopable sound effect that's speed is altered depending on how fast the heartbeat is
		  * Heart shrinks when lose lives
		  * Background
		  * Heart beat sound effect
		  * Lose Life sound effect
	  * 
	  */
	public class GameWorld extends World
	{
		private const Width:Number = 800;
		private const Height:Number = 600;
		
		private var heart:HeartEntity;
		private var transitionBlock:TransitionBlock;
		private var currentRing:RingEntity;
		private var nextRing:RingEntity;
		private var explodeRing:ExplodeRingEntity;
		
		private var state:int; // 0 = transitioning on, 1 = transitioning off, 2 = active, 3 = game over, 4 = growing
		private var isGrowing:Boolean = false;
		
		
		private var diffHeartBeatText:TextEntity;
		private var scoreText:TextEntity;
		private var levelText:TextEntity;
		private var highScoreText:TextEntity;
		private var scoreboard:ScoreBoardPopupEntity;
		
		private var differenceInHeartBeats:Number = 0.0;
		private var level:int = 0;
		private var round:int = 0;
		private var score:int = 0;
		private var highscore:int = 1120;
		
		private var isGameOver:Boolean = false;
		
		//Game Title: Heart Arrhythmia
		public function GameWorld() 
		{
			heart = new HeartEntity(Width / 2, Height / 2);
			transitionBlock = new TransitionBlock(0, 0, Width, 1);
			currentRing = new RingEntity(Width / 2, Height / 2, 1, 3);
			diffHeartBeatText = new TextEntity("Arrhythmia: " + differenceInHeartBeats, Width / 2, Height / 24, 22);
			scoreText = new TextEntity("Score: " + score, Width / 15, Height / 13, 22);
			levelText = new TextEntity("Level: " + level, Width / 2, Height / 13, 22);
			highScoreText = new TextEntity("High Score: " + highscore, Width / 15 + 45,  Height / 24, 22);
			
			
			add(heart);
			add(currentRing);
			add(levelText);
			add(highScoreText);
			add(diffHeartBeatText);
			add(scoreText);
			add(transitionBlock);
			
			state = 2;
			
			currentRing.SetTimer();
		}
		
		override public function update():void 
		{
			// Got back to main menu
			if (Input.pressed(Key.ESCAPE)) {
				TransitionOff();
			}
			if (state == 1 && transitionBlock.state == 2) {
				FP.world = new MainMenuWorld();
			}
			
			switch(state)
			{
				case(2): // regular game state
					
					// When the player presses at the time
					if(Input.pressed(Key.SPACE) && currentRing.IsOnBeat()) {
						heart.Pulse();
						round++;
						if (round == 3) { // Level Increase!
							currentRing.TurnOffLights();
							Grow();
							UpdateScore(100);
							heart.ChangeLife(true);
						} else {
							currentRing.SetTimer();
							UpdateScore(20);
						}
				
					} else if (currentRing.lightCounter == -2) {
						heart.ChangeLife(false);
						
						if (heart.lives == 0) {//|| round == 0){
							//isGameOver = true;
							state = 3;
							var beat:Boolean = false;
							if (score > highscore){
								highscore = score;
								beat = true;
							}
							highScoreText.ChangeText("High Score: " + highscore);
							scoreboard = new ScoreBoardPopupEntity(beat, Width / 2, Height / 2, score);
							add(scoreboard);
						} else
							currentRing.SetTimer();
					} else if (Input.pressed(Key.SPACE)) {
						if (score > 0)
							UpdateScore( -5);
					}
					break;
				case(3): // game over
					 if (Input.pressed(Key.SPACE)) {
						state = 2;
						remove(scoreboard);
						level = 0;
						levelText.ChangeText("Level: " + level);
						round = 0;
						remove(currentRing);
						currentRing = new RingEntity(Width / 2, Height / 2, 1, 3);
						add(currentRing);
						currentRing.SetTimer();
						heart.ActivateSwell(false);
						heart.Reset();
						UpdateScore( -score);
					}
					break;
				case(4): // growing
					//nextRing.Shrink(false, .08);
					if (heart.state == 2) { // Done swelling //currentRing.Shrink(false, .02)) {
						//isGrowing = false;
						
						nextRing.Shrink(false, .2);
						explodeRing.ChangeScale(-.09);
						remove(currentRing);
						
					}
					if (heart.state == 0) {
						//nextRing.Shrink(false, .8);
						state = 2;
						
						nextRing.Shrink(true, 1);
						currentRing = nextRing;
						currentRing.SetTimer();
						remove(explodeRing);
						heart.ActivateSwell(false);	
					}
					break;
			}
			
			// Game logic
			/*if (!isGameOver && Input.pressed(Key.SPACE) && currentRing.IsOnBeat()) {
				heart.Pulse();
				round++;
				if (round == 3) {
					currentRing.TurnOffLights();
					Grow();
					UpdateScore(100);
				} else {
					currentRing.SetTimer();
					UpdateScore(10);
				}
				
			} else if (!isGameOver && currentRing.lightCounter == -2) {
				heart.LoseLife();
				if (heart.lives == 0){
					isGameOver = true;
					state = 3;
					var beat:Boolean = false;
					if (score > highscore){
						highscore = score;
						beat = true;
					}
					highScoreText.ChangeText("High Score: " + highscore);
					scoreboard = new ScoreBoardPopupEntity(beat, Width / 2, Height / 2, score);
					add(scoreboard);
				}
				else
					currentRing.SetTimer();
			} else if (!isGameOver && Input.pressed(Key.SPACE)) {
				if (score > 0)
					UpdateScore( -5);
			}*/
			
			
				
			/*if (isGrowing)
			{
				
			}*/
			
			super.update();
		}
		
		private function UpdateScore(increment:int):void
		{
			score += increment;
			scoreText.ChangeText("Score: " + score);
		}
		
		public function Shrink():void {
			nextRing = new RingEntity(currentRing.x, currentRing.y, 5, currentRing.difficulty);
			remove(transitionBlock);
			explodeRing = new ExplodeRingEntity(currentRing.x, currentRing.y);
			add(explodeRing);
			add(nextRing);
			add(transitionBlock);
		}
		private function Grow():void 
		{
			level++;
			levelText.ChangeText("Level: " + level);
			round = 0;
			heart.ActivateSwell(true);
			currentRing.LevelUp();
			/*remove(nextRing);
			nextRing = new RingEntity(currentRing.x, currentRing.y, 5, currentRing.difficulty);
			remove(transitionBlock);
			add(nextRing);
			add(transitionBlock);*/
			//isGrowing = true;
			state = 4;
		
		}
		
		private function TransitionOff():void {
			state = 1;
			transitionBlock.SetState(0);
		}
		
	}

}