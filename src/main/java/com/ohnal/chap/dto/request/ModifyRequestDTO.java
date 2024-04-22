package com.ohnal.chap.dto.request;

import com.ohnal.chap.entity.Member;
import com.ohnal.chap.entity.Member.LoginMethod;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.multipart.MultipartFile;

@Setter @Getter @ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class ModifyRequestDTO {


    private String email;

    private  String password;

    private String nickname;

    private String gender;

    private String address;

    private MultipartFile profileImage;
    
    private LoginMethod loginMethod;

    public Member toEntity(PasswordEncoder encoder, String savePath) {
        return Member.builder()
                .email(email)
                .password(encoder.encode(password))
                .nickname(nickname)
                .address(address)
                .nickname(nickname)
                .gender(gender)
                .profileImage(savePath)
                .loginMethod(loginMethod)
                .build();
    }
}
