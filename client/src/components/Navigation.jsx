import 'bootstrap-icons/font/bootstrap-icons.css';

import { Navbar, Nav, Form } from 'react-bootstrap';

import { LoginButton, LogoutButton } from './Auth';

const Navigation = (props) => {

    return (
        <Navbar bg="primary" expand="md" variant="dark" className="navbar-padding">
            {/* left side */}
            <Navbar.Brand href='/' className="mx-2">
                <img
                    src="/logo_black.png"
                    alt="logo"
                    height="100"
                    className="me-2"
                />
            </Navbar.Brand>

            {/* central side */}
            <Nav className="mx-auto gap-4">
                <Nav.Link href="#" className="text-white">Torneo</Nav.Link>
                <Nav.Link href="#" className="text-white">Chi siamo</Nav.Link>
                <Nav.Link href="#" className="text-white">Dove siamo</Nav.Link>
            </Nav>

            {/* right side */}
            <Nav className="d-flex align-items-center">
                <Navbar.Text className="mx-2 fs-5">
                    {props.user && `${props.user.name}`}
                </Navbar.Text>
                <Nav.Link href="#" className="text-white fs-4 mx-2">
                    <i className="bi bi-person-circle" />
                </Nav.Link>
                <Nav.Link onClick={props.logout} className="text-white fs-4 mx-2" style={{ cursor: "pointer" }}>
                    <i className="bi bi-box-arrow-right" />
                </Nav.Link>

            </Nav>
        </Navbar>
    );
}

export { Navigation };
