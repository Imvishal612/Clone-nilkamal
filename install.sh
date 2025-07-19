#!/bin/bash
set -e

PROJECT=mkf-clone
echo "🚀 Creating project: $PROJECT"

npx create-react-app $PROJECT
cd $PROJECT

echo "📦 Installing Tailwind CSS..."
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p

echo "🛠️ Configuring Tailwind..."
cat > tailwind.config.js <<EOF
module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      colors: {
        blue: {
          100: "#e3f0fc",
          600: "#3797e0",
          700: "#2268b1",
          800: "#154286",
        },
      },
    },
  },
  plugins: [],
};
EOF

echo '@tailwind base;\n@tailwind components;\n@tailwind utilities;\nbody{font-family:sans-serif;background:#f8fafc;}' > src/index.css

echo "⚙️ Adding project files..."
mkdir -p src/components src/pages src/data public/assets

# README
cat > README.md <<EOF
# Nilkamal Furniture Clone (React + Tailwind CSS)
Educational UI clone using React, Tailwind, React Router. For learning only.
EOF

# Navbar
cat > src/components/Navbar.jsx <<EOF
import React from "react";
import { Link } from "react-router-dom";

const Navbar = () => {
  return (
    <nav className="bg-blue-800 text-white px-8 py-4 flex justify-between items-center">
      <Link to="/" className="text-2xl font-bold">FurniClone</Link>
      <ul className="flex space-x-6">
        <li><Link to="/collections/living-room">Living</Link></li>
        <li><Link to="/collections/office">Office</Link></li>
        <li><Link to="/collections/plastic-chairs">Plastic Chairs</Link></li>
        <li><Link to="/about">About</Link></li>
        <li><Link to="/contact">Contact</Link></li>
        <li><Link to="/cart" className="font-semibold">Cart</Link></li>
      </ul>
    </nav>
  );
};
export default Navbar;
EOF

# Footer
cat > src/components/Footer.jsx <<EOF
import React from "react";
const Footer = () => (
  <footer className="bg-blue-800 text-white px-8 py-6 mt-12">
    <div className="container mx-auto flex flex-col md:flex-row justify-between">
      <p>&copy; FurniClone</p>
      <p>info@furniclone.com</p>
    </div>
  </footer>
);
export default Footer;
EOF

# ProductCard
cat > src/components/ProductCard.jsx <<EOF
import React from "react";
import { Link } from "react-router-dom";
function ProductCard({ product }) {
  return (
    <div className="bg-white rounded-lg shadow-md p-4 hover:shadow-lg">
      <Link to={\`/products/\${product.id}\`}>
        <img src={product.image} alt={product.title} className="w-full h-48 object-cover rounded-md" />
      </Link>
      <h3 className="mt-2 text-lg font-semibold">{product.title}</h3>
      <p className="text-blue-800 font-bold mt-2">₹{product.price}</p>
      <button className="mt-4 bg-blue-600 text-white rounded px-4 py-2 w-full">Add to Cart</button>
    </div>
  );
}
export default ProductCard;
EOF

# ProductGrid
cat > src/components/ProductGrid.jsx <<EOF
import React from "react";
import ProductCard from "./ProductCard";
const ProductGrid = ({ products }) => (
  <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-8 mt-8">
    {products.map((p) => <ProductCard key={p.id} product={p} />)}
  </div>
);
export default ProductGrid;
EOF

# HeroSection
cat > src/components/HeroSection.jsx <<EOF
import React from "react";
const HeroSection = () => (
  <div className="bg-blue-100 flex flex-col md:flex-row items-center justify-between px-8 py-10 rounded-lg shadow">
    <div>
      <h1 className="text-4xl font-extrabold text-blue-800 mb-4">Comfort Meets Elegance</h1>
      <p className="text-lg text-blue-700">Discover modern furniture for every room.</p>
      <button className="mt-6 bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700">Shop Now</button>
    </div>
    <img src="/assets/chair-placeholder.png" alt="Featured" className="w-1/3 mt-8 md:mt-0" />
  </div>
);
export default HeroSection;
EOF

# App.js
cat > src/App.js <<EOF
import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import HomePage from "./pages/HomePage";
import CollectionPage from "./pages/CollectionPage";
import ProductDetail from "./pages/ProductDetail";
import CartPage from "./pages/CartPage";
import AboutPage from "./pages/AboutPage";
import ContactPage from "./pages/ContactPage";

function App() {
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route path="/" element={<HomePage />} />
        <Route path="/collections/:slug" element={<CollectionPage />} />
        <Route path="/products/:id" element={<ProductDetail />} />
        <Route path="/cart" element={<CartPage />} />
        <Route path="/about" element={<AboutPage />} />
        <Route path="/contact" element={<ContactPage />} />
      </Routes>
      <Footer />
    </Router>
  );
}
export default App;
EOF

# HomePage.jsx
cat > src/pages/HomePage.jsx <<EOF
import React from "react";
import HeroSection from "../components/HeroSection";
import ProductGrid from "../components/ProductGrid";
import products from "../data/products";
function HomePage() {
  return (
    <div className="container mx-auto px-4">
      <HeroSection />
      <h2 className="text-2xl font-bold text-blue-900 mt-12 mb-4">Featured Products</h2>
      <ProductGrid products={products} />
    </div>
  );
}
export default HomePage;
EOF

# Products Data
cat > src/data/products.js <<EOF
const products = [
  {
    id: 1,
    title: "Modern Lounge Chair",
    price: 4999,
    image: "/assets/chair-placeholder.png",
    description: "Comfortable lounge chair with modern design.",
  },
  {
    id: 2,
    title: "Classic Sofa",
    price: 12999,
    image: "/assets/sofa-placeholder.png",
    description: "Plush classic sofa.",
  },
  {
    id: 3,
    title: "Coffee Table",
    price: 3999,
    image: "/assets/table-placeholder.png",
    description: "Wooden table built to last.",
  },
];
export default products;
EOF

# AboutPage.jsx
cat > src/pages/AboutPage.jsx <<EOF
import React from "react";
const AboutPage = () => (
  <div className="container mx-auto px-4 mt-12">
    <h2 className="text-2xl font-bold mb-4">About Us</h2>
    <p>This is an educational furniture store UI clone built with React and Tailwind CSS.</p>
  </div>
);
export default AboutPage;
EOF

# ContactPage.jsx
cat > src/pages/ContactPage.jsx <<EOF
import React from "react";
const ContactPage = () => (
  <div className="container mx-auto px-4 mt-12">
    <h2 className="text-2xl font-bold mb-4">Contact Us</h2>
    <form className="bg-white p-6 rounded shadow-md max-w-md">
      <input type="text" placeholder="Your Name" className="border px-4 py-2 mb-4 w-full" />
      <input type="email" placeholder="Your Email" className="border px-4 py-2 mb-4 w-full" />
      <textarea placeholder="Message" rows="4" className="border px-4 py-2 w-full mb-4"></textarea>
      <button className="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">Send</button>
    </form>
  </div>
);
export default ContactPage;
EOF

# CartPage.jsx
cat > src/pages/CartPage.jsx <<EOF
import React from "react";
const CartPage = () => (
  <div className="container mx-auto px-4 mt-12">
    <h2 className="text-2xl font-bold">Your Cart</h2>
    <p className="mt-2">Cart page is under development.</p>
  </div>
);
export default CartPage;
EOF

# CollectionPage.jsx
cat > src/pages/CollectionPage.jsx <<EOF
import React from "react";
import { useParams } from "react-router-dom";
import products from "../data/products";
import ProductGrid from "../components/ProductGrid";

function CollectionPage() {
  const { slug } = useParams();
  const collection = slug.replace("-", " ");
  return (
    <div className="container mx-auto px-4 mt-8">
      <h1 className="text-2xl font-bold capitalize mb-6">{collection} Collection</h1>
      <ProductGrid products={products} />
    </div>
  );
}
export default CollectionPage;
EOF

# ProductDetail.jsx
cat > src/pages/ProductDetail.jsx <<EOF
import React from "react";
import { useParams } from "react-router-dom";
import products from "../data/products";

function ProductDetail() {
  const { id } = useParams();
  const product = products.find((p) => p.id === Number(id));

  if (!product) return <div className="text-center mt-12">Product not found.</div>;

  return (
    <div className="container mx-auto px-4 mt-12 flex flex-col md:flex-row gap-8">
      <img src={product.image} alt={product.title} className="w-full md:w-1/2 rounded-lg" />
      <div>
        <h2 className="text-3xl font-bold mb-2">{product.title}</h2>
        <p className="text-xl text-blue-800 font-semibold mb-4">₹{product.price}</p>
        <p className="mb-4">{product.description}</p>
        <button className="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700">Add to Cart</button>
      </div>
    </div>
  );
}
export default ProductDetail;
EOF

echo "🎉 Done!"
echo "👉 Next steps: cd $PROJECT && npm start"
