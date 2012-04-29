package com.marjenmedia.molecules
{
	
	public interface IMoleculeMaker
	{
		function createAtoms(DOArray:Array,  bondScale:Number, atomScale:Number, offsetX:Number = 0, offsetY:Number = 0, offsetZ:Number = 0, segmentsW:uint = 8 ,  segmentsH:uint =  8 ):Array;
		function addAtoms(atomGOA:Array, parentCont :*):*;
		function removeAtoms(atomGOA:Array, parentCont :*):*;
		function destroyAtoms(atomGOA:Array, parentCont: * ):*;
		
		function createBonds(bondDOArray:Array, atomDOArray:Array,  bondScale:Number ):Array;  
		
		function createRibbon(helixDOA:Array , mat:*, bondScale:Number):Array;
		
		function changeAtomColor(atomGOA:Array, atomColor :uint):Array;
		function normalAtomColor(atomGOA:Array):Array;
		function changeAtomSize(atomGOA:Array, atomScale:Number):Array;
		
	}
}