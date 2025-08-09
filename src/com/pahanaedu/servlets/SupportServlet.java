package com.pahanaedu.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/support")
public class SupportServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (isBlank(name) || isBlank(email) || isBlank(subject) || isBlank(message)) {
            request.setAttribute("supportError", "Please fill in all fields.");
            request.getRequestDispatcher("/help.jsp").forward(request, response);
            return;
        }

        // In real app: send email or persist the ticket. Here we just log.
        System.out.println("[Support] From=" + name + " <" + email + ">, Subject=" + subject + ", Message=" + message);

        request.setAttribute("supportSuccess", "Your request has been sent. We'll get back to you shortly.");
        request.getRequestDispatcher("/help.jsp").forward(request, response);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}


