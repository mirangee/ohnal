package com.ohnal.chap.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface WeatherMapper {
    Map<String, Object> getCode(@Param("area1") String area1, @Param("area2") String area2);
}
