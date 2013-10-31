import bb.cascades 1.0
import list 1.0

Page {
    
    function saveClicked (desc, datetime) {
        
        if (Model.addNewTask(desc, datetime) == 0) {
            return 0;
        }
    
    }
    
    titleBar: TitleBar {
        
        kind: TitleBarKind.FreeForm
        kindProperties: FreeFormTitleBarKindProperties {
            Container {
                
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                leftPadding: 10
                rightPadding: 10
                
                Button {
                    id: cancelBtn
                    text: "Cancel" 
                    
                    onClicked: {
                        pop();
                    }
                }
                
                Label {
                    text: "Add A New Task"	
                    multiline: enabled
                }
                
                Button {
                    id: saveBtn
                    text: "Save"
                    
                    onClicked: {
                        if (saveClicked(description.text, finishDatePicker.value) == 0) {
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
        
        background: Color.create("#2E2E2E")
        
        Container {
            id: dateContainer 
            layout: StackLayout {
            }
            
            topPadding: 15
            
            Label {
                text: "Date:"
                textStyle.color: Color.create("#DEDEDE")
                textStyle.fontWeight: FontWeight.Bold
                layoutProperties: StackLayoutProperties {
                }
                leftPadding: 2
                
                horizontalAlignment: HorizontalAlignment.Left
            }
            
            DateTimePicker {
                
                id: finishDatePicker
                title: "Date To Finish"
                maximum: "2038-01-19"
                minimum: "1970-01-01"
                mode: DateTimePickerMode.Date
                layoutProperties: StackLayoutProperties {
                }
                
                horizontalAlignment: HorizontalAlignment.Center
            }	
        }
        
        Container {
            id: timeContainer 
            layout: StackLayout {
            }
            
            topPadding: 15
            
            Label {
                text: "Time:"
                textStyle.color: Color.create("#DEDEDE")
                textStyle.fontWeight: FontWeight.Bold
                layoutProperties: StackLayoutProperties {
                }
                leftPadding: 2
                
                horizontalAlignment: HorizontalAlignment.Left
            }
            Container {
                layout: StackLayout {
                
                }
                
                preferredWidth: Infinity.MAX_VALUE
                DateTimePicker {
                    id: finishTimePicker
                    preferredWidth: Infinity.MAX_VALUE
                    title: "Time To Finish"
                    mode: DateTimePickerMode.Time
                    layoutProperties: StackLayoutProperties {
                    }
                    verticalAlignment: VerticalAlignment.Center
                }
            }
            Label {
                text: "Description:"
                textStyle.color: Color.create("#DEDEDE")
                textStyle.fontWeight: FontWeight.Bold
                layoutProperties: StackLayoutProperties {
                }
                leftPadding: 2
                
                horizontalAlignment: HorizontalAlignment.Left
            }
            
            TextArea {
                id: description
                inputMode: TextAreaInputMode.Text
            }	
        }
    }
}
