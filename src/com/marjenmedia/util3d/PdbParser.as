package com.marjenmedia.util3d
{
	import ascb.util.StringUtilities;
	
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.DO.Structure2ndDO;
	import com.marjenmedia.util3d.events.ParseDOAEvent;
	import com.marjenmedia.util3d.parsers.interfaces.IParser;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import com.marjenmedia.debug.MMDebug;
	import com.demonsters.debugger.MonsterDebugger;
	
	public class PdbParser extends  AbstractParser implements IParser,  IEventDispatcher
	{	
		private var _debug:MMDebug;
		
		public function PdbParser()
		{
			super();
			MonsterDebugger.initialize(this);
			_debug = new MMDebug('PdbParser:');
			_debug.debugFlag = false;
			_debug.traceM("Hello PdbParser!");
			
		}
		/**
		 * 
		 * @param lines
		 * 
		 */		
		
		override protected function createDOA(lines:Array):void
		{
			 var atomDOA :Array = new Array();
			 var structure2ndDOA :Array = new Array();
			
			var linesL : int = lines.length;
			
		if(linesL > 2){
			for(var i:int = 0; i < linesL; i++){
				
				var line :String = lines[i];
				
				if(stringStartsWith(line, 'HELIX')) {
					var helixDO :Structure2ndDO = createHelixDO(line);
					structure2ndDOA.push(helixDO);	
				
				}else if(stringStartsWith(line, 'SHEET')){
					var sheetDO :Structure2ndDO = createSheetDO(line);
					structure2ndDOA.push(sheetDO);
						
				}else if(stringStartsWith(line, 'ATOM')) {
					var atomDO :AtomDO = createAtomDO(line);
					atomDOA.push(atomDO);	
				
				}else if(stringStartsWith(line, 'HETATM')){
				
				var hetatmDO :AtomDO = createHetatmDO(line);
					atomDOA.push(hetatmDO);	
				}
			
			}//for(var i:int = 0; i < linesL; i++){
			
			structure2ndDOA = addAminnoAcidArray(structure2ndDOA);
			///////////////////////////////////////////////////////////interface
			var structureE:ParseDOAEvent = new ParseDOAEvent(ParseDOAEvent.STRUCTURE, structure2ndDOA);
			dispatchEvent(structureE);
			var atomE:ParseDOAEvent = new ParseDOAEvent(ParseDOAEvent.ATOM, atomDOA);
			dispatchEvent(atomE);
		}else {
				
				onParseError("createDOA", "No text in file");
		}
		//	trace("atomDOA;;;" + atomDOA);
			///////////////////////////////////////////////////////////interface
		}
		/**
		 * 
		 * @param str
		 * @param match
		 * @return 
		 * 
		 */			
		private function stringStartsWith(str:*, match:*):Boolean //line, 'HELIX'
		{
			return str.match("^" + match) == match;
		}
		/**
		 * 
		 * @param line
		 * @return 
		 * 
		 */			
			
		protected function  createAtomDO(line:String):AtomDO
		{
					var atomDO : AtomDO = new AtomDO();
					atomDO.molType 			= 	'ATOM';
					atomDO.atomNum 			=	parseInt(line.substring(7, 11));
					atomDO.atomType 		= 	StringUtilities.trim(line.substring(12, 16));//(12, 16));
					atomDO.aminoAcidName 	= 	StringUtilities.trim(line.substring(17, 20));//(17, 20));
					atomDO.subunitType		= 	StringUtilities.trim(line.substring(21, 22)); //(21, 22);
					atomDO.aminoAcidNum 	= 	parseInt(line.substring(23, 26));
					
					atomDO.x        		= 	parseFloat(line.substring(30, 38));
					atomDO.y				=	parseFloat(line.substring(46, 54));// -parseFloat(line.substring(46, 54))
					atomDO.z				=	parseFloat(line.substring(38, 46));
					atomDO.atomName 		= 	StringUtilities.trim(line.substring(76, 78));
		 return atomDO;
		}
		/**
		 * 
		 * @param line
		 * @return 
		 * 
		 */		
		protected function  createHetatmDO(line:String):AtomDO
		{
					var atomDO : AtomDO = new AtomDO();
					atomDO.molType 			= 	'HETATM';
					atomDO.atomNum 			=	parseInt(line.substring(7, 11));
					atomDO.atomType 		= 	StringUtilities.trim(line.substring(12, 16));//(12, 16));
					atomDO.aminoAcidName 	= 	StringUtilities.trim(line.substring(17, 20));//(17, 20));
					atomDO.subunitType		= 	StringUtilities.trim(line.substring(21, 22)); //(21, 22);
					atomDO.aminoAcidNum 	= 	parseInt(line.substring(23, 26));
					
					atomDO.x        		= 	parseFloat(line.substring(30, 38));
					atomDO.y				=	parseFloat(line.substring(46, 54));// -parseFloat(line.substring(46, 54))
					atomDO.z				=	parseFloat(line.substring(38, 46));
					atomDO.atomName 		= 	StringUtilities.trim(line.substring(76, 78));
			return atomDO;
		}					
			
			
		/**
		 * 
		 * @param line
		 * @return 
		 * 
		 */			
		protected function  createHelixDO(line:String):Structure2ndDO
		{
			var structure2ndDO : Structure2ndDO = new Structure2ndDO();
		//	trace("HELIX" + line.substring(33, 37)+'H');							
			structure2ndDO.structureType 	= "HELIX";
			structure2ndDO.structureNum 	= parseInt(line.substring(8, 10));
			structure2ndDO.structureName 	= StringUtilities.trim(line.substring(12, 14));
			
			structure2ndDO.startName 		= StringUtilities.trim(line.substring(15, 18));
			structure2ndDO.startSubunit		= StringUtilities.trim(line.substring(18, 21));
			structure2ndDO.startNum			= parseInt(line.substring(22, 25));
			
		//	structure2ndDO.endName 			= structureA[6];
		//	structure2ndDO.endSubunit		= structureA[7];	
			structure2ndDO.endNum 			= parseInt(line.substring(33, 37));//*/
			
			return structure2ndDO;
		}
		/**
		 * 
		 * @param line
		 * @return 
		 * 
		 */		
		protected function  createSheetDO(line:String):Structure2ndDO
		{
			var structure2ndDO : Structure2ndDO = new Structure2ndDO();
		//		trace("SHEET" + line.substring(33, 37)+ "H");					
			structure2ndDO.structureType 	= "SHEET";
			structure2ndDO.structureNum 	= parseInt(line.substring(8, 10));
			structure2ndDO.structureName 	= StringUtilities.trim(line.substring(12, 14));
			
			structure2ndDO.startName 		= StringUtilities.trim(line.substring(17, 20));
			structure2ndDO.startSubunit		= StringUtilities.trim(line.substring(20, 23));
			structure2ndDO.startNum			= parseInt(line.substring(23, 26));
			
		//	structure2ndDO.endName 			= structureA[6];
		//	structure2ndDO.endSubunit		= structureA[7];	
			structure2ndDO.endNum 			= parseInt(line.substring(33, 37));//*/
			return structure2ndDO;
		
		}
		/**
		 * 
		 * @param structure2ndDOA
		 * @return 
		 * 
		 */		
		protected function addAminnoAcidArray(structure2ndDOA:Array):Array
		{
			
			var structure2ndDOAL : int = structure2ndDOA.length;
			
			for(var i:int = 0; i < structure2ndDOAL; i++){
			
				var structure2ndDO :Structure2ndDO = structure2ndDOA[i];

					structure2ndDO.aminnoAcidArray = createNumberArray(structure2ndDO.startNum, structure2ndDO.endNum);
			
			}//for(var i:int = 0; i < _structure2ndDOAL; i++){
			
			return structure2ndDOA;
		}
		/**
		 * 
		 * @param start
		 * @param finish
		 * @return 
		 * 
		 */		
		protected function createNumberArray(start:int, finish:int):Array
		{
			var numberArray : Array = new Array();
			
			
			for(var i:int = start; i < finish + 1;i++)
			{
				numberArray.push(i);
			}
			return numberArray;
		}		
				
		protected function onParseError(type:String, message:String):void
		{
			var errArray:Array = [type , message];
			
			var evt:ParseDOAEvent = new ParseDOAEvent(ParseDOAEvent.PARSE_ERROR, errArray);
			dispatchEvent(evt);
			
		}
	}//class
}//pack