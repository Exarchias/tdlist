import bb.cascades 1.0
import list 1.0

Container {
    
    id: mainContainer
    
    background: Color.create("#222E2E")
    
    Container {
        id: listContainer    
        
        Container {
            id: addItemCont
            
            background: Color.create("#1D2B2B")
            
            rightPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            
            TextField {
                id: descField
                hintText: "Task Description"
                verticalAlignment: VerticalAlignment.Center
            }
            
            Button {
                id: add
                text: "Save"
                
                preferredWidth: 10
                onClicked: {
                    if (descField.text.length == 0) {
                        mainpage.pushAddPage();           
                    }
                    else {
                        var datee = new Date();
                        Model.addNewTask(descField.text, datee , 0);
                        descField.text = "";
                    }
                }
            
            }
        
        }
        
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
            
            function checkStat (taskId, newStat) {
                Model.changeStat(taskId, newStat);
            }
            
            dataModel: GroupDataModel {
                id: data
            
            }
            
            
            listItemComponents: [
                
                ListItemComponent {
                    type: "header"
                    
                    Container {
                        id: headerCont
                        
                        leftPadding: 10    
                        background: Color.create("#344343")
                        
                        Label {
                            
                            id: headerTitle
                            text: ListItemData == "2" ? "In Progress" : "Done"
                            textStyle.fontSize: FontSize.Small
                            textStyle.fontWeight: FontWeight.Bold
                            
                            //Have to add exact width of a device
                            preferredWidth: OrientationSupport.orientation == UIOrientation.Landscape ? headerCont.ListItem.view.getHeight() : headerCont.ListItem.view.getWidth()
                        }
                        
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
                            id: taskInfoCont
                            
                            leftPadding: 20                      
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
                                        color: Color.Gray
                                        fontStyle: FontStyle.Italic
                                    }
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
                        
                        Container {
                            id: checkbox
                            
                            verticalAlignment: VerticalAlignment.Center
                            rightPadding: 10
                            
                            property bool changedValue;
                            CheckBox {
                                id: chkbox
                                signal timeElapsed()
                                
                                verticalAlignment: VerticalAlignment.Center
                                checked: ListItemData.Status == "1" ? true: false
                                
                                onCheckedChanged: {
                                    checkbox.changedValue = chkbox.checked;
                                    clickedTimer.start();
                                }
                            
                            }
                            
                            attachedObjects: [
                                
                                QTimer {
                                    id: clickedTimer
                                    interval: 800
                                    
                                    onTimeout: {
                                        if (chkbox.checked == checkbox.changedValue && chkbox.checked == true)
                                            taskCont.ListItem.view.checkStat (ListItemData.DateCreated, 1);
                                        else if (chkbox.checked == checkbox.changedValue && chkbox.checked == false)
                                            taskCont.ListItem.view.checkStat (ListItemData.DateCreated, 2);                                
                                    }
                                }
                            ]            
                        }
                    
                    } // end of second ListItemComponent
                }
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
}
