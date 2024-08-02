package com.ohnal.chap.mapper;

import com.ohnal.chap.dto.request.AutoLoginDTO;
import com.ohnal.chap.entity.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface MemberMapper {

    void save(Member member);

    Member findMember(String email);

    void changePw(@Param("email") String email, @Param("password") String password);

    boolean isDuplicate(@Param("type")String type,@Param("keyword")String keyword);
    void saveAutoLogin(AutoLoginDTO build);

    Member findMemberByCookie(String sessionId);

    void modify(Member member);

    void modifyProfileImage(@Param("email") String email, @Param("profileImage") String savePath);
}
