import 'bootstrap-icons/font/bootstrap-icons.css';
import { Navbar, Nav } from 'react-bootstrap';

const sponsors = [
  { id: 1, href: 'https://www.instagram.com/nundiniconsulting/', src: 'logo/sponsor/ANundini.png'},
  { id: 2, href: 'https://www.instagram.com/mama__caffe/', src: 'logo/sponsor/BarAlino.png'},
  { id: 3, href: 'https://www.lafenicedargento.it/', src: 'logo/sponsor/LaFenice.png'},
  { id: 4, href: 'https://www.studiomedicopisa.it/', src: 'logo/sponsor/MedicinaAMisuraDUomo.png'},
  { id: 5, href: 'https://www.barmelabevo.it/', src: 'logo/sponsor/Melabevo.png'},
  { id: 6, href: 'https://www.facebook.com/AutofficinaCei/?locale=it_IT', src: 'logo/sponsor/OfficinaCei.png'},
  { id: 7, href: 'https://www.instagram.com/_lemolina_/?hl=am-et', src: 'logo/sponsor/PizzeriaMolina.png'},
  { id: 8, href: 'https://www.facebook.com/people/Tuttolegno-Di-Giussani-Moreno/100062343279367/', src: 'logo/sponsor/TuttoLegno.png'},

];

const Footer = () => {
  return (
    <footer className="bg-dark text-white mt-auto pt-4 pb-0">

      {/* LINEA 1: Sponsor */}

      <div className="d-flex justify-content-center flex-wrap gap-4 mb-4 px-3">
        {sponsors.map(s => (
          <a key={s.id} href={s.href} target="_blank" rel="noopener noreferrer">
            <img src={s.src} height={40} />
          </a>
        ))}
      </div>
      <div className="footer-separator"></div>

       {/* LINEA 2: Internal link and social*/}
          <div className="d-flex justify-content-between align-items-start mb-4 mt-3 px-5 w-100">
            <div className="text-start">
              <h6 className="text-white fw-bold mb-2">IL TORNEO</h6>
              <Nav className="flex-column">
                <Nav.Link href="/history" className="footer-link py-0 fs-7 ps-0">Storia</Nav.Link>
                <Nav.Link href="/contacts" className="footer-link py-0 fs-7 ps-0">Sedi e contatti</Nav.Link>
                <Nav.Link href="/mission" className="footer-link py-0 fs-7 ps-0">Mission</Nav.Link>
                <Nav.Link href="/archive" className="footer-link py-0 fs-7 ps-0">Archivio</Nav.Link>
              </Nav>
        </div>

        <Nav className="d-flex flex-row gap-3 align-self-end">
          <Nav.Link href="#" className="text-white p-0"><i className="bi bi-whatsapp fs-5"></i></Nav.Link>
          <Nav.Link href="mailto:info@glaptorneo.it" className="text-white p-0"><i className="bi bi-envelope-fill fs-5"></i></Nav.Link>
          <Nav.Link href="https://www.instagram.com/glap_the_torneo/?hl=it" target="_blank" rel="noopener noreferrer" className="text-white p-0"><i className="bi bi-instagram fs-5"></i></Nav.Link>
          <Nav.Link href="https://it.linkedin.com/company/glap" target="_blank" rel="noopener noreferrer" className="text-white p-0"><i className="bi bi-linkedin fs-5"></i></Nav.Link>
        </Nav>
      </div>

      {/* LINEA 3: */}
        <div className="bg-light text-dark d-flex align-items-center px-4 py-2 mt-4 footer-bar">
          {/* Logo a sinistra (placeholder) */}
          <div className="d-flex align-items-center me-3">
            <img src="/logo/glap/logo_black.png" alt="Logo Footer" height={30} />
          </div>

          {/* Testo giustificato a sinistra (occuppa spazio centrale) */}
          <div className="flex-grow-1 ms-3">
            <p className="mb-0 text-start">Copyright © 2025 GLAP - Powered by Baru.</p>
          </div>

          {/* Link policy a destra */}
          <div>
            <a href="/policy" className="text-dark text-decoration-none fw-semibold">Privacy Policy</a>
          </div>
        </div>

    </footer>
  );
};

export { Footer };