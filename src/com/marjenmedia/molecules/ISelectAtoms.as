package com.marjenmedia.molecules
{

	public interface ISelectAtoms 
	{
		function selectAtomNum(atomArray :Array , atomNum :int):Array;
		function selectAtomName(atomArray :Array , atomName :String):Array;
		function selectMolType(atomArray :Array , molType :String):Array;
		function selectAtomType(atomArray :Array , atomType:String):Array;
		function selectSubunitType(atomArray:Array , subunitType:String):Array;
	}
}