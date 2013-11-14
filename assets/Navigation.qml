import bb.cascades 1.0
import list 1.0

NavigationPane {
    
    id: navigationPane
    
    Page {
        id: folderPage
        
        titleBar: TitleBar {
            id: ttlbar
            
            title: "Group List"
        }
        
        function setClickedFolder (folderName) {
            CppHelper.setClickedFolderName(folderName);
        }
        
        function pushFolderViewPage () {
            var page = testpage.createObject();
            navigationPane.push(page);
        }
        
        function getFolderName (id) {
            return model.getFolderName (id);
        }
        
        attachedObjects: [
            ComponentDefinition {
                id: testpage;
                source: "asset:///folderView.qml"
            }
        ]
        
        
        
        Container {
            id: content
            
            background: Color.create("#222E2E")
            
            ListView {
                id: lstView
                dataModel: GroupDataModel {
                    id: data
                }
                
                
                listItemComponents: [
                    
                    ListItemComponent {
                        
                        type: "listitem"
                        
                        StandardListItem {
                            id: listItemComp  
                            
                            
                            title: ListItemData.FolderName
                            
                            gestureHandlers:[ 
                                
                                TapHandler {
                                    
                                    onTapped: {
                                        listItemComp.ListItem.view.parent.parent.setClickedFolder(ListItemData.Id);
                                        listItemComp.ListItem.view.parent.parent.pushFolderViewPage ();
                                    }
                                }
                            
                            ]
                        }
                    },
                    
                    ListItemComponent {
                        type: "header"  
                        
                        Container {
                            //Empty, we don't need a header
                        }
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
                
                attachedObjects: [
                    ContextFolderModel {
                        id: model
                    }
                ]
                
                onCreationCompleted: {
                    dataModel = model
                }
            }
        }
        
        actions: [
            ActionItem {
                id: addAction
                title: "Add"
                
                ActionBar.placement: ActionBarPlacement.OnBar
                
                onTriggered: {
                	var page = addFolderPage.createObject();
                	navigationPane.push(page);
                }
                attachedObjects: [
                    ComponentDefinition {
                        id: addFolderPage
                        source: "asset:///addFolder.qml"
                    }    
                ]
            }
        
        ]
    
    }    
}