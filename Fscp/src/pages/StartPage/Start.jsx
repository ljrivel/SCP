/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable react/no-unused-class-component-methods */
/* eslint-disable class-methods-use-this */
import React, { Component } from 'react';
import '../../Style.css';
import Swal from 'sweetalert2';

export class Start extends Component {
  Go_GISR() {
    window.location.href = '/GISR';
  }

  Report_Generater() {
    Swal.fire({
      title: 'Reporte CCV Generado',
      text: 'El reporte CCV se ha generado con exito',
      icon: 'success',
      confirmButtonText: 'ok',
    });
  }

  Cargas_Generater() {
    Swal.fire({
      title: 'Reporte de Cargas Generado',
      text: 'El reporte de cargas se ha generado con exito',
      icon: 'success',
      confirmButtonText: 'ok',
    });
  }

  render() {
    return (
      <section>
        {/* Card */}
        <div className="container Centro">
          <div className=" Fixrow g-0">
            {/* Nombre del sistema */}
            <h1 className="font-weight-bold text-center sizeText">SCP</h1>

            {/* Botones del sistema */}
            <div className="fix">
              <div className="col-lg-5">
                <button
                  type="button"
                  className="btn1 mt-3 mb-4"
                  onClick={() => this.Report_Generater()}
                >
                  Generar Reporte
                </button>
                <button
                  type="button"
                  className="btn1 mt-3 mb-4"
                  onClick={() => this.Cargas_Generater()}
                >
                  Generar Cargas
                </button>
                <button
                  type="button"
                  className="btn1 mt-3 mb-4"
                  onClick={() => this.Go_GISR()}
                >
                  Generar Impuestos sobre el salario de la renta
                </button>
              </div>
            </div>
          </div>
        </div>
      </section>
    );
  }
}

export default Start;
