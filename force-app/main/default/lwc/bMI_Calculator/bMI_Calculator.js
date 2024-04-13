import { LightningElement,track } from 'lwc';

export default class BMI_Calculator extends LightningElement {
    @track value;
    searchText;
    partOne;
    partTwo;
    
    changeHandler(){
        this.searchText = event.target.value;
        console.log('inside changeHandler');
    }
    handleClick9(){
        this.value = this.value == undefined ? '9' : this.value+'9';
    }
    handleClick8(){
        this.value = this.value == undefined ? '8' : this.value+'8';
    }
    handleClick7(){
        this.value = this.value == undefined ? '7' : this.value+'7';
    }
        handleClick6(){
        this.value = this.value == undefined ? '6' : this.value+'6';
    }
        handleClick5(){
        this.value = this.value == undefined ? '5' : this.value+'5';
    }
        handleClick4(){
        this.value = this.value == undefined ? '4' : this.value+'4';
    }
        handleClick3(){
        this.value = this.value == undefined ? '3' : this.value+'3';
    }
        handleClick2(){
        this.value = this.value == undefined ? '2' : this.value+'2';
    }
        handleClick1(){
        this.value = this.value == undefined ? '1' : this.value+'1';
    }
        handleClick0(){
        this.value = this.value == undefined ? '0' : this.value+'0';
    }
        handleClickDot(){
        this.value = this.value == undefined ? '0.' : this.value.includes('.') ? this.value : this.value+'.';
    }
        handleClickDel(){
        this.value = this.value == undefined ? undefined : this.value.substr(0,this.value.length-1);
    }
        handleClickX(){
        this.partOne = this.partOne != undefined ? this.showResult(): this.value ;
        this.value = this.partOne == undefined ? this.value : this.value + ' X ';
    }
    showResult(){
        this.partTwo = this.value.substr((this.value.indexOf('X', 0))+2,this.value.length);
        console.log(this.partTwo);
        this.value = (parseInt(this.partOne) * parseInt(this.partTwo)).toString();
        return undefined;
    }
}