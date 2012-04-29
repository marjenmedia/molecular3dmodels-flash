 package  com.marjenmedia.util3d
{
	import com.marjenmedia.util3d.DO.AtomDO;
	

public class SelectAtomDOsDNA extends SelectAtomDOs
{
	public function SelectAtomDOsDNA()
	{
			super();
	}
	
	public function multiSelect(selectArray:Array, atomDOA:Array , selectionType:String):Array 
	{
		var selectedArray : Array = new Array();
		var selectArrayL : int = selectArray.length;
		
		for(var i :int = 0; i < selectArrayL; i++)
		{	
			var select:*    =  selectArray[i];
			
			var returnArray :Array;
			
			if(selectionType == "nucleotideNum"){			 
				returnArray	 =  selectNucleotideNum(atomDOA , select);
			}
			if(selectionType == "nucleotideName"){			 
				returnArray =  selectNucleotideName(atomDOA , select);
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
	
	
	public function selectDNAbackbone(atomDOA : Array):Array
	{
		var selectedArray : Array =  multiSelect(["P", "OP1" , "OP2", "O5'","C5'", "C4'","O4'","C3'","O3'","C2'","C1'"], atomDOA ,"atomType");
		return selectedArray;
	}
	
	public function selectPhosphate(atomDOA : Array):Array
	{
		var selectedArray : Array =  multiSelect([ "P", "OP1" , "OP2"], atomDOA ,"selectAtomType");
		return selectedArray;
	}
	
	public function selectRibose(atomDOA : Array):Array
	{
		var selectedArray : Array =  multiSelect([ "O5'","C5'", "C4'","O4'","C3'","O3'","C2'","C1'"], atomDOA ,"atomType");
		return selectedArray;
	}
	
	public function selectBase(atomDOA : Array, nucleotideNum : int):Array
	{
		var selectedArray : Array 	=	selectNucleotideNum(atomDOA , nucleotideNum);
	
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


	public function selectA(atomDOA : Array , nucleotideNum : int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomDOA, "DA");
			selectedArray  			=  	multiSelect(["N9", "C8", "N7", "C5", "C6", "N6", "N1", "C2", "N3", "C4"], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
	}

	public function selectC(atomDOA : Array, nucleotideNum : int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomDOA, "DC");
			selectedArray  			=  	multiSelect(["N1", "C2", "O2", "N3", "C4", "N4", "C5", "C6" ], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
		
	}

	public function selectG(atomDOA : Array, nucleotideNum : int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomDOA, "DG");
			selectedArray  			=  	multiSelect(["N9", "C8", "N7", "C5", "C6", "O6", "N1", "C2", "N2", "N3", "C4"], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///N9   C8    N7 	C5    C6   O6   N1   C2    N2    N3    C4   
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
	}

	public function selectT(atomDOA : Array, nucleotideNum : int):Array
	{
		var selectedArray : Array 	=	selectNucleotideName(atomDOA, "DT");
			selectedArray  			=  	multiSelect(["N1", "C2", "O2", "N3", "C4", "O4", "C5", "C7", "C6" ], selectedArray ,"atomType");
			if(nucleotideNum == -1){
				///nothing///N1    C2   O2    N3    C4    O4    C5    C7    C6   
			}else{
			selectedArray 	=	selectNucleotideNum(selectedArray , nucleotideNum);
			}
		return selectedArray;
		
	}
	
	
	
	
	
	public function selectNucleotideName(atomDOA:Array , aminoAcidName:String):Array
	{
		var selectedArray : Array = new Array();
		
		var atomDOAL :int = atomDOA.length;
		for(var i:int = 0; i < atomDOAL; i++)
		{
			var atomDO :AtomDO	= atomDOA[i];
				 
				
				if(atomDO.aminoAcidName == aminoAcidName)
				{
					selectedArray.push(atomDO);
				}
		}
		return selectedArray;
	}

	public function selectNucleotideNum(atomDOA :Array, aminoAcidNum:int, atomFlag : Boolean = false):Array
	{
		var selectedArray : Array = new Array();
		
		var atomDOAL:int = atomDOA.length;
		for(var i:int = 0; i < atomDOAL; i++)
		{
			var atomDO :AtomDO 	= atomDOA[i];
			
			if(atomDO.aminoAcidNum == aminoAcidNum)
			{
				selectedArray.push(atomDO);
			}
		}
		return selectedArray;
	}

}
}