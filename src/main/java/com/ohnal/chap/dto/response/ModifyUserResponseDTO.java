package com.ohnal.chap.dto.response;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Setter @Getter @ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode
public class ModifyUserResponseDTO {

    private String email;

    private String nickname;

    private String address;

    private String gender;

    private String profileImage;

    private String loginMethod;

    private String regDate;
}
