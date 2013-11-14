import bb.cascades 1.0
import list 1.0


Container {
    
    property alias lView: listView
    
    id: mainContainer
    
    background: Color.create("#222E2E")
    
    
    
    Container {
        id: listContainer    
        
        signal timedOut()
        
        function resetTimer () {
            globalClickedTimer.start();
        }
        
        function stopTimer () {
            globalClickedTimer.stop();
        }
        
        attachedObjects: [
            QTimer {
                id: globalClickedTimer
                interval: 1000
                
                onTimeout: {
                    listContainer.timedOut();
                }            
            }
        ]
        
        
        
        Container {
            id: addItemCont
            bottomMargin: 10
            
            background: Color.create("#1D2B2B")
            
            rightPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            
            TextField {
                id: descField
                hintText: "Search/Add"
                verticalAlignment: VerticalAlignment.Center
                
                onTextChanging: {
                    model.searchData(descField.text);
                }
            }
            
            Button {
                id: add
                text: "Add"
                
                preferredWidth: 10
                onClicked: {
                    if (descField.text.length == 0) {
                        insideFolderPage.pushAddPage();           
                    }
                    else {
                        var datee = new Date();
                        Model.addNewTask(CppHelper.getClickedFolderName(), descField.text, datee , 0, 5, 15);
                        descField.text = "";
                    }
                }
            
            }
        
        }
        
        contextActions: [
            ActionSet {
                title: "Modify"
                ActionItem {
                    id: deleteAction
                    title: "Delete"
                }
            }
        ]
        
        function checkStat (taskId, newStat) {
            model.changeStat(taskId, newStat);
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
                insideFolderPage.pushInfoPage()            
            }
            
            //Passes touched Item Id to c++ helper function
            //Not the best way but I haven't found a better way to pass touched item to taskinfo page
            function passTouchedItem (taskId) {
                CppHelper.setclickedTaskId(taskId) 	   
            }
            
            function getDateToFinish (id) {
                return FolderModel.getDateToFinish(id);
            }
            
            function getDateCreated (id) {
                return FolderModel.getDateCreated(id);
            }
            
            function getPrice (id) {
                return FolderModel.getPrice(id);
            }
            
            function getQuantity (id) {
                return FolderModel.getQuantity(id);
            }
            
            function getId () {
                return CppHelper.getClickedFolderName();
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
                                
                                layout: StackLayout {
                                    orientation: LayoutOrientation.LeftToRight
                                }
                                
                                Label {
                                    
                                    horizontalAlignment: HorizontalAlignment.Left
                                    verticalAlignment: VerticalAlignment.Center
                                    visible: taskCont.ListItem.view.getDateCreated (taskCont.ListItem.view.getId())
                                    id: dateCreated
                                    text: "Date Created: " + ListItemData.DateCreated
                                    textStyle {
                                        color: Color.Gray
                                        fontStyle: FontStyle.Italic
                                    }
                                } 
                                
                                Label {
                                    id: dueDate
                                    text: "Due Date: " + ListItemData.DateToFinish
                                    visible: taskCont.ListItem.view.getDateToFinish (taskCont.ListItem.view.getId())
                                    
                                    textStyle {
                                        color: Color.Gray
                                        fontStyle: FontStyle.Italic
                                    }
                                }
                                
                                Label {
                                    id: priceLabel
                                    text: "Price: " + ListItemData.Price
                                    visible: taskCont.ListItem.view.getPrice (taskCont.ListItem.view.getId())
                                    textStyle {
                                        color: Color.Gray
                                        fontStyle: FontStyle.Italic
                                    }
                                }
                                
                                Label {
                                    id: quantityLabel
                                    text: "Quantity: " + ListItemData.Quantity
                                    visible: taskCont.ListItem.view.getQuantity (taskCont.ListItem.view.getId())
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
                                    taskCont.ListItem.view.parent.resetTimer();
                                    //clickedTimer.start();
                                }
                                
                                onCreationCompleted: {
                                    taskCont.ListItem.view.parent.timedOut.connect(changeStat);
                                }
                                
                                function changeStat () {
                                    if (chkbox.checked == checkbox.changedValue && chkbox.checked == true) {
                                        taskCont.ListItem.view.parent.checkStat (ListItemData.DateCreated, "1");
                                        taskCont.ListItem.view.parent.stopTimer ();
                                    }
                                    else if (chkbox.checked == checkbox.changedValue && chkbox.checked == false) {
                                        taskCont.ListItem.view.parent.checkStat (ListItemData.DateCreated, "2");    
                                        taskCont.ListItem.view.parent.stopTimer ();
                                    }         
                                
                                }
                            
                            }
                        
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
        }
    }

}


