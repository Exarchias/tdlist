import bb.cascades 1.0

Page {
    id: headerCont
    
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
    
    function saveClicked (fName, selectedValue) {
        var value;
        if (dropDown.selectedIndex == 0) value = "Simple";
        else if(dropDown.selectedIndex == 1) value = "Shopping List";
        else value = "Task List";
        FolderModel.addNewFolderByType (fName, value);
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
                        saveClicked(nameField.text, dropDown.selectedValue);
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
            
            DropDown {
                title: "Type"
                id: dropDown
                
                preferredWidth: OrientationSupport.orientation == UIOrientation.Landscape ? headerCont.getHeight() : headerCont.getWidth()
                
                selectedOption: simple
                
                options: [
                    Option {
                        id: simple   
                        text: "Simple"
                    },
                    Option {
                        id: option1
                        text: "Shopping List"
                    },
                    
                    Option {
                        id: option2
                        text: "Task List"
                    }
                ]
            }
            
            Label {
                text: "Group Name:"
                textStyle.color: Color.Gray
            }
            TextField {
                id: nameField
            }
        }
    
    }
}
