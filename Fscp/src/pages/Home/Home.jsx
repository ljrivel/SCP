import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

// import  for pages
import { Start } from '../StartPage/Start';
import { GISR } from '../Others/GISR';

function Home() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Start />} />
        <Route path="/GISR" element={<GISR />} />
      </Routes>
    </BrowserRouter>
  );
}

export default Home;
