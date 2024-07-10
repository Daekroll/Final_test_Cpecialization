package controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Scanner;

import models.Animal;
import models.Camel;
import models.Cat;
import models.Dog;
import models.Donkey;
import models.Hamster;
import models.Horse;

public class PetRegistry {
    private ArrayList<Animal> animals;

    public PetRegistry() {
        animals = new ArrayList<>();
    }

    public void addAnimal() {
        try (Scanner scanner = new Scanner(System.in);) {
            System.out.print("Введите тип животного (Dog, Cat, Hamster, Horse, Camel, Donkey): ");
            String type = scanner.nextLine();
            System.out.print("Введите имя животного: ");
            String name = scanner.nextLine();
            System.out.print("Введите дату рождения животного (dd/MM/yyyy): ");
            String birthDate = scanner.nextLine();

            Animal animal;
            switch (type.toLowerCase()) {
                case "dog":
                    animal = new Dog(name, birthDate);
                    break;
                case "cat":
                    animal = new Cat(name, birthDate);
                    break;
                case "hamster":
                    animal = new Hamster(name, birthDate);
                    break;
                case "horse":
                    animal = new Horse(name, birthDate);
                    break;
                case "camel":
                    animal = new Camel(name, birthDate);
                    break;
                case "donkey":
                    animal = new Donkey(name, birthDate);
                    break;
                default:
                    System.out.println("Неизвестный тип животного. Попробуйте снова.");
                    return;
            }
            animals.add(animal);
            System.out.println("Животное добавлено: " + animal.getName());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public void listCommands(String name) {
        for (Animal animal : animals) {
            if (animal.getName().equals(name)) {
                System.out.println("Commands for " + name + ": " + animal.getCommands());
                return;
            }
        }
        System.out.println("Animal not found.");
    }

    public void teachCommand(String name, String command) {
        for (Animal animal : animals) {
            if (animal.getName().equals(name)) {
                animal.addCommand(command);
                System.out.println(name + " has learned the command: " + command);
                return;
            }
        }
        System.out.println("Animal not found.");
    }

    public void listAnimalsByBirthDate() {
        Collections.sort(animals, Comparator.comparing(Animal::getBirthDate));
        for (Animal animal : animals) {
            System.out.println(animal.getName() + " - " + animal.getBirthDate());
        }
    }
    
}