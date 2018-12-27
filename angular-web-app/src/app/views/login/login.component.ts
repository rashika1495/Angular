import { Component, OnInit } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
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


constructor(private http:HttpClient, private router: Router,private toastr: ToastrService) { }

ngOnInit() { } 

async loginbuttonClick() {
  const requestData:any={
    email:this.username,
    password:this.password
  }

 await this.http.post<LoginData>('https://localhost:44358/api/Login/Login',requestData ).subscribe(res => {
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
Register(){
  this.router.navigateByUrl('/register');
}
}
export interface LoginData {
code: string;
message: string;
data:any
}
