package fun.ehe.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/start/**").addResourceLocations("classpath:/start/");
        registry.addResourceHandler("/backup/**").addResourceLocations("classpath:/backup/");
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {

    }

}
