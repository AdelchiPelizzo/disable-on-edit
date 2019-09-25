/**
 * Created by Adelchi on 19/09/2019.
 */

({
    editingStatus: function(component, event, helper){
        var editingStatus = component.get("c.saveEditingStatus");
        editingStatus.setParams({ recId : component.get("v.recordId") });
        editingStatus.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state .. '+state);
            if (state === "SUCCESS") {
                console.log("successfully closed");
            }else if (state === "ERROR"){
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
        $A.enqueueAction(editingStatus);
    },


    onDestroy: function(component, event, helper){
        var destroy = component.get("c.destroy");
        destroy.setParams({ recId : component.get("v.recordId") });
        destroy.setCallback(this, function(response) {
            var state = response.getState();
            console.log('state .. '+state);
            if (state === "SUCCESS") {
                console.log("successfully closed");
            }else if (state === "ERROR"){
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
        $A.enqueueAction(destroy);
    }
});