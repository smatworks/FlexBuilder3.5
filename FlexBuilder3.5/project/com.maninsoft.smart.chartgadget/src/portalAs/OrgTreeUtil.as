// ActionScript file
import flash.events.*;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.xml.*;

import mx.controls.Tree;
import mx.events.TreeEvent;

import com.maninsoft.smart.common.event.CustormEvent;
					
public var dataXML:XML;
private var myLoader:URLLoader;

public var selectedNode:Object;
public var selectedIndex:int;
public var xmlURL:String ;
public var tree_status:String = "init";
public var user_tree:Tree;

public function treeInit(tree:Tree, url:String):void
{	
	this.user_tree = tree;
	this.xmlURL = url;
	dataCall(this.xmlURL + "?method=getRootDept");
}

public function dataCall(url:String):void
{
	var dataXMLURL:URLRequest = new URLRequest(url);
	this.myLoader = new URLLoader(dataXMLURL);
	this.myLoader.addEventListener("complete", this.xmlLoaded);
}	

public function xmlLoaded(evtObj:Event):void 
{ 
	if(this.tree_status == "init")
	{
		this.dataXML = new XML(this.myLoader.data);
		user_tree.dataProvider = this.dataXML;
	}
	else if(this.tree_status == "itemClick")
	{
		var childNode:XML = new XML(this.myLoader.data);
		this.expandTree(childNode.item);
	}
	else if(this.tree_status == "selCombo")
	{
		this.dataXML = new XML(this.myLoader.data);
		user_tree.dataProvider = this.dataXML;
	}
}

public function treeOpening(event:TreeEvent):void {
	var stringTitle:String = XML(event.item).toXMLString();
	var itemObj:Object = event.item;
	
	this.tree_status = "itemClick";
	this.selectedIndex = this.getSelectItemIndex(itemObj);
	this.selectedNode = itemObj;
	var nodeType:String = itemObj.@nodeType;
	var name:String = itemObj.@name;
	var isOpened:String = this.isOpenedValue(itemObj);
	var data:String = itemObj.@id;
	
	if(isOpened == "false")
	{
		itemObj.@isOpened = "itemOpen";
		if(nodeType == "Directory")
		{
			var tempXmlUrl:String = this.xmlURL + "?method=findChildDept&userId=" + Properties.userId + "&parentId=" + data;
			dataCall(tempXmlUrl);
		}
		user_tree.expandItem(itemObj,true);	
	}
	else if(isOpened == "itemOpen")
	{
		itemObj.@isOpened = "itemClose";
	}
	else
	{
		itemObj.@isOpened = "itemOpen";
		user_tree.expandItem(itemObj,true);	
	}
	
	if(nodeType == "file")
	{
	}
}

//트리를 클릭하여 해당 노드에  맞는 액션을 설정한다.
public function treeSelect():void
{
	this.tree_status = "itemClick"
	this.selectedIndex = user_tree.selectedIndex;
	this.selectedNode = user_tree.selectedItem;
	var nodeType:String = user_tree.selectedItem.@nodeType;
	var name:String = user_tree.selectedItem.@name;
	var isOpened:String = this.isOpenedValue(user_tree.selectedItem);
	var data:String = user_tree.selectedItem.@id;
	deptId = user_tree.selectedItem.@id;
	
	if(isOpened == "false")
	{
		user_tree.selectedItem.@isOpened = "itemOpen";
		if(nodeType == "Directory")
		{
			var tempXmlUrl:String = this.xmlURL + "?method=findChildDept&userId=" + Properties.userId + "&parentId=" + data;
			dataCall(tempXmlUrl);
		}	
	}
	else if(isOpened == "itemOpen")
	{
		user_tree.selectedItem.@isOpened = "itemClose";
		dispatchEvent( new Event(TreeEvent.ITEM_CLOSE) ); 	
	}
	else
	{
		user_tree.selectedItem.@isOpened = "itemOpen";
		user_tree.expandItem(user_tree.selectedItem,true);	
	}
	
	var eventObj:CustormEvent = new CustormEvent(CustormEvent.CUSTORM_ITEM_CLICK);
	eventObj.deptId = user_tree.selectedItem.@id;
	dispatchEvent(eventObj);
}

//해당 인덱스 구하기 
public function getSelectItemIndex(selectItem:Object):int
{
	var childNode:XML = new XML(this.myLoader.data);
	var _dataProvider:XMLList = childNode.item;
	var selectIndex:int = 0;
	for(var x:int=0;x< _dataProvider.length();x++)
	{
		if(_dataProvider.@id == selectItem.@id)
		{
			selectIndex = x;
			break;
		}
	}
	return selectIndex;
}

// 해당 폴더 트리 오픈하기 
public function expandTree(childNode:XMLList):void
{
	var index:int = this.selectedIndex;
	var node:XML = this.selectedNode as XML;
	var parentNode:*;
	
	parentNode = node;
	index = 0;
	
	// 하위 노드추가하기 
	for(var x:int=0;x<childNode.length();x++)
	{
		var tag:int = Math.abs(childNode.length()-x)-1;
		var childData:XML = new XML(childNode[tag]);
 		user_tree.dataDescriptor.addChildAt(parentNode,childData,index);
	}
 		
	user_tree.expandItem(this.selectedNode, true, true, true);	
}

// 한번 오픈되었던 폴더는 더이상 노드를 추가하지 않는다.
public function isOpenedValue(itemObj:Object):String
{
	var nodeType:String = itemObj.@nodeType;
	var isOpenedValue:String = itemObj.@isOpened;
	var isOpened:String = itemObj.@isOpened;
	
	if(isOpened == "" || isOpened == "false" || isOpened == null)
	{
		isOpenedValue = "false";
	}
	else
	{
		isOpenedValue = isOpened;
	}
	return isOpenedValue;
}