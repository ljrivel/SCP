import React from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

// import  for pages
import { Start } from '../StartPage/Start';
import { GISR } from '../Others/GISR';
import { GCCP } from '../Others/GCCP';
import { GCCS } from '../Others/GCCS';

function Home() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Start />} />
        <Route path="/GISR/:id" element={<GISR />} />
        <Route path="/GCCP/:id" element={<GCCP />} />
        <Route path="/GCCS/:id" element={<GCCS />} />
      </Routes>
    </BrowserRouter>
  );
}

export default Home;
