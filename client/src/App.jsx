
import 'bootstrap/dist/css/bootstrap.min.css';
import 'bootstrap-icons/font/bootstrap-icons.css';
import './App.css';

import { React, useState, useEffect } from 'react';
import { Container } from 'react-bootstrap';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';

import { GenericLayout, NotFoundLayout, LoginLayout } from './components/Layout';
import API from './API.js';

function App() {
  return (
    <BrowserRouter>
      <AppWithRouter />
    </BrowserRouter>
  );
}

function AppWithRouter(props) {  

  // This states keeps track if the user is currently logged-in.
  const [loggedIn, setLoggedIn] = useState(false);
  const [user, setUser] = useState(null);

  //todo: understand if useful
  const [dirty, setDirty] = useState(true);

  // If an error occurs, the error message will be shown in a toast.
  const handleErrors = (err) => {
    //console.log('DEBUG: err: '+JSON.stringify(err));
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

  useEffect(()=> {
    const checkAuth = async() => {
      try {
        // here you have the user info, if already logged in
        const user = await API.getUserInfo();
        setLoggedIn(true);
        setUser(user);
      } catch(err) {
        // NO need to do anything: user is simply not yet authenticated
        //handleError(err);
      }
    };
    checkAuth();
  }, []);  // The useEffect callback is called only the first time the component is mounted.


  // Authentication functions
  const handleLogin = async (credentials) => {
    try {
      const user = await API.logIn(credentials);
      setUser(user);
      setLoggedIn(true);
    } catch (err) {
      // error is handled and visualized in the login form, do not manage error, throw it
      throw err;
    }
  };

  const handleRegister = async (credentials) => {
    try {
      await API.createUser(credentials);
      const user = await API.logIn(credentials);
      setUser(user);
      setLoggedIn(true);
    } catch (err) {
      throw err;
    }
  };

  const handleLogout = async () => {
    await API.logOut();
    setLoggedIn(false);
    setUser(null);
  };


  return (
    <Container fluid>
        <Routes>
          <Route
            path="/"
            element={loggedIn ? (
              <GenericLayout loggedIn={loggedIn} user={user} logout={handleLogout} />
            ) : (
              <Navigate replace to="/login" />
            )}
          />
          <Route
            path="/login"
            element={
              // login and registration in the same page and managed in Layout.jsx
              !loggedIn ? (
                <LoginLayout login={handleLogin} register={handleRegister} />
              ) : (
                <Navigate replace to="/" />
              )
            }
          />
          <Route path="*" element={<NotFoundLayout />} />
        </Routes>
    </Container>
  );
}

export default App;
