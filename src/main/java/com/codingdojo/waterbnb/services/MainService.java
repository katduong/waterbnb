package com.codingdojo.waterbnb.services;

import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import com.codingdojo.waterbnb.models.Pool;
import com.codingdojo.waterbnb.models.Review;
import com.codingdojo.waterbnb.models.Role;
import com.codingdojo.waterbnb.models.User;
import com.codingdojo.waterbnb.repositories.PoolRepository;
import com.codingdojo.waterbnb.repositories.ReviewRepository;
import com.codingdojo.waterbnb.repositories.RoleRepository;
import com.codingdojo.waterbnb.repositories.UserRepository;

@Service
public class MainService {
	private final UserRepository userRepo;
	private final PoolRepository poolRepo;
	private final ReviewRepository reviewRepo;
	private final RoleRepository roleRepo;
	
	public MainService(UserRepository userRepo, PoolRepository poolRepo, ReviewRepository reviewRepo,
			RoleRepository roleRepo) {
		this.userRepo = userRepo;
		this.poolRepo = poolRepo;
		this.reviewRepo = reviewRepo;
		this.roleRepo = roleRepo;
	}
	
	public List<Role> getRoles() {
		return roleRepo.findAll();
	}
	
	public User createUser(User u) {
		String hashed = BCrypt.hashpw(u.getPassword(), BCrypt.gensalt());
		u.setPassword(hashed);
		return userRepo.save(u);
	}
	
	public boolean authenticateUser(String email, String password) {
		User user = userRepo.findByEmail(email);
		if (user == null) {
			return false;
		}
		else {
			if (BCrypt.checkpw(password, user.getPassword())) {
				return true;
			}
			else {
				return false;
			}
		}
	}
	
	public User findByEmail(String email) {
		return userRepo.findByEmail(email);
	}
	
	public User findUser(Long id) {
		return userRepo.findById(id).get();
	}

	public Pool createPool(Pool p) {
		return poolRepo.save(p);
	}
	
	public Pool findPool(Long id) {
		return poolRepo.findById(id).get();
	}
	
	public List<Pool> findPoolsInArea(String address) {
		return poolRepo.findByAddressContaining(address);
	}
	public Review createReview(Review r) {
		return reviewRepo.save(r);
	}
}
