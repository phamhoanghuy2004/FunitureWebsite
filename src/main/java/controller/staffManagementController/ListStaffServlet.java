package controller.staffManagementController;


import DAO.StaffDAO;
import business.Staff;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@MultipartConfig
@WebServlet("/listStaff")
public class ListStaffServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Kiểm tra phân quyền: chỉ cho phép owner (admin) truy cập
        Object ownerObj = session.getAttribute("owner");
        if (ownerObj == null) {
            // Chưa đăng nhập hoặc không phải owner → redirect về trang login
            response.sendRedirect(request.getContextPath() + "/KhachHang/login.jsp");
            return;
        }

        List<Staff> listStaff = (List<Staff>) session.getAttribute("listStaff");
        if (listStaff == null) {
            listStaff = StaffDAO.getAllStaffs();
            session.setAttribute("listStaff", listStaff);
        }
        request.setAttribute("listStaff", listStaff);
        request.getRequestDispatcher("/Admin/listStaff.jsp").forward(request, response);
    }
}
