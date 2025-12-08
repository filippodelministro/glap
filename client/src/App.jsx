/*
 * [2023/2024]
 * Web Applications
 */

import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import './App.css';

import dayjs from 'dayjs';

import { React, useState, useEffect } from 'react';
import { Container, Row, Col, Button, Toast } from 'react-bootstrap';
import { BrowserRouter, Routes, Route, Outlet, Link, useParams, Navigate, useNavigate } from 'react-router-dom';

import { HomeLayout, StandingsLayout, NotFoundLayout, LoginLayout, MissionLayout, HistoryLayout, ArchiveLayout, ContactsLayout, PolicyLayout, TeamsLayout } from './components/Layout';
import API from './API.js';

function App() {
  return (
    <BrowserRouter>
      <AppWithRouter />
    </BrowserRouter>
  );
}

function AppWithRouter(props) {  

  const navigate = useNavigate();  // To be able to call useNavigate, the component must already be in BrowserRouter (see App)

  // This state keeps track if the user is currently logged-in.
  const [loggedIn, setLoggedIn] = useState(false);
  // This state contains the user's info.
  const [user, setUser] = useState(null);


  const [message, setMessage] = useState('');
  const [dirty, setDirty] = useState(true);

  const [authToken, setAuthToken] = useState(undefined);

  // If an error occurs, the error message will be shown in a toast.
  const handleErrors = (err) => {
    console.log('DEBUG: err: '+JSON.stringify(err));
    let msg = '';
    if (err.error)
      msg = err.error;
    else if (err.errors) {
      if (err.errors[0].msg)
        msg = err.errors[0].msg + " : " + err.errors[0].path;
    } else if (Array.isArray(err))
      msg = err[0].msg + " : " + err[0].path;
    else if (typeof err === "string") msg = String(err);
    else msg = "Unknown Error";
    setMessage(msg); // WARNING: a more complex application requires a queue of messages. In this example only the last error is shown.
    console.log(err);

    setTimeout( ()=> setDirty(true), 2000);
  }

  const renewToken = () => {
    API.getAuthToken().then((resp) => { setAuthToken(resp.token); } )
    .catch(err => {console.log("DEBUG: renewToken err: ",err)});
  }


  useEffect(()=> {
    const checkAuth = async() => {
      try {
        // here you have the user info, if already logged in
        const user = await API.getUserInfo();
        setLoggedIn(true);
        setUser(user);
        API.getAuthToken().then((resp) => { setAuthToken(resp.token); })
      } catch(err) {
        // NO need to do anything: user is simply not yet authenticated
        //handleError(err);
      }
    };
    checkAuth();

  }, []);  // The useEffect callback is called only the first time the component is mounted.


  /**
   * This function handles the login process.
   * It requires a username and a password inside a "credentials" object.
   */
  const handleLogin = async (credentials) => {
    try {
      const user = await API.logIn(credentials);
      setUser(user);
      setLoggedIn(true);
      renewToken();
    } catch (err) {
      // error is handled and visualized in the login form, do not manage error, throw it
      throw err;
    }
  };

  /**
   * This function handles the logout process.
   */ 
  const handleLogout = async () => {
    await API.logOut();
    setLoggedIn(false);
    // clean up everything
    setUser(null);
    setFilmList([]);
    setAuthToken(undefined);
    setFilmStats({});
  };

return (
  <Container fluid className="p-0 d-flex flex-column min-vh-100">
    <Routes>

      {/* HOME — route che userai per un layout ad hoc */}
      <Route path="/" element={loggedIn ? <HomeLayout /> : <Navigate replace to="/login" />}/>
      <Route path="/standings" element={loggedIn ? <StandingsLayout /> : <Navigate replace to="/login" />}/>

      {/* ROUTE PROTETTA */}
      {/* <Route
        path="teams"
        element={loggedIn ? <TeamsLayout /> : <Navigate replace to="/login" />}
      /> */}
      <Route
        path="team/:team_name"
        element={loggedIn ? <TeamsLayout /> : <Navigate replace to="/login" />}
      />

      {/* ROUTE NON PROTETTE */}
      <Route path="mission" element={<MissionLayout />} />
      {/* <Route path="sponsor" element={<SponsorLayout />} /> */}
      <Route path="policy" element={<PolicyLayout />} />
      <Route path="contacts" element={<ContactsLayout />} />
      <Route path="history" element={<HistoryLayout />} />
      <Route path="archive" element={<ArchiveLayout />} />

      {/* LOGIN */}
      <Route
        path="/login"
        element={!loggedIn ? <LoginLayout login={handleLogin} /> : <Navigate replace to="/" />}
      />

      {/* NOT FOUND */}
      <Route path="*" element={<NotFoundLayout />} />

    </Routes>
  </Container>
);
}

export default App;
