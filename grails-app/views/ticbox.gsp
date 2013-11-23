<html>
    <head>
        <meta name="layout" content="ticbox"/>
        <title>Welcome</title>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'slider.css')}" type="text/css">
    </head>
    <body>

        <div id="teaser-container" class="">

            <!-- Responsive CSS3 Slider w/o JS by Brendan Zabarauskas http://csscience.com/responsiveslidercss3/-->
            <article id=slider>

                <!-- Slider Setup -->

                <input checked type=radio name=slider id=slide1 style="display: none;"/>
                <input type=radio name=slider id=slide2 style="display: none;"/>
                <input type=radio name=slider id=slide3 style="display: none;"/>
                <input type=radio name=slider id=slide4 style="display: none;"/>
                <input type=radio name=slider id=slide5 style="display: none;"/>

                <!-- The Slider -->

                <div id=slides>

                    <div id=overflow>

                        <div class=inner>
                            <article>
                                %{--<div class=info><h3>Create Survey</h3>Cing, need help untuk content</div>--}%
                                <img src="images/ticbox/collaterals/New_Banner_ticbox_3.png" />
                            </article>

                            <article>
                                %{--<div class=info><h3>Join Respondent</h3>Cing, need help untuk content</div>--}%
                                <img src="images/ticbox/collaterals/New_Banner_ticbox_1.2.png" />
                            </article>

                            <article>
                                %{--<div class=info><h3>Solutions</h3>Cing, need help untuk content</div>--}%
                                <img src="images/ticbox/collaterals/New_Banner_ticbox_2.2.png"/>
                                %{--style="height: 300px; width: auto;"/>--}%
                            </article>

                            <article>
                                <div class=info><h3>Watch Demo</h3>..demo here..</div>
                                <img src=http://csscience.com/responsiveslidercss3/CliffsByBjzaba.png />
                            </article>

                            <article>
                                <div class=info><h3>etc</h3>..anything here..</div>
                                <img src=http://csscience.com/responsiveslidercss3/HillFortByBjzaba.png />
                            </article>

                        </div> <!-- .inner -->

                    </div> <!-- #overflow -->

                </div> <!-- #slides -->


            <!-- Controls and Active Slide Display -->

                <div id=controls>

                    <label for=slide1></label>
                    <label for=slide2></label>
                    <label for=slide3></label>
                    <label for=slide4></label>
                    <label for=slide5></label>

                </div> <!-- #controls -->

                <div id=active>

                    <label for=slide1>Create Survey</label>
                    <label for=slide2>Solutions</label>
                    <label for=slide3>Join Respondent</label>
                    <label for=slide4>Watch Demo</label>
                    <label for=slide5>etc</label>

                </div> <!-- #active -->

            </article> <!-- #slider -->

            <div class="landing-bar col">
                <div style="background-color: #b9d234;">
                    <h1>It's Free</h1>
                    <span>Sign me up</span>
                    <ul class="sign-up-icons">
                        <oauth:connect provider="facebook"><li class="fb"></li></oauth:connect>
                        <oauth:connect provider="twitter"><li class="tw"> </li></oauth:connect>
                        <oauth:connect provider="google"><li class="gg"> </li></oauth:connect>
                    </ul>
                </div>
                <div class="center" style="background-color: #96b11a;">
                    <a href="${request.contextPath}/auth/registerSurveyor" style="color: #ffffff;">
                        <h1>Go Pro!</h1>
                        <span>More perks</span><br>
                        <span>Unlimited Surveys</span>
                    </a>
                </div>
                <div style="background-color: #617800;">
                    <table>
                        <tr>
                            <td>
                                <a href="${request.contextPath}/auth/registerRespondent" style="color: #ffffff;">
                                    Be a respondent<br>
                                    Be rewarded
                                </a>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div> <!-- #teaser-container -->

    %{--
        <div class="landing-container line">

            <div class="landing-main col">

                <div class="landing-menu navbar">
                    <div class="landing-menu-btn-left col pull-left"></div>
                    <ul class="nav">
                        <li class="link" href="${request.contextPath}/survey/">Create Survey</li>
                        <li class="link" href="${request.contextPath}/respondent/">Join Respondent</li>
                        <li>Solutions</li>
                        <li>Watch Demo</li>
                    </ul>
                    <div class="landing-menu-btn-right col pull-right"></div>
                </div>

            </div>


        </div>
        --}%

        <div class="module" style="float: left;">
            %{--<div class="span5">--}%
                <div class="row">
                    <div class="span6">
                        <h4 id="aboutUs">
                            <a href="#" rel="tooltip" title="Find everything about us!">About Us</a>
                        </h4>
                        <p>
                            Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                        </p>
                        <p>
                            <a class="btn" href="#">View details »</a>
                        </p>
                    </div>
                    <div class="two-cols">
                        <h4>
                            How It Works
                        </h4>
                        <p>
                            Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                        </p>
                        <p>
                            <a class="btn" href="#">View details »</a>
                        </p>
                    </div>
                </div>
                <div class="row">
                    <div class="two-cols">
                        <h4>
                            Resources
                        </h4>
                        <p>
                            Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                        </p>
                        <p>
                            <a class="btn" href="#">View details »</a>
                        </p>
                    </div>
                    <div class="two-cols">
                        <h4>
                            Blog
                        </h4>
                        <p>
                            Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                        </p>
                        <p>
                            <a class="btn" href="#">View details »</a>
                        </p>
                    </div>
                </div>
            %{--</div>--}%
            %{--<div class="span4">--}%
            <div class="row">
                <div class="single-col">
                    <h4>
                        Latest News
                    </h4>
                    <h5>11.05.13</h5>
                    <p>
                        Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                    </p>
                    <p>
                        <a class="btn" href="#">View details »</a>
                    </p>
                    <h5>10.05.13</h5>
                    <p>
                        Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui.
                    </p>
                    <p>
                        <a class="btn" href="#">View details »</a>
                    </p>
                </div>
            </div>
            %{--</div>--}%
        </div>


    <script type="text/javascript">
        $('#aboutUs').tooltip({
            selector: "a[rel=tooltip]"
        });
    </script>
    </body>
</html>
