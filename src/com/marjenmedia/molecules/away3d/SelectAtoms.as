package  com.marjenmedia.molecules.away3d
{
	import com.marjenmedia.molecules.ISelectAtoms;
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.Structure2ndDO;
	/**
	 * @author marjenmedia
	 */
	
	public class SelectAtoms implements ISelectAtoms
	{
		public function SelectAtoms()
		{
		}
		
		/**
		 * 
		 * @param	atomArray
		 * @param	atomNum
		 * @return
		 */
		
		
		public function selectAtomNum(atomArray :Array , atomNum :int):Array
		{
			var selectedArray : Array = new Array();
	
			var atomArrayL :int = atomArray.length;
					for(var i :int = 0; i < atomArrayL; i++)
					{
						var atomGO :  * 	= atomArray[i];
						var atomDO :AtomDO	= atomGO.extra as AtomDO;
						if(atomDO.atomNum == atomNum)
						{
							selectedArray.push(atomGO);
						}
					}
 		return selectedArray;
		}
		
		/**
		 * 
		 * @param	atomArray
		 * @param	atomName
		 * @return
		 */
		
		public function selectAtomName(atomArray :Array , atomName :String):Array
		{
			var selectedArray : Array = new Array();
	
			var atomArrayL :int = atomArray.length;
					for(var i :int = 0; i < atomArrayL; i++)
					{
						var atomGO :  * 	= atomArray[i];
						var atomDO :AtomDO	= atomGO.extra as AtomDO;
						if(atomDO.atomName == atomName)
						{
							selectedArray.push(atomGO);
						}
					}
 		return selectedArray;
		}
		/**
		 * 
		 * @param	atomArray
		 * @param	molType
		 * @return
		 */
		
		public function selectMolType(atomArray :Array , molType :String):Array
		{
			var selectedArray : Array = new Array();
	
			var atomArrayL :int = atomArray.length;
					for(var i :int = 0; i < atomArrayL; i++)
					{
						var atomGO :  * 	= atomArray[i];
						var atomDO :AtomDO	= atomGO.extra as AtomDO;
						if(atomDO.molType == molType)
						{
							selectedArray.push(atomGO);
						}
					}
 		return selectedArray;
		}
		/**
		 * 
		 * @param	atomArray
		 * @param	atomType
		 * @return
		 */
		
		public function selectAtomType(atomArray :Array , atomType:String):Array
		{
			var selectedArray : Array = new Array();
	
				var atomArrayL:int = atomArray.length;
				for(var i:int = 0; i < atomArrayL; i++)
				{
					var atomGO :  * 	= atomArray[i];
					var atomDO :AtomDO  	= atomGO.extra as AtomDO;
					
					if(atomDO.atomType == atomType)
					{
						selectedArray.push(atomGO);
					}
				}
 			return selectedArray;
		}
		/**
		 * 
		 * @param	atomArray
		 * @param	subunitType
		 * @return
		 */
		
		public function selectSubunitType(atomArray:Array , subunitType:String):Array
		{
			var selectedArray : Array = new Array();
	
			var atomArrayL :int = atomArray.length;
			//trace(atomArrayL);
			for(var i:int = 0; i < atomArrayL; i++)
			{
				var atomGO :  * 	= atomArray[i];
				var atomDO :AtomDO  	= atomGO.extra as AtomDO;
				
					if(atomDO.subunitType == subunitType){
						selectedArray.push(atomGO);
					}
			}
 			return selectedArray;
		}

		/**
		 * 
		 * @param	structure2ndDOA
		 * @param	aminoAcidNumArray
		 * @return
		 */
		
		public function getRemainder(structure2ndDOA : Array , aminoAcidNumArray : Array):Array
		{	
		var aminoAcidNumArrayL: int = aminoAcidNumArray.length;	
			
		var structure2ndAAarray : Array	= concatAminoAcidArrays(structure2ndDOA);
	
		var structure2ndAAarrayL : int = structure2ndAAarray.length;
			
		for(var i: int = 0; i < structure2ndAAarrayL; i++){
			
			for(var j: int = 0; j < aminoAcidNumArrayL; j++){
				
				if(aminoAcidNumArray[j] == structure2ndAAarray[i]){
					
					
					 var dump:Array = aminoAcidNumArray.splice(j, 1);
					
					aminoAcidNumArrayL = aminoAcidNumArray.length;
				}
			}//for(var j: int = 0; j < aminoAcidNumArrayL; j++){
			
		}//for(var i: int = 0; i < structure2ndAAarrayL; i++){	
		return aminoAcidNumArray;	
			
				
			
		}
		/**
		 * 
		 * @param	structure2ndDOA
		 * @return
		 */
		
		private function concatAminoAcidArrays(structure2ndDOA : Array):Array
		{
			var structure2ndDOAL :int = structure2ndDOA.length;
			var structure2ndAAarray : Array = new  Array();
		
			for(var i: int = 0; i < structure2ndDOAL; i++){
				
				var structure2ndDO: Structure2ndDO = structure2ndDOA[i];
				
				 structure2ndAAarray = structure2ndAAarray.concat(structure2ndDO.aminnoAcidArray);
			}
			return structure2ndAAarray;	
				
		}

	}//cla
}//pack