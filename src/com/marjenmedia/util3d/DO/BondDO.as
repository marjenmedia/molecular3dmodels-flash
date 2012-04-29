package  com.marjenmedia.util3d.DO
{
	import flash.geom.Vector3D;
	public class BondDO
	{
		public var bondNum :int						= 0;
		
		public var atom1Num : int					= 0;
		public var atom1Name :String				= "";
		public var atom1Pos :Vector3D				= null;
		
		public var atom2Num :int					= 0;
		public var atom2Name :String				= "";
		public var atom2Pos :Vector3D				= null;
		
		public var numOfBonds :int					= 0;
		public var bondLength :int					= 0;
		
		
		public var extra:Object = null;
			
				
	}
}