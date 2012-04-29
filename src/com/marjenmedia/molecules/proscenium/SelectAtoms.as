package  com.marjenmedia.molecules.proscenium
{
	import com.adobe.scenegraph.SceneMesh;
	import com.marjenmedia.molecules.ISelectAtoms;
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.Structure2ndDO;
	/**
	 * @author marjenmedia
	 */
	
	public class SelectAtoms  implements ISelectAtoms
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
						var atomGO :SceneMesh	= atomArray[i];
						var atomDO :AtomDO	= atomGO.userData as AtomDO;
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
						var atomGO :SceneMesh	= atomArray[i];
						var atomDO :AtomDO	= atomGO.userData as AtomDO;
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
						var atomGO :SceneMesh	= atomArray[i];
						var atomDO :AtomDO	= atomGO.userData as AtomDO;
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
					var atomGO :SceneMesh	= atomArray[i];
					var atomDO :AtomDO  	= atomGO.userData as AtomDO;
					
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
				var atomGO :SceneMesh	= atomArray[i];
				var atomDO :AtomDO  	= atomGO.userData as AtomDO;
				
					if(atomDO.subunitType == subunitType){
						selectedArray.push(atomGO);
					}
			}
 			return selectedArray;
		}

		
		public function getRemainder(structure2ndDOA : Array , aminoAcidNumArray : Array):Array
		{	
		var aminoAcidNumArrayL: int = aminoAcidNumArray.length;	
			//trace("aminoAcidNumArrayL:"+ aminoAcidNumArrayL);
		var structure2ndAAarray : Array	= concatAminoAcidArrays(structure2ndDOA);
	
		var structure2ndAAarrayL : int = structure2ndAAarray.length;
			//trace("structure2ndAAarrayL:"+ structure2ndAAarrayL);
		for(var i: int = 0; i < structure2ndAAarrayL; i++){
			
			for(var j: int = 0; j < aminoAcidNumArrayL; j++){
				
				if(aminoAcidNumArray[j] == structure2ndAAarray[i]){
					
					
					
				//	aminoAcidNumArray.RemoveAt(j);
					 var dump:Array = aminoAcidNumArray.splice(j, 1);
				//	trace("dump" + i + ":"+ dump);
					
					aminoAcidNumArrayL = aminoAcidNumArray.length;
				}
			}//for(var j: int = 0; j < aminoAcidNumArrayL; j++){
			
		}//for(var i: int = 0; i < structure2ndAAarrayL; i++){	
		return aminoAcidNumArray;	
			
				
			
		}

		private function concatAminoAcidArrays(structure2ndDOA : Array):Array
		{
			
			var structure2ndDOAL :int = structure2ndDOA.length;
			var structure2ndAAarray : Array = new  Array();
		
			for(var i: int = 0; i < structure2ndDOAL; i++){
				
				
				var structure2ndDO: Structure2ndDO = structure2ndDOA[i];
				//trace("structure2ndDO" + structure2ndDO.aminnoAcidArray);
				 structure2ndAAarray = structure2ndAAarray.concat(structure2ndDO.aminnoAcidArray);
			}
		//trace("structure2ndAAarray" + structure2ndAAarray);
			return structure2ndAAarray;	
				
		}

	}//cla
}//pack