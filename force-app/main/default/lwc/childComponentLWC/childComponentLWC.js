import { LightningElement,api } from 'lwc';

export default class ChildComponentLWC extends LightningElement {
    sendEvent(){
        console.log('sendEvent');
    const lwcevent = new CustomEvent('childevent',
    {
    detail: {
        var1:'Custom',
        var2:'event'
        }
    });
    this.dispatchEvent(lwcevent);
    }
}