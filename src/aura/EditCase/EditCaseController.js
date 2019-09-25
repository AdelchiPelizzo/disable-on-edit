/**
 * Created by Adelchi on 16/09/2019.
 */


({
    doInit : function(component, event, helper) {
        var isEdited = component.get("c.run");
        isEdited.setParams({ recId : component.get("v.recordId") });
        isEdited.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state .. '+state);
            if (state === "SUCCESS") {
                component.set("v.isEdit", response.getReturnValue());
                if(response.getReturnValue() == true){
                    var toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "title": "WARNING! - Your case is being edited by another user",
                        "message": "Any changes you make to this record might be lost. Please come back later, and refresh the page.",
                        "mode": "sticky",
                        "type": "error"
                    });
                    toastEvent.fire();
                    // alert("Your case is being edited by a user - Any changes to this record will be lost. Please come back later.");
                }
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                            errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(isEdited);
    },

    save : function(component, event, helper) {
        component.find("edit").get("e.recordSave").fire();
        $A.get("e.force:closeQuickAction").fire();
        helper.editingStatus(component);
        helper.onDestroy(component, event, helper);
    },

    destroyComponent: function(component, event, helper) {
        console.log("destroying ...");
        helper.editingStatus(component);
        helper.onDestroy(component, event, helper);
    },

    destroyUnchanged: function(component, event, helper) {
        console.log("destroying ....");
        helper.onDestroy(component);
    },
});