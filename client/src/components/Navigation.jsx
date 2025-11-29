import 'bootstrap-icons/font/bootstrap-icons.css';

import { Navbar, Nav, Form } from 'react-bootstrap';
import { NavLink } from 'react-router-dom';
import { Link } from 'react-router-dom';

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
                <Nav.Link as={Link} to="/filter/matches" className="text-white">Partite</Nav.Link>
                <Nav.Link as={Link} to="/filter/standings" className="text-white">Classifica</Nav.Link>
                <Nav.Link as={Link} to="/filter/stats" className="text-white">Statistiche</Nav.Link>
                <Nav.Link as={Link} to="/filter/players" className="text-white">Giocatori</Nav.Link>

                {/* to remove */}
                <Nav.Link as={Link} to="/teams" className="text-white">Teams</Nav.Link>
            </Nav>

            {/* right side */}
            <Nav className="d-flex align-items-center">
                <Nav.Link href="#" className="text-white fs-4 mx-2">
                    {props.user && `${props.user.name}`}
                </Nav.Link>
                <Nav.Link onClick={props.logout} className="text-white fs-4 mx-2" style={{ cursor: "pointer" }}>
                    <i className="bi bi-box-arrow-right" />
                </Nav.Link>

            </Nav>
        </Navbar>
    );
}

export { Navigation };
