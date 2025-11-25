import 'bootstrap-icons/font/bootstrap-icons.css';
import { Navbar, Nav } from 'react-bootstrap';

const Footer = () => {
  return (
    <Navbar bg="dark" variant="dark" className="py-3 mt-4 justify-content-center">
      <Nav className="text-center gap-4">
        <Nav.Link href="#" className="text-white">Archivio</Nav.Link>
        <Nav.Link href="#" className="text-white">Mission</Nav.Link>
        <Nav.Link href="#" className="text-white">Storie</Nav.Link>
        <Nav.Link href="#" className="text-white">Sponsor</Nav.Link>
        <Nav.Link href="#" className="text-white">Privacy Policies</Nav.Link>
      </Nav>
      <Nav>
        <Navbar.Text className="text-center gap-4">
          Copyrght © 2025 GLAP - Powered by Baru.
        </Navbar.Text>
      </Nav>
    </Navbar>
  );
};

export { Footer };