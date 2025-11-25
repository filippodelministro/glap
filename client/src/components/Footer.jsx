import 'bootstrap-icons/font/bootstrap-icons.css';
import { Navbar, Nav } from 'react-bootstrap';

const Footer = () => {
  return (
    <Navbar bg="dark" variant="dark" className="py-4 mt-auto flex-column">
      {/* Primo livello: contatti con icone */}
      <Nav className="justify-content-center gap-4 mb-3">
        <Nav.Link href="mailto:info@glaptorneo.it" className="text-white">
          <i className="bi bi-envelope-fill me-1"></i> Email
        </Nav.Link>
        <Nav.Link href="#" className="text-white">
          <i className="bi bi-whatsapp me-1"></i> Whatsapp
        </Nav.Link>
        <Nav.Link href="https://www.instagram.com/glap_the_torneo/?hl=it" target="_blank" rel="noopener noreferrer" className="text-white">
          <i className="bi bi-instagram me-1"></i> Instagram
        </Nav.Link>
        <Nav.Link href="https://it.linkedin.com/company/glap?trk=public_profile_topcard_current_company" target="_blank" rel="noopener noreferrer" className="text-white">
          <i className="bi bi-linkedin me-1"></i> Linkedin
        </Nav.Link>
      </Nav>

      {/* Secondo livello: navigazione interna */}
      <Nav className="justify-content-center gap-4 mb-3">
        <Nav.Link href="#" className="text-white">Archivio</Nav.Link>
        <Nav.Link href="#" className="text-white">Mission</Nav.Link>
        <Nav.Link href="#" className="text-white">Storie</Nav.Link>
        <Nav.Link href="#" className="text-white">Sponsor</Nav.Link>
        <Nav.Link href="#" className="text-white">Privacy Policies</Nav.Link>
      </Nav>

      {/* Terzo livello: copyright */}
      <Nav className="justify-content-center">
        <Navbar.Text className="text-white text-center">
          Copyright © 2025 GLAP - Powered by Baru.
        </Navbar.Text>
      </Nav>
    </Navbar>
  );
};

export { Footer };