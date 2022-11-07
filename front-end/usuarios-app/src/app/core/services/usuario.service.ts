import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpRequest } from "@angular/common/http";
import { environment } from 'src/environments/environment';
@Injectable({
  providedIn: 'root'
})
export class UsuarioService {

  constructor(private http: HttpClient) { }

  url: string = environment.apiUrl+"Usuario";

  httpHeaders = new HttpHeaders({
    'Content-Type': 'application/json',
    'Accept': 'application/json'
    });
  
  getUsuarios(filtro:string){
    return this.http.get(this.url+"?"+filtro);
  }

  getActividades(){
    return this.http.get(this.url+"/actividad");
  }

  update(usuario:any){
    return this.http.put(this.url,usuario);
  }

  post(usuario:any){
    return this.http.post(this.url,usuario);
  }

  delete(idUsuario:number){
    return this.http.delete(this.url+"?idUsuario="+idUsuario);
  }
}
