<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Box Product List - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="../../assert/css/home.css" />
  </head>
  <body>
    <%@include file="navbar.jsp" %>
    <div class="homepage-body">
      <div class="container">
        <div class="row">
          <div class="col-md-1">
            <div class="sidenav">
            <c:forEach var="category" items="${categories}">
                <a href="#">${category}</a>
            </c:forEach>
            </div>
          </div>
          <div class="col-md-11">
          <div class="col-lg-12 card-margin">
    <div class="card search-form">
        <div class="card-body p-0">
            <form id="search-form">
                <div class="row">
                    <!-- Location Dropdown -->
                    <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                        <select class="form-control" id="exampleFormControlSelect1">
                            <c:forEach var="category" items="${categories}">
                                <a href="#">${category}</a>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- Search Input -->
                    <div class="col-lg-8 col-md-6 col-sm-12 p-0">
                        <input type="text" placeholder="Search..." class="form-control" id="search" name="search">
                    </div>
                    <!-- Search Button -->
                    <div class="col-lg-1 col-md-3 col-sm-12 p-0">
                        <button type="submit" class="btn btn-base">
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                        </button>
                    </div>
                </div>
                <div class="row mt-2">
                    <!-- Gender Dropdown -->
                    <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                        <select class="form-control" id="gender">
                            <option>Gender</option>
                            <option>Male</option>
                            <option>Female</option>
                        </select>
                    </div>
                    <!-- Category Dropdown -->
                    <div class="col-lg-5 col-md-6 col-sm-12 p-0">
                        <select class="form-control" id="category">
                            <option>Category</option>
                            <option>Electronics</option>
                            <option>Clothing</option>
                            <option>Books</option>
                            <!-- Add more options as needed -->
                        </select>
                    </div>
                    <!-- Price Range Input -->
                    <div class="col-lg-4 col-md-3 col-sm-12 p-0">
                        <input type="text" placeholder="Price Range" class="form-control" id="price" name="price">
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

          <div class="row top-kol" style="margin-top: 50px;">
            <div class="col">
            <!-- Top kol -->
            <div class="top-kol-tilte">
              <h3>The Top KOL</h3>
            <div>
              <!-- Sản phẩm 1 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 2 -->
              <div class="col-md-2 box-product-outer">
               <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 3 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 4 -->
              <div class="col-md-2 box-product-outer">
               <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 5 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              </div>
              </br>
              </br>
              </br>
               <!-- list -->
               <div class="col">
                <div class="hot-kol-tilte">
                  <h3>Hot KOL</h3>
                <div>
                <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 3 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 4 -->
              <div class="col-md-2 box-product-outer">
               <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 5 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
               <div class="col-md-2 box-product-outer">
               <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 3 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 4 -->
              <div class="col-md-2 box-product-outer">
               <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <!-- Sản phẩm 5 -->
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
              <div class="col-md-2 box-product-outer">
                <div class="box-product">
                  <div class="img-wrapper">
                    <a href="detail.html">
                      <img
                        alt="Product"
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                      />
                    </a>
                    <div class="tags">
                      <span class="label-tags"
                        ><span class="label label-danger">Sale</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-info">Featured</span></span
                      >
                      <span class="label-tags"
                        ><span class="label label-warning">Polo</span></span
                      >
                    </div>
                    <div class="option">
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Add to Cart"
                        ><i class="ace-icon fa fa-shopping-cart"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Compare"
                        ><i class="ace-icon fa fa-align-left"></i
                      ></a>
                      <a
                        href="#"
                        data-toggle="tooltip"
                        data-placement="bottom"
                        title
                        data-original-title="Wishlist"
                        ><i class="ace-icon fa fa-heart"></i
                      ></a>
                    </div>
                  </div>
                  <h6><a href="detail.html">IncultGeo Print Polo T-Shirt</a></h6>
                  <div class="price">
                    <div>$16.59<span class="price-down">-10%</span></div>
                    <span class="price-old">$15.00</span>
                  </div>
                  <div class="rating">
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star"></i>
                    <i class="ace-icon fa fa-star-half-o"></i>
                    <a href="#">(2 reviews)</a>
                  </div>
                </div>
              </div>
            </div>
            </div>
          </div>
          </div>
        </div>
      </div>
    </div>
    <script type="text/javascript"></script>
  </body>
</html>
