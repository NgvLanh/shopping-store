package com.poly.repositories;

import com.poly.entities.BestSellerProduct;
import com.poly.entities.MonthlySalesSummary;
import com.poly.entities.Payment;
import com.poly.entities.PendingInvoice;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    @Query("SELECT SUM(p.amount) FROM payments p WHERE p.status like 'completed'")
    Double sumAmountByStatus();

    //truy vấn theo tháng
    @Query("SELECT SUM(p.amount) AS totalAmount " +
            "FROM payments p WHERE p.status LIKE 'completed' " +
            "AND YEAR(p.date) = :year AND MONTH(p.date) = :month")
    Double sumAmountByMonth(@Param("year") int year, @Param("month") int month);

    @Query("SELECT SUM(p.amount) AS totalAmount " +
            "FROM payments p WHERE p.status LIKE 'completed' " +
            "AND YEAR(p.date) = YEAR(CURRENT_DATE()) " +
            "AND MONTH(p.date) = MONTH(CURRENT_DATE()) " +
            "GROUP BY YEAR(p.date), MONTH(p.date)")
    Double sumAmountCurrentMonth();
    //truy vấn tổng doanh thu theo ngày
    @Query("SELECT SUM(p.amount) FROM payments p WHERE p.status LIKE 'completed' AND p.date = :currentDate")
    Double findTotalRevenueForDate(@Param("currentDate") LocalDate currentDate);
    //truy vấn tổng doanh thu theo năm
    @Query("SELECT SUM(p.amount) FROM payments p WHERE p.status LIKE 'completed' AND YEAR(p.date) = YEAR(:currentDate)")
    Double getTotalAmountForCurrentYear(@Param("currentDate") LocalDate currentDate);
    @Query("select distinct date from payments")
    List<String> findDistinctByDate();

    @Query("SELECT new com.poly.entities.MonthlySalesSummary(YEAR(p.date), MONTH(p.date), SUM(p.amount)) " +
            "FROM payments p " +
            "WHERE p.status LIKE 'completed' " +
            "AND YEAR(p.date) = YEAR(current_date) " +
            "GROUP BY YEAR(p.date), MONTH(p.date) " +
            "ORDER BY YEAR(p.date), MONTH(p.date)")
    List<MonthlySalesSummary> findMonthlySalesSummary();

    @Query("SELECT new com.poly.entities.BestSellerProduct(pr.productId, pr.name, pr.image, pi.price, SUM(oi.quantity)) " +
            "FROM orderItems oi " +
            "JOIN oi.order o " +
            "JOIN o.payment p " +
            "JOIN oi.productItem pi " +
            "JOIN pi.product pr " +
            "WHERE p.status LIKE 'completed' " +
            "GROUP BY pr.productId, pr.name, pr.image, pi.price " +
            "ORDER BY SUM(oi.quantity) DESC")
    List<BestSellerProduct> getBestSellers();


}
