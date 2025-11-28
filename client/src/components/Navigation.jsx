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
                <Nav.Link as={Link} to="/" className="text-white">All</Nav.Link>
                <Nav.Link as={Link} to="/filter/favorite" className="text-white">Favourites</Nav.Link>
                <Nav.Link as={Link} to="/filter/best" className="text-white">Best Rated</Nav.Link>
                <Nav.Link as={Link} to="/filter/lastmonth" className="text-white">Seen last month</Nav.Link>
                <Nav.Link as={Link} to="/filter/unseen" className="text-white">Unseen</Nav.Link>
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
