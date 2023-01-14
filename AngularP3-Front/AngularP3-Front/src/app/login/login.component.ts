import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { ApiService } from '../servicios/api/api.service';

import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  loginForm = new FormGroup({
    mail : new FormControl('',Validators.required),
    password : new FormControl('',Validators.required)
  })

  constructor(private api:ApiService, private router:Router){}

  errorStatus:boolean = false;
  errorMsj:any = '';

  ngOnInit(): void {
      this.checkLocalStorage()
  }

  checkLocalStorage(){
    if(localStorage.getItem('token')){
      this.router.navigate([''])
    }else{
      this.router.navigate(['login'])
    }
  }

  onLogin(form: any){
    this.api.loginByEmail(form).subscribe(data =>{
      let response: any = data;
      if(response.result == 1){
        localStorage.setItem('token',response.data);
        this.router.navigate(['']);
      }else{
        this.errorStatus = true;
        this.errorMsj = response.message;
      }

    })
  }
  
}
