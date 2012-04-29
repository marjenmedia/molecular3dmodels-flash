package com.marjenmedia.molecules.proscenium
{	
	import com.adobe.display.Color;
	import com.adobe.scenegraph.MaterialStandard;
	import com.adobe.scenegraph.MeshUtils;
	import com.adobe.scenegraph.SceneMesh;
	import flash.geom.Vector3D;
	
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.BondDO;
	
	import com.demonsters.debugger.MonsterDebugger;	
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * @author marjenmedia
	 */
	
	public class MoleculeMaker
	{
		private var _atomMaker:AtomMaker;
		
		public function MoleculeMaker()
		{
			_atomMaker = new AtomMaker();	
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
					var atom:SceneMesh = _atomMaker.createAtom(atomDO, atomScale, segmentsW ,  segmentsH);
					atom.userData = atomDO;
					var	atomX:Number 	= (atomDO.x  * bondScale) + offsetX;
					var	atomY:Number	= (atomDO.y  * bondScale) + offsetY;
					var	atomZ:Number 	= (atomDO.z  * bondScale) +	offsetZ;	
					atom.setPosition(atomX , atomY, atomZ);	
					atomArray.push(atom);	
			}//for(var i:int = 0; i < DOArrayL; i++){	
			
			return atomArray
		}
	
		/**
		 * 
		 * @param atomGOA
		 * @param parentCont
		 * @return 
		 * 
		 */		
		
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
				var bondGO1 :SceneMesh;
				var bondGO2 :SceneMesh;
				var bondGO3 :SceneMesh;
				
				if(bondDO.numOfBonds == 1){
					bondGO1  = createBond(bondDO);
					bondGOA.push(bondGO1);
				}else if (bondDO.numOfBonds == 2){
					bondGO1 = createBond(bondDO);
					bondGO1.prependTranslation(1.5, 0, 0);
					bondGO2 = createBond(bondDO);
					bondGO2.prependTranslation(-1.5, 0, 0);
					bondGOA.push(bondGO1);
					bondGOA.push(bondGO2);
				}else if (bondDO.numOfBonds == 3){
					bondGO1  = createBond(bondDO);
					bondGO1.prependTranslation(2, 0, 0);
					bondGO2 = createBond(bondDO);
					bondGO3  = createBond(bondDO);
					bondGO3..prependTranslation(-2, 0, 0);
					bondGOA.push(bondGO1);
					bondGOA.push(bondGO2);
					bondGOA.push(bondGO3);
				}
			}	
			return bondGOA;
		}
		
		private function createBond(bondDO:BondDO) :SceneMesh
		{
			
			//var mat :ColorMaterial	=  new ColorMaterial(0x909090);
			var material1:MaterialStandard  = new MaterialStandard();
			material1.name = "AtomMaterial1";
			material1.diffuseColor = Color.fromUint(0xd0d0d0) as  Color
			material1.ambientColor = Color.fromUint(0x909090) as Color;
			//var c:Color
			var atomsDistance:Number = Vector3D.distance(bondDO.atom1Pos , bondDO.atom2Pos);
			bondDO.bondLength = atomsDistance;
			//var m:MeshUtils
		
			var bond:SceneMesh = MeshUtils.createCylinder(1, atomsDistance, 12, 4, material1, "bond");
			
			//bond.x = bondDO.atom1Pos.x;
			//bond.y = bondDO.atom1Pos.y;
			//bond.z = bondDO.atom1Pos.z;
			//bond.yUp = false;
			bond.lookat(bondDO.atom1Pos, bondDO.atom2Pos, new Vector3D( 1, 0, 1));
			bond.prependTranslation( 0, 0, -atomsDistance);
			//bond.lookAt(bondDO.atom2Pos);
			//bond.moveForward(atomsDistance / 2);	
			
			bond.userData = bondDO;
	
				
			return bond;
		}
			 
		 //*/
		 
		 
		 /**
		  * 
		  * @param	atomGOA
		  * @param	parentCont
		  * @return
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
			//	MonsterDebugger.trace(this, i);
			}
			return atomGOA;
		}	

	}//class
}//pack