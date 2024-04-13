import { LightningElement, api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';
 
export default class LWCPlatformEvent extends LightningElement {
    @track message;
    @track isShowPopUp;
     @api content;
    subscription = {};
    @api channelName = '/event/Test__e';
 
    connectedCallback() {
        // Register error listener     
        this.registerErrorListener();
        this.handleSubscribe();
    }
 
    // Handles subscribe button click
    handleSubscribe() {
        // Callback invoked whenever a new event message is received
        const self = this;
        const messageCallback = function (response) {
            console.log('New message received 1: ', JSON.stringify(response));
            console.log('New message received 2: ', response);
            var obj = JSON.parse(JSON.stringify(response));
            console.log(obj.data.payload);
            console.log(obj.data.payload.Serial_Number__c);
            console.log(self.channelName);
            let objData = obj.data.payload;
            self.message = objData.Serial_Number__c;
            self.showPopUpBox();
        };
 
        // Invoke subscribe method of empApi. Pass reference to messageCallback
        subscribe(this.channelName, -1, messageCallback).then(response => {
            // Response contains the subscription information on subscribe call
            console.log('Subscription request sent to: ', JSON.stringify(response.channel));
            this.subscription = response;
        });
    }
 
    //handle Error
    registerErrorListener() {
        onError(error => {
            console.log('Received error from server: ', JSON.stringify(error));
        });
    }

        handleOkay() {
        this.close('okay');
    }

    showPopUpBox() {  
        this.isShowPopUp = true;
    }

    hidePopUpBox() {  
        this.isShowPopUp = false;
    }
}