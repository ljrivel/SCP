/* eslint-disable no-plusplus */
/* eslint-disable prefer-const */
/* eslint-disable no-console */
/* eslint-disable react/sort-comp */
/* eslint-disable react/destructuring-assignment */
/* eslint-disable react/no-unused-state */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable react/no-unused-class-component-methods */
/* eslint-disable class-methods-use-this */
import React, { Component } from 'react';
import '../../Style.css';
import Swal from 'sweetalert2';
import Select from 'react-select';
import axios from 'axios';

export class Start extends Component {
  constructor(props) {
    super(props);

    this.state = {
      meses: [],
      idMes: 0,
    };
    this.handleSelectionChange = this.handleSelectionChange.bind(this);
  }

  handleSelectionChange(selectedOption) {
    this.setState({ idMes: selectedOption.id_mes_planilla });
  }

  Go_GISR() {
    window.location.href = `/GISR/${this.state.idMes}`;
  }

  Go_GCCP() {
    window.location.href = `/GCCP/${this.state.idMes}`;
  }

  Go_GCCS() {
    window.location.href = `/GCCS/${this.state.idMes}`;
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

  async componentDidMount() {
    await axios.get('http://localhost:3001/Meses').then((response) => {
      this.setState({ meses: response.data });
    });
  }

  render() {
    const { selectedOption } = this.state;
    return (
      <section>
        {/* Card */}
        <div className="container Centro">
          <div className=" Fixrow g-0">
            {/* Nombre del sistema */}
            <h1 className="font-weight-bold text-center sizeText">SCP</h1>
            <Select
              value={selectedOption}
              options={this.state.meses}
              onChange={this.handleSelectionChange}
              getOptionValue={(option) => option.id_mes_planilla}
              getOptionLabel={(option) => option.rango}
            />

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
