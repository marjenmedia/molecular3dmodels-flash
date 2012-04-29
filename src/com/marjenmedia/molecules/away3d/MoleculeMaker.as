package com.marjenmedia.molecules.away3d
{	
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.primitives.CylinderGeometry;
	import away3d.containers.ObjectContainer3D;
	
	import com.marjenmedia.molecules.IMoleculeMaker;
	import com.marjenmedia.util3d.SelectAtomDOsPeptide;
	
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.BondDO;
	
	import flash.geom.Vector3D;
	
	import com.marjenmedia.debug.MMDebug;
	import com.demonsters.debugger.MonsterDebugger;
	import org.flashdevelop.utils.FlashConnect;
	
	public class MoleculeMaker implements IMoleculeMaker
	{
		private var _atomMaker:AtomMaker;
		private var _lightPicker :StaticLightPicker;
		
		private var _debug:MMDebug;
		private var _debugFlag:Boolean = true;
		
		public function MoleculeMaker(lights :Array)
		{
			_lightPicker =  new StaticLightPicker(lights);
			_atomMaker = new AtomMaker(_lightPicker);
			
			//MonsterDebugger.initialize(this);
			_debug = new MMDebug('MoleculeMaker:');
			_debug.debugFlag = _debugFlag;
			_debug.traceM("Hello MoleculeMaker!");
		}
		///////////////////
		/**
		 * 
		 * @param DOArray
		 * @param bondScale
		 * @param atomScale
		 * @return 
		 * 
		 */		
		public function createAtoms(DOArray:  Array,  bondScale:Number, atomScale:Number, offsetX:Number = 0, offsetY:Number = 0, offsetZ:Number = 0, segmentsW : uint = 8 ,  segmentsH : uint =  8 ):Array
		{  
			var atomArray:Array = new Array();

			var DOArrayL :int = DOArray.length;

			for(var i:int = 0; i < DOArrayL; i++){	
			
							var atomDO :AtomDO = DOArray[i];			
					
				var atom:*  = _atomMaker.createAtom(atomDO, atomScale, segmentsW ,  segmentsH);
				
			
				atom.x = (atomDO.x  * bondScale) + 	offsetX;
				atom.y = (atomDO.y  * bondScale) + 	offsetY;
				atom.z = (atomDO.z  * bondScale) +	offsetZ;
			
			atom.rotationX = 0;
			atom.rotationY = 0;
			atom.rotationZ = 0;
			
			atomArray.push(atom);
		
			
			}//for(var i:int = 0; i < DOArrayL; i++){	
			
			return atomArray
		}
		
		public function createBonds(bondDOArray: Array, atomDOArray: Array,  bondScale:Number ):Array//, atomScale:Number, offsetX:Number = 0, offsetY:Number = 0, offsetZ:Number = 0, segmentsW : uint = 8 ,  segmentsH : uint =  8
		{  
			var bondArray:Array = new Array();

			var atomDOArrayL :int = atomDOArray.length;
			var bondDOArrayL :int = bondDOArray.length;

			for (var i:int = 0; i < bondDOArrayL; i++) {	
				for(var j:int = 0; j < atomDOArrayL; j++){	
			
					var bondDO :BondDO	= bondDOArray[i];
							var atomDO :AtomDO	= atomDOArray[j];
				
					if (bondDO.atom1Num == atomDO.atomNum) {
					
						bondDO.atom1Pos = new Vector3D(atomDO.x * bondScale , atomDO.y * bondScale, atomDO.z * bondScale);
						bondDO.atom1Name = atomDO.atomName;
					}
					if (bondDO.atom2Num == atomDO.atomNum) {
					
						bondDO.atom2Pos = new Vector3D(atomDO.x * bondScale, atomDO.y * bondScale , atomDO.z * bondScale );
						bondDO.atom2Name = atomDO.atomName;
					}
		
				}//for(var i:int = 0; i < DOArrayL; i++){
			}//for(var i:int = 0; i < DOArrayL; i++){	
			var bondGOA :Array = createBondObj3d(bondDOArray)
			return bondGOA;
		}
		private function createBondObj3d(bondDOArray:Array ) : Array
		{
			var bondGOA :Array =	new Array();	
			var bondDOArrayL :int = bondDOArray.length;
			
			for (var i:int = 0; i < bondDOArrayL; i++) {
							var bondDO :BondDO =	bondDOArray[i];
				var bondGO1 :*;
				var bondGO2 :*;
				var bondGO3 :*;
				
				if(bondDO.numOfBonds == 1){
					bondGO1  = createBond(bondDO);
					bondGOA.push(bondGO1);
				}else if (bondDO.numOfBonds == 2){
					bondGO1 = createBond(bondDO);
					bondGO1.moveDown(1.5);
					bondGO2 = createBond(bondDO);
					bondGO2.moveUp(1.5);
					bondGOA.push(bondGO1);
					bondGOA.push(bondGO2);
				}else if (bondDO.numOfBonds == 3){
					bondGO1  = createBond(bondDO);
					bondGO1.moveDown(2.5);
					bondGO2 = createBond(bondDO);
					bondGO3  = createBond(bondDO);
					bondGO3.moveUp(2.5);
					bondGOA.push(bondGO1);
					bondGOA.push(bondGO2);
					bondGOA.push(bondGO3);
				}
			}	
			return bondGOA;
		}
		
		private function createBond(bondDO:BondDO) :*
		{
			var bond :* = _atomMaker.createBond(bondDO);
			return bond;
		}	
			
		public function createRibbon(helixDOA:Array , mat:*, bondScale:Number):Array
		{
			var selector:SelectAtomDOsPeptide = new SelectAtomDOsPeptide();
			helixDOA 		=  selector.selectAtomType(helixDOA , "N" );
			var helixDOAL:int = helixDOA.length;
			var lastAtomDO:AtomDO = null;
			var atomGOA:Array = new Array();
			
			for(var i:int = 0; i < helixDOAL; i++)
			{
				var currentAtomDO:AtomDO = helixDOA[i];
				if (lastAtomDO == null)
				{
					lastAtomDO = currentAtomDO;	
				}else {
					var bondDO:BondDO = new BondDO();
					bondDO.atom1Pos   = new Vector3D(lastAtomDO.x *bondScale, lastAtomDO.y * bondScale, lastAtomDO.z * bondScale);
					bondDO.atom2Pos   = new Vector3D(currentAtomDO.x * bondScale , currentAtomDO.y * bondScale, currentAtomDO.z * bondScale);
					bondDO.extra = lastAtomDO;
					var connect:* = _atomMaker.createRibbonAminoAcid(bondDO, mat);
					//_molecule.addChild(connect);
					lastAtomDO = currentAtomDO;	
					atomGOA.push(connect);
				}
			}
			return atomGOA;
		}
		
		
		
		
		
		
		
		/**
		 * 
		 * @param atomGOA
		 * @param parentCont
		 * @return 
		 * 
		 */		
		public function removeAtoms(atomGOA : Array, parentCont :*):*
		{
			
			var atomGOAL : int = atomGOA.length;
			
			for(var i : int = 0; i < atomGOAL; i++)
			{
				var gO : * = atomGOA[i];
			
				parentCont.removeChild(gO);
			}
			
			return atomGOA;
		}
		/**
		 * 
		 * @param atomGOA
		 * @param parentCont
		 * @return 
		 * 
		 */		
		public function addAtoms(atomGOA : Array, parentCont :*):*
		{
			var atomGOAL : int = atomGOA.length;
			
			for(var i : int = 0; i < atomGOAL; i++)
			{
				var atom : * = atomGOA[i];
				parentCont.addChild(atom);
			}
			return atomGOA;
		}
		
		public function destroyAtoms(atomGOA :Array, parentCont: *):*
		{

			var atomGOAL : int = atomGOA.length;

			for(var i : int = 0; i < atomGOAL; i++)
			{
				    var gO :* = atomGOA[i];
				   parentCont.removeChild(gO);
				   _atomMaker.destroyAtom(gO);
	   
			}
		atomGOA = [];
		return atomGOA;
		}//*/
		
		public function changeAtomColor(atomGOA :Array, atomColor :uint):Array
		{
			var changedAtomGOA:Array = new Array();
			
			var atomGOAL : int = atomGOA.length;
			
			for(var i : int = 0; i < atomGOAL; i++)
			{
				    var atom : * = atomGOA[i];
				    atom	= _atomMaker.changeAtomColor(atom, atomColor);
				    
				    changedAtomGOA.push(atom);  
			}
			return changedAtomGOA;
		}
		
		public function normalAtomColor(atomGOA :Array):Array
		{
			var changedAtomGOA:Array = new Array();
			
			var atomGOAL : int = atomGOA.length;
			
			for(var i : int = 0; i < atomGOAL; i++)
			{
				    var atom : * = atomGOA[i];
				    atom	= _atomMaker.normalAtomColor(atom);
				    
				    changedAtomGOA.push(atom);  
			}
			return changedAtomGOA;
		}
		
		public function changeAtomSize(atomGOA:Array, atomScale:Number):Array
		{
			var changedAtomGOA:Array = new Array();
			
			var atomGOAL : int = atomGOA.length;
			
			for(var i : int = 0; i < atomGOAL; i++)
			{
				    var atom : * = atomGOA[i];
				    atom	= _atomMaker.changeAtomSize(atom , atomScale);
				    
				    changedAtomGOA.push(atom);  
			}
			return changedAtomGOA;
		}
		
		public function get atomMaker():AtomMaker 
		{
			return _atomMaker;
		}
		
		public function set atomMaker(value:AtomMaker):void 
		{
			_atomMaker = value;
		}
		
		public function get lightPicker():StaticLightPicker 
		{
			return _lightPicker;
		}
		
		public function set lightPicker(value:StaticLightPicker):void 
		{
			_lightPicker = value;
		}

	}//class
}//pack