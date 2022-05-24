
class Hero():
    """Class to Create Hero for our Game"""
    def __init__(self,name,level,race):
        """initiate our hero"""
        self.name = name 
        self.level = level
        self.race = race 
        self.health = 100
    
    def show_hero(self):
        """print all parameters of this hero"""
        discription = (self.name + " level is: " + str(self.level) + " Race is: " + self.race + " health is " + str(self.health).title())
        print(discription)

    def level_up(self):
        self.level += 1

    def move(self):
        print("hero " + self.name + " start moving...")


myhero = Hero("vurdalak", 5 , "ork")
myhero1 = Hero("alexandr", 4 , "Human")

myhero.show_hero()
myhero1.move()
myhero.level_up()
myhero.show_hero()
        