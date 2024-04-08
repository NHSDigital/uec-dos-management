import React from 'react';
import { Routes, Route } from 'react-router-dom';
import Header from './components/header';
// import AddOrganisationPage from './pages/organisations/add';
// import OrganisationsPage from './pages/organisations';
// import TestPage from './pages/test';
// import SearchOrganisationPage from './pages/organisations/search';
// import ViewOrganisationPage from './pages/organisations/view';
import Footer from './components/footer';
import buildConfig from './buildconfig.json';
// import './styles/global.css';

function App() {
  const { buildDate, commitHash } = buildConfig;

  return (
    <>
        <Header />
        <div role="main">
          {/* <Routes>
              <Route path="/organisations/search" element={<SearchOrganisationPage />} />
              <Route path="/organisations/add" element={<AddOrganisationPage />} />
              <Route path="/organisations/view/:id" element={<ViewOrganisationPage />} />
              <Route path="/test" element={<TestPage />} />
              <Route path="*" element={<OrganisationsPage />} />
          </Routes> */}
        </div>
        <div className='app-footer'>
            <Footer buildDate={buildDate} commitHash={commitHash.substring(0,7)} />
        </div>
    </>
  );
}

export default App;

