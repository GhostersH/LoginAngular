import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from './servicios/api/api.service';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'AngularP3-Front';

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

}
