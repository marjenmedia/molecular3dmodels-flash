package  com.marjenmedia.util3d.DO
{
	public class AtomDO
	{
			public var molType :String = "";
			public var subunitType :String	= "";
			public var atomType :String = "";
			public var aminoAcidName :String = "";
			public var aminoAcidNum :int	= 0;
			public var atomName :String 	= "";
			public var atomNum :int;
		 	public var x:Number;
		 	public var y:Number;
			public var z:Number;
			public var info : String 	= "";
			public var extra:Object = null;
			public var structure2ndDO:Structure2ndDO = null;
			
			public var oriMaterial:*;
			public var currentMaterial:*;
			
		
	
		
		
		

	    public function toString():String 
	    {
	        return "atomName:" + atomName + ", atomNum:" + atomNum + ", pos:" + x + ","+ y + ","+ z + ", aminoAcidName:" + aminoAcidName; 
	    }

	}
}