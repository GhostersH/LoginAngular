import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from '../servicios/api/api.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {

  constructor(private api:ApiService, private router:Router){}

  ngOnInit(): void {
    this.checkLocalStorage()
  }

  checkLocalStorage(){
    if(localStorage.getItem('token')){
      this.router.navigate(['home'])
    }else{
      this.router.navigate(['login'])
    }
  }

  
  logout(){
      localStorage.clear();
      window.location.reload();
  }
  

}
