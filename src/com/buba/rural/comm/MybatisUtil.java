package com.buba.rural.comm;

import java.io.InputStream;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisUtil {
	private static SqlSessionFactory sqlSessionFactory = null;
	static{
		InputStream inputStream = MybatisUtil.class.
				getResourceAsStream("/mybatis-config.xml");
		sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
	}
	public static SqlSession getSqlSession(){
		return sqlSessionFactory.openSession();
	}
	public static void closeSession(SqlSession sqlSession){
		if(sqlSession != null){
			sqlSession.close();
		}
	}
}
