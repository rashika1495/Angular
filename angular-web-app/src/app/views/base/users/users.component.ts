import { Component, OnInit , ViewChild} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { DataTableModule, DataTable } from 'angular-6-datatable';
import { ModalDirective } from 'ngx-bootstrap/modal';
import { ToastrService } from 'ngx-toastr';
import {Router} from '@angular/router';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.scss']
})
export class UsersComponent implements OnInit {
  public primaryModal;
  userData:UserList[];
  rowsOnPage:any=10;
  activePage:any=1;
  searchText:any="";
  firstName:string="";
  lastName:string="";
  email:string="";
  contactNumber:string="";
  password:string="";
  confirmPassword:string="";
  responseData:Response;

  constructor(private http:HttpClient,private toastr: ToastrService, private router :Router) { }

  ngOnInit() {
      
    this.loadUsersList();

  }
async loadUsersList(){
  const requestData:any={
    SearchText:this.searchText,
    PageSize:100,
    PageNumber:1
   // IsActive:null
  }
  await this.http.post<Users>('https://localhost:44358/api/User/Details',requestData).subscribe(res=>{
  
  this.userData=res.data;
    console.log(this.userData);
  });
}
async AddButtonClick(){
  const requestData:any={
    firstName:this.firstName,
    lastName:this.lastName,
    email:this.email,
    phoneNumber:this.contactNumber,
    password:this.password
  }

/*   await this.http.post<Response>('https://localhost:44358/api/User/Add',requestData).subscribe(res=>{
    this.responseData=res;
    if(this.responseData.message=="Success"){
      this.toastr.success('Your account has been created successfully. You will now be redirected to login page.');
      this.Reload();
    }
    else{
      this.toastr.error(this.responseData.message);
    }
  }); */
}
Reload(){
  this.router.navigateByUrl('/base/users');
}

public onPageChange(event) {
  this.rowsOnPage = event.rowsOnPage;
  this.activePage = event.activePage;
  this.loadUsersList();
}
}

interface Response{
code: string;
message: string;
data:any
}
interface Users{
  code: string;
  message: string;
  data:UserList[];
}
interface UserList{
  firstName:string;
  lastName:string;
  email:string;
  phoneNumber:string;
  password:string;
  //IsActive:boolean;
}
