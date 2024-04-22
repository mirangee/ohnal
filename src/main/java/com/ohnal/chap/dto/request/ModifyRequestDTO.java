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



    public Member toEntity() {
        return Member.builder()
                .email(email)
                .nickname(nickname)
                .address(address)
                .gender(gender)
                .build();
    }

    public Member toEntity(PasswordEncoder encoder) {
        return Member.builder()
                .email(email)
                .nickname(nickname)
                .password(encoder.encode(password))
                .address(address)
                .gender(gender)
                .build();
    }

    public Member toEntity(String savePath) {
        return Member.builder()
                .email(email)
                .nickname(nickname)
                .address(address)
                .gender(gender)
                .profileImage(savePath)
                .build();
    }


    public Member toEntity(PasswordEncoder encoder, String savePath) {
        return Member.builder()
                .email(email)
                .password(encoder.encode(password))
                .nickname(nickname)
                .address(address)
                .nickname(nickname)
                .gender(gender)
                .profileImage(savePath)
                .build();
    }
}
