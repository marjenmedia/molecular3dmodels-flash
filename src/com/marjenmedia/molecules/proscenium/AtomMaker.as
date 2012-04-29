package com.marjenmedia.molecules.proscenium
{
	import com.adobe.display.Color;
	import com.adobe.scenegraph.MeshUtils;
	import com.adobe.scenegraph.MaterialStandard;
	import com.adobe.scenegraph.SceneMesh;
	
	
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.BondDO;
	
	import com.marjenmedia.molecules.IAtomMaker;
	
	import com.marjenmedia.debug.MMDebug;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class AtomMaker implements IAtomMaker
	{
		public  var _segmentsW : uint;
		public  var _segmentsH : uint;
		public var 	scaleConstant : Number = 20;
		
		public var _lights : Array;
		
		private var _Cmat : uint = 0x909090;
		private var _Nmat : uint = 0x3050F8;
		private var _Omat : uint = 0xFF0D0D;
		private var _Smat : uint = 0xFFFF30;
		private var _Pmat : uint = 0xFF8000;
		private var _Hmat : uint = 0xFFFFFF;
		private var _FEmat : uint = 0xE06633;
		
		private var _debug:MMDebug;
		private var _debugFlag:Boolean = true;
		/**
		 * @author marjenmedia
		 */
		
		public function AtomMaker()
		{
			MonsterDebugger.initialize(this);
			_debug = new MMDebug('AtomMaker:');
			_debug.traceM("Hello AtomMaker!");
			
		}
			
		/**
		 * 
		 * @param	atomDO
		 * @param	scale
		 * @param	segmentsW
		 * @param	segmentsH
		 * @return
		 */
									
		public function createAtom(atomDO :AtomDO, scale:Number = 1, segmentsW : uint = 8 ,  segmentsH : uint =  8 ):*
		{
			_segmentsW = segmentsW;
			_segmentsH = segmentsH;
				
			var atom:SceneMesh;
			var e : String = atomDO.atomName	
				if(e=="C"){	
				atom = 	makeSphere(_Cmat , 0.76 ,scale);
				}
				if(e=="N"){	
				atom = 	makeSphere(_Nmat , 0.71 ,scale);
				}
				if(e=="O"){	
				atom = 	makeSphere(_Omat , 0.66 ,scale);
				}
				if(e=="S"){	
				atom = 	makeSphere(_Smat , 1.05 ,scale);
				}
				if(e=="P"){	
				atom = 	makeSphere(_Pmat , 1.07 ,scale);
				}
				if(e=="H"){	
				atom = 	makeSphere(_Hmat , 0.31 ,scale);
				}
				if(e=="FE"){	
				atom = 	makeSphere(_FEmat , 1.32 ,scale);
				}	
	//	atom.extra = atomDO;
		atom.name = e + "-" + atomDO.aminoAcidName;
		return atom;
		}
		
		
		
		/*public var molType : String = "";
			public var subunitType : String	= "";
			public var atomType : String = "";
			public var aminoAcidName : String = "";
			public var aminoAcidNum : int		= 0;
			public var atomName : String 	= "";
			public var atomNum :int;
		 	public var x:Number;
		 	public var y:Number;
			public var z:Number;*/
		/**
		 * 
		 * @param	atom
		 * @param	atomColor
		 * @return
		 */
		//
		public function createBond(bondDO:BondDO):*
		{
			
			return "TO DO";
		}
		public function createRibbonAminoAcid(bondDO:BondDO  , mat:*) :*
		{
			
			return "TO DO";
		}
		public function changeAtomColor(atom:*, atomColor:uint):*
		{	
			var atomS :SceneMesh = atom as SceneMesh;
			var mat:MaterialStandard = atom.elements[0].material as MaterialStandard; 
			 mat.diffuseColor.setFromUInt(atomColor);
			 mat.ambientColor.setFromUInt(atomColor);
			return atomS;
		}
		public function normalAtomColor(atom:*):*
		{
			return "TO DO";
		}
		public function changeAtomSize(atom:*, atomScale:Number):*
		{
			
			return "TO DO";
			
		}
		public function destroyAtom(atom:*):void
		{
			
			
		}
		
		
	/*	public function destroyAtom(atom:*):void
		{
			var atomS :Sphere = atom as Sphere;
			atomS.dispose(false);

		}
		
	//*/
		
		private function makeSphere(matColor: uint , size:Number, scale:Number):SceneMesh
		{
			var material: MaterialStandard  = new MaterialStandard();
			material.name = "AtomMaterial";
			material.diffuseColor = Color.fromUint(matColor) as Color;
			material.ambientColor = Color.fromUint(matColor) as Color;
			
			material.specularColor.set( 1, 1, 1 );
		//	material.specularExponent = 30;
			var rad:Number = size * scale * scaleConstant;
			var sphere:SceneMesh = MeshUtils.createSphere( rad, _segmentsW, _segmentsH, material, "sphere" );
		
		return sphere;
		}
		
	}
}