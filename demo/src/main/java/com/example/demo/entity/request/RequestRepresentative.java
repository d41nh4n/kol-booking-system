package com.example.demo.entity.request;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.micrometer.common.lang.Nullable;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "RequestRepresentatives")
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RequestRepresentative {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Nullable
    private Date startDate;
    @Nullable
    private Date endDate;

    private int months;

    @JsonIgnore
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "request_id")
    private Request request;
}
