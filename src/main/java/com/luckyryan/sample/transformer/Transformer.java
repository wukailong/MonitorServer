package com.luckyryan.sample.transformer;

import org.springframework.stereotype.Component;

import com.luckyryan.sample.dao.model.HostStatusInfo;
import com.luckyryan.sample.dto.HostStatusInfoDTO;

@Component
public class Transformer {

//    private DozerBeanMapper mapper = new DozerBeanMapper();

    public HostStatusInfo dtoToHostInfo(HostStatusInfoDTO dto) {
    	HostStatusInfo info = new HostStatusInfo();
    	info.setId(dto.getId());
    	info.setHostname(dto.getHostname());
    	info.setTotalMem(dto.getTotalMem());
    	info.setFreeMem(dto.getFreeMem());
    	info.setCpuTotalUsed(dto.getCpuTotalUsed());
    	info.setCpuCount(dto.getCpuCount());
    	
        return info;
    }

    public HostStatusInfoDTO hostInfoToDto(HostStatusInfo info) {
    	
    	HostStatusInfoDTO dto = new HostStatusInfoDTO();
    	dto.setId(info.getId());
    	dto.setHostname(info.getHostname());
    	dto.setTotalMem(info.getTotalMem());
    	dto.setFreeMem(info.getFreeMem());
    	dto.setCpuTotalUsed(info.getCpuTotalUsed());
    	dto.setCpuCount(info.getCpuCount());
    	
    	// Add client command, This command is send by browser 
    	dto.setCommandStr("cmd /c tasklist");
    	
        return dto;
    }
    
    public Long stringToLong(String id) {
    	return Long.valueOf(id);
    }

}
