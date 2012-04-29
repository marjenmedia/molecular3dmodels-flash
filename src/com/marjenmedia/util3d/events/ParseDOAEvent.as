package  com.marjenmedia.util3d.events
{
	import flash.events.Event;
	
	public class ParseDOAEvent extends Event
	{
		public static const ATOM:String = "atom";
		public static const STRUCTURE:String = "structure";
		public static const BOND:String = "bond";
		public static const HELIX:String = "helix";
		public static const SHEET:String = "sheet";
		public static const HETATM:String = "hetatm";
		public static const LOAD_ERROR:String = "load_error";
		public static const PARSE_ERROR:String = "parse_error";
		
		public var DOArray: Array;
		
		public function ParseDOAEvent(type:String, DOArray: Array)
		{
			super(type);
			this.DOArray = DOArray;
		}
		
		override public function clone():Event{
			return new ParseDOAEvent(type, DOArray);
		}
		
		override public function toString():String
    	{
        	return formatToString("ParserEvent","type" ,"DOArray");
    	}

	}
}