import bb.cascades 1.0
import list 1.0


Container {
    id: listContainer    
    
    ListView {
        
        property string touchedItem : ""
        
        id: listView
        
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
        
        
        //Push new page
        function pushNewPage () {
            mainpage.pushInfoPage()            
        }
        
        //Passes touched Item Id to c++ helper function
        //Not the best way but I haven't found a better way to pass touched item to taskinfo page
        function passTouchedItem (taskId) {
            CppHelper.setclickedTaskId(taskId) 	   
        }
        
        dataModel: GroupDataModel {
            id: data
        
        }
        
        
        listItemComponents: [
            
            ListItemComponent {
                type: "header"
                
                Container {
                    id: headerCont
                    
                    Label {
                        id: headerTitle
                        text: ListItemData == "1" ? "In Progress" : "Done"
                        textStyle.fontStyle: FontStyle.Italic
                        textStyle.fontSize: FontSize.Large
                        textStyle.fontWeight: FontWeight.Bold
                        
                        //Have to add exact width of a device
                        preferredWidth: OrientationSupport.orientation == UIOrientation.Landscape ? headerCont.ListItem.view.getHeight() : headerCont.ListItem.view.getWidth()
                    }
                    background: Color.create("#4e4e4e")
                    
                    
                    attachedObjects: [
                        OrientationHandler {
                            onOrientationAboutToChange: {
                                if (OrientationSupport.orientation == UIOrientation.Portrait)
                                    headerTitle = headerCont.ListItem.view.getHeight();
                                else 
                                    headerTitle = headerCont.ListItem.view.getWidth();
                            }
                        }
                    ] 
                }
            },
            
            ListItemComponent {
                type: "listitem"
                id:listComponent
                Container {
                    id: taskCont
                    
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    
                    Container {
                        id: checkbox
                        
                        
                        CheckBox {
                            verticalAlignment: VerticalAlignment.Center
                            
                        }
                    }
                    
                    Container {
                        id: taskInfoCont
                        
                        layout: StackLayout {
                        }
                        
                        Container {
                            id: titleCont
                            
                            Label {
                                multiline: false
                                text: ListItemData.Description
                                
                                textStyle {
                                    fontSize: FontSize.XLarge
                                    color: Color.White
                                    fontWeight: FontWeight.Bold
                                }
                            }
                        }
                        
                        Container {
                            id: dateTime
                            
                            preferredWidth: OrientationSupport.orientation == UIOrientation.Landscape ? taskCont.ListItem.view.getHeight() : taskCont.ListItem.view.getWidth()
                            
                            layout: DockLayout {
                            }
                            
                            Label {
                                
                                horizontalAlignment: HorizontalAlignment.Left
                                verticalAlignment: VerticalAlignment.Center
                                
                                id: datetofinish
                                text: ListItemData.DateCreated
                                textStyle {
                                    color: Color.create("#5c5c5c")
                                    fontStyle: FontStyle.Italic
                                }
                            } 
                            
                            Label {
                                id: statusLabel
                                horizontalAlignment: HorizontalAlignment.Right
                                verticalAlignment: VerticalAlignment.Center
                                
                                
                                text: ListItemData.Status == "1" ? "In Progress" : "Done"
                            }   
                        }
                        
                        gestureHandlers: [
                            
                            TapHandler {
                                
                                onTapped: {
                                    taskCont.ListItem.view.passTouchedItem(ListItemData.DateCreated);
                                    taskCont.ListItem.view.pushNewPage();
                                
                                }
                                
                                attachedObjects: ComponentDefinition {
                                    id: infoPage;
                                    source: "asset:///taskInfo.qml"                        
                                }
                            }
                        ]
                        
                        attachedObjects: [
                            OrientationHandler {
                                id: handler
                                onOrientationAboutToChange: {
                                    if (OrientationSupport.orientation == UIOrientation.Portrait)
                                        dateTime.preferredWidth = taskCont.ListItem.view.getHeight();
                                    else 
                                        dateTime.preferredWidth = taskCont.ListItem.view.getWidth();
                                }
                            }
                        ]    
                    }
                }
            } // end of second ListItemComponent
        ]
        
        function itemType(data, indexPath) {
            if(indexPath.length == 1){
                return "header";
            }
            else {
                return "listitem";
            }	
        
        }
        
        onCreationCompleted: {
            listView.dataModel = Model.get();
            apear.play();
        }
        
        animations: [
            TranslateTransition {
                id: apear
                duration: 700
                
                //Max Y of a device
                fromY: 1024
            }
        ]
    }
}