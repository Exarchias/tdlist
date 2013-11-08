import bb.cascades 1.0

Page {
    
    function saveClicked (fName) {
        Model.addNewFolder (fName)
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
                        saveClicked(nameField.text);
                        pop();                                                
                    }
                }
            }
        }
    }    
    
    Container {
        background: Color.create("#222E2E")
        
        layout: StackLayout {
        
        }
        
        Container {
            layout: StackLayout {
            
            }
            
            Label {
                text: "Folder Name:"
                textStyle.color: Color.Gray
            }
            TextField {
                id: nameField
            }
        }
    
    }
}
