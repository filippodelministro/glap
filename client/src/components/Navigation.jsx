import 'bootstrap-icons/font/bootstrap-icons.css';

import { Navbar, Nav, Form, Container } from 'react-bootstrap';
import { NavLink, useParams } from 'react-router-dom';
import { Link } from 'react-router-dom';

import { LoginButton, LogoutButton } from './Auth';

const teams = [
    { id: 1, logo: "/logo/teams/9/Arancini.png", link: "/team/Arancini" },
    { id: 2, logo: "/logo/teams/9/Blancatorres.png", link: "/team/Blancatorres" },
    { id: 3, logo: "/logo/teams/9/Legna.png", link: "/team/Legna" },
    { id: 4, logo: "/logo/teams/9/Saetta Mc Team.png", link: "/team/Saetta Mc Team" },
    { id: 5, logo: "/logo/teams/9/Sailpost.png", link: "/team/Sailpost" },
    { id: 6, logo: "/logo/teams/9/Sconosciuti.png", link: "/team/Sconosciuti" },
    { id: 7, logo: "/logo/teams/9/Sporting Mistona.png", link: "/team/Sporting Mistona" },
    { id: 8, logo: "/logo/teams/9/Svincolati.png", link: "/team/Svincolati" },
    { id: 9, logo: "/logo/teams/9/Tattari.png", link: "/team/Tattari" },
    { id: 10, logo: "/logo/teams/9/Terroni.png", link: "/team/Terroni" }
];

// todo: use a scalable approach => get name of teams from Db (use League ID as max leagueID) 
const Navigation = () => {
    // const { team_name } = useParams();

    return (
        <div style={{ backgroundColor: "#fafafa" }}>

            {/* ------------- 1° MENU ORIZZONTALE: LOGHI SQUADRE ------------- */}
            <Navbar bg="fafafa" variant="dark" className="py-1">
                <Container className="justify-content-center gap-3">
                    {teams.map(t => (
                        <Link key={t.id} to={t.link}>
                            <img 
                                src={t.logo}
                                alt="team logo"
                                height="32"
                                style={{ cursor: "pointer" }}
                            />
                        </Link>
                    ))}
                </Container>
            </Navbar>

            {/* ---------------------- LOGO CENTRALE ------------------------ */}
            <Container className="d-flex justify-content-center py-3">
                <Nav.Link as={Link} to="/">
                    <img src="/logo/glap/logo_black.png" alt="GLAP logo" height="150" style={{ cursor: 'pointer' }}/>
                </Nav.Link>
            </Container>

            {/* ------------- 2° MENU ORIZZONTALE: STATS TORNEO ------------- */}
            <Navbar bg="black" variant="dark">
                <Nav className="mx-auto gap-4 fs-5">
                    <Nav.Link as={Link} to="/">Calendario e Risultati</Nav.Link>
                    <Nav.Link as={Link} to="/standings">Classifica</Nav.Link>
                    <Nav.Link as={Link} to="/awards">Award</Nav.Link>
                    <Nav.Link as={Link} to="/history">Albo d'oro</Nav.Link>
                </Nav>
            </Navbar>

        </div>
    );
}


const NavigationTeam = () => {
    const { team_name } = useParams();
    
    return (
        <div style={{ backgroundColor: "#fafafa" }}>

            {/* ------------- 1° MENU ORIZZONTALE: LOGHI SQUADRE ------------- */}
            <Navbar bg="fafafa" variant="dark" className="py-1">
                <Container className="justify-content-center gap-3">
                    {teams.map(t => (
                        <Link key={t.id} to={t.link}>
                            <img 
                                src={t.logo}
                                alt="team logo"
                                height="32"
                                style={{ cursor: "pointer" }}
                            />
                        </Link>
                    ))}
                </Container>
            </Navbar>

            {/* ---------------------- LOGO CENTRALE ------------------------ */}
            <Container className="d-flex justify-content-center py-3">
                {/* <Nav.Link as={Link} to="/"> */}
                    <img src={`/logo/teams/9/${team_name}.png`} height="150" style={{ cursor: 'pointer' }}/>
                {/* </Nav.Link> */}
            </Container>

            {/* ------------- 2° MENU ORIZZONTALE: STATS TORNEO ------------- */}
            <Navbar bg="black" variant="dark">
                <Nav className="mx-auto gap-4 fs-5">
                    <Nav.Link as={Link} to="/">Calendario e Risultati</Nav.Link>
                    <Nav.Link as={Link} to="/standings">Classifica</Nav.Link>
                    <Nav.Link as={Link} to="/awards">Squadra</Nav.Link>
                    {/* <Nav.Link as={Link} to="/history">Albo d'oro</Nav.Link> */}
                </Nav>
            </Navbar>

        </div>
    );
}

export { Navigation, NavigationTeam };
