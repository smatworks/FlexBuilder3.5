package com.maninsoft.smart.workbench.command
{
	import com.maninsoft.smart.workbench.common.command.model.Command;
	import com.maninsoft.smart.workbench.common.meta.impl.SWPackage;
	import com.maninsoft.smart.workbench.common.meta.impl.SWGanttProcess;
	import com.maninsoft.smart.workbench.event.MISPackageEvent;
	import com.maninsoft.smart.workbench.util.WorkbenchConfig;
	
	public class RemoveGanttProcessCommand extends Command
	{
		public var pack:SWPackage;		
		public var swGPrc:SWGanttProcess;
		
		public var resultHandler:Function;		
		public var faultHandler:Function;
		public var undoHandler:Function;
	
		public function RemoveGanttProcessCommand(pack:SWPackage, swGPrc:SWGanttProcess, resultHandler:Function, faultHandler:Function, undoHandler:Function) {
			super("프로세스 삭제");
			
			this.pack = pack;
			this.swGPrc = swGPrc;
			this.resultHandler = resultHandler;
			this.faultHandler = faultHandler;
			this.undoHandler = undoHandler;
		}
	
		/**
		 * 실행가능한 지 확인
		 */
		public override function canExecute():Boolean{
			// 패키지에  프로세스가 없는 경우에만
			return true;
		}
		
		/**
		 * undo가 가능한 지 확인
		 */
		public override function canUndo():Boolean{
			// 해당 패키지에 프로세스가 있는 경우에만 true
			// 프로세스 정보가 있는 경우에만 true
			return false;
		}
		
		public override function execute():void{
			WorkbenchConfig.repoService.removeProcess(this.pack, swGPrc, resultHandler, faultHandler);
		}

		public override function undo():void{			
		}		
		
//		private function executeHandler(e:MISPackageEvent):void{		
//			this.pack.setProcessResource(null);
//			
//			resultHandler(e);	
//		}	
	}
}