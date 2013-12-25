package codex
{
	import codex.items.Inventory;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Olivier
	 */
	public class Level
	{
		private var _id:String;
		private var _townIndex:int;
		private var _name:String;
		private var _isAlly:Boolean;
		
		private var _armyGrowth:Array = new Array();
		private var _propaganda:Array = new Array();
		
		private var _searchItem:Inventory = new Inventory();
		
		private var _background:MovieClip = new MovieClip();
		private var _mapIcon:MovieClip = new MovieClip();
		
		private var _positionOnMapX:Number;
		private var _positionOnMapY:Number;
		
		private var _neighbours:Array = new Array;
		
		public function Level()
		{
		
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
		
		public function get isAlly():Boolean
		{
			return _isAlly;
		}
		
		public function set isAlly(value:Boolean):void
		{
			_isAlly = value;
		}
		
		public function get armyGrowth():Array
		{
			return _armyGrowth;
		}
		
		public function set armyGrowth(value:Array):void
		{
			_armyGrowth = value;
		}
		
		public function get propaganda():Array
		{
			return _propaganda;
		}
		
		public function set propaganda(value:Array):void
		{
			_propaganda = value;
		}
		
		public function get searchItem():Inventory
		{
			return _searchItem;
		}
		
		public function set searchItem(value:Inventory):void
		{
			_searchItem = value;
		}
		
		public function get background():MovieClip
		{
			return _background;
		}
		
		public function set background(value:MovieClip):void
		{
			_background = value;
		}
		
		public function get townIndex():int 
		{
			return _townIndex;
		}
		
		public function set townIndex(value:int):void 
		{
			_townIndex = value;
		}
		
		public function get positionOnMapX():Number 
		{
			return _positionOnMapX;
		}
		
		public function set positionOnMapX(value:Number):void 
		{
			_positionOnMapX = value;
		}
		
		public function get positionOnMapY():Number 
		{
			return _positionOnMapY;
		}
		
		public function set positionOnMapY(value:Number):void 
		{
			_positionOnMapY = value;
		}
		
		public function get mapIcon():MovieClip 
		{
			return _mapIcon;
		}
		
		public function set mapIcon(value:MovieClip):void 
		{
			_mapIcon = value;
		}
		
		public function get neighbours():Array 
		{
			return _neighbours;
		}
		
		public function set neighbours(value:Array):void 
		{
			_neighbours = value;
		}
	
	}

}