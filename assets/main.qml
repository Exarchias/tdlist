import bb.cascades 1.0
import list 1.0


TabbedPane {
    Tab {
        title: "Folder"
        id: page1
        
        Navigation {
        
        }
    }
    
    Tab {
        title: "All"
        
        NavigationPane {
            id: navigationPane        
            Page {
                id: insideFolderPage
                titleBar: TitleBar {
                    title: "All tasks"
                }
                
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
                    },
                    
                    ContextModel {
                        id: model
                        folder: CppHelper.getClickedFolderName()
                    }
                ]
                
                TaskList {
                    id: tskList
                }
                                  
                onCreationCompleted: {
                    model.fillEntire();
                    tskList.lView.dataModel = model;
                }
            }
        }
    }
}