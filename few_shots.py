few_shots = [
{'Question': "how many remaining days to get leave for chamari fernando",
     'SQLQuery' : "SELECT SUM(remaining_days) FROM remaining_leaving_days WHERE employee_id = 'A0001'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "207"
     },
{'Question': "how many remaining days to get leave for Isuri Perera",
     'SQLQuery' : "SELECT SUM(remaining_days) FROM remaining_leaving_days WHERE employee_id = 'A0003'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "205"
     },
{'Question': "What is the department of Denuka Perera",
     'SQLQuery' : "SELECT name FROM departments WHERE department_id = (SELECT department_id FROM employees WHERE employee_id = 'A0002')",
     'SQLResult': "Result of the SQL query",
     'Answer' : "Human Resource"
     },

    {'Question': "Who is the supervisor of Dinuka Perera",
     'SQLQuery':"SELECT e.first_name , e.last_name  FROM employees e WHERE e.employee_id = (SELECT supervisor_id FROM employees WHERE employee_id = 'A0002')",
     'SQLResult': "Result of the SQL query",
     'Answer': "Chamari Fernando"},
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
     },
     {'Question': "Give me all employees names",
          'SQLQuery' : "SELECT first_name, last_name AS employee_name FROM employees",
          'SQLResult': "Result of the SQL query",
          'Answer' : "Chamari Fernando,Dinuka Perera,Isuri Silva,Janith	Karunaratne,Nethmi	Ratnayake,Pasan	Jayawardena,Dimalsha Wijeratne,Sahan Bandara,Sanduni Perera,Lahiru Dissanayake,Chathuri Gunasekara,Nisal Samarasekera,Shanika Mendis,Sankalpa Wickramasinghe,Thisari Jayasundara,Ashen Senanayake,Kavindya Alwis,Milinda Rajapaksa,Ruvini Peris,Buddhika Kodikara,Dinuka Perera"
          },
{'Question': "What is the pay grade level of Chamari Fernando",
          'SQLQuery' : "SELECT pay_grade FROM pay_grades WHERE pay_grade_id = ( SELECT pay_grade_id FROM employees WHERE employee_id = 'A0001')",
          'SQLResult': "Result of the SQL query",
          'Answer' : "Level 3"
          }


]