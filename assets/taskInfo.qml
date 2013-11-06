import bb.cascades 1.0

Page {
    
    id:taskInfo
    
    function getHeight () {
        if (Device.getDevice() == 1)
            return 1280;
        else if(Device.getDevice() == 2)
            return 720;
        else if(Device.getDevice() == 3)
            return 1280; 	
    }
    
    function getWidth() {
        if (Device.getDevice() == 1)
            return 768;
        else if(Device.getDevice() == 2)
            return 720;
        else if(Device.getDevice() == 3)
            return 720; 	
    }
    
    
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
        
        leftPadding: 10
        rightPadding: 10
        
        layout: StackLayout {
        
        }	
        
        Label {
            text: "Created on: " + CppHelper.getclickedTaskId()
            
            textStyle {
                fontStyle: FontStyle.Italic
                color: Color.Gray
                fontSize: FontSize.Medium    
            }
        }
        Container {
            
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            
            CheckBox {
                id: isReminded
                checked: Model.isReminded (CppHelper.getclickedTaskId())
                
                verticalAlignment: VerticalAlignment.Center
                
                onCheckedChanged: {
                    saveItem.enabled = true;
                }
            }    
            
            DateTimePicker {
                id: finishDateTime
                mode: DateTimePickerMode.DateTime
                title: "Remind date"
                value: {new Date(getDatetoFinish(CppHelper.getclickedTaskId())*1000); }
                
                preferredWidth: OrientationSupport.orientation == UIOrientation.Portrait ? taskInfo.getWidth() : taskInfo.getHeight()
                
                onValueChanged: {
                    saveItem.enabled = true;                }
            }	
        }
        Label {
            text: "Description: "
            
            textStyle {
                color: Color.Gray
                fontSize: FontSize.Medium
            }
        }
        
        TextField {
            id: descriptionField
            text: taskInfo.getDescription(CppHelper.getclickedTaskId())
            
            onTextChanged: {
                saveItem.enabled = true;
            }
        }
        
        attachedObjects: [
            OrientationHandler {
                onOrientationAboutToChange: {
                    if (OrientationSupport.orientation == UIOrientation.Portrait)
                        finishDateTime.preferredWidth = taskInfo.getHeight();
                    else 
                        finishDateTime.preferredWidth = taskInfo.getWidth();
                }
            }
        ]
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
        },
        
        ActionItem {
            id: saveItem
            title: "Save"
            ActionBar.placement: ActionBarPlacement.OnBar
            
            onTriggered: {
                var a = (isReminded == true) ? 1: 0;
                if (Model.replaceEntry(CppHelper.getclickedTaskId(), descriptionField.text, finishDateTime.value, a) == 0) {
                    pop();
                }
            }
        }
    ]
    
    onCreationCompleted: {
        saveItem.enabled = false;
    }
}
