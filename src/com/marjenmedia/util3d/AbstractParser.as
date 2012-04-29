package  com.marjenmedia.util3d
{
	/*File: C:\Users\MarjenDell\Documents\FlashDevelop4Projects\PdbTest\src\com\marjenmedia\util3d\AbstractParser.as
	Created: 7/07/2011 11:31:24 AM
	Modified: 28/06/2011 11:39:47 AM
	Size: 1179 bytes*/
	import com.marjenmedia.util3d.events.ParseDOAEvent;
	import com.marjenmedia.util3d.parsers.interfaces.IParser;
	import flash.events.IOErrorEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	public class AbstractParser extends EventDispatcher implements  IParser
	{
		
		
		public function AbstractParser()
		{
			
		}
		
		/**
		 * 
		 *  a simple load request
		 * 
		 * @param url:String
		 * 
		 */		
		public function load(url:String):void
		{
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, onLoad);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			var request:URLRequest = new URLRequest(url);
			loader.load(request);
			
		}
		
		protected function onIoError(e:IOErrorEvent):void 
		{
		/*	bubbles	false
			cancelable	false; there is no default behavior to cancel.
			currentTarget	The object that is actively processing the Event object with an event listener.
			errorID	A reference number associated with the specific error (AIR only).
			target	The network object experiencing the input/output error.
			text	Text to be displayed as an error message.*/
			var arr:Array = [e]
			var evt:ParseDOAEvent = new ParseDOAEvent(ParseDOAEvent.LOAD_ERROR , arr);
			dispatchEvent(evt);
		}
		/**
		 * 
		 * @param evt:Event
		 * 
		 */		
		protected function onLoad(evt:Event):void
		{
			var dataStr:String = evt.currentTarget.data as  String;
			var lines:Array = dataStr.split('\n');	
			createDOA(lines);
		
		}
		
		protected function createDOA(lines:Array):void
		{
		//trace(lines.length);
		}
	}
}