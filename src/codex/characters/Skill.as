package codex.characters 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Olivier
	 */
	public class Skill 
	{
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes of the class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private var _id:String;
		private var _name:String;
		private var _isKnown:Boolean
		private var _isWarSkill:Boolean;
		private var _effectAnim:MovieClip;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes of formula
		//	The formula will be used by DuelManager and WarManager as described below:
		//	Target.vitalArray[_targetedVital].curValue -= _multiplicator * Caster.statArray[_originStat].finalAmmount
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		private var _targetedVital:int;				//Use for exemple Main.LIFE
		private var _multiplicator:int;
		private var _originStat:int;					//Use for exemple Main.STRENGTH
		
		private var _hasCost:Boolean;
		private var _cost:int;
		private var _costVital:int;
		
		public function Skill() 
		{
			_id = "";
			_name = "";
			_isWarSkill = false;
			_effectAnim = new MovieClip();
			_targetedVital = 0;
			_multiplicator = 0;
			_originStat = 0;
			_hasCost = false;
			_cost = 0;
			_costVital = 0;
			_isKnown = false;
		}
		
		public function get id():String 
		{
			return _id;
		}
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get effectAnim():MovieClip 
		{
			return _effectAnim;
		}
		
		public function set effectAnim(value:MovieClip):void 
		{
			_effectAnim = value;
		}
		
		public function get targetedVital():int 
		{
			return _targetedVital;
		}
		
		public function set targetedVital(value:int):void 
		{
			_targetedVital = value;
		}
		
		public function get multiplicator():int 
		{
			return _multiplicator;
		}
		
		public function set multiplicator(value:int):void 
		{
			_multiplicator = value;
		}
		
		public function get originStat():int 
		{
			return _originStat;
		}
		
		public function set originStat(value:int):void 
		{
			_originStat = value;
		}
		
		public function get isWarSkill():Boolean 
		{
			return _isWarSkill;
		}
		
		public function set isWarSkill(value:Boolean):void 
		{
			_isWarSkill = value;
		}
		
		public function get hasCost():Boolean 
		{
			return _hasCost;
		}
		
		public function set hasCost(value:Boolean):void 
		{
			_hasCost = value;
		}
		
		public function get cost():int 
		{
			return _cost;
		}
		
		public function set cost(value:int):void 
		{
			_cost = value;
		}
		
		public function get costVital():int 
		{
			return _costVital;
		}
		
		public function set costVital(value:int):void 
		{
			_costVital = value;
		}
		
		public function get isKnown():Boolean 
		{
			return _isKnown;
		}
		
		public function set isKnown(value:Boolean):void 
		{
			_isKnown = value;
		}
		
	}

}