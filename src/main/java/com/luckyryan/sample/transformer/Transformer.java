package com.luckyryan.sample.transformer;

import java.util.ArrayList;
import java.util.List;

import org.dozer.DozerBeanMapper;
import org.springframework.stereotype.Component;

import com.luckyryan.sample.dao.model.HostStatusInfo;
import com.luckyryan.sample.dao.model.UserCommand;
import com.luckyryan.sample.dto.HostStatusInfoDTO;
import com.luckyryan.sample.dto.UserCommandDTO;


@Component
public class Transformer {

    private DozerBeanMapper mapper = new DozerBeanMapper();

    public HostStatusInfo dtoToHostInfo(HostStatusInfoDTO dto) {
    	HostStatusInfo info = new HostStatusInfo();
    	info.setId(dto.getId());
    	info.setHostname(dto.getHostname());
    	info.setTotalMem(dto.getTotalMem());
    	info.setFreeMem(dto.getFreeMem());
    	info.setCpuTotalUsed(dto.getCpuTotalUsed());
    	info.setCpuCount(dto.getCpuCount());
    	info.setMacAddress(dto.getMacAddress());
    	
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
    	dto.setMacAddress(info.getMacAddress());
    	
    	// Add client command, This command is send by browser 
    	dto.setCommandStr("cmd /c tasklist");
    	
        return dto;
    }
    
    public Long stringToLong(String id) {
    	return Long.valueOf(id);
    }
    
    public String stringToStr(String str) {
    	return str;
    }
    
    public UserCommandDTO userCommandToDto(UserCommand info) {
    	
    	UserCommandDTO dto = mapper.map(info, UserCommandDTO.class);
        return dto;
    }
    
    public List<UserCommandDTO> userCmdListToDtoList(List<UserCommand> cmdList) {
    	List<UserCommandDTO> dtoList = new ArrayList<UserCommandDTO>();
    	for (UserCommand cmd : cmdList) {
    		dtoList.add(mapper.map(cmd, UserCommandDTO.class));
    	}
        return dtoList;
    }
    
    public UserCommand dtoToUserCommand(UserCommandDTO info) {
    	
    	UserCommand command = mapper.map(info, UserCommand.class);
        return command;
    }

}
