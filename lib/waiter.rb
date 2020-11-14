
class Waiter

    attr_accessor :name, :yrs_experience

    @@all = []

    def initialize(name, yrs_experience)
        self.name = name
        self.yrs_experience = yrs_experience
        self.class.all << self
    end

    def self.all
        @@all
    end

    def new_meal(customer, total, tip=0)
        Meal.new(self, customer, total, tip)
    end

    def meals
        Meal.all.select {|meal| meal.waiter == self}
    end

    def best_tipper
        best_tipped_meal = meals.max do |meal_a, meal_b|
            meal_a.tip <=> meal_b.tip
        end
        best_tipped_meal.customer
    end

    # Practice

    def customers
        meals.collect {|meal| meal.customer}
    end

    def most_frequent_customer
        customers.max_by {|name| customer.count(name)}
    end

    def tips
        meals.collect {|meal| meal.tip}
    end

    def meal_with_worst_tip
        meals.detect {|meal| meal.tip == tips.min}
    end

    def self.least_experienced_waiter
        experience_levels = self.class.all.collect do |waiter|
            waiter.yrs_experience
        end
        lowest_level = experience_levels.min
        self.class.all.detect do |waiter|
            waiter.yrs_experience == lowest_level
        end
    end

    def self.most_experienced_waiter
        experience_levels = self.class.all.collect do |waiter|
            waiter.yrs_experience
        end
        highest_level = experience_levels.max
        self.class.all.detect do |waiter|
            waiter.yrs_experience == highest_level
        end
    end

    def self.avg_tips_by_experience
        low_exp_tips = least_experienced_waiter.tips
        low = low_exp_tips.inject {|sum, tip| sum + tip}.to_f / low_exp_tips.size

        high_exp_tips = most_experienced_waiter.tips
        high = high_exp_tips.inject {|sum, tip| sum + tip}.to_f / high_exp_tips.size

        "Avg. Tip For Rookie: $#{low}, Avg. Tip For Expert: $#{high}"
    end
end

