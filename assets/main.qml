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
        
        //I have to push "taskInfo.qml" from main, s
        //I can use contextProperties in it.
        //Somewhy, when I push it from "taskList", 
        //I am unable to use contextProperties
        function pushInfoPage() {
            var page = testpage.createObject();
            navigationPane.push(page);	
        }
        attachedObjects: ComponentDefinition {
            id: testpage;
            source: "asset:///taskInfo.qml"
        }
        
        
        /*Main content*/
        Container {
            id: main_content
            
            //background: Color.create("#2E2E2E")
            
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