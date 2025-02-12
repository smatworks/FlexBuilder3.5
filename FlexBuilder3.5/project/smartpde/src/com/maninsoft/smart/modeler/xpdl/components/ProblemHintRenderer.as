//  ProblemHintRenderer.as
//  2008.03.20, created by gslim
//
//  ============================================================================
//  Copyright (C) 2007-2008 ManInSoft Corp.
//  All Rights Reserved. 
////////////////////////////////////////////////////////////////////////////////

package com.maninsoft.smart.modeler.xpdl.components
{
	import com.maninsoft.smart.modeler.xpdl.XPDLEditor;
	import com.maninsoft.smart.modeler.xpdl.dialogs.ProblemDialog;
	import com.maninsoft.smart.modeler.xpdl.syntax.Problem;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Label;
	
	/**
	 * Problem 그리드이 Hint 컬럼의 Renderer
	 */
	public class ProblemHintRenderer extends Label {
		
		//----------------------------------------------------------------------
		// Initialization & finalization
		//----------------------------------------------------------------------

		/** Constructor */
		public function ProblemHintRenderer() {
			super();

			buttonMode = true;			
			useHandCursor = true;
			mouseChildren = false;
			
			setStyle("color", 0x0000ff);
			setStyle("textDecoration", "underline");
			setStyle("textAlign", "center");
			
			addEventListener(MouseEvent.CLICK, doClick);
		}


		//----------------------------------------------------------------------
		// Properties
		//----------------------------------------------------------------------
		
		/**
		 * editor
		 */
		public var editor: XPDLEditor;


		//----------------------------------------------------------------------
		// Overriden methods
		//----------------------------------------------------------------------
		
		override public function set data(value: Object):void {
			super.data = value;
			
			this.text = (value is Problem && Problem(value).hasHint) ? resourceManager.getString("ProcessEditorETC", "hintText") : "";
		}


		//----------------------------------------------------------------------
		// Event handlers
		//----------------------------------------------------------------------
		
		private function doClick(event: MouseEvent): void {
			var problem: Problem = data as Problem;
			
			if (problem && problem.hasHint)
				ProblemDialog.execute(problem, editor);
		}
	}
}