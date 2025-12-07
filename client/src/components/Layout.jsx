
import { Row, Col, Button, Alert, Toast, Table } from 'react-bootstrap';
import { Outlet, Link, useParams, Navigate, useLocation } from 'react-router-dom';

import { Navigation } from './Navigation';
import { useState, useEffect } from 'react';
import { LoginForm } from './Auth';
import { Footer } from './Footer.jsx';

import API from '../API.js';


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
          <LoginForm login={props.login} />
        </Col>
      </Row>
    );
}

function HomeLayout(props) {
  const [matches, setMatches] = useState([]);
  const [error, setError] = useState(null);
  const [selectedLeague, setSelectedLeague] = useState(null);
  const availableLeagues = [...new Set(matches.map(m => m.league))];

  useEffect(() => {
    API.getMatches()
      .then(data => setMatches(data))
      .catch(err => setError(err.error || 'Errore nel recupero delle partite'));
  }, []);
  if (error) {
    return <Alert variant="danger">{error}</Alert>;
  }

  const groupName = matches[0]?.group;
  const leagueID = matches[0]?.league;

// Mappa LID -> Nome
const leagueNames = {
  1: "16/17",
  2: "17/18",
  3: "18/19",
  4: "19/20 A",
  5: "19/20 B",
  6: "21/22 A",
  7: "21/22 B",
  8: "2025",
  9: "25/26"
};

const filteredMatches = selectedLeague
  ? matches.filter(m => m.league === Number(selectedLeague))
  : matches;

const matchesByRound = filteredMatches.reduce((acc, m) => {
  if (!acc[m.round]) acc[m.round] = [];
  acc[m.round].push(m);
  return acc;
}, {});

const filteredGroupName = filteredMatches[0]?.group;
const filteredLeagueID = filteredMatches[0]?.league;

  return (
    <div className="d-flex flex-column min-vh-100">

      <Navigation 
        loggedIn={props.loggedIn} 
        user={props.user} 
        logout={props.logout}
      />

      <div className="container my-5 flex-grow-1">


        <h1>Partite - Girone {filteredGroupName}; league: {filteredLeagueID}</h1>

        <div className="mb-4">
  <label className="me-2"><strong>Filtra per lega:</strong></label>
  <select
    value={selectedLeague ?? ""}
    onChange={(e) => setSelectedLeague(e.target.value || null)}
  >
    <option value="">Tutte le leghe</option>

    {Object.keys(leagueNames).map(id => (
      <option key={id} value={id}>
        {leagueNames[id]}
      </option>
    ))}
  </select>
</div>

        {Object.keys(matchesByRound)
          .sort((a, b) => a - b)
          .map(round => (
            <div key={round} className="mt-4">

              {/* TITLE */}
              <h4 className="mb-3">Giornata {round}</h4>

              {matchesByRound[round].map(match => (
                <div 
                  key={match.id} 
                  className="p-3 mb-3 border rounded d-flex align-items-center justify-content-between"
                  style={{ width: "100%", backgroundColor: "#fff" }}
                >

                  {/* LEFT: DATE */}
                  <div style={{ width: "20%" }}>
                    <div style={{ fontSize: "0.8rem", fontWeight: 600, color: "#666" }}>
                      Giornata {round}
                    </div>
                    <div style={{ fontSize: "0.85rem", color: "#555" }}>
                      {match.date} – {match.time}
                    </div>
                  </div>

                  {/* CENTRAL: MATCH INFO */}
                  <div className="d-flex align-items-center justify-content-center" style={{ width: "60%" }}>

                    {/* HOME TEAM */}
                    <div className="d-flex justify-content-end align-items-center" style={{ flex: 1 }}>
                      <div style={{ textAlign: "right" }}>
                        <strong>{match.team_home}</strong>
                        {match.penalties === 1 && match.winner === match.team_home_id && (
                          <div style={{ fontSize: "0.7rem", color: "#333" }}>Vittoria DCR</div>
                        )}
                      </div>
                      <img 
                        src={`/logo/teams/${leagueID}/${match.team_home}.png`} 
                        // alt={match.team_home} 
                        style={{ width: "30px", height: "30px", marginLeft: "8px" }}
                        onError={(e) => { e.target.src = '/logo/teams/default.png'; }}
                      />

                    </div>

                    {/* CENTER: SCORE OR VS */}
                    <div style={{ flex: 1, textAlign: "center" }}>
                      {match.winner !== 0 ? (
                        <span 
                          style={{
                            color: "#ffffff",
                            backgroundColor: "#000000",
                            padding: "6px 12px",
                            borderRadius: "2px",
                            fontWeight: 700
                          }}
                        >
                          {match.goals_home ?? "-"} - {match.goals_away ?? "-"}
                        </span>
                      ) : (
                        <span 
                          style={{
                            padding: "6px 12px",
                            fontWeight: 700
                          }}
                        >
                          vs
                        </span>
                      )}
                    </div>

                    {/* AWAY TEAM */}
                    <div className="d-flex justify-content-start align-items-center" style={{ flex: 1 }}>
                      <img 
                        src={`/logo/teams/${leagueID}/${match.team_away}.png`} 
                        // alt={match.team_away} 
                        style={{ width: "30px", height: "30px", marginRight: "8px" }}
                        onError={(e) => { e.target.src = '/logo/teams/default.png'; }}
                      />
                      <div style={{ textAlign: "left" }}>
                        <strong>{match.team_away}</strong>
                        {match.penalties === 1 && match.winner === match.team_away_id && (
                          <div style={{ fontSize: "0.7rem", color: "#333" }}>Vittoria DCR</div>
                        )}
                      </div>
                    </div>

                  </div>

                </div>
              ))}
            </div>
        ))}

      </div>

      <Footer />
    </div>
  );
}


function StandingsLayout(props) {
  const [ranking, setRanking] = useState([]);
  const [error, setError] = useState(null);

  const teamLogos = {
    1: "Arancini.png",
    2: "Blancatorres.png",
    3: "Legna.png",
    4: "Saetta.png",
    5: "Sailpost.jpg",
    6: "Sconosciuti.png",
    7: "SportingMistona.png",
    8: "Svincolati.png",
    9: "Tattari.png",
    10: "Terroni.png"
  };

  useEffect(() => {
    API.getRanking()
      .then(data => setRanking(data))
      .catch(err => setError(err.error || "Errore nel recupero della classifica"));
  }, []);

  if (error) {
    return <Alert variant="danger">{error}</Alert>;
  }

  return (
    <div className="d-flex flex-column min-vh-100">

      <Navigation 
        loggedIn={props.loggedIn} 
        user={props.user} 
        logout={props.logout}
      />

      <div className="container my-5 flex-grow-1">
        <h1>Classifica</h1>

        <div className="table-responsive">
          <table className="table table-striped mt-3 align-middle text-center">
            <thead>
              <tr>
                <th>Pos</th><th>Squadra</th><th>Pt</th><th>G</th><th>V</th><th>N</th><th>P</th><th>GF</th><th>GS</th><th>DR</th>
              </tr>
            </thead>
            <tbody>
              {ranking.map(team => (
                <tr key={team.team}>
                  <td>{team.position}</td>
                  <td className="d-flex align-items-center">
                    <img 
                        src={`/logo/teams/${teamLogos[team.team_id]}`} 
                        alt={team.team} 
                        style={{ width: "30px", height: "30px", marginLeft: "8px" }}
                        onError={(e) => { e.target.src = '/logo/teams/default.png'; }}
                      />
                    <span>{team.team}</span>
                  </td>
                  <td>{team.pt}</td>
                  <td>{team.played}</td>
                  <td>{team.wins}</td>
                  <td>{team.draws}</td>
                  <td>{team.losses}</td>
                  <td>{team.gf}</td>
                  <td>{team.gs}</td>
                  <td>{team.dr}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

      </div>

      <Footer />
    </div>
  );
}

function MissionLayout(props) {
  return (
<>
      <div className="flex-grow-1">
        <Row>
          <Col>
            <Navigation loggedIn={props.loggedIn} user={props.user} logout={props.logout} />
          </Col>
        </Row>
        
        <div className="container my-2 flex-grow-5 d-flex justify-content-center">
          <p className="text-muted">
            Dai ma secondo te, cosa pensavi di trovarci qui? Un Manifesto Politico? 
            La Magna Charta Libertatum? Una Dichiarazione di Indipendenza? <br/> La mission.. 
            ti devi svegliare. <br /> <br />Siamo un torneo di calcetto, niente di speciale, 
            il più bel torneo di calcetto a cui tu abbia mai partecipato o solo assistito. <br />
            Niente di più. <br /> Una roba che non esiste in tutto il mondo. <br /> Niente da aggiungere. <br />
            Un torneo unico, un’esperienza indimenticabile, qualcosa che non hai mai visto prima. <br />
            Tutto qui.
          </p>
      </div>
      </div>
      <Row>
        <Col>
          <Footer className="mt-auto" />
        </Col>
      </Row>
    </>
  );
}

function SponsorLayout(props) {
  // Inserisci qui i link delle immagini sponsor
  const sponsors = [
    "/sponsor_logo/ANundini.png",
    "/sponsor_logo/BarAlino.png",
    "/sponsor_logo/LaFenice.png",
    "/sponsor_logo/MedicinaAMisuraDUomo.png",
    "/sponsor_logo/Melabevo.png",
    "/sponsor_logo/OfficinaCei.png",
    "/sponsor_logo/TuttoLegno.png",
    "/sponsor_logo/Pizzeria Molina.svg",
    "/sponsor_logo/logo_black.png"
  ];

  return (
    <div className="d-flex flex-column min-vh-100">

      <Navigation 
        loggedIn={props.loggedIn} 
        user={props.user} 
        logout={props.logout}
      />

      <div className="container my-5 flex-grow-1">

        <Row className="g-4">
          {sponsors.map((src, index) => (
            <Col key={index} xs={12} sm={6} md={4}>
              <div className=" p-3 d-flex align-items-center justify-content-center">
                <img 
                  src={src} 
                  alt={`Sponsor ${index + 1}`} 
                  className="img-fluid" 
                  style={{ maxHeight: "250px", objectFit: "contain" }}
                />
              </div>
            </Col>
          ))}
        </Row>
      </div>

      <Footer />
    </div>
  );
}

function PolicyLayout(props) {
  return (
    <div className="d-flex flex-column min-vh-100">

      <Navigation 
        loggedIn={props.loggedIn} 
        user={props.user} 
        logout={props.logout}
      />

      <div className="container my-5 flex-grow-1">

        <Row className="g-4">
          <div>
            <h4>Chi siamo</h4>
            <p>L’indirizzo del nostro sito web è: https://glapthetorneo.it</p>

            <h4>Commenti</h4>
            <p>Quando i visitatori lasciano commenti sul sito, raccogliamo i dati mostrati nel modulo dei commenti oltre all’indirizzo IP del visitatore e la stringa dello user agent del browser per facilitare il rilevamento dello spam.</p>
            <p>Una stringa anonimizzata creata a partire dal tuo indirizzo email (altrimenti detta hash) può essere fornita al servizio Gravatar per vedere se lo stai usando. La privacy policy del servizio Gravatar è disponibile qui: https://automattic.com/privacy/. Dopo l’approvazione del tuo commento, la tua immagine del profilo è visibile al pubblico nel contesto del tuo commento.</p>

            <h4>Media</h4>
            <p>Se carichi immagini sul sito web, dovresti evitare di caricare immagini che includono i dati di posizione incorporati (EXIF GPS). I visitatori del sito web possono scaricare ed estrarre qualsiasi dato sulla posizione dalle immagini sul sito web.</p>

            <h4>Cookie</h4>
            <p>Se lasci un commento sul nostro sito, puoi scegliere di salvare il tuo nome, indirizzo email e sito web nei cookie. Sono usati per la tua comodità in modo che tu non debba inserire nuovamente i tuoi dati quando lasci un altro commento. Questi cookie dureranno per un anno.</p>
            <p>Se visiti la pagina di login, verrà impostato un cookie temporaneo per determinare se il tuo browser accetta i cookie. Questo cookie non contiene dati personali e viene eliminato quando chiudi il browser.</p>
            <p>Quando effettui l’accesso, verranno impostati diversi cookie per salvare le tue informazioni di accesso e le tue opzioni di visualizzazione dello schermo. I cookie di accesso durano due giorni mentre i cookie per le opzioni dello schermo durano un anno. Se selezioni “Ricordami”, il tuo accesso persisterà per due settimane. Se esci dal tuo account, i cookie di accesso verranno rimossi.</p>
            <p>Se modifichi o pubblichi un articolo, un cookie aggiuntivo verrà salvato nel tuo browser. Questo cookie non include dati personali, ma indica semplicemente l’ID dell’articolo appena modificato. Scade dopo 1 giorno.</p>
            <p>Inoltre, noi i cookies li mangiamo col milk.</p>

            <h4>Contenuto incorporato da altri siti web</h4>
            <p>Gli articoli su questo sito possono includere contenuti incorporati (ad esempio video, immagini, articoli, ecc.). I contenuti incorporati da altri siti web si comportano esattamente allo stesso modo come se il visitatore avesse visitato l’altro sito web.</p>
            <p>Questi siti web possono raccogliere dati su di te, usare cookie, integrare ulteriori tracciamenti di terze parti e monitorare l’interazione con essi, incluso il tracciamento della tua interazione con il contenuto incorporato se hai un account e sei connesso a quei siti web.</p>

            <h4>Con chi condividiamo i tuoi dati</h4>
            <p>Se richiedi una reimpostazione della password, il tuo indirizzo IP verrà incluso nell’email di reimpostazione.</p>

            <h4>Per quanto tempo conserviamo i tuoi dati</h4>
            <p>Se lasci un commento, il commento e i relativi metadati vengono conservati a tempo indeterminato. È così che possiamo riconoscere e approvare automaticamente eventuali commenti successivi invece di tenerli in una coda di moderazione.</p>
            <p>Per gli utenti che si registrano sul nostro sito web (se presenti), memorizziamo anche le informazioni personali che forniscono nel loro profilo utente. Tutti gli utenti possono vedere, modificare o eliminare le loro informazioni personali in qualsiasi momento (eccetto il loro nome utente che non possono cambiare). Gli amministratori del sito web possono anche vedere e modificare queste informazioni.</p>

            <h4>Quali diritti hai sui tuoi dati</h4>
            <p>Se hai un account su questo sito, o hai lasciato commenti, puoi richiedere di ricevere un file esportato dal sito con i dati personali che abbiamo su di te, compresi i dati che ci hai fornito. Puoi anche richiedere che cancelliamo tutti i dati personali che ti riguardano. Questo non include i dati che siamo obbligati a conservare per scopi amministrativi, legali o di sicurezza.</p>

            <h4>Dove i tuoi dati sono inviati</h4>
            <p>I commenti dei visitatori possono essere controllati attraverso un servizio di rilevamento automatico dello spam.</p>
          </div>
        </Row>
      </div>

      <Footer />
    </div>



    
  );

}

function TeamsLayout(props) {
  const [teams, setTeams] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
  API.getTeams()
    .then(data => {
      console.log(data);   
      setTeams(data);
    })
    .catch(err => setError(err.error || 'Errore nel recupero delle squadre'));
}, []);

  if (error) {
    return <Alert variant="danger">{error}</Alert>;
  }

  return (
    <div className="d-flex flex-column min-vh-100">

      <Navigation 
        loggedIn={props.loggedIn} 
        user={props.user} 
        logout={props.logout}
      />

      <div className="container my-5 flex-grow-1">

        <Row className="g-4">
          <div>
        <h1>Squadre</h1>
        <Table striped bordered hover responsive>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome squadra</th>
            </tr>
          </thead>
          <tbody>
            {teams.map(team => (
              <tr key={team.id}>
                <td>{team.id}</td>
                <td>{team.name}</td>
              </tr>
            ))}
          </tbody>
        </Table>
        </div>
        </Row>
      </div>

      <Footer />
    </div>
  );
}



export { HomeLayout, StandingsLayout, NotFoundLayout, LoginLayout, MissionLayout, SponsorLayout, PolicyLayout, TeamsLayout };