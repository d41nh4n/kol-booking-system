<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>KOL</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://netdna.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../assert/css/home.css" />
</head>
<body>
    <%@ include file="navbar.jsp" %>
    <div class="homepage-body">
        <div class="sidenav">
            <c:forEach var="category" items="${categories}">
                <a href="/search-page?category=${category}">${category}</a>
            </c:forEach>
        </div>
        <div class="container">
            <div class="row">
                <div class="section-margin">
                    <div class="row bg-color-1 card-margin">
                        <div class="card search-form">
                            <div class="card-body p-0">
                                <form id="search-form" method="get" action="/search-page">
    <div class="row">
        <!-- Location Dropdown -->
        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
            <select class="form-control" id="location" name="location">
                <option value="">Select Location</option>
                <c:forEach var="province" items="${provinces}">
                    <option value="${province}">${province}</option>
                </c:forEach>
            </select>
        </div>
        <!-- Search Input -->
        <div class="col-lg-8 col-md-6 col-sm-12 p-0">
            <input type="text" placeholder="Search..." class="form-control" id="nameSearch" name="nameSearch">
        </div>
        <!-- Search Button -->
        <div class="col-lg-1 col-md-3 col-sm-12 p-0">
            <button type="submit" class="btn btn-base">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search">
                    <circle cx="11" cy="11" r="8"></circle>
                    <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                </svg>
            </button>
        </div>
    </div>
    <div class="row mt-2">
        <!-- Gender Dropdown -->
        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
            <select class="form-control" id="gender" name="gender">
                <option value="">Gender</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
            </select>
        </div>
        <!-- Category Dropdown -->
        <div class="col-lg-5 col-md-6 col-sm-12 p-0">
            <select class="form-control" id="category" name="category">
                <option value="">Select Category</option>
                <c:forEach var="category" items="${categories}">
                    <option value="${category}">${category}</option>
                </c:forEach>
            </select>
        </div>
        <!-- Price Range Input -->
        <div class="col-lg-4 col-md-3 col-sm-12 p-0">
            <input type="text" placeholder="Min Price" class="form-control" id="minPrice" name="minPrice">
            <input type="text" placeholder="Max Price" class="form-control" id="maxPrice" name="maxPrice">
        </div>
    </div>
    <div class="row mt-2">
        <!-- Additional Filters as Checkboxes -->
        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="aPost" name="aPost" value="True">
                <label class="form-check-label" for="aPost">
                    aPost
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="hireADay" name="hireADay" value="True">
                <label class="form-check-label" for="hireADay">
                    hireADay
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="aVideo" name="aVideo" value="True">
                <label class="form-check-label" for="aVideo">
                    aVideo
                </label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="representative" name="representative" value="True">
                <label class="form-check-label" for="representative">
                    representative
                </label>
            </div>
        </div>
    </div>
</form>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="section-margin">
                    <h2 class="my-4">TOP KOL</h2>
                    <div class="row bg-color-1 product-row">
                        <!-- Example Product -->
                       <c:forEach var="user" items="${topUsers}">
                                <div class="col-12 col-lg-2 box-product-outer">
                                    <div class="box-product">
                                        <div class="img-wrapper">
                                            <a href="/profile?userId=${user.userId}">
                                                <img alt="Product" src="${user.avatarUrl}" class="img-fluid" />
                                            </a>
                                            <c:if test="${not empty user.catgories}">
                                                <div class="tags">
                                                    <c:forEach var="category" items="${user.catgories}">
                                                        <span class="label-tags"><span class="label label-danger">${category}</span></span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                        <h5><a href="/profile?userId=${user.userId}">${user.fullName}</a></h5>
                                        <div class="price">
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.pricePost}" type="number" pattern="###0" /></span> <h6>(A Post)</h6>
                                            </div>
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.priceVideo}" type="number" pattern="###0" /></span> <h6>(A Video)</h6>
                                            </div>
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.priceHireByDay}" type="number" pattern="###0" /></span> <h6>(Per Day)</h6>
                                            </div>
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.representativePrice}" type="number" pattern="###0" /></span> <h6>(Representative)</h6>
                                            </div>
                                        </div> 
                                        <div class="rating-location">
                                        <div class="rating">
                                            <i class="ace-icon fa fa-star"></i>
                                            <span>${user.rating}</span>
                                        </div>
                                         <div class="location">
                                            <span>${user.location}</span>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>    
                    </div>
                </div>
                    <div class="section-margin">
                        <h2 class="my-4">HOT KOL</h2>
                        <div class="row bg-color-1 product-row">
                            <!-- Loop through list products -->
                            <c:forEach var="user" items="${users}">
                                <div class="col-12 col-lg-2 box-product-outer">
                                    <div class="box-product">
                                        <div class="img-wrapper">
                                            <a href="/profile?userId=${user.userId}">
                                                <img alt="Product" src="${user.avatarUrl}" class="img-fluid" />
                                            </a>
                                            <c:if test="${not empty user.catgories}">
                                                <div class="tags">
                                                    <c:forEach var="category" items="${user.catgories}">
                                                        <span class="label-tags"><span class="label label-danger">${category}</span></span>
                                                    </c:forEach>
                                                </div>
                                            </c:if>
                                        </div>
                                        <h5><a href="/profile?userId=${user.userId}">${user.fullName}</a></h5>
                                        <div class="price">
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.pricePost}" type="number" pattern="###0" /></span> <h6>(A Post)</h6>
                                            </div>
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.priceVideo}" type="number" pattern="###0" /></span> <h6>(A Video)</h6>
                                            </div>
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.priceHireByDay}" type="number" pattern="###0" /></span> <h6>(Per Day)</h6>
                                            </div>
                                            <div class="price-item">
                                                <span class="dot"></span>
                                                <span class="price-down"><fmt:formatNumber value="${user.representativePrice}" type="number" pattern="###0" /></span> <h6>(Representative)</h6>
                                            </div>
                                        </div> 
                                       <div class="rating-location">
                                        <div class="rating">
                                            <i class="ace-icon fa fa-star"></i>
                                            <span>${user.rating}</span>
                                        </div>
                                         <div class="location">
                                            <span>${user.location}</span>
                                        </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>    
                        </div>
                    </div>
                </div>        
            </div>
        </div>
    </div>
    <script type="text/javascript"></script>
</body>
</html>
