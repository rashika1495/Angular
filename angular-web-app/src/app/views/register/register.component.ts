import { Component } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import {Router} from '@angular/router';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-dashboard',
  templateUrl: 'register.component.html'
})
export class RegisterComponent {
  firstName:string="";
  lastName:string="";
  email:string="";
  contactNumber:string="";
  password:string="";
  confirmPassword:string="";
  errorMessage:string="";
  userData:User;

  constructor(private http:HttpClient, private router :Router,private toastr: ToastrService) { }

  async RegisterButtonClick(){
    debugger;
    const requestData:any={
      firstName:this.firstName,
      lastName:this.lastName,
      email:this.email,
      phoneNumber:this.contactNumber,
      password:this.password
    }
  
    await this.http.post<User>('https://localhost:44358/api/User/Add',requestData).subscribe(res=>{
      this.userData=res;
      if(this.userData.message=="Success"){
        this.toastr.success('Your account has been created successfully. You will now be redirected to login page.');
        this.LoginRoute();
        
      }
      else{
        this.toastr.error(this.userData.message);
      }
    });
  }
  LoginRoute(){
    this.router.navigateByUrl('/login');
  }

}
export interface User{
  code: string;
message: string;
data:any
}