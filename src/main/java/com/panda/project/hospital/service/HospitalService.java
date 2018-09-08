package com.panda.project.hospital.service;

import java.util.List;

import com.panda.project.hospital.model.Hospital;

public interface HospitalService {

	List<Hospital> findPageHospitals(String name, String address, int page, int rows);

	int findAllHospitals();

	int findPartHospitals(String name,String address);

	Hospital findHospitalByUsercode(String hpcode);

	void addHospital(Hospital hospital);

	void editHospital(Hospital hospital);

	void deleteHospital(String ids);

	List<Hospital> getAllHospitals();

}
