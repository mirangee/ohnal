package com.ohnal.chap.common;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
@EqualsAndHashCode
public class Search extends Page {
    
    // 검색 조건, 검색어
    private String keyword;
    
    public Search() {
        this.keyword = "";
    }
    
    
    
}
