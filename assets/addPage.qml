import bb.cascades 1.0
import list 1.0

Page {
    
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
    
    
    function saveClicked (desc, datetime, ischecked) {
        
        if (Model.addNewTask(desc, datetime, ischecked) == 0) {
            return 0;
        }
    
    }
    
    titleBar: TitleBar {
        
        kind: TitleBarKind.FreeForm
        
        kindProperties: FreeFormTitleBarKindProperties {
            
            Container {
                
                layout: DockLayout {
                }
                
                Button {
                    id: cancelBtn
                    text: "Cancel" 
                    
                    horizontalAlignment: HorizontalAlignment.Left
                    
                    onClicked: {
                        pop();
                    }
                }
                
                Button {
                    id: saveBtn
                    text: "Save"
                    horizontalAlignment: HorizontalAlignment.Right
                    
                    onClicked: {
                        var chckboxvalue;
                        if (reminder.checked == true)
                            chckboxvalue = 1;
                        else 
                            chckboxvalue = 0;	
                        if (saveClicked(description.text, finishDatePicker.value, chckboxvalue ) == 0) {
                            pop();                            
                        } else {
                            //Error message
                        }                        
                    }
                }
            }
        }
    }
    
    Container {
        
        background: Color.create("#222E2E")
        
        leftPadding: 10
        rightPadding: 10
        
        Container {
            id: dateContainer 
            layout: StackLayout {
            }
            
            topPadding: 15
            
            Label {
                text: "Remind Date And Time:"
                textStyle.color: Color.Gray
                layoutProperties: StackLayoutProperties {
                }
                leftPadding: 2
                
                horizontalAlignment: HorizontalAlignment.Left
            }
            
            Container {
                
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                
                CheckBox {
                    verticalAlignment: VerticalAlignment.Center
                    id: reminder
                }                
                
                DateTimePicker {
                    preferredWidth: OrientationSupport.orientation == UIOrientation.Portrait ? getWidth() : getHeight()
                    id: finishDatePicker
                    title: "Date/Tme To Remind"
                    maximum: "2038-01-19"
                    minimum: "1970-01-01"
                    enabled: reminder.checked == true ? true : false
                    value: {new Date();}
                    mode: DateTimePickerMode.DateTime
                    layoutProperties: StackLayoutProperties {
                    }
                    
                    horizontalAlignment: HorizontalAlignment.Center
                }
            }	
        }
        
        Label {
            text: "Description:"
            textStyle.color: Color.Gray
            layoutProperties: StackLayoutProperties {
            }
            leftPadding: 2
            
            horizontalAlignment: HorizontalAlignment.Left
        }
        
        TextArea {
            id: description
            inputMode: TextAreaInputMode.Text
            preferredHeight: OrientationSupport.orientation == UIOrientation.Portrait ? 250 : 50
        }	
    }
    
    attachedObjects: [
        OrientationHandler {
            onOrientationAboutToChange: {
                if (OrientationSupport.orientation == UIOrientation.Portrait) {
                    finishDatePicker.preferredWidth = getHeight();
                    finishTimePicker.preferredWidth = getHeight();
                    description.preferredHeight = 100
                }
                else { 
                    finishDatePicker.preferredWidth = getWidth();
                    finishTimePicker.preferredWidth = getWidth();
                    description.preferredHeight = 250
                }
            }
        }
    ]
}

