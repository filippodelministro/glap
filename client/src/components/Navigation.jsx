import 'bootstrap-icons/font/bootstrap-icons.css';

import { Navbar, Nav, Form } from 'react-bootstrap';
import { LogoutButton } from './Auth';
import { RiAccountBoxFill } from "react-icons/ri";

import './../App.css';


const Navigation = (props) => {
    return (
        <Navbar >
            {/* <Navbar.Brand>
                Home
            </Navbar.Brand>
             */}
            
            <Nav className="ms-auto d-flex align-items-center">
                {props.user && props.user.username && (
                    <Navbar.Text className="mx-2 fs-5 text-black">
                        <RiAccountBoxFill/>
                        <small>{props.user.username}</small>
                    </Navbar.Text>
                )}
                <Form>
                    {props.loggedIn ? <LogoutButton logout={props.logout} /> : <LoginButton />}
                </Form>
            </Nav>
        </Navbar>
    );
}

export { Navigation };
