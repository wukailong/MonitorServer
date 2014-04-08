package com.luckyryan.sample.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luckyryan.sample.dao.HostStatusInfoDao;
import com.luckyryan.sample.dao.model.HostStatusInfo;
import com.luckyryan.sample.exception.InvalidUserException;

@Service("hostStatusInfoService")
public class HostStatusInfoServiceImpl implements HostStatusInfoService {

	@Autowired
	private HostStatusInfoDao dao;
	
	public HostStatusInfo saveInfo(HostStatusInfo info)
			throws InvalidUserException {
		
		if(info == null) {
            throw new InvalidUserException("Sorry Dave");
        }
		
		HostStatusInfo host = dao.getHostByMacAddress(info.getMacAddress());
		if (host != null && host.getId() != null) {
			info.setId(host.getId());
		}
		
        return dao.save(info);
	}

	public HostStatusInfo getInfo(Long id) throws InvalidUserException {
		if(id == null) {
            throw new InvalidUserException("Sorry Dave");
        }
		
		return dao.findOne(id);
	}

	public HostStatusInfo getHostByMacAddress(String macAddress) throws InvalidUserException {
		
		return dao.getHostByMacAddress(macAddress);
	}

	public List<HostStatusInfo> getAll(Long userId) throws InvalidUserException {
		
		return dao.getAll();
	}
}
