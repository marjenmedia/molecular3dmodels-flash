package com.marjenmedia.molecules
{
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.BondDO;
	
	public interface IAtomMaker
	{
		function createAtom(atomDO:AtomDO, scale:Number = 1, segmentsW : uint = 8 ,  segmentsH : uint =  8 ):*;
		function createBond(bondDO:BondDO):*;
		function createRibbonAminoAcid(bondDO:BondDO  , mat:*) :*;
		function changeAtomColor(atom:*, atomColor:uint):*;
		function normalAtomColor(atom:*):*;
		function changeAtomSize(atom:*, atomScale:Number):*;
		function destroyAtom(atom:*):void;
	}
}