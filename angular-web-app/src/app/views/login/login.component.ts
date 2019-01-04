import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpParams, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import {Router} from '@angular/router';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-dashboard',
  templateUrl: 'login.component.html'
})
export class LoginComponent implements OnInit {
  buttonTitle:string="Submit";
  username:string="";
  password:string="";
  rememberMe:boolean=false;
  login: LoginData;
  errorMessage:string="";
  private heroesUrl = 'https://localhost:44358/api/Login/GoogleLogin';
 


constructor(private http:HttpClient, private router: Router,private toastr: ToastrService) {
 }

ngOnInit() { } 

async loginbuttonClick() {
  const requestData:any={
    email:this.username,
    password:this.password
  }

 await this.http.post<LoginData>('http://net.site4demo.com/webapp/api/Login/Login',requestData ).subscribe(res => {
    this.login = res;
    console.log(this.login);
    if(this.login.message=="Success"){
      this.router.navigateByUrl('/dashboard');
    }
    else{
      this.toastr.error(this.login.message);
    }

  });
  
}
async googleLogin(){
const headers = new HttpHeaders();
headers.append('Access-Control-Allow-Headers', 'Content-Type');
headers.append('Access-Control-Allow-Methods', 'GET');
headers.set('Access-Control-Allow-Origin', '*');
let _options = { headers: headers };
debugger;
  await this.http.get<any>('https://localhost:44358/api/Login/GoogleLogin',_options).subscribe(res => {
    
    this.login = res;
    console.log(this.login);
    if(this.login.message=="Success"){
      this.router.navigateByUrl('/dashboard');
    }
    else{
      this.toastr.error(this.login.message);
    }

  }); 

/* var xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function () {
if (this.readyState == 4 && this.status == 200) {
console.log(xhttp.responseText);
}
};
xhttp.open("GET", "https://localhost:44358/api/Login/GoogleLogin", true);
xhttp.send(); */

}


Register(){
  this.router.navigateByUrl('/register');
}
}
export interface LoginData {
code: string;
message: string;
data:any
}
