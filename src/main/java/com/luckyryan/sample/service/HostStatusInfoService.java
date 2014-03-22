package com.luckyryan.sample.service;

import com.luckyryan.sample.dao.model.HostStatusInfo;
import com.luckyryan.sample.exception.InvalidUserException;

public interface HostStatusInfoService {
	public HostStatusInfo saveInfo(HostStatusInfo user) throws InvalidUserException;
	public HostStatusInfo getInfo(Long id) throws InvalidUserException;
}
