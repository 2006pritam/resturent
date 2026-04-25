<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String ctx = request.getContextPath(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Foodu - Restaurant Management</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWix+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkR4j8l9ggpc8X+Ytst4yBo/hH+8FkY+gR0w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="<%= ctx %>/assets/css/style.css" />
</head>
<body>
    <header class="site-header">
        <div class="top-strip">
            <div class="container top-strip-inner">
                <p>Fresh flavors daily. Open from 8:00 AM to 11:00 PM</p>
                <div class="top-social">
                    <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#" aria-label="Dribbble"><i class="fa-brands fa-dribbble"></i></a>
                    <a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
                </div>
            </div>
        </div>
        <div class="container nav-wrap">
            <a href="#" class="brand">Foodu</a>
            <button class="menu-toggle" id="menuToggle" aria-label="Toggle menu">
                <span></span><span></span><span></span>
            </button>
            <nav id="mainNav">
                <a href="#home">Home</a>
                <a href="#menu">Menu</a>
                <a href="#popular">Popular</a>
                <a href="#chef">Chef</a>
                <a href="#gallery">Gallery</a>
                <a href="#blog">Blog</a>
            </nav>
            <div class="nav-actions">
                <button class="theme-toggle" id="themeToggle" type="button" aria-label="Switch to dark mode" title="Switch to dark mode">
                    <i class="fa-solid fa-moon"></i>
                    <span class="toggle-text">Dark mode</span>
                </button>
                <a class="btn-ghost" href="<%= ctx %>/login.jsp">Login</a>
            </div>
        </div>
    </header>

    <main>
        <section class="hero" id="home">
            <div class="hero-bg-shape shape-1"></div>
            <div class="hero-bg-shape shape-2"></div>
            <div class="container hero-grid">
                <div class="hero-copy reveal">
                    <p class="kicker">Purchase Today. Just ₹65</p>
                    <h1>Special Offer<br />Cheese Burger</h1>
                    <p>
                        Plan upon yet way get cold spot its week. Almost do am or limits hearts.
                        Resolve parties but why she shewing know.
                    </p>
                    <div class="hero-actions">
                        <a href="<%= ctx %>/login.jsp" class="btn-primary">Order Now</a>
                        <a href="#menu" class="btn-link">Explore Menu <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </div>
                <div class="hero-image reveal">
                    <img src="https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80" alt="Cheese Burger" />
                    <div class="floating-stat">
                        <img src="https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=160&q=80" alt="Food items" />
                        <div>
                            <strong>500+</strong>
                            <span>Menu and Dishes</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="menu-section section-pad" id="menu">
            <div class="container">
                <div class="section-head reveal">
                    <p class="kicker">Food Items</p>
                    <h2>Starters &amp; Main Dishes</h2>
                </div>
                <div class="menu-tabs reveal">
                    <button class="tab active">Main Dishes</button>
                    <button class="tab">Desserts</button>
                    <button class="tab">Sea Food</button>
                    <button class="tab">Beverage</button>
                </div>
                <div class="menu-grid">
                    <article class="menu-card reveal">
                        <h3>Chicken Alfredo</h3>
                        <p>Ricotta / Goat Cheese / Beetroot</p>
                        <div class="price-row"><span>₹20</span><small>₹30</small></div>
                        <em>Extra Free Juice.</em>
                    </article>
                    <article class="menu-card reveal">
                        <h3>Fish &amp; Chips</h3>
                        <p>Atlantic / Chips / Salad / Tartare</p>
                        <div class="price-row"><span>₹36</span><small>₹55</small></div>
                        <em>Extra Free Juice.</em>
                    </article>
                    <article class="menu-card reveal">
                        <h3>Ebony Fillet Steak</h3>
                        <p>Truffle Mash / Pepper Sauce</p>
                        <div class="price-row"><span>₹44</span><small>₹88</small></div>
                        <em>Extra Free Juice.</em>
                    </article>
                    <article class="menu-card reveal">
                        <h3>Creamy Mushroom Pasta</h3>
                        <p>Parmesan / Garlic / Basil</p>
                        <div class="price-row"><span>₹22</span><small>₹35</small></div>
                        <em>Chef Recommended.</em>
                    </article>
                </div>
            </div>
        </section>

        <section class="deals section-pad">
            <div class="container deals-grid">
                <a class="deal-card reveal" href="#">
                    <img src="https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=900&q=80" alt="Mexican Pizza" />
                    <span class="tag">Best Deal</span>
                    <h3>Mexican Pizza</h3>
                    <p>Make an order - 50% Off</p>
                </a>
                <a class="deal-card reveal" href="#">
                    <img src="https://images.unsplash.com/photo-1550317138-10000687a72b?auto=format&fit=crop&w=900&q=80" alt="Luger Burger" />
                    <span class="tag">Best Deal</span>
                    <h3>Luger Burger</h3>
                    <p>Make an order - Best Deal</p>
                </a>
                <a class="deal-card reveal" href="#">
                    <img src="https://images.unsplash.com/photo-1565299507177-b0ac66763828?auto=format&fit=crop&w=900&q=80" alt="Delicious Crab" />
                    <span class="tag">Best Deal</span>
                    <h3>Delicious Crab</h3>
                    <p>Make an order now</p>
                </a>
            </div>
        </section>

        <section class="popular section-pad" id="popular">
            <div class="container">
                <div class="section-head reveal">
                    <p class="kicker">Best Deal</p>
                    <h2>Our Popular Dishes</h2>
                </div>
                <div class="product-grid">
                    <article class="product-card reveal">
                        <img src="https://images.unsplash.com/photo-1600891964599-f61ba0e24092?auto=format&fit=crop&w=500&q=80" alt="Margherita Pizza" />
                        <p class="cat">Cheese, Pizza</p>
                        <h3>Margherita Pizza</h3>
                        <div class="price-line">₹12.00</div>
                        <a href="#">Add to Cart <i class="fa-solid fa-cart-shopping"></i></a>
                    </article>
                    <article class="product-card reveal">
                        <img src="https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=500&q=80" alt="Beef Burger" />
                        <p class="cat">Creamy, Burger</p>
                        <h3>Beef Burger</h3>
                        <div class="price-line">₹8.00 <small>₹5.00</small></div>
                        <a href="#">Add to Cart <i class="fa-solid fa-cart-shopping"></i></a>
                    </article>
                    <article class="product-card reveal">
                        <img src="https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=500&q=80" alt="Grilled Flank Steak" />
                        <p class="cat">Beef, Steak</p>
                        <h3>Grilled Flank Steak</h3>
                        <div class="price-line">₹14.00</div>
                        <a href="#">Add to Cart <i class="fa-solid fa-cart-shopping"></i></a>
                    </article>
                    <article class="product-card reveal">
                        <img src="https://images.unsplash.com/photo-1527477396000-e27163b481c2?auto=format&fit=crop&w=500&q=80" alt="Barbecue Chicken" />
                        <p class="cat">BBQ, Meat</p>
                        <h3>Barbecue Chicken</h3>
                        <div class="price-line">₹8.00</div>
                        <a href="#">Add to Cart <i class="fa-solid fa-cart-shopping"></i></a>
                    </article>
                </div>
            </div>
        </section>

        <section class="offer-banner section-pad">
            <div class="container offer-grid">
                <div class="offer-copy reveal">
                    <p class="kicker">Limited Offer</p>
                    <h2>Delicious Burger</h2>
                    <p>
                        It is a long established fact that a reader will be distracted by the readable
                        content of a page when looking at the layout.
                    </p>
                    <div class="countdown" id="countdown">
                        <div><strong id="days">00</strong><span>Days</span></div>
                        <div><strong id="hours">00</strong><span>Hours</span></div>
                        <div><strong id="minutes">00</strong><span>Minutes</span></div>
                        <div><strong id="seconds">00</strong><span>Seconds</span></div>
                    </div>
                </div>
                <div class="offer-image reveal">
                    <img src="https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?auto=format&fit=crop&w=800&q=80" alt="Offer Burger" />
                </div>
            </div>
        </section>

        <section class="chef section-pad" id="chef">
            <div class="container">
                <div class="section-head reveal">
                    <p class="kicker">Professional Chef</p>
                    <h2>Meet Our Kitchen Kings</h2>
                </div>
                <div class="chef-grid">
                    <article class="chef-card reveal">
                        <img src="https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=500&q=80" alt="Alexander Petllo" />
                        <h3>Alexander Petllo</h3>
                        <p>Assistant Chef</p>
                    </article>
                    <article class="chef-card reveal">
                        <img src="https://images.unsplash.com/photo-1595273670150-bd0c3c392e46?auto=format&fit=crop&w=500&q=80" alt="Mendia Juxef" />
                        <h3>Mendia Juxef</h3>
                        <p>Burger King</p>
                    </article>
                    <article class="chef-card reveal">
                        <img src="https://images.unsplash.com/photo-1607631568010-a87245c0daf8?auto=format&fit=crop&w=500&q=80" alt="Petro William" />
                        <h3>Petro William</h3>
                        <p>Main Chef</p>
                    </article>
                    <article class="chef-card reveal">
                        <img src="https://images.unsplash.com/photo-1583394293214-28a5b9f8f9a8?auto=format&fit=crop&w=500&q=80" alt="Kunnel Jexos" />
                        <h3>Kunnel Jexos</h3>
                        <p>Pizza Master</p>
                    </article>
                </div>
            </div>
        </section>

        <section class="testimonial section-pad">
            <div class="container testimonial-wrap reveal">
                <div>
                    <p class="stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></p>
                    <h3>Best Chicken Fry</h3>
                    <p>
                        Thanks to your web agency team for their professional work. The website they
                        created for my business exceeded my expectations and my clients have given
                        positive feedback about its design and user-friendliness.
                    </p>
                </div>
                <img src="https://images.unsplash.com/photo-1600891963935-c97e59f4d8b7?auto=format&fit=crop&w=700&q=80" alt="Customer favorite" />
            </div>
        </section>

        <section class="gallery section-pad" id="gallery">
            <div class="container">
                <div class="section-head reveal">
                    <p class="kicker">Food Item</p>
                    <h2>Our Restaurant Gallery</h2>
                </div>
                <div class="gallery-grid">
                    <img class="reveal" src="https://images.unsplash.com/photo-1543353071-10c8ba85a904?auto=format&fit=crop&w=700&q=80" alt="Gallery 1" />
                    <img class="reveal" src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=700&q=80" alt="Gallery 2" />
                    <img class="reveal" src="https://images.unsplash.com/photo-1559339352-11d035aa65de?auto=format&fit=crop&w=700&q=80" alt="Gallery 3" />
                    <img class="reveal" src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=700&q=80" alt="Gallery 4" />
                    <img class="reveal" src="https://images.unsplash.com/photo-1552566626-52f8b828add9?auto=format&fit=crop&w=700&q=80" alt="Gallery 5" />
                </div>
                <h3 class="sponsor-title reveal">Global 5K+ Happy Sponsors With Us</h3>
                <div class="sponsor-row reveal">
                    <span>FOODIE</span><span>GREENBITE</span><span>KITCHNOVA</span><span>URBAN TASTE</span><span>FLAVORA</span>
                </div>
            </div>
        </section>

        <section class="blog section-pad" id="blog">
            <div class="container">
                <div class="section-head reveal">
                    <p class="kicker">News &amp; Blog</p>
                    <h2>Our Latest News &amp; Blog</h2>
                </div>
                <div class="blog-grid">
                    <article class="blog-card reveal">
                        <img src="https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=700&q=80" alt="Blog 1" />
                        <span>18 March, 2024</span>
                        <h3>Announcing if attachment resolution sentiments at the projection.</h3>
                    </article>
                    <article class="blog-card reveal">
                        <img src="https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?auto=format&fit=crop&w=700&q=80" alt="Blog 2" />
                        <span>25 April, 2024</span>
                        <h3>This prefabricated passive are comfortable highly sustainable.</h3>
                    </article>
                    <article class="blog-card reveal">
                        <img src="https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?auto=format&fit=crop&w=700&q=80" alt="Blog 3" />
                        <span>15 June, 2024</span>
                        <h3>Minuter him own clothes but observe country at the maintaining.</h3>
                    </article>
                </div>
            </div>
        </section>
    </main>

    <footer class="site-footer">
        <div class="container footer-grid">
            <div>
                <h3>Foodu</h3>
                <p>Discover culinary delights recipes and inspiration in our food haven.</p>
                <p>Mon - Fri: 8:00 AM - 6:00 PM</p>
                <p>Saturday: 9:00 AM - 5:00 PM</p>
            </div>
            <div>
                <h4>Explore</h4>
                <a href="#">Company Profile</a>
                <a href="#">About</a>
                <a href="#">Help Center</a>
                <a href="#">Contact</a>
            </div>
            <div>
                <h4>Contact Info</h4>
                <p>175 10th Street, Office 375 Berlin, DE 21562</p>
                <p>+123 34598768</p>
                <p>food@restan.com</p>
            </div>
            <div>
                <h4>Newsletter</h4>
                <p>Join our subscribers list to get the latest news and special offers.</p>
                <form class="newsletter">
                    <input type="email" placeholder="Your email" />
                    <button type="button">Subscribe</button>
                </form>
            </div>
        </div>
        <div class="container footer-bottom">
            <p>&copy; Copyright 2026 Foodu. All Rights Reserved</p>
            <div class="top-social">
                <a href="#" aria-label="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" aria-label="Dribbble"><i class="fa-brands fa-dribbble"></i></a>
                <a href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
            </div>
        </div>
    </footer>

    <button id="backToTop" class="back-to-top" type="button" aria-label="Back to top" title="Back to top">
        <i class="fa-solid fa-arrow-up"></i>
        <span>Top</span>
    </button>

    <script src="<%= ctx %>/assets/js/main.js"></script>
</body>
</html>
