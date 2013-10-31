import bb.cascades 1.0
import list 1.0


Container {
    id: listContainer    
           
    ListView {
        id: listView
        
        function pushNewPage (page) {
            navigationPane.push(page);
        }
        
        
        //property url inprogressIcon : 
        
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
                        
                        layout: DockLayout {
                        }
                        
                        Label {
                            id: datetofinish
                            text: ListItemData.DateCreated
                            textStyle {
                                color: Color.create("#5c5c5c")
                                fontStyle: FontStyle.Italic
                            }
                        }    
                    }
                    
                    gestureHandlers: [
                        
                        TapHandler {
                            
                            onTapped: {
                                //taskCont.ListItem.view.CppHelper.setclickedTaskId(ListItemData.taskId);
                                var page = infoPage.createObject();
                                
                                //navigationPane.push(page);
                            
                                taskCont.ListItem.view.pushNewPage(page);
                            	    
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