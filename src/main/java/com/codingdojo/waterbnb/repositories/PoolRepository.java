package com.codingdojo.waterbnb.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.waterbnb.models.Pool;

@Repository
public interface PoolRepository extends CrudRepository<Pool, Long>{
	List<Pool> findByAddressContaining(String address);
}
