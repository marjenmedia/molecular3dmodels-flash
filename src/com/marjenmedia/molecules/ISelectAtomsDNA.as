package com.marjenmedia.molecules
{

	public interface ISelectAtomsDNA
	{
		function selectDNAbackbone(atomArray :Array):Array;
		function selectPhosphate(atomArray :Array):Array;
		function selectRibose(atomArray :Array):Array;
		
		function selectBase(atomArray :Array, nucleotideNum :int):Array;
		function selectA(atomArray :Array , nucleotideNum :int):Array;
		function selectC(atomArray :Array, nucleotideNum :int):Array;
		function selectG(atomArray :Array, nucleotideNum :int):Array;
		function selectT(atomArray :Array, nucleotideNum :int):Array;
		
		function multiSelect(selectArray:Array, atomArray:Array , selectionType:String):Array;
		
		function selectNucleotideName(atomArray:Array , aminoAcidName:String):Array;
		function selectNucleotideNum(atomArray :Array, aminoAcidNum:int, atomFlag :Boolean = false):Array;
	}
}