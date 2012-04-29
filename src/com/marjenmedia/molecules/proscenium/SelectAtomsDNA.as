package  com.marjenmedia.molecules.proscenium
{
	import com.adobe.scenegraph.SceneMesh;
	import com.marjenmedia.molecules.ISelectAtomsDNA;
	import com.marjenmedia.util3d.DO.AtomDO;

	/**
	 * @author marjenmedia
	 */
	
public class SelectAtomsDNA extends SelectAtoms implements ISelectAtomsDNA
{
	public function SelectAtomsDNA()
	{
		super();
	}
	/**
	 * 
	 * @param	atomArray
	 * @return
	 */
	
	public function selectDNAbackbone(atomArray : Array):Array
	{
		var selectedArray : Array =  multiSelect(["P", "OP1" , "OP2", "O5'","C5'", "C4'","O4'","C3'","O3'","C2'","C1'"], atomArray ,"atomType");
		return selectedArray;
	}
	/**
	 * 
	 * @param	atomArray
	 * @return
	 */
	
	public function selectPhosphate(atomArray : Array):Array
	{
		var selectedArray : Array =  multiSelect([ "P", "OP1" , "OP2"], atomArray ,"selectAtomType");
		return selectedArray;
	}
	
	public function selectRibose(atomArray : Array):Array
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
	
	public function selectBase(atomArray : Array, nucleotideNum : int):Array
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
	
	public function selectA(atomArray : Array , nucleotideNum : int):Array
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
	
	public function selectC(atomArray : Array, nucleotideNum : int = -1):Array
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
	
	public function selectG(atomArray : Array, nucleotideNum : int):Array
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
	
	public function selectT(atomArray : Array, nucleotideNum : int):Array
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
			
			 
			if(selectionType == "nucleotideNum"){			 
				var returnArray1 :Array =  selectNucleotideNum(atomArray , select);
				selectedArray = selectedArray.concat(returnArray1);
			}
			if(selectionType == "nucleotideName"){			 
				var returnArray2 :Array =  selectNucleotideName(atomArray , select);
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
			
			if(selectionType == "atomNum"){			 
				var returnArray7:Array =  selectAtomNum(atomArray , select);
				selectedArray = selectedArray.concat(returnArray7);
			}
		}  //for(var i = 0; i < selectArrayL; i++)
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
				var atomGO :SceneMesh 	= atomArray[i];
				var atomDO :AtomDO 		= atomGO.userData as AtomDO;
				
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
	
	public function selectNucleotideNum(atomArray :Array, aminoAcidNum:int, atomFlag : Boolean = false):Array
	{
		var selectedArray : Array = new Array();
		
		var atomArrayL:int = atomArray.length;
		for(var i:int = 0; i < atomArrayL; i++)
		{
			var atomGO :SceneMesh 	= atomArray[i];
			var atomDO :AtomDO 		= atomGO.userData as AtomDO;
			if(atomDO.aminoAcidNum == aminoAcidNum)
			{
				selectedArray.push(atomGO);
			}
		}
		return selectedArray;
	}

}
}