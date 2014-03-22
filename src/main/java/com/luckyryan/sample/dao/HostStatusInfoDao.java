package com.luckyryan.sample.dao;

import org.springframework.data.repository.CrudRepository;
import com.luckyryan.sample.dao.model.HostStatusInfo;

public interface HostStatusInfoDao extends CrudRepository<HostStatusInfo,Long> {
}
