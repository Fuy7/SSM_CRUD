package com.fuy.bean;

import javax.validation.constraints.Pattern;

public class User {
    private Integer id;

    @Pattern(regexp = "(^[a-z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
            message = "用户名不符合规则(2-5位中文或者6-16位英文和下划线组合)")
    private String name;

    @Pattern(regexp = "(^[0-9]{4})",
            message = "输入金额应为5位数")
    private Double money;

    private Integer dId;

    private Dept dept;

    public User() {
    }

    public User(Integer id, String name, Double money, Integer dId) {
        this.id = id;
        this.name = name;
        this.money = money;
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", money=" + money +
                ", dId=" + dId +
                ", dept=" + dept +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getMoney() {
        return money;
    }

    public void setMoney(Double money) {
        this.money = money;
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Dept getDept() {
        return dept;
    }

    public void setDept(Dept dept) {
        this.dept = dept;
    }
}