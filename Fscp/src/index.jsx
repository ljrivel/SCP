/* eslint-disable comma-dangle */
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './pages/Home/Home';
import 'bootstrap/dist/css/bootstrap.min.css';
import './Style.css';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
