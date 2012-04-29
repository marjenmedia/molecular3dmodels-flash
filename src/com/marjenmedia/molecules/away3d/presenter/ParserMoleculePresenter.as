package com.marjenmedia.molecules.away3d.presenter 
{
	
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import com.marjenmedia.util3d.AbstractParser;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Vector3D;
	
	import com.marjenmedia.molecules.away3d.MoleculeMaker;
	
	import com.marjenmedia.util3d.SelectAtomDOsDNA;
	import com.marjenmedia.util3d.events.ParseDOAEvent;
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.SdfParser;
	
	import flash.display.DisplayObjectContainer;
	
	import com.marjenmedia.debug.MMDebug;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Marjenmedia
	 */
	public class ParserMoleculePresenter extends EventDispatcher
	{
		
		public var	atomsGOA:Array;
		public var 	_molecule:ObjectContainer3D;
		
		protected var 	_container:DisplayObjectContainer;
		protected var 	_view3D:View3D;
		protected var 	_lights:Array;
		protected var 	_atomNum:int = -1;
		
		//protected var 	_service:SdfParser;
		protected var 	_moleculeMaker:MoleculeMaker;
		
		
		
		protected var _bondScale:Number =	10;
		protected var _atomScale:Number = 	0.7;
		protected var _offsetX:Number = 0;
		protected var _offsetY:Number = 0;
		protected var _offsetZ:Number = 0;
		
		private  var _debug:MMDebug;
		
		
		public function ParserMoleculePresenter(container:DisplayObjectContainer, lights:Array , view3D:View3D , atomNum:int = -1) 
		{
			_container = container;
			_lights = lights;
			_view3D = view3D;
			_atomNum = atomNum;
			///////////////////////////////////////////////////
				
		}
		
		public function createMolecule(service:AbstractParser, url:String, molecule:ObjectContainer3D):void
		{	
			_molecule = molecule;
			//_view3D.scene.addChild(_molecule);
			_moleculeMaker = new MoleculeMaker(_lights);
			
			service.addEventListener(ParseDOAEvent.ATOM, onParse);
			service.load(url);	
		}
		
		protected var togAtom:Boolean= false;
		protected var tempAtomGOA : Array;
		
		public function changeMolecule():void
		{	
			
			if(atomsGOA){
				if(!togAtom){
					tempAtomGOA 	=	_moleculeMaker.addAtoms(atomsGOA , _molecule);
					togAtom = true;	
				
					if (_atomNum > -1) {
						var atom:ObjectContainer3D = _molecule.getChildAt(_atomNum);
						var atomDO:AtomDO =  atom.extra as AtomDO;
						var pivotPoint:Vector3D = new Vector3D(atom.x ,  atom.y , atom.z);
						_molecule.pivotPoint = pivotPoint;
						FlashConnect.atrace("pivotPoint:" + "x:"+ atom.x + " y:" +   atom.y + " z:" +  atom.z);
						FlashConnect.atrace("nucName:" + atomDO.aminoAcidName );
						FlashConnect.atrace("nucNum:" + atomDO.aminoAcidNum );
						FlashConnect.atrace("atomType:" + atomDO.atomType );
						FlashConnect.atrace("atomName:"+ atomDO.atomName);
					}
					
				}else{
					tempAtomGOA 	= 	_moleculeMaker.removeAtoms(tempAtomGOA , _molecule);
					togAtom = false;		
				}
			}
			
			
		}
		
		private function onParse(e:ParseDOAEvent):void 
		{	
			var atomDOA:Array = e.DOArray;
			FlashConnect.atrace("atomDOA:"+ atomDOA);
			createAtoms(atomDOA);
			
		}
		
		protected function createAtoms(atomDOA:Array):void 
		{
			atomsGOA 	= 	_moleculeMaker.createAtoms(atomDOA,  _bondScale, _atomScale, _offsetX, _offsetY, _offsetZ);	
			
			var evt:Event = new Event(Event.COMPLETE);
			dispatchEvent(evt)
		}
		
	}

}