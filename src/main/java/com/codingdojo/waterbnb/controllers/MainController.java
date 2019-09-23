package com.codingdojo.waterbnb.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.waterbnb.models.Pool;
import com.codingdojo.waterbnb.models.Review;
import com.codingdojo.waterbnb.models.Role;
import com.codingdojo.waterbnb.models.User;
import com.codingdojo.waterbnb.services.MainService;
import com.codingdojo.waterbnb.validator.UserValidator;

@Controller
public class MainController {
	private final MainService mainService;
	private final UserValidator userValidator;

	public MainController(MainService mainService, UserValidator userValidator) {
		this.mainService = mainService;
		this.userValidator = userValidator;
	}
	
	@RequestMapping("/signin")
	public String index(Model model, @ModelAttribute("user") User user) {
		List<Role> roles = mainService.getRoles();
		model.addAttribute("roles", roles);
		return "index.jsp";
	}
	
	@PostMapping("/registration")
	public String createUser(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "index.jsp";
		}
		else {
			User u = mainService.createUser(user);
			session.setAttribute("userid", u.getId());
			if (user.getRole().getName().equals("guest")) {
				return "redirect:/";
			}
			else {
				return "redirect:/host/dashboard";
			}
		}
	}
	
	@PostMapping("/login")
	public String loginUser(@RequestParam("email") String email, @RequestParam("password") String password, HttpSession session, RedirectAttributes redirectAttributes) {
		if (mainService.authenticateUser(email, password)) {
			User user = mainService.findByEmail(email);
			session.setAttribute("userid", user.getId());
			if (user.getRole().getName().equals("guest")) {
				return "redirect:/";
			}
			else {
				return "redirect:/host/dashboard";
			}
		}
		else {
			redirectAttributes.addFlashAttribute("error", "User could not be authenticated");
			return "redirect:/signin";
		}
	}
	
	@RequestMapping("")
	public String guestHome() {
		return "home.jsp";
	}
	
	@RequestMapping("/host/dashboard")
	public String hostHome(Model model, @ModelAttribute("pool") Pool pool, HttpSession session) {
		Long userid = (Long) session.getAttribute("userid");
		User user = mainService.findUser(userid);
		if (userid == null || user.getRole().getName().equals("guest")) {
			return "redirect:/";
		}
		List<Pool> pools = user.getPools();
		model.addAttribute("pools", pools);
		return "dashboard.jsp";
		
	} 
	
	@PostMapping("/host/pools")
	public String createPool(@Valid @ModelAttribute("pool") Pool pool, BindingResult result, HttpSession session) {
		if (result.hasErrors()) {
			return "dashboard.jsp";
		}
		else {
			User user = mainService.findUser((Long) session.getAttribute("userid"));
			pool.setUser(user);
			mainService.createPool(pool);
			return "redirect:/host/dashboard";
		}
	}
	
	@RequestMapping("/host/pools/{id}")
	public String editPool(@PathVariable("id") Long id, Model model) {
		Pool pool = mainService.findPool(id);
		model.addAttribute("pool", pool);
		return "editPool.jsp";
	}
	
	@PostMapping("/host/pools/{id}")
	public String updatePool(@PathVariable("id") Long id, @Valid @ModelAttribute("pool") Pool pool, BindingResult result) {
		if (result.hasErrors()) {
			return "editPool.jsp";
		}
		else {
			mainService.createPool(pool);
			return "redirect:/host/pools/"+id;
		}
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/signin";
	}
	
	@RequestMapping("/search")
	public String search(@RequestParam("location") String location, Model model) {
		List<Pool> pools = mainService.findPoolsInArea(location);
		model.addAttribute("pools", pools);
		return "searchResults.jsp";
	}
	
	@RequestMapping("/pools/{id}")
	public String showPool(@PathVariable("id") Long id, Model model) {
		Pool pool = mainService.findPool(id);
		model.addAttribute("pool", pool);
		return "showPool.jsp";
	}
	
	@RequestMapping("/pools/{id}/review")
	public String reviewPool(@PathVariable("id") Long id, Model model, @ModelAttribute("review") Review review) {
		Pool pool = mainService.findPool(id);
		model.addAttribute("pool", pool);
		return "reviewPool.jsp";
	}
	
	@PostMapping("/pools/{id}/review")
	public String createReview(@PathVariable("id") Long id, @Valid @ModelAttribute("review") Review review, BindingResult result, HttpSession session, Model model) {
		if (result.hasErrors()) {
			Pool pool = mainService.findPool(id);
			model.addAttribute("pool", pool);
			return "reviewPool.jsp";
		}
		else {
			Long userid = (Long) session.getAttribute("userid");
			Pool pool = mainService.findPool(id);
			
			System.out.printf("Review id: %d%n", review.getId());
			
			Double avgRating = pool.getAvgRating();
			System.out.printf("Avg rating before: %f%n %d", avgRating, pool.getReviews().size());
			Double sumOfRatings = avgRating * pool.getReviews().size();
			System.out.printf("sum of all ratings: %f%n", sumOfRatings);
			sumOfRatings += review.getRating();
			System.out.printf("sum of all ratings plus new rating: %f%n", sumOfRatings);
			sumOfRatings /= (pool.getReviews().size() + 1);
			System.out.printf("Avg rating after recalculating: %f%n", sumOfRatings);
			
			pool.setAvgRating(sumOfRatings);
			mainService.createPool(pool);
			
			User user = mainService.findUser(userid);
			review.setId(null);
			Review r = mainService.createReview(review);
			r.setUser(user);
			r.setPool(pool);
			user.getReviews().add(r);
			pool.getReviews().add(r);
			mainService.createPool(pool);
			return "redirect:/pools/" +id;
		}
	}
}
