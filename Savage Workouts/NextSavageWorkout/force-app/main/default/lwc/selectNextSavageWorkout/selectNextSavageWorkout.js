import { LightningElement , track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getNextSavage from '@salesforce/apex/selectNextSavageWorkoutController.selectNextWorkout';

export default class SelectNextSavageWorkout extends NavigationMixin(LightningElement) {

    @track nextSavageWorkoutId;
    @track error;

    @wire(getNextSavage) 
    nextSavageWorkoutWiredId({ error, data}){
        if(data){
            this.nextSavageWorkoutId = data;
            this.error = undefined;
            this.navigateToSavageWorkout();
        } else if (error){
            this.error = error;
            this.nextSavageWorkoutId = undefined;
        }else{
        }
    }

    navigateToSavageWorkout() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.nextSavageWorkoutId,
                objectApiName: 'Savage_Workout__c',
                actionName: 'view'
            }
        });
    }    

}