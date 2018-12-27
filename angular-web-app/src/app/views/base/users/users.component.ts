import { Component, OnInit , ViewChild} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import { DataTableModule, DataTable } from 'angular-6-datatable';
import { ModalDirective } from 'ngx-bootstrap/modal';


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
  constructor(private http:HttpClient) { }

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
  debugger;  
  this.userData=res.data;
    console.log(this.userData);
  });
}

public onPageChange(event) {
  this.rowsOnPage = event.rowsOnPage;
  this.activePage = event.activePage;
  this.loadUsersList();
}




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
