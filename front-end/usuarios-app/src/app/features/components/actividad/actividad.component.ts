import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import {MatPaginator} from '@angular/material/paginator';
import { UsuarioService } from 'src/app/core/services/usuario.service';

@Component({
  selector: 'app-actividad',
  templateUrl: './actividad.component.html',
  styleUrls: ['./actividad.component.scss']
})
export class ActividadComponent implements OnInit {

  displayedColumns: any = ["id","actividad","nombreCompleto", "fecha"];
  dataSource: any = [];
  constructor(private usuarioService: UsuarioService) { }

  ngOnInit(): void {
    this.getActividades();
  }

  getActividades(){
    this.usuarioService.getActividades().subscribe({
      next:(data)=>{
        this.dataSource = data;
      },
      error: (error: HttpErrorResponse)=>{

      }
    });
  }
}
