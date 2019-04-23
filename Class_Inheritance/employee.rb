class Employee
    attr_accessor :salary
    
    def initialize(name,title,salary,boss)
        @name = name
        @title = title
        @salary = salary
        @boss =boss

    end

    def bonus(multiplier)
        #How the employee bonus is calculated: bonus = (employee salary) * multiplier
        self.salary * multiplier
    end
    
end


class Manager < Employee
    attr_accessor :employees
    def initialize(name,title,salary,boss=nil, employees)
        @employees = employees
        super(name,title,salary,boss)

    end

    def calculate_subemployee_salaries
        sum = 0
        self.employees.each do |employee|
        # if the employee is a manager, 
            if employee.is_a?(Manager)
                sum+= employee.salary + employee.calculate_subemployee_salaries
                # sum += employee.salary + employee.calculate_subemployee_salaries
            else
                sum+= employee.salary
            end
        end
        sum
    end

    def bonus(multiplier)
        #How the manager bonus is calculated: bonus = (total salary of all sub-employees) * multiplier 
        self.calculate_subemployee_salaries * multiplier
    end

end

david  = Employee.new("David", "TA", 10000, "darren")
shawna  = Employee.new("Shawna", "TA", 12000, "darren")
darren = Manager.new("Darren", "TA Manager", 78000, "ned", [david, shawna])
ned = Manager.new("Ned", "Founder", 1000000, nil, [darren])

puts ned.bonus(5)
puts darren.bonus(4)
puts david.bonus(3)