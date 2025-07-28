import { useState } from 'react';
import { Form, Button, Alert, Col, Container, Card } from 'react-bootstrap';
import { FaUser, FaLock} from 'react-icons/fa';
import { FiLogOut } from "react-icons/fi";

function LoginForm(props) {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState(''); // For registration
  const [errorMessage, setErrorMessage] = useState('');
  const [showRegister, setShowRegister] = useState(false); // Stato per gestire la visualizzazione del form di registrazione o login


  const handleLoginSubmit = (event) => {
    event.preventDefault();
    const credentials = { username, password };

    if (!username) {
      setErrorMessage('Username cannot be empty');
    } else if (!password) {
      setErrorMessage('Password cannot be empty');
    } else {
      props.login(credentials)
        .then(() => props.onLoginSuccess())
        .catch((err) => {
          setErrorMessage(err.error);
        });
    }
  };

  const handleRegisterSubmit = (event) => {
    event.preventDefault();
    const credentials = { username, password };

    //todo: change this value for proper validation
    // const usernameRegex = /^(?=.*[A-Za-z])[A-Za-z0-9]{3,}$/;
    // const passwordRegex = /^.{8,}$/;
    const usernameRegex = /^.{1,}$/;
    const passwordRegex = /^.{1,}$/;
  
    if (!username) {
      setErrorMessage('Username cannot be empty!');
    } else if (!usernameRegex.test(username)) {
      setErrorMessage('Username must be at least 3 characters long and contain at least one letter');
    }   
    else if (!password) {
      setErrorMessage('Password cannot be empty');
    } else if (!passwordRegex.test(password)) {
      setErrorMessage('Password must be at least 8 characters long');
    } else if (password !== confirmPassword) {
      setErrorMessage('Passwords do not match');
    } else {
      props.register(credentials)
        .catch((err) => {
          setErrorMessage(err.error);
        });
    }
  };

  return (
    <Container className="loginContainer d-flex align-items-center justify-content-center vh-100">
      <Col xs={12} md={6} lg={4}>
      
      {/* -------- login form -------- */}
        {!showRegister ? (
          <Card className="shadow-lg p-4 rounded">
            <h2 className="loginTitle text-center">Login</h2>
            <Form onSubmit={handleLoginSubmit}>
              {errorMessage && (
                <Alert dismissible onClose={() => setErrorMessage('')} variant="danger">
                  {errorMessage}
                </Alert>
              )}
              <Form.Group className="loginForm mb-3">
                <Form.Label>
                  <FaUser className="me-2" />
                  Username
                </Form.Label>
                <Form.Control
                  type="text"
                  value={username}
                  placeholder="Enter your username"
                  onChange={(ev) => setUsername(ev.target.value)}
                />
              </Form.Group>
              <Form.Group className="loginInsert mb-3">
                <Form.Label>
                  <FaLock className="me-2" />
                  Password
                </Form.Label>
                <Form.Control
                  type="password"
                  value={password}
                  placeholder="Enter your password"
                  onChange={(ev) => setPassword(ev.target.value)}
                />
              </Form.Group>
              <Button className="w-100 mt-3" variant="primary" type="submit">
                Login
              </Button>
            </Form>
            <div className="text-center mt-3">
              <small className="text-muted">Don't have an account?</small>
              <Button variant="link" onClick={() => setShowRegister(true)}>Create one</Button>
            </div>
          </Card>
        ) :
        // /* -------- registration form -------- 
        (
          <Card className="shadow-lg p-4 rounded">
            <h2 className="text-center mb-4">Register</h2>
            <Form onSubmit={handleRegisterSubmit}>
              {errorMessage && (
                <Alert dismissible onClose={() => setErrorMessage('')} variant="danger">
                  {errorMessage}
                </Alert>
              )}
              <Form.Group className="mb-3">
                <Form.Label>
                  <FaUser className="me-2" />
                  Username
                </Form.Label>
                <Form.Control
                  type="string"
                  value={username}
                  placeholder="Enter your username"
                  onChange={(ev) => setUsername(ev.target.value)}
                />
              </Form.Group>
              <Form.Group className="mb-3">
                <Form.Label>
                  <FaLock className="me-2" />
                  Password
                </Form.Label>
                <Form.Control
                  type="password"
                  value={password}
                  placeholder="Enter your password"
                  onChange={(ev) => setPassword(ev.target.value)}
                />
              </Form.Group>
              <Form.Group className="mb-3">
                <Form.Label>
                  <FaLock className="me-2" />
                  Confirm Password
                </Form.Label>
                <Form.Control
                  type="password"
                  value={confirmPassword}
                  placeholder="Confirm your password"
                  onChange={(ev) => setConfirmPassword(ev.target.value)}
                />
              </Form.Group>
              <Button className="w-100 mt-3" variant="success" type="submit">
                Register
              </Button>
            </Form>
            <div className="text-center mt-3">
              <small className="text-muted">Already have an account?</small>
              <Button variant="link" onClick={() => setShowRegister(false)}>Login</Button>
            </div>
          </Card>
        )}
      </Col>
    </Container>
  );
}

function LogoutButton(props) {
  return (
    <Button className='iconButton' onClick={props.logout}>
      <FiLogOut />
    </Button>
  );
}

export {LoginForm, LogoutButton};