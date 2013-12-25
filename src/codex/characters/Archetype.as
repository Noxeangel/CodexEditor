package codex.characters 
{
	/**
	 * ...
	 * @author Olivier
	 */
	public class Archetype
	{
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Attributes of the class
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _name:String;												// Name od the Archetype
		private var _id:String;													// ID of the Archetype in the XML File
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Vitals Multiplicators used by Characters 
		//		Exemple: Max Life of a character = Constitution * _strLife of his Archetype
		//		Exemple: Max Mana of a character = Intelligence * _strMana of his Archetype
		///////////////////////////////////////////////////////////////////////////////////////////////////////

		private var _vitalsMult:Array = new Array();							//New version of vital mults holder
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Attributes Multiplicators used by Characters 
		//		Exemple: Strength of a character = Level of the character * _strMult of his Archetype
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _statMult:Array = new Array();								//New version of stats mult holder
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Skills usable by Characters 
		//		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private var _hasPhyFightWithTroops:Boolean = false;
		private var _hasMagFightWithTroops:Boolean= false;
		private var _hasTalkTroops:Boolean= false;
		private var _hasHealTroops:Boolean= false;
		private var _hasKillGeneral:Boolean= false;
		private var _hasSpellTroops:Boolean= false;
		
		private var _hasPhyAttack:Boolean= false;
		private var _hasMagAttack:Boolean= false;
		private var _hasSpecialTech:Boolean= false;
		private var _hasObjectUse:Boolean= false;
		private var _hasHeal:Boolean= false;
		private var _hasProtect:Boolean= false;
		private var _hasMagic:Boolean= false;
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Constructor
		//		The only way to build an object is to load it from the XML File
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Archetype(id:String)
		{
			_id = id;
			//LoadXML();
		}
		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Basic Setters And Getters
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
		
		public function get hasPhyFightWithTroops():Boolean 
		{
			return _hasPhyFightWithTroops;
		}
		
		public function set hasPhyFightWithTroops(value:Boolean):void 
		{
			_hasPhyFightWithTroops = value;
		}
		
		public function get hasMagFightWithTroops():Boolean 
		{
			return _hasMagFightWithTroops;
		}
		
		public function set hasMagFightWithTroops(value:Boolean):void 
		{
			_hasMagFightWithTroops = value;
		}
		
		public function get hasTalkTroops():Boolean 
		{
			return _hasTalkTroops;
		}
		
		public function set hasTalkTroops(value:Boolean):void 
		{
			_hasTalkTroops = value;
		}
		
		public function get hasHealTroops():Boolean 
		{
			return _hasHealTroops;
		}
		
		public function set hasHealTroops(value:Boolean):void 
		{
			_hasHealTroops = value;
		}
		
		public function get hasKillGeneral():Boolean 
		{
			return _hasKillGeneral;
		}
		
		public function set hasKillGeneral(value:Boolean):void 
		{
			_hasKillGeneral = value;
		}
		
		public function get hasSpellTroops():Boolean 
		{
			return _hasSpellTroops;
		}
		
		public function set hasSpellTroops(value:Boolean):void 
		{
			_hasSpellTroops = value;
		}
		
		public function get hasPhyAttack():Boolean 
		{
			return _hasPhyAttack;
		}
		
		public function set hasPhyAttack(value:Boolean):void 
		{
			_hasPhyAttack = value;
		}
		
		public function get hasMagAttack():Boolean 
		{
			return _hasMagAttack;
		}
		
		public function set hasMagAttack(value:Boolean):void 
		{
			_hasMagAttack = value;
		}
		
		public function get hasSpecialTech():Boolean 
		{
			return _hasSpecialTech;
		}
		
		public function set hasSpecialTech(value:Boolean):void 
		{
			_hasSpecialTech = value;
		}
		
		public function get hasObjectUse():Boolean 
		{
			return _hasObjectUse;
		}
		
		public function set hasObjectUse(value:Boolean):void 
		{
			_hasObjectUse = value;
		}
		
		public function get hasHeal():Boolean 
		{
			return _hasHeal;
		}
		
		public function set hasHeal(value:Boolean):void 
		{
			_hasHeal = value;
		}
		
		public function get hasProtect():Boolean 
		{
			return _hasProtect;
		}
		
		public function set hasProtect(value:Boolean):void 
		{
			_hasProtect = value;
		}
		
		public function get hasMagic():Boolean 
		{
			return _hasMagic;
		}
		
		public function set hasMagic(value:Boolean):void 
		{
			_hasMagic = value;
		}
		
		public function get vitalsMult():Array 
		{
			return _vitalsMult;
		}
		
		public function set vitalsMult(value:Array):void 
		{
			_vitalsMult = value;
		}
		
		public function get statMult():Array 
		{
			return _statMult;
		}
		
		public function set statMult(value:Array):void 
		{
			_statMult = value;
		}

		
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		//				Custom Methods
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DebugTrace():void
		{
			trace ("_____________________________");
			trace ("/////////////////////////////");
			trace ("|______ARCHETYPE____________|");
			trace ("|_ID= "+ _id );
			trace ("|_Name= " + _name );
			trace ("|___________________________|");
			trace ("|_lifeMult= " + _vitalsMult[Main.LIFE] );
			trace ("|_manaMult= " + _vitalsMult[Main.MANA] );
			trace ("|___________________________|");
			trace ("|_strMult= " + _statMult[Main.STRENGTH] );
			trace ("|_conMult= " + _statMult[Main.CONSTITUTION] );
			trace ("|_wilMult= " + _statMult[Main.WILLPOWER] );
			trace ("|_intMult= " + _statMult[Main.INTELLIGENCE] );
			trace ("|_chaMult= " + _statMult[Main.CHARISMA] );
			trace ("_____________________________");
			trace ("/////////////////////////////");
			trace ("_____________________________");
			trace ("|_hasPhyAttack= " + _hasPhyAttack);
			trace ("|_hasMagAttack= " + _hasMagAttack);
			trace ("|_hasSpecialTech= " + _hasSpecialTech);
			trace ("|_hasObjectUse= " + _hasObjectUse);
			trace ("|_hasHeal= " + _hasHeal);
			trace ("|_hasProtect= " + _hasProtect);
			trace ("|_hasMagic= " + _hasMagic);
			
		}
	}

}