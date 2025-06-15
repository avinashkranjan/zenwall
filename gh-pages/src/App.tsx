import { Routes, Route } from "react-router-dom";
import Landing from "./Landing";
import Privacy from "./Privacy";

export default function App() {
  return (
    <Routes>
      <Route path="/" element={<Landing />} />
      <Route path="/privacy" element={<Privacy />} />
      <Route path="/privacy-policy" element={<Privacy />} />
    </Routes>
  );
}
