import bb.cascades 1.0

Page {
    
    id:taskInfo
    
    property  variant variantList: CppHelper.getclickedTaskId()
    
    function getDescription (taskId) {
        return Model.getDesctiption(taskId)
    }
    
    function getDatetoFinish (taskId) {
        return Model.getDatetoFinish(taskId)
    }
    
    titleBar: TitleBar {
        title: getDescription(CppHelper.getclickedTaskId())
    }
    
    Container {
        background: Color.create("#2E2E2E")
        
        layout: StackLayout {
        
        }	
        
        Label {
            text: taskInfo.getDescription(CppHelper.getclickedTaskId())
        }	
        
        Label {
            text: taskInfo.getDatetoFinish(CppHelper.getclickedTaskId()) 
        }
    }
    
    actions: [
        
        ActionItem {
            title: Model.getStatus(CppHelper.getclickedTaskId()) == 2 ? "Done" : "Undone"
            
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                if (Model.getStatus(CppHelper.getclickedTaskId()) == 2) {
                    if (Model.changeStat(CppHelper.getclickedTaskId(), 1) == 0)
                        pop();
                } else {
                    if (Model.changeStat(CppHelper.getclickedTaskId(), 2) == 0)
                        pop();
                }
            }
        },
        
        ActionItem {
            title: "Delete"
            
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                Model.removeTask(CppHelper.getclickedTaskId());
                pop();       
            }            
        }
    ]
}
