package com.marjenmedia.util3d 
{
	
	import com.marjenmedia.util3d.DO.BondDO;
	import com.marjenmedia.util3d.DO.AtomDO;
	import com.marjenmedia.util3d.events.ParseDOAEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	
	import com.demonsters.debugger.MonsterDebugger;
	import com.marjenmedia.debug.MMDebug;
	
	
	/**
	 * ...
	 * @author Martyn Cook
	 */
	public class SdfStringParser extends EventDispatcher 
	{
		private  var _debug:MMDebug;
		private var _debugFlag:Boolean = true;
		
		public function SdfStringParser() 
		{
			_debug = new MMDebug('SdfP:');
			_debug.debugFlag = _debugFlag;
			_debug.monsterDebugger = true;
			_debug.flashdevelop = true;
			_debug.traceM("Hello SdfStringParser!");
			
			
		}
		
		public function parseString(sdfInfo:String):void
		{
			//_debug.traceM("sdfInfo" + sdfInfo);
			var lines:Array = sdfInfo.split(',');
		//	_debug.traceM("lines" + lines);
			createDOA(lines);
		}
		
		protected function createDOA(lines:Array):void
		{
			var parsLines:Boolean = true;
			var atomArrays:Array = new Array();
			var bondsArray:Array = new Array();
			var linesLen:int = lines.length;
			
			for(var i:int = 0; i < linesLen; i++)
			{
			     var line:String = lines[i];
				
				 var lineArray:Array = line.split(' ');	
				 var cleanArray:Array = cleanUpArray(lineArray);
				 
			if(parsLines){
				 if(cleanArray.length == 16 ){
					atomArrays.push(cleanArray);
						//_debug.traceM("cleanArray.length-" + cleanArray.length);
				}
				 if(cleanArray.length == 7){
					//bondsArray.push(cleanArray);
				}
			}
			if(cleanArray[0] == "END"){
					//_debug.traceM("END");
					parsLines = false;
			}	
			}
			
			var atomDOA:Array = createAtomDOA(atomArrays);
		//	_debug.traceM("atomDOA" + atomDOA);
			//var bondDOA:Array = createBondDOA(bondsArray);
			
			var atomE:ParseDOAEvent = new ParseDOAEvent(ParseDOAEvent.ATOM, atomDOA);
			//traceArray(bondDOA)
			dispatchEvent(atomE);
		//	var bondE:ParseDOAEvent = new ParseDOAEvent(ParseDOAEvent.BOND, bondDOA);
		//	dispatchEvent(bondE);
	
		}
		
		protected function cleanUpArray(dirtyArray:Array):Array
		{
			var cleanArray:Array = new Array();
			var dirtyArrayLen:int = dirtyArray.length;
			
			for(var i:int = 0; i < dirtyArrayLen; i++)
			{
			     var str:String = dirtyArray[i];
				 if (str == ""){
					 }else {	 
						cleanArray.push(str)	 
					 }
			}
			return cleanArray;
		}
		
		protected function createBondDOA(bondsArray:Array):Array
		{
			
			var bondDOA:Array = new Array();
			var bondsArrayLen:int = bondsArray.length;
			
			for (var i:int = 0; i < bondsArrayLen; i++) {
								var bArray:Array = bondsArray[i];
				
				var bondDO:BondDO = new BondDO();
				bondDO.bondNum = i + 1;		
				bondDO.atom1Num 	=	bArray[0];
				bondDO.atom2Num		=	bArray[1];
				bondDO.numOfBonds 	=	bArray[2];

				bondDOA.push(bondDO);
				
			}
		
			return bondDOA;
		}
		
		
		protected function createAtomDOA(atomArrays:Array):Array
		{
			//_debug.traceM("atomArrays.length-" + atomArrays.length);
			var atomDOA:Array = new Array();
			var atomArraysLen:int = atomArrays.length;
			
			for (var i:int = 0; i < atomArraysLen; i++) {
								var atomArray:Array = atomArrays[i];
				
				var atomDO:AtomDO = new AtomDO();
				atomDO.atomNum = i + 1;		
				atomDO.atomName = atomArray[3];
				atomDO.x =	atomArray[0];
				atomDO.y =	atomArray[1];
				atomDO.z =	atomArray[2];

				atomDOA.push(atomDO);
				
			}
			return atomDOA;
		}
		
		protected function traceArray(arr:Array):void
		{
			
			for(var i:int = 0; i < arr.length; i++)
			{
			    // traceM(i + ':' + arr[i]);
				 var  bd :BondDO = arr[i];
				var str:String = "";
				 str += "bondNum:" +	bd.bondNum;
				
				 str += " atom1Name:" + bd.atom1Name;
				 str += " atom1Num:" +	bd.atom1Num;
				 str += " atom1Pos:" +	bd.atom1Pos;
				 
				 str += " atom2Name:" +	bd.atom2Name;
				str += " atom2Num:" +	bd.atom2Num
				  str += " atom2Pos:" +	bd.atom2Pos;
				  
				  str += " atom1Name:" 	+	bd.numOfBonds;
				 //  str += "atom1Name:" 	+	bd.atom2Pos;
				  
				 
				 _debug.traceM(str);
				
			}
		
		}
		
	}

}