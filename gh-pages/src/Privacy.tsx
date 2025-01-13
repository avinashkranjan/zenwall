import { Image, Shield, Lock, Eye, UserCheck } from "lucide-react";
import { Link } from "react-router-dom";

export default function PrivacyPolicy() {
  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 via-purple-900 to-gray-900">
      {/* Navigation */}
      <nav className="container mx-auto px-6 py-4">
        <div className="flex items-center justify-between">
          <Link to="/" className="flex items-center space-x-2">
            <Image className="w-8 h-8 text-purple-400" />
            <span className="text-2xl font-bold text-white">ZenWall</span>
          </Link>
        </div>
      </nav>

      {/* Privacy Policy Content */}
      <div className="container mx-auto px-6 py-12">
        <div className="max-w-4xl mx-auto bg-white/5 backdrop-blur-lg rounded-2xl p-8 text-gray-300">
          <h1 className="text-4xl font-bold text-white mb-8">Privacy Policy</h1>

          <div className="space-y-8">
            <section className="space-y-4">
              <div className="flex items-center gap-3">
                <Shield className="w-6 h-6 text-purple-400" />
                <h2 className="text-2xl font-semibold text-white">
                  Information We Collect
                </h2>
              </div>
              <p>
                We collect minimal information necessary to provide you with the
                best wallpaper experience. This includes:
              </p>
              <ul className="list-disc list-inside ml-4 space-y-2">
                <li>
                  Device information (screen resolution, operating system)
                </li>
                <li>
                  Usage statistics (most viewed categories, download counts)
                </li>
                <li>Cache data for improved performance</li>
              </ul>
            </section>

            <section className="space-y-4">
              <div className="flex items-center gap-3">
                <Lock className="w-6 h-6 text-purple-400" />
                <h2 className="text-2xl font-semibold text-white">
                  How We Use Your Information
                </h2>
              </div>
              <p>Your information helps us:</p>
              <ul className="list-disc list-inside ml-4 space-y-2">
                <li>Optimize wallpaper recommendations</li>
                <li>Improve app performance</li>
                <li>Develop new features</li>
                <li>Fix technical issues</li>
              </ul>
            </section>

            <section className="space-y-4">
              <div className="flex items-center gap-3">
                <Eye className="w-6 h-6 text-purple-400" />
                <h2 className="text-2xl font-semibold text-white">
                  Data Protection
                </h2>
              </div>
              <p>
                We implement industry-standard security measures to protect your
                data:
              </p>
              <ul className="list-disc list-inside ml-4 space-y-2">
                <li>Encryption of data in transit</li>
                <li>Regular security audits</li>
                <li>Secure data storage practices</li>
                <li>Limited employee data access</li>
              </ul>
            </section>

            <section className="space-y-4">
              <div className="flex items-center gap-3">
                <UserCheck className="w-6 h-6 text-purple-400" />
                <h2 className="text-2xl font-semibold text-white">
                  Your Rights
                </h2>
              </div>
              <p>You have the right to:</p>
              <ul className="list-disc list-inside ml-4 space-y-2">
                <li>Access your personal data</li>
                <li>Request data deletion</li>
                <li>Opt-out of analytics</li>
                <li>Update your preferences</li>
              </ul>
            </section>

            <section className="space-y-4">
              <h2 className="text-2xl font-semibold text-white">Contact Us</h2>
              <p>
                If you have any questions about our privacy policy, please
                contact us at:
              </p>
              <p className="text-purple-400">privacy@zenwall.com</p>
            </section>

            <section className="space-y-4">
              <h2 className="text-2xl font-semibold text-white">
                Updates to This Policy
              </h2>
              <p>
                We may update this privacy policy from time to time. The latest
                version will always be posted on this page.
              </p>
              <p>Last updated: {new Date().toLocaleDateString()}</p>
            </section>
          </div>
        </div>
      </div>

      {/* Footer */}
      <footer className="bg-gray-900 py-12 mt-12">
        <div className="container mx-auto px-6">
          <div className="flex flex-col md:flex-row justify-between items-center">
            <div className="flex items-center space-x-2 mb-4 md:mb-0">
              <Image className="w-6 h-6 text-purple-400" />
              <span className="text-xl font-bold text-white">ZenWall</span>
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
              &copy; {new Date().getFullYear()} ZenWall. All rights reserved.
            </p>
          </div>
        </div>
      </footer>
    </div>
  );
}
