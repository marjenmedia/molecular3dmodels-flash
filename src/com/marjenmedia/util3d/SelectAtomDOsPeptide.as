package  com.marjenmedia.util3d
{
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.Structure2ndDO;
	import com.marjenmedia.util3d.SelectAtomDOs;
	
	/**
	 * @author marjenmedia
	 */
	
	
	public class SelectAtomDOsPeptide extends SelectAtomDOs
	{
		public function SelectAtomDOsPeptide()
		{
			super();
		}
		
		/**
		 * 
		 * @param	selectArray
		 * @param	atomDOA
		 * @param	selectionType
		 * @return
		 */
		
		public function multiSelect(selectArray:Array, atomDOA:Array , selectionType:String):Array 
		{
			var selectedArray :Array = new Array();
			var selectArrayL :int = selectArray.length;
			
			for(var i :int = 0; i < selectArrayL; i++)
			{		
				var select:*    =  selectArray[i];
				
				var returnArray :Array;
				
				if(selectionType == "aminoAcidNum"){			 
					returnArray =  selectAminoAcidNum(atomDOA , select);
				}
				if(selectionType == "aminoAcidName"){			 
					returnArray =  selectAminoAcidName(atomDOA , select);
				}
				if(selectionType == "subunitType"){			 
					returnArray =  selectSubunitType(atomDOA , select);
				}
				if(selectionType == "molType"){			 
					returnArray =  selectMolType(atomDOA , select);
				}
				if(selectionType == "atomType"){			 
					returnArray =  selectAtomType(atomDOA , select);
				}
				if(selectionType == "atomName"){			 
				returnArray =  selectAtomName(atomDOA , select);
				}
				if(selectionType == "atomNum"){			 
				returnArray =  selectAtomNum(atomDOA , select);
				}
			
			selectedArray = selectedArray.concat(returnArray);
			}  //for(var i = 0; i < selectArrayL; i++)
			return selectedArray;
		}
		/**
		 * 
		 * @param	atomDOA
		 * @return
		 */
		
		public function selectPeptideChain(atomDOA:Array):Array
		{
			var selectedArray : Array =  multiSelect(['N', 'CA', 'C'], atomDOA , "atomType");
			return selectedArray;
		
		}
		
		/**
		 * 
		 * @param	atomDOA
		 * @param	aminoAcidName
		 * @param	atomFlag
		 * @return
		 */
		
		public function selectAminoAcidName(atomDOA:Array , aminoAcidName:String, atomFlag : Boolean = false):Array
		{
		var selectedArray : Array = new Array();
		var atomDOAL :int = atomDOA.length;
			for(var i:int = 0; i < atomDOAL; i++)
			{
				var atomDO :AtomDO = atomDOA[i];
				if(atomDO.aminoAcidName == aminoAcidName){
				selectedArray.push(atomDO);
				}
			}
		return selectedArray;
		}
		/**
		 * 
		 * @param	atomDOA
		 * @param	aminoAcidNum
		 * @return
		 */
		
		public function selectAminoAcidNum(atomDOA :Array, aminoAcidNum:int):Array
		{
		var selectedArray : Array = new Array();
		var atomDOAL:int = atomDOA.length;
			for(var i:int = 0; i < atomDOAL; i++)
			{
				var atomDO :AtomDO	= atomDOA[i];
				if(atomDO.aminoAcidNum == aminoAcidNum){
				selectedArray.push(atomDO);
				}
			}
		
		return selectedArray;
		}
		
		public function attachStructure2ndDO(atomDOA:Array, structure2ndDO :Structure2ndDO):Array
		{
			var atomDOAL:int = atomDOA.length;
			
			for(var i:int = 0; i < atomDOAL; i++)
			{
				var atomDO :AtomDO	= atomDOA[i];
				atomDO.structure2ndDO = structure2ndDO;
				
			}
			
			return atomDOA;
			
		}
		
		/**
		 * 
		 * @param	structure2ndDOA
		 * @param	type
		 * @param	selectValue
		 * @return
		 */
		
		public function selectStructure2ndDOA(structure2ndDOA :Array , type :String , selectValue :String ):Array
		{
		
			if(type == "startSubunit"){
			
			var selectedArray :Array = new Array();
		
			var structure2ndDOAL :int = structure2ndDOA.length;
				for(var i: int = 0; i < structure2ndDOAL; i++){
				
					var structure2ndDO :Structure2ndDO  = structure2ndDOA[i];
					
					if(structure2ndDO.startSubunit == selectValue){
					
						selectedArray.push(structure2ndDO);  
					}
				}
				
			}//if(type == "startSubunit"){
			
		 return selectedArray;
		}
		/**
		 * 
		 * @param	structure2ndDOA
		 * @param	aminoAcidNumArray
		 * @return
		 */
		
		public function getRemainder(structure2ndDOA :Array , aminoAcidNumArray :Array):Array
		{	
			var aminoAcidNumArrayL :int = aminoAcidNumArray.length;	
			
			var structure2ndAAarray :Array	= concatAminoAcidArrays(structure2ndDOA);
			
			var structure2ndAAarrayL :int = structure2ndAAarray.length;
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
		/**
		 * 
		 * @param	structure2ndDOA
		 * @return
		 */
		
		 
		private function concatAminoAcidArrays(structure2ndDOA :Array):Array
		{
			
			var structure2ndDOAL :int = structure2ndDOA.length;
			var structure2ndAAarray :Array = new  Array();
		
			for(var i: int = 0; i < structure2ndDOAL; i++){
				
				
				var structure2ndDO:Structure2ndDO = structure2ndDOA[i];
				//trace("structure2ndDO" + structure2ndDO.aminnoAcidArray);
				 structure2ndAAarray = structure2ndAAarray.concat(structure2ndDO.aminnoAcidArray);
			}
		//trace("structure2ndAAarray" + structure2ndAAarray);
			return structure2ndAAarray;	
				
		}
		
		
		
	}
}