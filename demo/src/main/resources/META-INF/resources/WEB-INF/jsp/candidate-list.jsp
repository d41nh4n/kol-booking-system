<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />

    <title>candidate list with skills rating and location - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style type="text/css">
      body {
        padding-top: 40px;
        background: #e6e6fa;
      }
      .card {
        box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
      }

      .avatar-md {
        height: 5rem;
        width: 5rem;
      }

      .fs-19 {
        font-size: 19px;
      }

      .primary-link {
        color: #314047;
        -webkit-transition: all 0.5s ease;
        transition: all 0.5s ease;
      }

      a {
        color: #02af74;
        text-decoration: none;
      }

      .bookmark-post .favorite-icon a,
      .job-box.bookmark-post .favorite-icon a {
        background-color: #da3746;
        color: #fff;
        border-color: danger;
      }
      .favorite-icon a {
        display: inline-block;
        width: 30px;
        height: 30px;
        font-size: 18px;
        line-height: 30px;
        text-align: center;
        border: 1px solid #eff0f2;
        border-radius: 6px;
        color: rgba(173, 181, 189, 0.55);
        -webkit-transition: all 0.5s ease;
        transition: all 0.5s ease;
      }

      .candidate-list-box .favorite-icon {
        position: absolute;
        right: 22px;
        top: 22px;
      }
      .fs-14 {
        font-size: 14px;
      }
      .bg-soft-secondary {
        background-color: rgba(116, 120, 141, 0.15) !important;
        color: #74788d !important;
      }

      .mt-1 {
        margin-top: 0.25rem !important;
      }
      .candidate-body{
        margin-top: 70px;
      }
    </style>
  </head>
  <%@include file="navbar.jsp" %>
  <body>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
      integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc="
      crossorigin="anonymous"
    />
    <section class="section candidate-body">
      <div class="container">
        <div class="row">
          <div class="col-lg-12">
            <div class="candidate-list">
            <c:forEach var="user" items="${candidates}">
              <div class="candidate-list-box card mt-4">
                <div class="p-4 card-body">
                  <div class="align-items-center row">
                    <div class="col-auto">
                      <div class="candidate-list-images">
                        <a href="/profile?userId=${user.userId}"
                          ><img
                            src="${user.avatarUrl}"
                            alt
                            class="avatar-md img-thumbnail rounded-circle"
                        /></a>
                      </div>
                    </div>
                    <div class="col-lg-5">
                      <div class="candidate-list-content mt-3 mt-lg-0">
                        <h5 class="fs-19 mb-0">
                          <a class="primary-link" href="/profile?userId=${user.userId}">${user.fullName}</a
                          ><span class="badge bg-success ms-1"
                            ><i class="mdi mdi-star align-middle"></i>${user.rating}</span
                          >
                        </h5>
                        <ul class="list-inline mb-0 text-muted">
                          <li class="list-inline-item">
                            <i class="mdi mdi-map-marker"></i> ${user.location}
                          </li>

                        </ul>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div
                        class="mt-2 mt-lg-0 d-flex flex-wrap align-items-start gap-1"
                      >
                      <c:forEach var="category" items="${user.categories}">
                        <span class="badge bg-soft-secondary fs-14 mt-1">${category}</span>
                        </c:forEach>
                      </div>
                    </div>
                  </div>
                  <div class="favorite-icon">
                     <button class="btn btn-primary" onclick="choiceCandidate('${requestId}', '${user.userId}')">Choice</button>
                  </div>
                </div>
              </div>
            </c:forEach>  
            </div>
          </div>
        </div>
        </div>
      </div>
    </section>
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../../assert/js/candidate-list.js"></script>
  </body>
</html>
