package com.marjenmedia.molecules
{
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.BondDO;
	
	import away3d.materials.ColorMaterial;

	public interface ISelectAtomsPeptide 
	{
		function multiSelect(selectArray:Array, atomArray:Array , selectionType:String):Array; 
		function selectPeptideChain(atomArray:Array):Array;
		function selectAminoAcidName(atomArray:Array , aminoAcidName:String):Array;
		function selectAminoAcidNum(atomArray :Array, aminoAcidNum:int):Array
	}
}