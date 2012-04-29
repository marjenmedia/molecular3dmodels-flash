package  com.marjenmedia.molecules.proscenium
{
	import com.adobe.scenegraph.SceneMesh;
	import com.marjenmedia.molecules.ISelectAtomsPeptide;
	import com.marjenmedia.util3d.DO.AtomDO;
	/**
	 * @author marjenmedia
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
				
				if(selectionType == "aminoAcidNum"){			 
					var returnArray1 :Array =  selectAminoAcidNum(atomArray , select);
					selectedArray = selectedArray.concat(returnArray1);
				}
				if(selectionType == "aminoAcidName"){			 
					var returnArray2 :Array =  selectAminoAcidName(atomArray , select);
					selectedArray = selectedArray.concat(returnArray2);
				}
				if(selectionType == "subunitType"){			 
					var returnArray3: Array =  selectSubunitType(atomArray , select);
					selectedArray = selectedArray.concat(returnArray3);
				}
				if(selectionType == "molType"){			 
					var returnArray4 :Array =  selectMolType(atomArray , select);
					selectedArray = selectedArray.concat(returnArray4);
				}
				if(selectionType == "atomType"){			 
					var returnArray5:Array =  selectAtomType(atomArray , select);
					selectedArray = selectedArray.concat(returnArray5);
				}
				if(selectionType == "atomName"){			 
				var returnArray6:Array =  selectAtomName(atomArray , select);
				selectedArray = selectedArray.concat(returnArray6);
			}
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
				var atomGO :SceneMesh	= 	atomArray[i];
				var atomDO : AtomDO  	= 	atomGO.userData as AtomDO;
				
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
		 */
		
		public function selectAminoAcidNum(atomArray :Array, aminoAcidNum:int):Array
		{
			var selectedArray : Array = new Array();
			var atomArrayL:int = atomArray.length;
			for(var i:int = 0; i < atomArrayL; i++){
				var atomGO :  * 	= atomArray[i];
				var atomDO :AtomDO 	= atomGO.userData as AtomDO;
				
				if(atomDO.aminoAcidNum == aminoAcidNum){
					selectedArray.push(atomGO);
				}
			}
			return selectedArray;
		}
		
	}
}