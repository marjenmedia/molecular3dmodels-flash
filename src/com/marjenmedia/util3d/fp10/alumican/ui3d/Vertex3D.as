package com.marjenmedia.util3d.fp10.alumican.ui3d
{
	public class Vertex3D
	{
		//----------------------------------------
		//CLASS CONSTANTS
		
		
		
		
		
		//----------------------------------------
		//VARIABLES
		
		/**
		 * 3D座標
		 */
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		/**
		 * UV座標
		 */
		public var u:Number;
		public var v:Number;
		
		/**
		 * 頂点インデックス
		 */
		public var index:int;
		
		
		
		
		
		//----------------------------------------
		//STAGE INSTANCES
		
		
		
		
		
		//----------------------------------------
		//METHODS
		
		/**
		 * コンストラクタ
		 */
		public function Vertex3D():void 
		{
			index = -1;
		}
	}
}