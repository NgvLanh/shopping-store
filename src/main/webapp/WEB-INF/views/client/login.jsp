<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--================ End Header Menu Area =================-->

<!-- ================ start banner area ================= -->
<style>
    .error-message {
        color: #ff4d4d; /* Màu đỏ đậm */
        font-size: 14px;
        margin: 4px;
        padding: 5px;
    }
</style>
<section class="blog-banner-area" id="category">
    <div class="container h-100">
        <div class="blog-banner">
            <div class="text-center">
                <h1>Login / Register</h1>
                <nav aria-label="breadcrumb" class="banner-breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/home">Home</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Login/Register</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- ================ end banner area ================= -->

<!--================Login Box Area =================-->
<section class="login_box_area section-margin">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="login_box_img">
                    <div class="hover">
                        <h4>New to our website?</h4>
                        <p>There are advances being made in science and technology everyday, and a good example of this
                            is the</p>
                        <a class="button button-account" href="/register">Create an Account</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="login_form_inner">
                    <h3>Log in to enter</h3>
                    <form class="row login_form" action="/login" method="post">
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="email" name="email" placeholder="Email"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'">
                            <p class="error-message d-flex justify-content-start"
                               style="font-size: 14px; margin: 4px">${emailError}</p>
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="password" class="form-control" id="password" name="password"
                                   placeholder="Password"
                                   onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
                            <p class="error-message d-flex justify-content-start"
                               style="font-size: 14px; margin: 4px">${passwordError}</p>
                        </div>
                        <div class="col-md-12 form-group">
                            <div class="creat_account">
                                <input type="checkbox" id="remember" name="remember"/>
                                <label for="remember">Remember me</label>
                            </div>
                        </div>
                        <div class="col-md-12 form-group">
                            <button type="submit" value="submit" class="button button-login w-100">Log In</button>
                            <%--                            <a href="#">Forgot Password?</a>--%>
                            <p class="error-message d-flex justify-content-start"
                               style="font-size: 14px; margin: 4px">${allError}</p>
                            <b><i class="error-message d-flex justify-content-start"
                                  style="font-size: 14px; margin: 4px">${message}${param.error}</i></b>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</section>
<!--================End Login Box Area =================-->
