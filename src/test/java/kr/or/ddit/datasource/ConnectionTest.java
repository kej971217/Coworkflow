package kr.or.ddit.datasource;

import java.sql.Connection;
import java.sql.SQLException;

import javax.inject.Inject;
import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;

import kr.or.ddit.AbstractModelLayerTest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ConnectionTest extends AbstractModelLayerTest{
	@Inject
	private DataSource dataSource;
	
	@Inject
	private SqlSessionFactory factory;
	
	@Test
	public void testFactory() {
		log.info("주입된 sqlSessionFactory : {}", factory);
	}
	
	@Test
	public void test() throws SQLException {
		try(
			Connection conn = dataSource.getConnection();
		){
			log.info("주입된 dataSource의 연결객체 : {}", conn);
		}
	}
}







