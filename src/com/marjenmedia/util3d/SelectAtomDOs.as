package  com.marjenmedia.util3d
{
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.Structure2ndDO;
	
	public class SelectAtomDOs
	{
		public function SelectAtomDOs()
		{
		}
		public function selectAtomNum(atomDOA :Array , atomNum :int):Array
		{
			var selectedArray : Array = new Array();
			var atomDOAL :int = atomDOA.length;
					for(var i :int = 0; i < atomDOAL; i++)
					{
						var atomDO :AtomDO	= atomDOA[i];
						
						if(atomDO.atomNum == atomNum)
						{
							selectedArray.push(atomDO);
						}
					}
 		return selectedArray;
		}
		
		public function selectAtomName(atomDOA :Array , atomName :String):Array
		{
			var selectedArray : Array = new Array();
			var atomDOAL :int = atomDOA.length;
					for(var i :int = 0; i < atomDOAL; i++)
					{
						var atomDO :AtomDO	= atomDOA[i];
						
						if(atomDO.atomName == atomName)
						{
							selectedArray.push(atomDO);
						}
					}
 		return selectedArray;
		}
		
		public function selectMolType(atomDOA :Array , molType :String):Array
		{
			var selectedArray : Array = new Array();
			var atomDOAL :int = atomDOA.length;
					for(var i :int = 0; i < atomDOAL; i++)
					{
						var atomDO :AtomDO	= atomDOA[i];
						
						if(atomDO.molType == molType)
						{
							selectedArray.push(atomDO);
						}
					}
 		return selectedArray;
		}

		public function selectAtomType(atomDOA :Array , atomType:String):Array
		{
			var selectedArray : Array = new Array();
			
			var atomDOAL:int = atomDOA.length;
			for(var i:int = 0; i < atomDOAL; i++)
			{
				var atomDO :AtomDO	= atomDOA[i];
				
				if(atomDO.atomType == atomType)
				{
					selectedArray.push(atomDO);
				}
			}
			return selectedArray;
		}
		
		public function selectSubunitType(atomDOA:Array , subunitType:String):Array
		{
			var selectedArray : Array = new Array();
	
			var atomDOAL :int = atomDOA.length;
			//trace(atomDOAL);
			for(var i:int = 0; i < atomDOAL; i++)
			{
				var atomDO :AtomDO	= atomDOA[i];
				
					if(atomDO.subunitType == subunitType){
						selectedArray.push(atomDO);
					}
			}
 			return selectedArray;
		}

		public function createNumberArray(start:int, finish:int):Array
		{
			var numberArray :Array = new Array();
			
			
			for(var i:int = start; i < finish + 1;i++)
			{
				numberArray.push(i);
			}
			return numberArray;
		}	
		

	}//cla
}//pack