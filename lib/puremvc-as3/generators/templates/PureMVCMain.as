package <%= package_name@ %>
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
    public class <%= class_name %> extends Sprite 
	{
	
		private var _appFacade:AppFacade = AppFacade.getInstance();
		
        public function <%= class_name %>() 
		{
			init();
		}
		
		protected function init():void
		{
		}
		
		public function start():void
		{
			_appFacade.startup(stage);
		}
		
	}
}
