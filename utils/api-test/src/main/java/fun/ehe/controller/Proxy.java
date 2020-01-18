package fun.ehe.controller;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import cn.net.bhe.utils.main.JacksonUtils;

@Controller
public class Proxy {

    static final Logger LOGGER = LoggerFactory.getLogger(Proxy.class);
    static ConcurrentMap<String, Object> session = new ConcurrentHashMap<>();

    private void addHeader(HttpServletRequest request, HttpPost post) {
        Enumeration<String> hnames = request.getHeaderNames();
        while (hnames.hasMoreElements()) {
            String hname = hnames.nextElement();
            String hvalue = request.getHeader(hname);
            if (hname.equalsIgnoreCase("Content-Length")) continue;
            post.setHeader(hname, hvalue);
        }
    }

    @PostMapping(value = { "/api/request", "/api/request/*" })
    @ResponseBody
    public String proxy(HttpServletRequest request) throws IOException {
        String requestBody = StreamUtils.copyToString(request.getInputStream(), StandardCharsets.UTF_8);
        JsonNode jsonNode = JacksonUtils.getObjectMapper().readTree(requestBody);
        String result = "";
        CloseableHttpClient client = HttpClients.createDefault();
        String targetUrl = jsonNode.get("url").toString().replace("\"", "");
        if (targetUrl.contains("stat")) {
            targetUrl = "http://127.0.0.1:9090/" + targetUrl;
        } else {
            targetUrl = "http://127.0.0.1:8080/" + targetUrl;
        }
        HttpPost post = new HttpPost(targetUrl);
        try {
            String payload = jsonNode.get("reqdata").toString();
            StringEntity se = new StringEntity(payload, Charset.forName("UTF-8"));
            addHeader(request, post);
            post.setEntity(se);
            HttpResponse rs = client.execute(post);
            if (rs.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                result = EntityUtils.toString(rs.getEntity());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (client != null) {
                    client.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    @PostMapping("/api/user/login")
    @ResponseBody
    public String registerSession(HttpServletRequest request) throws IOException {
        String requestBody = StreamUtils.copyToString(request.getInputStream(), StandardCharsets.UTF_8);
        JsonNode jsonNode = JacksonUtils.getObjectMapper().readTree(requestBody);
        session.put(request.getSession().getId(), jsonNode);
        return "";
    }

    @PostMapping("/api/user/auth")
    @ResponseBody
    public String userAuth(HttpServletRequest request) {
        JsonNode jsonNode = (JsonNode) session.get(request.getSession().getId());
        String response = null;
        if (jsonNode != null) {
            response = "{\"rst\":200, \"user\":" + jsonNode.get("user") + "}";
        }
        LOGGER.info(response);
        return response;
    }

    @PostMapping("/api/user/logout")
    @ResponseBody
    public String sessionInvalidate(HttpServletRequest request) {
        session.remove(request.getSession().getId());
        return "";
    }
}
