import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';

export function Nav() {
  return (
    <div>
      <nav className="nav  flex-column flex-sm-row navegation">
        <a
          className="flex-sm-fill text-sm-center nav-link active TextNav"
          href="/"
        >
          Inicio
        </a>
        <a
          className="flex-sm-fill text-sm-center nav-link active TextNav"
          href="/information"
        >
          ¿Quienes somos?
        </a>
        <a
          className="flex-sm-fill text-sm-center nav-link active TextNav"
          href="/products"
        >
          Productos
        </a>
        <a
          className="flex-sm-fill text-sm-center nav-link active TextNav"
          href="/ubication"
        >
          Sedes
        </a>
      </nav>
    </div>
  );
}

export default Nav;
