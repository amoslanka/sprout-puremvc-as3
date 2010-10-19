package <%= package_name %> 
{

	import <%= package_name %>.<%= controller %>.<%= commands %>.StartupCommand;
	import <%= package_name %>.utils.Notifications;
	//import <%= package_name %>.<%= view %>.StageMediator;
	
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	public class ApplicationFacade extends Facade implements IFacade
	{
		
		//---------------------------------------
		//  SINGLETON ACCESSOR
		//---------------------------------------
		private static var _instance:ApplicationFacade;
		public static function getInstance():ApplicationFacade
		{
			_instance = _instance ? _instance : new ApplicationFacade(new SingletonEnforcer());
			return _instance;
		}
		
		//---------------------------------------
		//  CLASS PROPERTIES
		//---------------------------------------
		
		//---------------------------------------
		//  CLASS CONSTANTS
		//---------------------------------------
		
		//---------------------------------------
		//  GETTERS & SETTERS
		//---------------------------------------
		
		//---------------------------------------
		//  CONSTRUCTOR
		//---------------------------------------
		public function ApplicationFacade(enforcer:SingletonEnforcer)
		{
			super();
		}
		
		/**
		 * Registers most of the commands and the stage mediator 
		 * @param stage
		 */		
		public function startup(stage:Stage):void
		{			
			// Register commands
			registerCommand(Notifications.STARTUP, StartupCommand);
			
			// Register mediators
			//this.registerMediator(new StageMediator(stage));
			
			// Register proxies
			
			// Run startup command
			this.sendNotification(Notifications.STARTUP);
		}

	}

}

class SingletonEnforcer {}