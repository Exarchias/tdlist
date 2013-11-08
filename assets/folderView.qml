import bb.cascades 1.0
import list 1.0

Page {

    id: insideFolderPage
    
    /*Title bar*/
    titleBar : TitleBar {
        title: folderPage.getFolderName (CppHelper.getClickedFolderName ())
    }
    
    //I have to push "taskInfo.qml" from main, s
    //I can use contextProperties in it.
    //Somewhy, when I push it from "taskList", 
    //I am unable to use contextProperties
    function pushInfoPage() {
        var page = testpage.createObject();
        navigationPane.push(page);	
    }
    function pushAddPage () {
        var page = addPage.createObject();
        navigationPane.push(page); 
    }
    attachedObjects: [
        ComponentDefinition {
            id: testpage;
            source: "asset:///taskInfo.qml"
        },
        
        ComponentDefinition {
            id:addPage
            source: "asset:///addPage.qml"
        }
    ]
    
    
    /*Main content*/
    Container {
        id: main_content
        
        //background: Color.create("#2E2E2E")
        
        TaskList {
            id: tList
        }
        attachedObjects: [
            ContextModel {
                id: model
                folder: CppHelper.getClickedFolderName()
            }
        ]
        
        onCreationCompleted: {
            model.fillByFolderName();
            tList.lView.dataModel = model;
        }
        
        animations: [
            TranslateTransition {
                id: apear
                duration: 400
                
                //Max Y of a device
                fromX: 700
            }
        ]
    }
    
    
    actions: [
    	    	  	    
        ActionItem {
            title: "Add"
            ActionBar.placement: ActionBarPlacement.OnBar 
            
            onTriggered: {
                insideFolderPage.pushAddPage();
            }
        }
    ]

}
