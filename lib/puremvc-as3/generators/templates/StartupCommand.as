package <%= package_name %>.<%= controller %>.<%= commands %>
{

	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		//---------------------------------------
		// CONSTRUCTOR
		//---------------------------------------
		public function StartupCommand():void
		{
			super();
		}
		
		/**
		 * Starts the application
		 * @param note
		 */
		override public function execute(note:INotification):void
		{

		}
		
	}
	
}