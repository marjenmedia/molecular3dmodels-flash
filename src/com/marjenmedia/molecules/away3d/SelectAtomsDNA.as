package  com.marjenmedia.molecules.away3d
{
	import com.marjenmedia.molecules.ISelectAtomsDNA;
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.debug.MMDebug;
	/**
	* @author marjenmedia
	* @version 0,9
	*
	*/

public class SelectAtomsDNA extends SelectAtoms implements ISelectAtomsDNA
{
	/**
	 * 
	 */
	private  var _debug:MMDebug;
	
	public function SelectAtomsDNA()
	{
			super();
		_debug = new MMDebug('SelectAtomsDNA:');
			_debug.debugFlag = true;
			_debug.flashbuilder = false;	
			_debug.traceM("Hello SelectAtomsDNA!");
		
			
	}
	/**
	 * 
	 * @param	selectArray
	 * @param	atomArray
	 * @param	selectionType
	 * @return
	 */
	// MM_TODO replace strings with constants 
	
	public function multiSelect(selectArray:Array, atomArray:Array , selectionType:String):Array 
	{
		var selectedArray : Array = new Array();
		var selectArrayL : int = selectArray.length;
		
		for(var i :int = 0; i < selectArrayL; i++)
		{	
			var select:*    =  selectArray[i];
			
			var returnArray :Array;
			
			if(selectionType == "nucleotideNum"){			 
				returnArray	 =  selectNucleotideNum(atomArray , select);
			}
			if(selectionType == "nucleotideName"){			 
				returnArray =  selectNucleotideName(atomArray , select);
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
	
	public function selectDNAbackbone(atomArray :Array):Array
	{
		var selectedArray : Array =  multiSelect(["P", "OP1" , "OP2", "O5'","C5'", "C4'","O4'","C3'","O3'","C2'","C1'"], atomArray ,"atomType");
		return selectedArray;
	}
	
	/**
	 * 
	 * @param	atomArray
	 * @return
	 */
	
	public function selectPhosphate(atomArray :Array):Array
	{
		var selectedArray : Array =  multiSelect([ "P", "OP1" , "OP2"], atomArray ,"atomType");
		return selectedArray;
	}
	/**
	 * 
	 * @param	atomArray
	 * @return
	 */
	
	
	public function selectRibose(atomArray :Array):Array
	{
		var selectedArray : Array =  multiSelect([ "O5'","C5'", "C4'","O4'","C3'","O3'","C2'","C1'"], atomArray ,"atomType");
		return selectedArray;
	}
	/**
	 * 
	 * @param	atomArray
	 * @param	nucleotideNum
	 * @return
	 */
	
	public function selectBase(atomArray :Array, nucleotideNum :int):Array
	{
		var selectedArray : Array 	=	selectNucleotideNum(atomArray , nucleotideNum);
	
		var baseName : String = selectedArray[0].extra.aminoAcidName;
			if(baseName == "DA"){
			selectedArray = selectA(selectedArray, -1);
			
			}else if(baseName == "DC"){
			selectedArray = selectC(selectedArray, -1);
				
			}else if(baseName == "DG"){
			selectedArray = selectG(selectedArray, -1);
				
			}else if(baseName == "DT"){
			selectedArray = selectT(selectedArray, -1);
				
			}
		
		//trace("baseName: " + baseName);
		return selectedArray;
	}

	/**
	 * 
	 * @param	atomArray
	 * @param	nucleotideNum
	 * @return
	 */
	
	public function selectA(atomArray :Array , nucleotideNum :int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomArray, "DA");
			selectedArray  			=  	multiSelect(["N9", "C8", "N7", "C5", "C6", "N6", "N1", "C2", "N3", "C4"], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
	}
	
	/**
	 * 
	 * @param	atomArray
	 * @param	nucleotideNum
	 * @return
	 */
	
	public function selectC(atomArray :Array, nucleotideNum :int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomArray, "DC");
			selectedArray  			=  	multiSelect(["N1", "C2", "O2", "N3", "C4", "N4", "C5", "C6" ], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;	
	}

	/**
	 * 
	 * @param	atomArray
	 * @param	nucleotideNum
	 * @return
	 */
	
	public function selectG(atomArray :Array, nucleotideNum :int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomArray, "DG");
			selectedArray  			=  	multiSelect(["N9", "C8", "N7", "C5", "C6", "O6", "N1", "C2", "N2", "N3", "C4"], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///N9   C8    N7 	C5    C6   O6   N1   C2    N2    N3    C4   
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
	}
	/**
	 * 
	 * @param	atomArray
	 * @param	nucleotideNum
	 * @return
	 */
	
	public function selectT(atomArray :Array, nucleotideNum :int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomArray, "DT");
			selectedArray  			=  	multiSelect(["N1", "C2", "O2", "N3", "C4", "O4", "C5", "C7", "C6" ], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///N1    C2   O2    N3    C4    O4    C5    C7    C6   
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
		
	}
	
	
	/**
	 * 
	 * @param	atomArray
	 * @param	aminoAcidName
	 * @return
	 */
	
	public function selectNucleotideName(atomArray:Array , aminoAcidName:String):Array
	{
		var selectedArray : Array = new Array();
		
		var atomArrayL :int = atomArray.length;
		for(var i:int = 0; i < atomArrayL; i++)
		{
				var atomGO :  * 	= atomArray[i];
				var atomDO :AtomDO 	= atomGO.extra as AtomDO;
				
				if(atomDO.aminoAcidName == aminoAcidName)
				{
					selectedArray.push(atomGO);
				}
		}
		return selectedArray;
	}
	/**
	 * 
	 * @param	atomArray
	 * @param	aminoAcidNum
	 * @param	atomFlag
	 * @return
	 */
	
	public function selectNucleotideNum(atomArray :Array, aminoAcidNum:int, atomFlag :Boolean = false):Array
	{
		var selectedArray : Array = new Array();
		
		var atomArrayL:int = atomArray.length;
		for(var i:int = 0; i < atomArrayL; i++)
		{
			var atomGO :  * 	= atomArray[i];
			var atomDO :AtomDO 	= atomGO.extra as AtomDO;
			if(atomDO.aminoAcidNum == aminoAcidNum)
			{
				selectedArray.push(atomGO);
			}
		}
		return selectedArray;
	}

}
}