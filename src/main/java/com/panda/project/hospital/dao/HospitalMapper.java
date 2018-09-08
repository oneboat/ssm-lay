package com.panda.project.hospital.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.panda.project.hospital.model.Hospital;

public interface HospitalMapper {

	List<Hospital> findPageHospitals(@Param("map")Map<String, Object> map);

	int findPartHospitals(@Param("map")Map<String, Object> map);

	int findAllHospitals();

	Hospital findHospitalByUsercode(String hpcode);

	void addHospital(@Param("hospital")Hospital hospital);

	void deleteHospital(@Param("ids")int[] ids);

	void editHospitalToNew(@Param("hospital")Hospital hospital);

	List<Hospital> getAllHospitals();

}
