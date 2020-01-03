package fun.ehe.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class Test {

    static final Logger LOGGER = LoggerFactory.getLogger(Test.class);

    @PostMapping("/postWithForm")
    @ResponseBody
    public String postWithForm(HttpServletRequest request, Payload payload) {
        System.out.printf("%-10s%s%n", "data:", payload.getData());
        System.out.printf("%-10s%s%n", "remark:", payload.getRemark());
        return "";
    }

    @PostMapping("/postWithJson")
    @ResponseBody
    public String postWithJson(HttpServletRequest request, @RequestBody Payload payload) {
        System.out.printf("%-10s%s%n", "data:", payload.getData());
        System.out.printf("%-10s%s%n", "remark:", payload.getRemark());
        return "";
    }

    @GetMapping("/get")
    @ResponseBody
    public String get(HttpServletRequest request, @RequestParam Integer id) {
        System.out.printf("%-10s%s%n", "data:", id);
        return "";
    }

}

class Payload {
    private String data;
    private String remark;

    public String getData() {
        return data;
    }

    public String getRemark() {
        return remark;
    }

    public void setData(String data) {
        this.data = data;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

}
