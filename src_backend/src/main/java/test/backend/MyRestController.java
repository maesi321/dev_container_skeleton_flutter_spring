package test.backend;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(produces = "application/json")
@CrossOrigin(origins = {"*"})
public class MyRestController {
    
    @GetMapping("/api/v1/hello")
    public Map<String, String> helloWorld() {
        final var response = new HashMap<String, String>();
        response.put("data", "Hello World");
        return response;
    }
}
