import bb.cascades 1.0
import list 1.0


Container {
    id: listContainer    
           
           
    ListView {
        
        property string touchedItem : ""
           
        id: listView
        
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
                type: "item"
                
                               
                id:listComponent
                Container {
                    id: taskCont
                                       
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
                        
                        preferredWidth: 700
                        
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
                }
            } // end of second ListItemComponent
        ]
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