package com.marjenmedia.molecules.away3d
{
	import away3d.core.base.Geometry;
	import away3d.entities.Mesh;
	import away3d.materials.ColorMaterial;
	import away3d.materials.lightpickers.StaticLightPicker;
	import away3d.materials.MaterialBase;
	import away3d.materials.methods.AnisotropicSpecularMethod;
	import away3d.materials.methods.BasicSpecularMethod;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.CylinderGeometry;
	import away3d.primitives.SphereGeometry;
	
	import com.marjenmedia.util3d.DO.BondDO;
	import com.marjenmedia.util3d.DO.AtomDO;
	
	import flash.geom.Vector3D;
	
	import com.marjenmedia.molecules.IAtomMaker;
	
	import com.marjenmedia.debug.MMDebug;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class AtomMaker implements  IAtomMaker
	{
		public  var _segmentsW : uint;
		public  var _segmentsH : uint;
		public var 	_scaleConstant : Number = 20;
		public var 	_scale:Number;
		
		public var _lightPicker :StaticLightPicker;
		
		private var _Cmat :ColorMaterial;
		private var _Nmat :ColorMaterial;
		private var _Omat :ColorMaterial;
		private var _Smat :ColorMaterial;
		private var _Pmat :ColorMaterial;
		private var _Hmat :ColorMaterial;
		private var _FEmat :ColorMaterial;
		
		private var _bondMat :ColorMaterial;
		private var _bondColor :uint;
		
		
		private var _debug:MMDebug;
		private var _debugFlag:Boolean = true;
		
		public function AtomMaker(lightPicker :StaticLightPicker , bondColor :uint = 0x909090 )
		{
			_lightPicker 	= lightPicker;
			_bondColor 		= bondColor;
			
			_bondMat 		=  new ColorMaterial(_bondColor);
			_bondMat.lightPicker = _lightPicker;
			
			//MonsterDebugger.initialize(this);
			_debug = new MMDebug('AtomMaker:');
			_debug.debugFlag = _debugFlag;
			
			_debug.traceM("Hello AtomMaker!");
		}
			
		public function createAtom(atomDO:AtomDO, scale:Number = 1, segmentsW : uint = 8 ,  segmentsH : uint =  8 ):*
		{
			_segmentsW 	= segmentsW;
			_segmentsH 	= segmentsH;
			_scale 		= scale;
			var atom:Mesh;
			
			
			var e : String = atomDO.atomName;
			
				if(e=="C"){	
				var Cgeo:Geometry;
				var Cmat:ColorMaterial;
					if (!Cmat) {	
					Cmat = makeMaterial(0x909090);
					Cgeo = makeGeometry(0.76);
					_Cmat = Cmat;
					}
					atom = new Mesh(Cgeo , Cmat);
				}
				
				if(e=="N"){	
				var Ngeo:Geometry;
				var Nmat:ColorMaterial;
					if (!Nmat) {
						Nmat = makeMaterial(0x3050F8);
						Ngeo = makeGeometry(0.71);
						_Nmat = Nmat;	
					}
					atom = new Mesh(Ngeo , Nmat);
				}
				
				if(e=="O"){	
				var Ogeo:Geometry;
				var Omat:ColorMaterial;
					if(!Omat){
						Omat = makeMaterial(0xFF0D0D);
						Ogeo = makeGeometry(0.66);
						_Omat =  Omat;
					}
					atom = new Mesh(Ogeo , Omat);
				}
				
				if(e=="S"){	
				var Sgeo:Geometry;
				var Smat:ColorMaterial;
					if(!Smat){
					Smat = makeMaterial(0xFFFF30);
					Sgeo = makeGeometry( 1.05);
					_Smat = Smat;
					}
					atom = new Mesh(Sgeo , Smat);
				}
				
				if(e=="P"){	
				var Pgeo:Geometry;
				var Pmat:ColorMaterial;
					if(!Pmat){
					Pmat = makeMaterial(0xFF8000);
					Pgeo = makeGeometry( 1.07);
					_Pmat = Pmat;
					}
					atom = new Mesh(Pgeo , Pmat);
				}
				
				if (e == "H") {	
					
				var Hgeo:Geometry;
				var Hmat:ColorMaterial;
					if (!Hmat) {
					Hmat = makeMaterial(0xFFFFFF);
					Hgeo = makeGeometry(0.31);
					_Hmat = Hmat
					}
					atom = new Mesh(Hgeo , Hmat);
				}
				
				if(e=="FE"){	
				var FEgeo:Geometry;
				var FEmat:ColorMaterial;
					if(!FEmat){
					FEmat = makeMaterial(0xE06633);
					FEgeo = makeGeometry(1.32);
					_FEmat = FEmat;
					}
					atom = new Mesh(FEgeo , FEmat);
				}
				
			atomDO.oriMaterial = atom.material;
			atom.extra = atomDO;
			atom.name = atomDO.atomName + "-" + atomDO.aminoAcidName + "-" + atomDO.atomType;
		
		return atom;
		}
		
		public function createBond(bondDO:BondDO):*
		{
			var atomsDistance:Number = Vector3D.distance(bondDO.atom1Pos , bondDO.atom2Pos);
			bondDO.bondLength = atomsDistance;
			
			var bondGeometry :CylinderGeometry = new CylinderGeometry(1, 1, atomsDistance);
			bondGeometry.yUp = false;
			
			var bond :Mesh = new Mesh(bondGeometry , _bondMat);
			bond.x = bondDO.atom1Pos.x;
			bond.y = bondDO.atom1Pos.y;
			bond.z = bondDO.atom1Pos.z;
			
			bond.lookAt(bondDO.atom2Pos);
			bond.moveForward(atomsDistance / 2);	
			
			bond.extra = bondDO;
	
				
			return bond;
			
		}
		
		public function createRibbonAminoAcid(bondDO:BondDO , mat:*) :*
		{
			var atomsDistance:Number = Vector3D.distance(bondDO.atom1Pos , bondDO.atom2Pos);
			bondDO.bondLength = atomsDistance;
			
			var bondGeo:CubeGeometry = new CubeGeometry(10, 3, atomsDistance + 3, 1, 1, 1, true);
			var bond:Mesh = new  Mesh(bondGeo , mat);
			bond.x = bondDO.atom1Pos.x;
			bond.y = bondDO.atom1Pos.y;
			bond.z = bondDO.atom1Pos.z;
			//bond.yUp = false;
			bond.lookAt(bondDO.atom2Pos);
			bond.moveForward(atomsDistance / 2);	
			
			bond.extra = bondDO.extra;	
			return bond;
		}
		
		public function destroyAtom(atom:*):void
		{
			var atomS :Mesh= atom as Mesh;
			atomS.dispose();

		}
		
		public function changeAtomColor(atom:*, atomColor:uint):*
		{
			var mat : ColorMaterial = new ColorMaterial(atomColor);
			mat.lightPicker = _lightPicker;  
			
			var atomS :Mesh = atom as Mesh;
			
			atomS.material =  mat;
			
			return atomS;
		}
		
		public function normalAtomColor(atom:*):*
		{
			
			var atomDO:AtomDO = atom.extra;
			
			var e : String = atomDO.atomName
			
				if(e=="C"){	
				atom.material =  	_Cmat;
				}
				if(e=="N"){	
				atom.material =		_Nmat;
				}
				if(e=="O"){	
				atom.material =		_Omat;
				}
				if(e=="S"){	
				atom.material =  	_Smat;
				}
				if(e=="P"){	
				atom.material =  	_Pmat;
				}
				if(e=="H"){	
				atom.material =  	_Hmat;
				}
				if(e=="FE"){	
				atom.material =  	_FEmat;
				}
		
		return atom;
		}
		
		public function changeAtomSize(atom:*, atomScale:Number):*
		{
			var atomS :Mesh = atom as Mesh;
			atomS.scale(atomScale);	
			return atomS;
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
		
		
		
		
		
		
		
		
		
		
		private function makeGeometry(size:Number):Geometry
		{
			var rad:Number =  size  * _scale * _scaleConstant;	
			var geo:Geometry =  new SphereGeometry(rad,  _segmentsW , _segmentsH);
			return geo;
		}
		
		private function makeMaterial(atomColor:uint):ColorMaterial
		{
			var mat:ColorMaterial = new ColorMaterial(atomColor);
				mat.lightPicker	= _lightPicker;	
			return mat;
		}
		
		public function get bondColor():uint 
		{
			return _bondColor;
		}
		
		public function set bondColor(value:uint):void 
		{
			_bondColor = value;
		}
		
		
	}
}