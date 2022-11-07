import { HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormGroup, ReactiveFormsModule, FormBuilder, FormControl, Validators } from '@angular/forms';
import { UsuarioService } from 'src/app/core/services/usuario.service';
import contries from "../../../../assets/contries.json";

@Component({
  selector: 'app-usuarios',
  templateUrl: './usuarios.component.html',
  styleUrls: ['./usuarios.component.scss']
})
export class UsuariosComponent implements OnInit {

  constructor(
    private form: FormBuilder,
    private service: UsuarioService) { 
      this.contries = contries;
    }

  contries!: any;
  usuarioForm!: FormGroup;

  ngOnInit(): void {
    this.usuarioForm = new FormGroup({
      nombre: new FormControl('',[Validators.required, Validators.pattern('^[a-zA-Z ]*$')]),
      email: new FormControl('',[Validators.required, Validators.email]),
      apellido: new FormControl('',[Validators.required, Validators.pattern('^[a-zA-Z ]*$')]),
      telefono: new FormControl('',[Validators.pattern("^[0-9]*$")]),
      fechaNacimiento: new FormControl(new Date(),[Validators.required]),
      paisResidente: new FormControl('',[Validators.required]),
      notificacion: new FormControl(false,[Validators.required])
    });
  }


  submit(){

  }

  AddUsuario(){
    this.service.post(this.usuarioForm.getRawValue()).subscribe({
      next: (data)=>{
        console.log(data);
      },
      error: (error: HttpErrorResponse)=>{

      }
    })
  }
}
