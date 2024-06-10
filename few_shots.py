few_shots = [
    {'Question' : "How many employees are in the Operations department?",
     'SQLQuery' : "SELECT COUNT(*) FROM employees WHERE department_id = 3",
     'SQLResult': "Result of the SQL query",
     'Answer' : "7"},
    {'Question': "Who is the supervisor of Chamari",
     'SQLQuery':"SELECT e.first_name || ' ' || e.last_name AS supervisor_name FROM employees e WHERE e.employee_id = (SELECT supervisor_id FROM employees WHERE employee_id = 'A0001')",
     'SQLResult': "Result of the SQL query",
     'Answer': "Dinuka Perera"},
    {'Question': "How many remaining leavings for Chamari" ,
     'SQLQuery' : "SELECT remaining_days FROM remaining_leaving_days WHERE employee_id = 'A0001'",
     'SQLResult': "Result of the SQL query",
     'Answer': "17" } ,
     {'Question' : "What is the reason to take free days by chamari on january 01" ,
      'SQLQuery': "SELECT reason FROM leave_requests WHERE employee_id = 'A0001' AND leave_start_date = '2023-01-01'",
      'SQLResult': "Result of the SQL query",
      'Answer' : "Family event"},
    {'Question': "How many disapproved leaves until now",
     'SQLQuery' : "SELECT COUNT(*) AS `disapproved_leaves` FROM leave_requests WHERE approved = 0",
     'SQLResult': "Result of the SQL query",
     'Answer' : "4"
     },
    {'Question': "How many approved leaves until now",
     'SQLQuery' : "SELECT COUNT(*) AS `approved_leaves` FROM leave_requests WHERE approved = 1",
     'SQLResult': "Result of the SQL query",
     'Answer' : "5"
     }

]