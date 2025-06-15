import React from "react";
import {
  Search,
  Download,
  Share2,
  Image,
  Smartphone,
  Heart,
} from "lucide-react";
import { Link } from "react-router-dom";

function Landing() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 via-purple-900 to-gray-900">
      <nav className="container mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center space-x-2">
            <Image className="w-8 h-8 text-purple-400" />
            <span className="text-2xl font-bold text-white">Miniflex</span>
          </div>
          <div className="hidden md:flex space-x-8">
            <a
              href="#features"
              className="text-gray-300 hover:text-white transition"
            >
              Features
            </a>
            <a
              href="#download"
              className="text-gray-300 hover:text-white transition"
            >
              Download
            </a>
            <a
              href="#support"
              className="text-gray-300 hover:text-white transition"
            >
              Support
            </a>
          </div>
        </div>
      </nav>

      {/* Hero Section */}
      <header className="container mx-auto px-6 py-16 text-center">
        <div className="relative">
          <div className="absolute inset-0 bg-gradient-to-r from-purple-500/20 to-pink-500/20 blur-3xl"></div>
          <h1 className="text-6xl font-bold mb-6 text-white relative">
            Beautiful Wallpapers for Your Device
          </h1>
          <p className="text-xl text-gray-300 mb-8 max-w-2xl mx-auto">
            Discover and apply stunning wallpapers powered by Pexels. Your
            perfect wallpaper is just a tap away.
          </p>
          <div className="flex justify-center gap-4">
            <a
              href="#download"
              className="bg-purple-600 hover:bg-purple-700 text-white px-8 py-3 rounded-lg font-semibold transition flex items-center gap-2"
            >
              <Download size={20} />
              Download Now
            </a>
          </div>
        </div>
      </header>

      {/* Features Section */}
      <section id="features" className="py-20 bg-black/20">
        <div className="container mx-auto px-6">
          <h2 className="text-4xl font-bold text-center text-white mb-16">
            Features
          </h2>
          <div className="grid md:grid-cols-3 gap-8">
            <FeatureCard
              icon={<Search className="w-8 h-8 text-purple-400" />}
              title="Smart Search"
              description="Find the perfect wallpaper using our powerful search functionality"
            />
            <FeatureCard
              icon={<Download className="w-8 h-8 text-purple-400" />}
              title="Easy Download"
              description="Save your favorite wallpapers directly to your device"
            />
            <FeatureCard
              icon={<Share2 className="w-8 h-8 text-purple-400" />}
              title="Share with Friends"
              description="Share beautiful wallpapers with your friends and family"
            />
          </div>
        </div>
      </section>

      {/* Preview Section */}
      <section className="py-20">
        <div className="container mx-auto px-6">
          <div className="flex flex-col md:flex-row items-center gap-12">
            <div className="md:w-1/2">
              <img
                src="https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=800&q=80"
                alt="App Preview"
                className="rounded-2xl shadow-2xl"
              />
            </div>
            <div className="md:w-1/2 space-y-6">
              <h2 className="text-4xl font-bold text-white">
                Stunning Collection
              </h2>
              <p className="text-gray-300 text-lg">
                Access thousands of high-quality wallpapers from Pexels. Our
                curated collection ensures you'll find the perfect wallpaper for
                any mood or occasion.
              </p>
              <ul className="space-y-4">
                <Feature text="High-resolution wallpapers" />
                <Feature text="Regular updates with fresh content" />
                <Feature text="Optimized for all devices" />
                <Feature text="Smart caching for quick loading" />
              </ul>
            </div>
          </div>
        </div>
      </section>

      {/* Download Section */}
      <section id="download" className="py-20 bg-black/20">
        <div className="container mx-auto px-6 text-center">
          <h2 className="text-4xl font-bold text-white mb-8">
            Get Miniflex Today
          </h2>
          <p className="text-gray-300 text-lg mb-12 max-w-2xl mx-auto">
            Transform your device with stunning wallpapers. Download Miniflex
            now and start customizing your screen.
          </p>
          <div className="flex justify-center gap-6">
            <DownloadButton
              icon={<Smartphone className="w-6 h-6" />}
              text="Download for Android"
            />
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-900 py-12">
        <div className="container mx-auto px-6">
          <div className="flex flex-col md:flex-row justify-between items-center">
            <div className="flex items-center space-x-2 mb-4 md:mb-0">
              <Image className="w-6 h-6 text-purple-400" />
              <span className="text-xl font-bold text-white">Miniflex</span>
            </div>
            <div className="flex space-x-6">
              <Link
                to="/privacy"
                className="text-gray-400 hover:text-white transition"
              >
                Privacy Policy
              </Link>
              <a href="#" className="text-gray-400 hover:text-white transition">
                Terms of Service
              </a>
              <a href="#" className="text-gray-400 hover:text-white transition">
                Contact
              </a>
            </div>
          </div>
          <div className="mt-8 text-center text-gray-400">
            <p>
              &copy; {new Date().getFullYear()} Miniflex. All rights reserved.
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}

function FeatureCard({
  icon,
  title,
  description,
}: {
  icon: React.ReactNode;
  title: string;
  description: string;
}) {
  return (
    <div className="bg-white/5 p-6 rounded-xl backdrop-blur-lg">
      <div className="mb-4">{icon}</div>
      <h3 className="text-xl font-semibold text-white mb-2">{title}</h3>
      <p className="text-gray-300">{description}</p>
    </div>
  );
}

function Feature({ text }: { text: string }) {
  return (
    <li className="flex items-center space-x-3">
      <Heart className="w-5 h-5 text-purple-400" />
      <span className="text-gray-300">{text}</span>
    </li>
  );
}

function DownloadButton({
  icon,
  text,
}: {
  icon: React.ReactNode;
  text: string;
}) {
  return (
    <a
      href="#"
      className="bg-purple-600 hover:bg-purple-700 text-white px-8 py-3 rounded-lg font-semibold transition flex items-center gap-2"
    >
      {icon}
      {text}
    </a>
  );
}

export default Landing;
