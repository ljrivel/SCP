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
import Select from 'react-select';
import '../../Style.css';

// eslint-disable-next-line react/prefer-stateless-function
export class GCCP extends Component {
  constructor(props) {
    super(props);

    this.state = {
      data: [],
      meses: [],
      idMes: 4,
    };
  }

  Generar = async () => {
    await axios
      .post('http://localhost:3001/CIR', { id_mes: this.state.idMes })
      .then((response) => {
        this.setState({ data: response.data });
      });
  };

  componentDidMount() {
    axios.get('http://localhost:3001/Meses').then((response) => {
      const options = response.data.map((option) => ({
        value: option.id_mes_planilla,
        label: option.rango,
      }));
      this.setState({ meses: options });
    });
  }

  handleSelectionChange = (event) => {
    const idMes = Array.from(
      event.target.selectedOptions,
      (option) => option.value
    );
    this.setState({ idMes });
  };

  prueba = () => {
    console.log(this.state.meses);
  };

  render() {
    return (
      <div>
        <h1 className="centerT">GISR</h1>
        <Select options={this.state.meses} />
        <button type="button" onClick={() => this.Generar()}>
          Datos
        </button>
        <button type="button" onClick={() => this.prueba()}>
          Prueba
        </button>
      </div>
    );
  }
}

export default GCCP;
