import { LightningElement,track,wire } from 'lwc';
import getweather from '@salesforce/apex/weatherApi.getweather';
import getCityName from '@salesforce/apex/weatherApi.getCityName';
import getTime from '@salesforce/apex/weatherApi.getTime';
import login2Weather from '@salesforce/apex/weatherApi.login2Weather';
import { refreshApex } from '@salesforce/apex';
export default class WeatherAPI extends LightningElement {
weather;
imageURL;
city;
temp;
date;
username;
password = '';
@track passwordError = false;
@track loginSuccess = false;
@track hasweekend;
@track time;
@track date;
@track day;
@track weather;
@track temp;
@track imageURL;
@track citi;
      connectedCallback() {
      /*setInterval(() => {
    this.getCoordinates();
  }, 5000);*/
  this.getCoordinates();
}

  getLongitude(){
    return this.longitude;
  }

  setLongitude(longitude){
    this.longitude = longitude;
  }

  getLatitude(){
    return this.latitude;
  }

  setLatitude(latitude){
    this.latitude = latitude;
  }
getCoordinates(){
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(this.showPosition.bind(this));
  } else { 
    console.log('Geolocation is not supported by this browser.');
  }
}
handleOnchange(event){
this.city = event.target.value;
}
showPosition(position) {
  console.log('Latitude: ' + position.coords.latitude + '\nLongitude: ' + position.coords.longitude);
  var lati = position.coords.latitude;
  var longi = position.coords.longitude;
  //console.log(longi+'  '+lati);
  this.setLongitude(position.coords.longitude);
  this.setLatitude(position.coords.latitude);
  this.getWeatherData();
}

getWeatherData(){
    //console.log(this.getLatitude());
    //console.log(this.getLongitude());
    getCityName({lat: this.getLatitude(), longi: this.getLongitude()}).then((response)=>{
    console.log('####Response City :',response);
    let parsedData = JSON.parse(response);
    //console.log('####Response parsedData :',parsedData.current.condition.text);
    //console.log('####Response parsedData :',parsedData.current.temp_c+'°C');
    //console.log('####Response parsedData :',parsedData.location.name);
    //console.log('####Response parsedData :',parsedData.location.localtime);
    this.imageURL = parsedData.current.condition.icon;
    this.weather = parsedData.current.condition.text;
    this.temp = parsedData.current.temp_c+'°C';
    this.citi = parsedData.location.name;
getTime({lat: this.getLatitude(), longi: this.getLongitude()}).then((response)=>{
    let parsedTime = JSON.parse(response);
    this.time = parsedTime.time;
    this.date = parsedTime.day+'-'+parsedTime.month+'-'+parsedTime.year;
    this.hasweekend = parsedTime.dayOfWeek == 'Sunday' || parsedTime.dayOfWeek == 'Saturday' ? true : false;
    this.day = parsedTime.dayOfWeek;
    //console.log('####Response Time :',response);
    }).catch((error) => {console.log('ERROR$$~~~ :',error.toString())});
  }).catch((error) => {
    //console.log('ERROR$$ :',error.toString()+' at line '+error.line);
        console.log('Failed line number: ', error.message);
});
}

buttonClick(){
  if(this.city == ''){
    this.getCoordinates();
    return;
  }
  console.log('inside buttonclick');
  setInterval(() => {
  /*getweather({city: this.city}).then((response)=>{
    //console.log('####Response :',response);
    let parsedData = JSON.parse(response);
    this.imageURL = parsedData.current.condition.icon;
    this.weather = parsedData.current.condition.text;
    this.temp = parsedData.current.temp_c+'°C';
    this.citi = parsedData.location.name;
getTime({lat: this.getLatitude(), longi: this.getLongitude()}).then((response)=>{
    let parsedTime = JSON.parse(response);
    this.time = parsedTime.time;
    this.date = parsedTime.date;
    this.hasweekend = parsedTime.dayOfWeek == 'Sunday' || parsedTime.dayOfWeek == 'Saturday' ? true : false;
    this.day = parsedTime.dayOfWeek;
    //console.log('####Response Time :',response);
    }).catch((error) => {console.log('ERROR$$~~~ :',error.toString())});
  }).catch((error) => {console.log('ERROR$$ :',error.toString())});*/
  this.getButtonClickWeather();
    }, 5000);
}

clearAll(){
this.weather = '';
this.imageURL = '';
this.city = '';
this.temp = '';
this.time = '';
this.date = '';
this.weather = '';
this.temp = '';
this. imageURL = '';
}
 handleEnter(event){
  console.log(event);
    if(event.keyCode === 13){
      this.buttonClick();
    }
  }

  handleUsername(event){
    this.username = event.target.value;
  }

    handlePassword(event){
    this.password += event.target.value.substring(event.target.value.length-1);
  }

    login(event){
login2Weather({username: this.username, password: this.password}).then((response)=>{
  console.log('login2Weather :',response);
    if(response == 'success'){
      this.getCoordinates();
      this.passwordError = false;
      this.loginSuccess = true;
    }else if(response == 'error'){
      this.passwordError = true;
    }
    }).catch((error) => {console.log('ERROR$$~~~ :',error.toString())});
  }

  handleEnter2(event){
    if(event.keyCode === 13){
      this.login();
    }
  }
  getButtonClickWeather(){
  getweather({city: this.city}).then((response)=>{
    //console.log('####Response :',response);
    let parsedData = JSON.parse(response);
    this.imageURL = parsedData.current.condition.icon;
    this.weather = parsedData.current.condition.text;
    this.temp = parsedData.current.temp_c+'°C';
    this.citi = parsedData.location.name;
getTime({lat: this.getLatitude(), longi: this.getLongitude()}).then((response)=>{
    let parsedTime = JSON.parse(response);
    this.time = parsedTime.time;
    this.date = parsedTime.date;
    this.hasweekend = parsedTime.dayOfWeek == 'Sunday' || parsedTime.dayOfWeek == 'Saturday' ? true : false;
    this.day = parsedTime.dayOfWeek;
    //console.log('####Response Time :',response);
    }).catch((error) => {console.log('ERROR$$~~~ :',error.toString())});
  }).catch((error) => {console.log('ERROR$$ :',error.toString())});
  }
}