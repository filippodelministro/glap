
import { Row, Col, Button, Alert, Toast } from 'react-bootstrap';
import { Outlet, Link, useParams, Navigate, useLocation } from 'react-router-dom';

import { Navigation } from './Navigation';
import { useEffect } from 'react';
import { LoginForm } from './Auth';


function NotFoundLayout(props) {
    return (
      <>
        <h2>This route is not valid!</h2>
        <Link to="/">
          <Button variant="primary">Go back to the main page!</Button>
        </Link>
      </>
    );
  }

function LoginLayout(props) {
  return (
    <Row>
      <Col>
        {/* both props are passed to the LoginForm to handle btoh cases */}
        <LoginForm login={props.login} register={props.register} />
      </Col>
    </Row>
  );
}

function RegisterLayout(props) {
  return (
    <Row>
      <Col>
        <RegisterForm register={props.register} />
      </Col>
    </Row>
  );
}

function GenericLayout(props) {

  return (
    <>
      <Row>
        <Col>
          <Navigation loggedIn={props.loggedIn} user={props.user} logout={props.logout} />
        </Col>
      </Row>

      <Row><Col>
        {props.message? <Alert className='my-1' onClose={() => props.setMessage('')} variant='danger' dismissible>
          {props.message}</Alert> : null}
      </Col></Row>

    </>
  );
}
  
export { GenericLayout, NotFoundLayout, LoginLayout, RegisterLayout };
