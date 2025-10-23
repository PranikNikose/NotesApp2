package com.example.demo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NotesController {

    private List<String> notes = new ArrayList<>();

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("notes", notes);
        return "notes"; // corresponds to notes.jsp
    }

    @PostMapping("/addNote")
    public String addNote(@RequestParam String note) {
        notes.add(note);
        return "redirect:/";
    }

    @PostMapping("/deleteNote")
    public String deleteNote(@RequestParam String note) {
        notes.remove(note);
        return "redirect:/";
    }
}
