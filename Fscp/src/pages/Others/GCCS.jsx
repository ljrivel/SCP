/* eslint-disable react/self-closing-comp */
/* eslint-disable react/jsx-closing-tag-location */
/* eslint-disable react/jsx-one-expression-per-line */
/* eslint-disable react/no-access-state-in-setstate */
/* eslint-disable react/button-has-type */
/* eslint-disable no-plusplus */
/* eslint-disable no-else-return */
/* eslint-disable react/no-array-index-key */
/* eslint-disable react/jsx-tag-spacing */
/* eslint-disable quotes */
/* eslint-disable react/prop-types */
/* eslint-disable no-restricted-globals */
/* eslint-disable react/jsx-props-no-multi-spaces */
/* eslint-disable class-methods-use-this */
/* eslint-disable import/no-extraneous-dependencies */
/* eslint-disable jsx-a11y/label-has-associated-control */
/* eslint-disable no-unused-vars */
/* eslint-disable comma-dangle */
/* eslint-disable function-paren-newline */
/* eslint-disable react/sort-comp */
/* eslint-disable jsx-a11y/control-has-associated-label */
/* eslint-disable react/no-unused-class-component-methods */
/* eslint-disable no-console */
/* eslint-disable react/destructuring-assignment */
/* eslint-disable react/no-unused-state */
import React, { Component } from 'react';
import axios from 'axios';
import '../../Style.css';

// eslint-disable-next-line react/prefer-stateless-function
export class GCCS extends Component {
  constructor(props) {
    super(props);

    this.state = {
      data: [],
      meses: [],
      megaData: [],
      idMes: 1,
      cargando: true,
      pag: 0,
      update: false,
    };
    this.handleSelectionChange = this.handleSelectionChange.bind(this);
  }

  Generar = async () => {
    const nuevosElementos = [];

    await axios
      .post('http://localhost:3001/CCS', {
        id_mes: window.location.pathname.split('/')[2],
      })
      .then((response) => {
        for (let i = 1; i <= 10000; i++) {
          nuevosElementos.push(response.data[i]);
        }
        this.setState({ megaData: response.data });
        console.log(response.data);
      });
    this.setState({ data: nuevosElementos });
    this.setState({ cargando: false });
  };

  componentDidUpdate() {
    if (this.state.update !== false) {
      const nuevosElementos = [];
      const max = 10000 * (this.state.pag + 1);
      let min = 0;
      if (this.state.pag === 0) {
        min = 1;
      } else {
        min = 10000 * this.state.pag;
      }

      for (let i = min; i <= max; i++) {
        nuevosElementos.push(this.state.megaData[i]);
      }

      this.setState({ data: nuevosElementos });
      this.setState({ cargando: false });
      this.setState({ update: false });
    }
  }

  async componentDidMount() {
    this.Generar();
  }

  handleSelectionChange(selectedOption) {
    this.setState({ idMes: selectedOption.value });
  }

  nextPage = () => {
    console.log('next');
    this.setState({ pag: this.state.pag + 1 });
    this.setState({ update: true });
  };

  GoHome() {
    window.location.href = '/';
  }

  beginPage = () => {
    console.log('begin');
    if (this.state.pag !== 0) {
      this.setState({ pag: this.state.pag - 1 });
      this.setState({ update: true });
    }
  };

  render() {
    if (this.state.cargando) {
      return (
        <div className="loading-screen">
          <div className="loader"></div>
          <div className="message">Cargando...</div>
        </div>
      );
    } else {
      return (
        <>
          <div className="contenedor">
            <button className="boton" onClick={() => this.beginPage()}>
              Pag Anterior
            </button>
            <button
              className="boton"
              style={{ margin: '0 auto' }}
              onClick={() => this.GoHome()}
            >
              Inicio
            </button>
            <button className="boton" onClick={() => this.nextPage()}>
              Pag Siguiente
            </button>
          </div>
          <div>
            <h1 className="centerT">GCCS</h1>
            <table className="table">
              <thead>
                <tr>
                  <th>Cedula</th>
                  <th>Monto Cargas Sociales</th>
                </tr>
              </thead>

              <tbody>
                {this.state.data.map((item, index) => (
                  <tr key={index}>
                    <td>{item.cedula}</td>
                    <td> ₡ {item.monto_cargas_sociales}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </>
      );
    }
  }
}

export default GCCS;
