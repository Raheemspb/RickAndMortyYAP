//
//  YapManager.swift
//  RickAndMortyYAP
//
//  Created by Рахим Габибли on 01.08.2024.
//

import YapDatabase

class YapDatabaseManager {

    static let shared = YapDatabaseManager()

    private var database: YapDatabase
    private var connection: YapDatabaseConnection

    private init() {
        let databasePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/YapDatabase.sqlite")
        let databaseUrl = URL(fileURLWithPath: databasePath)
        let databaseOptions = YapDatabaseOptions()

        guard let databaseInstance = YapDatabase(url: databaseUrl, options: databaseOptions) else {
            fatalError("Failed to initialize YapDatabase")
        }

        database = databaseInstance
        connection = database.newConnection()
    }

    func saveCharacters(_ characters: [Character], completion: @escaping () -> Void) {
        connection.readWrite { transaction in

            for character in characters {
                let key = "\(character.id)"
                do {
                    let data = try JSONEncoder().encode(character)
                    transaction.setObject(data, forKey: key, inCollection: "characters")
                } catch {
                    print("Failed to encode character with ID \(character.id): \(error.localizedDescription)")
                }
            }
        }
            completion()
    }

    func fetchCharacters(completion: @escaping ([Character]) -> Void) {
        connection.read { transaction in
            var characters = [Character]()
            let allKeys = transaction.allKeys(inCollection: "characters")

            for key in allKeys {
                if let data = transaction.object(forKey: key, inCollection: "characters") as? Data {
                    do {
                        let character = try JSONDecoder().decode(Character.self, from: data)
                        characters.append(character)
                    } catch {
                        print("Ошибка при декодировании персонажа с ключом \(key): \(error.localizedDescription)")
                    }
                } else {
                    print("Объект с ключом \(key) не является типом Data.")
                }
            }
            completion(characters)
        }
    }
}
