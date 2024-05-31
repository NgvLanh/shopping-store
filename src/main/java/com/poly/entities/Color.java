package com.poly.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@Entity(name = "colors")
public class Color {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long colorId;

    @NotBlank(message = "NotBlank.color.color")
    private String colorName;

    @NotBlank(message = "NotBlank.color.colorDescription")
    private String colorDescription;

    @ManyToMany(mappedBy = "colors")
    private List<ProductItem> productItems;

//        @ManyToOne
//        @JoinColumn(name = "productItemId")
//        private ProductItem productItem;

    public Color(String color, String colorDescription) {
        this.colorName = color;
        this.colorDescription = colorDescription;
    }

    // ko cần dùng nữa thì xoá ko để hàm ko dùng
    public void print() {
        System.out.println("color: " + colorName);
        System.out.println("description: " + colorDescription);


    }

    public boolean isEmpty() {
        return colorName == null || colorDescription == null;
    }
}
