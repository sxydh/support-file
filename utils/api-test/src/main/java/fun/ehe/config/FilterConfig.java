package fun.ehe.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import fun.ehe.servlet.CORSFilter;
import fun.ehe.servlet.GateFilter;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<GateFilter> gateFilter() {
        FilterRegistrationBean<GateFilter> filterRegistrationBean = new FilterRegistrationBean<>();
        GateFilter gateFilter = new GateFilter();
        List<String> urlPatterns = new ArrayList<String>();
        urlPatterns.add("/*");
        filterRegistrationBean.setFilter(gateFilter);
        filterRegistrationBean.setName(gateFilter.getClass().getSimpleName());
        filterRegistrationBean.setOrder(0);
        filterRegistrationBean.setUrlPatterns(urlPatterns);
        return filterRegistrationBean;
    }

    @Bean
    public FilterRegistrationBean<CORSFilter> CORSFilter() {
        FilterRegistrationBean<CORSFilter> filterRegistrationBean = new FilterRegistrationBean<>();
        CORSFilter CORSFilter = new CORSFilter();
        List<String> urlPatterns = new ArrayList<String>();
        urlPatterns.add("/*");
        filterRegistrationBean.setFilter(CORSFilter);
        filterRegistrationBean.setName(CORSFilter.getClass().getSimpleName());
        filterRegistrationBean.setOrder(1);
        filterRegistrationBean.setUrlPatterns(urlPatterns);
        return filterRegistrationBean;
    }

}
