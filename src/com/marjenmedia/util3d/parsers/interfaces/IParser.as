package com.marjenmedia.util3d.parsers.interfaces
{
	import flash.events.IEventDispatcher;
	
	public interface IParser extends IEventDispatcher
	{
		function load(url:String):void;
		
	}
	
}