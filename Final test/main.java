import java.util.Scanner;
import controller.*;
import models.Animal;

public class main {
    public static void main(String[] args) {
        PetRegistry registry = new PetRegistry();
        
        String input;
        try (Scanner scanner = new Scanner(System.in);) {
            do {
                System.out.println("1. Add new animal");
                System.out.println("2. List commands of an animal");
                System.out.println("3. Teach new command to an animal");
                System.out.println("4. List animals by birth date");
                System.out.println("5. Show total number of animals");
                System.out.println("0. Exit");
                System.out.print("Enter option: ");
                input = scanner.nextLine();
                switch (input) {
                    case "1":
                        registry.addAnimal();
                        break;
                    case "2":
                        System.out.println("Input name: ");
                        input = scanner.nextLine();
                        registry.listCommands(input);
                        break;
                    case "3":
                        System.out.println("Input name and command with space: ");
                        input = scanner.nextLine();
                        String name = input.split(" ")[0];
                        String command = input.split(" ")[1];
                        registry.teachCommand(name, command);
                        break;
                    case "4":
                        registry.listAnimalsByBirthDate();
                        break;
                    case "5":
                        // Показать общее количество животных
                        System.out.println("Total number of animals: " + Animal.getAnimalCount());
                        break;
                    case "0":
                        System.out.println("Exiting...");
                        break;
                    default:
                        System.out.println("Invalid option. Please try again.");
                        break;
                }
            } while (!input.equals("0"));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        
    }
}
