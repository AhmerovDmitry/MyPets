//
//  PetInfoModel.swift
//  MyPets
//
//  Created by Дмитрий Ахмеров on 13.08.2021.
//

import UIKit

struct PetInfoModel {
    // MARK: - Properties
    /// Массив со стройками которые заполняют тайтл ячейки таблицы
    let menuTitles = [
        "Кличка",
        "Вид",
        "Порода",
        "Дата рождения",
        "Вес, кг",
        "Стерилизация",
        "Окрас",
        "Шерсть",
        "Номер чипа"
    ]
    /// Массив параметров который заполняется по мере заполнения информации
    /// Создан для удобства
    /// чтобы тут же в файле модели можно было его разобрать по индексам
    /// в объект класса Pet и не делать это в контроллере
    private(set) var petInformation: [String?] = [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil]
    private(set) var defaultEntity = Pet()
    private let nilEntity = Pet()
    // MARK: - Methods
    /// Функция которая заполняет массив информации об объекте
    mutating func updateInformation(_ info: String, index: Int) {
        petInformation[index] = info
        if info.isEmpty {
            petInformation[index] = nil
        }
    }
    /// Подготовка модели данных к сохранению
    mutating func prepareObjectForSave() {
        defaultEntity.name = petInformation[0]
        defaultEntity.kind = petInformation[1]
        defaultEntity.breed = petInformation[2]
        defaultEntity.birthday = petInformation[3]
        defaultEntity.weight = petInformation[4]
        defaultEntity.sterile = petInformation[5]
        defaultEntity.color = petInformation[6]
        defaultEntity.hair = petInformation[7]
        defaultEntity.chipNumber = petInformation[8]
        defaultEntity.image = petInformation[9]
    }
    /// Сохранение модели в CoreData
    mutating func saveEntityInCoreData() {
        prepareObjectForSave()
        if defaultEntity != nilEntity {
            CoreDataManager.shared.createEntity(defaultEntity)
        }
    }
    /// Удаление модели из CoreData
    func removeEntityFromCoreData(at index: Int) {
        CoreDataManager.shared.deleteEntity(at: index)
    }
    /// Редактирование модели
    mutating func editingEntity(at index: Int) {
        prepareObjectForSave()
        if defaultEntity != nilEntity {
            CoreDataManager.shared.deleteEntity(at: index)
            CoreDataManager.shared.createEntity(defaultEntity)
        } else {
            CoreDataManager.shared.deleteEntity(at: index)
        }
    }
    /// Заполнение массива информации при открытии существующего питомца
    mutating func loadEntity(at index: Int) {
        let entity = CoreDataManager.shared.pets[index]
        petInformation[0] = entity.name
        petInformation[1] = entity.kind
        petInformation[2] = entity.breed
        petInformation[3] = entity.birthday
        petInformation[4] = entity.weight
        petInformation[5] = entity.sterile
        petInformation[6] = entity.color
        petInformation[7] = entity.hair
        petInformation[8] = entity.chipNumber
        petInformation[9] = entity.image
    }
}
