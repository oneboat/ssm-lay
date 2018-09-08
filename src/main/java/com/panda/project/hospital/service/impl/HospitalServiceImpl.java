package com.panda.project.hospital.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.panda.project.hospital.dao.HospitalMapper;
import com.panda.project.hospital.model.Hospital;
import com.panda.project.hospital.service.HospitalService;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService{
	@Resource
	private HospitalMapper hospitalMapper;
	@Override
	public List<Hospital> findPageHospitals(String name, String addresss, int page, int rows) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("address", addresss);
		map.put("name", name);
		map.put("start", rows*(page-1));
		map.put("end", rows);
		return hospitalMapper.findPageHospitals(map);
	}

	@Override
	public int findAllHospitals() {
		// TODO Auto-generated method stub
		return hospitalMapper.findAllHospitals();
	}

	@Override
	public int findPartHospitals(String name,String address) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("name", name);
		map.put("address", address);
		return hospitalMapper.findPartHospitals(map);
	}

	@Override
	public Hospital findHospitalByUsercode(String hpcode) {
		// TODO Auto-generated method stub
		return hospitalMapper.findHospitalByUsercode(hpcode);
	}

	@Override
	public void addHospital(Hospital hospital) {
		// TODO Auto-generated method stub
		hospitalMapper.addHospital(hospital);
	}

	@Override
	public void editHospital(Hospital hospital) {
		// TODO Auto-generated method stub
		hospitalMapper.editHospitalToNew(hospital);
	}

	@Override
	public void deleteHospital(String ids) {
		// TODO Auto-generated method stub
		String [] arrayStr = ids.split(",");
		int[] arrInt = new int[arrayStr.length];
		for(int i=0;i<arrayStr.length;i++) {
			arrInt[i] = Integer.parseInt(arrayStr[i]);
		}
		hospitalMapper.deleteHospital(arrInt);
	}

	@Override
	public List<Hospital> getAllHospitals() {
		// TODO Auto-generated method stub
		return hospitalMapper.getAllHospitals();
	}

}
