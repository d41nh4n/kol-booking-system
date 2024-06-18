<!DOCTYPE html>
<html lang="vi">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>media profile - Bootdey.com</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <link href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.10.2/fullcalendar.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../../assert/css/infor-kol.css" />
    <style>
    html, body {
        height: 100%;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    #content {
        flex: 1;
    }

    .footer {
        flex-shrink: 0;
    }
</style>
  </head>
  <%@include file="navbar.jsp" %>
  <body>
    <link
      href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
      rel="stylesheet"
    />
    <section id="content" class="container">
      <div class="page-heading">
        <div class="media clearfix">
          <div class="media-left pr30">
            <a href="#">
              <img
                class="media-object mw150"
                src="${userInformation.avatarUrl}"
                alt="..."
              />
            </a>
          </div>
          <div class="media-body va-m">
            <h2 class="media-heading">${userInformation.fullName}</h2>
          </div>
          <div class="media-right va-m">
          <c:if test="${not empty me}">
            <a href="/update-profile-form" class="btn btn-primary edit-profile">
              <i class="fa fa-pencil-square fa-lg"></i> Edit profile
            </a>
          </c:if>
          <c:if test="${empty me}">
           <button id="hire-button" type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#myModal">$ Hire</button>
          </c:if>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-md-4">
          <div class="panel">
            <div class="panel-heading">
              <span class="panel-icon">
                <i class="fa fa-star"></i>
              </span>
              <span class="panel-title"> User Popularity</span>
            </div>
            <div class="panel-body pn">
              <table class="table mbn tc-icon-1 tc-med-2 tc-bold-last">
                <thead>
                  <tr class="hidden">
                    <th class="mw30">#</th>
                    <th>First Name</th>
                    <th>Revenue</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>
                      <span class="fa fa-desktop text-warning"></span>
                    </td>
                    <td>Television</td>
                    <td>
                      <i class="fa fa-caret-up text-info pr10"></i>$855,913
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <span class="fa fa-microphone text-primary"></span>
                    </td>
                    <td>Radio</td>
                    <td>
                      <i class="fa fa-caret-down text-danger pr10"></i>$349,712
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <span class="fa fa-newspaper-o text-info"></span>
                    </td>
                    <td>Newspaper</td>
                    <td>
                      <i class="fa fa-caret-up text-info pr10"></i>$1,259,742
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
          <div class="panel">
            <div class="panel-heading">
              <span class="panel-icon">
                <i class="fa fa-trophy"></i>
              </span>
              <span class="panel-title"> My Field</span>
            </div>
            <div class="panel-body pb5">
              <span class="label label-warning mr5 mb10 ib lh15">Default</span>
              <span class="label label-primary mr5 mb10 ib lh15">Primary</span>
              <span class="label label-info mr5 mb10 ib lh15">Success</span>
              <span class="label label-success mr5 mb10 ib lh15">Info</span>
              <span class="label label-alert mr5 mb10 ib lh15">Warning</span>
              <span class="label label-system mr5 mb10 ib lh15">Danger</span>
              <span class="label label-info mr5 mb10 ib lh15">Success</span>
              <span class="label label-success mr5 mb10 ib lh15"
                >Ui Design</span
              >
              <span class="label label-primary mr5 mb10 ib lh15">Primary</span>
            </div>
          </div>
          <div class="panel">
    <div class="panel-heading">
        <span class="panel-icon">
            <i class="fa fa-user"></i>
        </span>
        <span class="panel-title">About Me</span>
    </div>
    <div class="panel-body pb5">
        <h6>Name</h6>
        <h4>John Doe</h4>
        <hr class="short br-lighter" />
        
        <h6>Age</h6>
        <h4>30</h4>
        <hr class="short br-lighter" />
        
        <h5>Description</h5>
        <p class="text-muted">
            Experienced software engineer with a background in web development and data analysis. Passionate about building scalable software and improving user experience.
        </p>
        <hr class="short br-lighter" />
        
        <h5>Location</h5>
        <h4>University of Missouri, Columbia</h4>
    </div>
</div>

        </div>
        <div class="col-md-8">
          <div class="tab-block">
            <ul class="nav nav-tabs">
              <li class="about-me active">
                <a href="#" data-toggle="tab">About Me</a>
              </li>
              <li class="evaluate">
                <a href="#" data-toggle="tab">Evaluate</a>
              </li >
              <c:if test="${not empty me}">
                <li class="schedule">
                  <a href="#" data-toggle="tab">Schedule</a>
                </li>
              </c:if>
            </ul>
            <div class="tab-content p30" style="height: 1200px">
              <div id="tab1" class="tab-pane active">
                <div class="container-image_list">
                  <div class="superbox">
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar3.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar5.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar3.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar3.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar5.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar3.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar5.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar3.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar5.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar2.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar3.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar5.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar6.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar5.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar4.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                    <div class="superbox-list">
                      <img
                        src="https://bootdey.com/img/Content/avatar/avatar1.png"
                        alt
                        class="superbox-img"
                      />
                    </div>
                  </div>
                </div>
              </div>
              <div id="tab2" class="tab-pane ">
                <section class="content-item" id="comments">
                  <div class="container-comment">
                    <div class="row">
                      <div class="col-sm-11">
                        <form>
                          <h3 class="pull-left">New Comment</h3>
                          <button
                            type="submit"
                            class="btn btn-normal pull-right"
                          >
                            Submit
                          </button>
                          <fieldset>
                            <div class="row">
                              <div class="col-sm-3 col-lg-2 hidden-xs">
                                <img
                                  class="img-responsive"
                                  src="https://bootdey.com/img/Content/avatar/avatar1.png"
                                  alt
                                />
                              </div>
                              <div
                                class="form-group col-xs-12 col-sm-9 col-lg-10"
                              >
                                <textarea
                                  class="form-control"
                                  id="message"
                                  placeholder="Your message"
                                  required
                                ></textarea>
                              </div>
                            </div>
                          </fieldset>
                        </form>
                        <h3>4 Comments</h3>

                        <div class="media">
                          <a class="pull-left" href="#"
                            ><img
                              class="media-object"
                              src="https://bootdey.com/img/Content/avatar/avatar1.png"
                              alt
                          /></a>
                          <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>
                              Lorem ipsum dolor sit amet, consectetur adipiscing
                              elit. Lorem ipsum dolor sit amet, consectetur
                              adipiscing elit. Lorem ipsum dolor sit amet,
                              consectetur adipiscing elit. Lorem ipsum dolor sit
                              amet, consectetur adipiscing elit. Lorem ipsum
                              dolor sit amet, consectetur adipiscing elit. Lorem
                              ipsum dolor sit amet, consectetur adipiscing elit.
                            </p>
                            <ul
                              class="list-unstyled list-inline media-detail pull-left"
                            >
                              <li><i class="fa fa-calendar"></i>27/02/2014</li>
                            </ul>
                          </div>
                        </div>

                        <div class="media">
                          <a class="pull-left" href="#"
                            ><img
                              class="media-object"
                              src="https://bootdey.com/img/Content/avatar/avatar2.png"
                              alt
                          /></a>
                          <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>
                              Lorem ipsum dolor sit amet, consectetur adipiscing
                              elit. Lorem ipsum dolor sit amet, consectetur
                              adipiscing elit. Lorem ipsum dolor sit amet,
                              consectetur adipiscing elit. Lorem ipsum dolor sit
                              amet, consectetur adipiscing elit. Lorem ipsum
                              dolor sit amet, consectetur adipiscing elit. Lorem
                              ipsum dolor sit amet, consectetur adipiscing elit.
                            </p>
                            <ul
                              class="list-unstyled list-inline media-detail pull-left"
                            >
                              <li><i class="fa fa-calendar"></i>27/02/2014</li>
                            </ul>
                          </div>
                        </div>

                        <div class="media">
                          <a class="pull-left" href="#"
                            ><img
                              class="media-object"
                              src="https://bootdey.com/img/Content/avatar/avatar3.png"
                              alt
                          /></a>
                          <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>
                              Lorem ipsum dolor sit amet, consectetur adipiscing
                              elit. Lorem ipsum dolor sit amet, consectetur
                              adipiscing elit. Lorem ipsum dolor sit amet,
                              consectetur adipiscing elit. Lorem ipsum dolor sit
                              amet, consectetur adipiscing elit. Lorem ipsum
                              dolor sit amet, consectetur adipiscing elit. Lorem
                              ipsum dolor sit amet, consectetur adipiscing elit.
                            </p>
                            <ul
                              class="list-unstyled list-inline media-detail pull-left"
                            >
                              <li><i class="fa fa-calendar"></i>27/02/2014</li>
                            </ul>
                          </div>
                        </div>

                        <div class="media">
                          <a class="pull-left" href="#"
                            ><img
                              class="media-object"
                              src="https://bootdey.com/img/Content/avatar/avatar4.png"
                              alt
                          /></a>
                          <div class="media-body">
                            <h4 class="media-heading">John Doe</h4>
                            <p>
                              Lorem ipsum dolor sit amet, consectetur adipiscing
                              elit. Lorem ipsum dolor sit amet, consectetur
                              adipiscing elit. Lorem ipsum dolor sit amet,
                              consectetur adipiscing elit. Lorem ipsum dolor sit
                              amet, consectetur adipiscing elit. Lorem ipsum
                              dolor sit amet, consectetur adipiscing elit. Lorem
                              ipsum dolor sit amet, consectetur adipiscing elit.
                            </p>
                            <ul
                              class="list-unstyled list-inline media-detail pull-left"
                            >
                              <li><i class="fa fa-calendar"></i>27/02/2014</li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </section>
              </div>
              <div id="tab3" class="tab-pane">
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <div
      class="modal fade"
      id="showPhoto"
      tabindex="-1"
      role="dialog"
      aria-labelledby="myModalLabel"
    >
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button
              type="button"
              class="close"
              data-dismiss="modal"
              aria-label="Close"
            >
              <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="myModalLabel">Modal title</h4>
          </div>
          <div class="modal-body"></div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">
              Close
            </button>
          </div>
        </div>
      </div>
    </div>

<!-- Main Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Hire Type</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <button type="button" class="btn btn-primary" onclick="showContent('post')">A Post</button>
                    <button type="button" class="btn btn-primary" onclick="showContent('video')">A Video</button>
                    <button type="button" class="btn btn-primary" onclick="showContent('by_date')">Hire By Day</button>
                    <button type="button" class="btn btn-primary" onclick="showContent('representative')">Representative</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>


<!-- Post Modal -->
<div class="modal fade" id="postModal" tabindex="-1" role="dialog" aria-labelledby="postModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" id="cancelPost" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="postModalLabel">Post Modal</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="postDeadline">Deadline:</label>
                    <input type="date" class="form-control" id="postDeadline">
                </div>
                <div class="form-group">
                    <label for="postDescription">Description:</label>
                    <textarea class="form-control" id="postDescription"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Video Modal -->
<div class="modal fade" id="videoModal" tabindex="-1" role="dialog" aria-labelledby="videoModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="videoModalLabel">Video</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="videoDeadline">Deadline:</label>
                    <input type="date" class="form-control" id="videoDeadline">
                </div>
                <div class="form-group">
                    <label for="videoDescription">Description:</label>
                    <textarea class="form-control" id="videoDescription"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Date Modal -->
<div class="modal fade" id="dateModal" tabindex="-1" role="dialog" aria-labelledby="dateModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="dateModalLabel">Hire By Day</h4>
            </div>
            <div class="modal-body">
                <div class="calendar">
                    <div class="calendar-header">
                        <button onclick="prevMonth()">&#8249;</button>
                        <div class="month-name" id="month-name">January 2024</div>
                        <button onclick="nextMonth()">&#8250;</button>
                    </div>
                    <div class="weekdays">
                        <div>Sun</div>
                        <div>Mon</div>
                        <div>Tue</div>
                        <div>Wed</div>
                        <div>Thu</div>
                        <div>Fri</div>
                        <div>Sat</div>
                    </div>
                    <div class="days" id="days"></div>
                </div>
                <button class="submit" onclick="submitSelection()">Submit</button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Representative Modal -->
<div class="modal fade" id="representativeModal" tabindex="-1" role="dialog" aria-labelledby="representativeModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="representativeModalLabel">Representative Modal</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="representativeDescription">Description:</label>
                    <textarea class="form-control" id="representativeDescription"></textarea>
                </div>
                <div class="form-group">
                    <label for="representativeMonths">Month Number:</label>
                    <select class="form-control" id="representativeMonths">
                        <option value="3">3 Tháng</option>
                        <option value="6">6 Tháng</option>
                        <option value="9">9 Tháng</option>
                    </select>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>


    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script src="https://netdna.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="../../assert/js/infor-kol.js"></script>
    <footer>  
    </footer>
  </body>
</html>
