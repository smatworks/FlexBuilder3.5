package com.maninsoft.smart.formeditor.refactor.simple.control
{
	import  com.maninsoft.smart.formeditor.refactor.editor.FormEditDomain
	import com.maninsoft.smart.formeditor.refactor.event.FormPropertyEvent;
	import com.maninsoft.smart.formeditor.model.FormDocument;
	import com.maninsoft.smart.formeditor.refactor.simple.view.form.FormDocumentRootViewer;
	
	public class FormDocumentController
	{
		public var editDomain:FormEditDomain;
		public var formEditPartViewer:FormDocumentRootViewer;
		
		public var _formModel:FormDocument;
		
		public function set formModel(formModel:FormDocument):void{
			this._formModel = formModel;
			
			if(this._formModel != null){
				this._formModel.addEventListener(FormPropertyEvent.UPDATE_FORM_INFO, propertyChange);
				this._formModel.addEventListener(FormPropertyEvent.UPDATE_FORM_STRUCTURE, structureChange);				
			}
		}
		
		public function get formModel():FormDocument{
			return this._formModel;
		}
		
		public function propertyChange(event:FormPropertyEvent):void{
			if(event.target == this.formModel){
				this.formEditPartViewer.refreshBasicVisual();	
			}			
		}
		
		public function structureChange(propertyChangeEvent:FormPropertyEvent):void{
			if(propertyChangeEvent.target == this.formModel){
				this.formEditPartViewer.refreshVisual();	
			}			
		}
	}
}