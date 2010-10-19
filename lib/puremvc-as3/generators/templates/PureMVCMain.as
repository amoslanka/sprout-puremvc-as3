package
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import <%= package_name %>.ApplicationFacade;
	
    public class <%= class_name %> extends Sprite 
	{
	
		private var _appFacade:ApplicationFacade = ApplicationFacade.getInstance();
		
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
