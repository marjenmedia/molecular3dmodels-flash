package  com.marjenmedia.molecules.away3d
{	
	import com.marjenmedia.molecules.ISelectAtomsPeptide;
	import com.marjenmedia.util3d.DO.AtomDO;
	/**
	 * @author marjenmedia
	 * @version 0.9
	 * 
	 * 
	 */
	
	
	
	public class SelectAtomsPeptide extends SelectAtoms implements ISelectAtomsPeptide
	{
		public function SelectAtomsPeptide()
		{
			super();
		}
		
		/**
		 * 
		 * @param	selectArray 
		 * @param	atomArray
		 * @param	selectionType
		 * @return
		 */
		
		public function multiSelect(selectArray:Array, atomArray:Array , selectionType:String):Array 
		{
			var selectedArray : Array = new Array();
			var selectArrayL : int = selectArray.length;
			
			for(var i :int = 0; i < selectArrayL; i++)
			{		
				var select:*    =  selectArray[i];
				
				var returnArray :Array;
				
				if(selectionType == "aminoAcidNum"){			 
					returnArray =  selectAminoAcidNum(atomArray , select);
				}
				if(selectionType == "aminoAcidName"){			 
					returnArray =  selectAminoAcidName(atomArray , select);
				}
				if(selectionType == "subunitType"){			 
					returnArray =  selectSubunitType(atomArray , select);
				}
				if(selectionType == "molType"){			 
					returnArray =  selectMolType(atomArray , select);
				}
				if(selectionType == "atomType"){			 
					returnArray =  selectAtomType(atomArray , select);
				}
				if(selectionType == "atomName"){			 
				returnArray =  selectAtomName(atomArray , select);
				}
				if(selectionType == "atomNum"){			 
				returnArray =  selectAtomNum(atomArray , select);
				}
			
			selectedArray = selectedArray.concat(returnArray);
			}  //for(var i = 0; i < selectArrayL; i++)
			return selectedArray;
			
		}
		/**
		 * 
		 * @param	atomArray
		 * @return
		 */
		
		public function selectPeptideChain(atomArray:Array):Array
		{
			var selectedArray : Array =  multiSelect(['N', 'CA', 'C'], atomArray , "atomType");
			return selectedArray;
		
		}
		
		/**
		 * 
		 * @param	atomArray
		 * @param	aminoAcidName
		 * @return
		 */
		
		public function selectAminoAcidName(atomArray:Array , aminoAcidName:String):Array
		{
			var selectedArray : Array = new Array();
			
			var atomArrayL :int = atomArray.length;
			for(var i:int = 0; i < atomArrayL; i++){
				var atomGO :  * 		= 	atomArray[i];
				var atomDO : AtomDO  	= 	atomGO.extra as AtomDO;
				
				if(atomDO.aminoAcidName == aminoAcidName){
					selectedArray.push(atomGO);
				}
			}
			return selectedArray;
		}
		/**
		 * 
		 * @param	atomArray
		 * @param	aminoAcidNum
		 * @return	
		 * 
		 */
		
		public function selectAminoAcidNum(atomArray :Array, aminoAcidNum:int):Array
		{
			var selectedArray : Array = new Array();
			var atomArrayL:int = atomArray.length;
			for(var i:int = 0; i < atomArrayL; i++){
				var atomGO :  * 	= atomArray[i];
				var atomDO :AtomDO 	= atomGO.extra as AtomDO;
				
				if(atomDO.aminoAcidNum == aminoAcidNum){
					selectedArray.push(atomGO);
				}
			}
			return selectedArray;
		}
		
	}
}