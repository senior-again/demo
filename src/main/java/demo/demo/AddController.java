package demo.demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Slf4j
public class AddController {

    @GetMapping("/sum/{a}/{b}")
    public String add(@PathVariable int a, @PathVariable int b){
        log.info("a+b = {}",a+b);
        return "ok";
    }

}

