import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Landing from "./Landing";
import Privacy from "./Privacy";

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Landing />} />
        <Route path="/privacy" element={<Privacy />} />
      </Routes>
    </Router>
  );
}
