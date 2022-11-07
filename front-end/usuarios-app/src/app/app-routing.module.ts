import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ActividadComponent } from './features/components/actividad/actividad.component';
import { UsuariosComponent } from './features/components/usuarios/usuarios.component';

const routes: Routes = [
  {
    path: '',
    component: ActividadComponent,
  },
  {
    path: 'usuario',
    component: UsuariosComponent
  },
  {
    path: 'actividad',
    component: ActividadComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
