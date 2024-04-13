import { LightningElement,api } from 'lwc';

export default class ParentComponentLWC extends LightningElement {
    @api parentProp;
    handleCllick(event){
    //this.parentProp = 'Message from Parent Component';
    //console.log(this.parentProp);
    //this.template.querySelector('c-child-component-l-w-c').childfunction();
    //let compref = this.refs.child;
    //compref.display('Parent Component');
    console.log('Message Recieved deom Child Com. ',event.detail.var1);

}
}