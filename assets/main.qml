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
        
        Page {
            
            titleBar: TitleBar {
                title: "All tasks"
            }
            
            TaskList {
                id: tskList
            }
            
            attachedObjects: [
                ContextModel {
                    id: model
                    folder: CppHelper.getClickedFolderName()
                }
            ]
            
            onCreationCompleted: {
                model.fillEntire();
                tskList.lView.dataModel = model;
            }
        }
    }
}