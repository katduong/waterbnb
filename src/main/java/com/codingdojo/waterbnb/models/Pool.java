package com.codingdojo.waterbnb.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="pools")
public class Pool {
	@Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    private Long id;
	@NotEmpty(message="Must enter an address")
	private String address;
	@NotEmpty(message="Must enter a description")
	private String description;
	@NotNull(message="Must ener a cost per night")
	private Double costPerNight;
	private String poolSize;
	private Double avgRating = 0.0;
	@Column(updatable=false)
    private Date createdAt;
    private Date updatedAt;
    
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
    
    @OneToMany(mappedBy="pool", fetch = FetchType.LAZY)
    private List<Review> reviews;
    
    public Pool() {}
    
    
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public Double getCostPerNight() {
		return costPerNight;
	}


	public void setCostPerNight(Double costPerNight) {
		this.costPerNight = costPerNight;
	}


	public String getPoolSize() {
		return poolSize;
	}


	public void setPoolSize(String poolSize) {
		this.poolSize = poolSize;
	}
	
	public Double getAvgRating() {
		return avgRating;
	}


	public void setAvgRating(Double avgRating) {
		this.avgRating = avgRating;
	}


	public Date getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}


	public Date getUpdatedAt() {
		return updatedAt;
	}


	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public List<Review> getReviews() {
		return reviews;
	}


	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}


	// other getters and setters removed for brevity
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}
