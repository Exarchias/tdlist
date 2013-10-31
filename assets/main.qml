import bb.cascades 1.0
import list 1.0

NavigationPane {
    
    id: navigationPane
    
    Page {
        id: mainpage
        
        /*Title bar*/
        titleBar : TitleBar {
            title: "ToDo List"
        }
        
        
        /*Main content*/
        Container {
            id: main_content
            
            background: Color.create("#2E2E2E")
            
            TaskList {
            }
     
        }
        
        actions: [
            
            ActionItem {
                title: "Add"
                ActionBar.placement: ActionBarPlacement.OnBar 
                
                onTriggered: {
                	var page = addPage.createObject();
                    navigationPane.push(page);  	
                }
                
                attachedObjects: ComponentDefinition {
                    id: addPage;
                    source: "asset:///addPage.qml"
                }
            }	    
        ]
    }
    onPopTransitionEnded: { page.destroy(); }
}