////////////////////////////////////////////////////////////////////////////////
//  AndGatewayController.as
//  2007.12.21, created by gslim
//
//  ============================================================================
//  Copyright (C) 2007-2008 ManInSoft Corp.
//  All Rights Reserved. 
////////////////////////////////////////////////////////////////////////////////

package com.maninsoft.smart.modeler.xpdl.controller
{
	import com.maninsoft.smart.modeler.controller.ControllerTool;
	import com.maninsoft.smart.modeler.view.NodeView;
	import com.maninsoft.smart.modeler.xpdl.controller.tool.GatewaySplitTool;
	import com.maninsoft.smart.modeler.xpdl.model.AndGateway;
	import com.maninsoft.smart.modeler.xpdl.view.AndGatewayView;
	
	/**
	 * Controller for AndGateway
	 */	
	public class AndGatewayController extends GatewayController {
		
		//----------------------------------------------------------------------
		// Initialization & Finalization
		//----------------------------------------------------------------------

		/** Constructor */
		public function AndGatewayController(model: AndGateway) {
			super(model);
		}


		//----------------------------------------------------------------------
		// Overriden Methods
		//----------------------------------------------------------------------
		
		override protected function createNodeView(): NodeView {
			return new AndGatewayView();
		}

		override protected function createTools(): Array {
			var tools: Array = [];
			var tool: ControllerTool;
			
			tool = new GatewaySplitTool(this);
			tools.push(tool);
			
			return tools;
		}
	}
}