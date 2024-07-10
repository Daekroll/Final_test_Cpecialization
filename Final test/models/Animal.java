package models;

import java.util.ArrayList;

public class Animal {
    private static int animalCount = 0;
    private String name;
    private String birthDate;
    private ArrayList<String> commands;

    public Animal(String name, String birthDate) {
        this.name = name;
        this.birthDate = birthDate;
        this.commands = new ArrayList<>();
        animalCount++;
    }

    public void addCommand(String command) {
        commands.add(command);
    }

    public ArrayList<String> getCommands() {
        return commands;
    }

    public String getName() {
        return name;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public static int getAnimalCount() {
        return animalCount;
    }
}