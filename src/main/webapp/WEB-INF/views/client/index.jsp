<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 5/14/2024
  Time: 9:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>FOUR FREE</title>
    <link rel="icon" href="/assets/images/logo.png" type="image/png">
    <link rel="stylesheet" href="/vendors/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="/vendors/fontawesome/css/all.min.css">
    <link rel="stylesheet" href="/vendors/themify-icons/themify-icons.css">
    <link rel="stylesheet" href="/vendors/nice-select/nice-select.css">
    <link rel="stylesheet" href="/vendors/owl-carousel/owl.theme.default.min.css">
    <link rel="stylesheet" href="/vendors/owl-carousel/owl.carousel.min.css">

    <link rel="stylesheet" href="/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body>
<!--================ Start Header Menu Area =================-->
<jsp:include page="components/hearder.jsp"/>
<!--================ End Header Menu Area =================-->
<jsp:include page="${page}"/>
<!--================ Start footer Area  =================-->
<jsp:include page="components/footer.jsp"/>
<!--================ End footer Area  =================-->

<script src="/vendors/jquery/jquery-3.2.1.min.js"></script>
<script src="/vendors/bootstrap/bootstrap.bundle.min.js"></script>
<script src="/vendors/skrollr.min.js"></script>
<script src="/vendors/owl-carousel/owl.carousel.min.js"></script>
<script src="/vendors/nice-select/jquery.nice-select.min.js"></script>
<script src="/vendors/jquery.ajaxchimp.min.js"></script>
<script src="/vendors/mail-script.js"></script>
<script src="/js/main.js"></script>
</body>
</html>
