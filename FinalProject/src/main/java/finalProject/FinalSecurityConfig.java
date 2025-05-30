package finalProject;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.stereotype.Component;

@Component
public class FinalSecurityConfig {
	//security에 의한 로그인 화면을 사용하지 않게 설정
		@Bean
		public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
			System.out.println("fsdvsdxbdb");
			return http.formLogin().disable().csrf().disable().build();
		}
}