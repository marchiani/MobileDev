//
//  CoreDataManager.swift
//  Dogomania
//
//  Created by SWAN mac on 23.05.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "movieCoreData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func updateMovie() {
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    
    func deleteMovie(movie: MovieCoreData) {
        
        persistentContainer.viewContext.delete(movie)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
    func getAllMovieCoreDatas() -> [MovieCoreData] {
        
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    func getMovieByID(imdbID: String) -> MovieCoreData? {
        
        let fetchRequest: NSFetchRequest<MovieCoreData> = MovieCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imdbID == %@", imdbID)
        fetchRequest.fetchLimit = 1
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)[0]
        } catch {
            return nil
        }
        
    }
    
    func getMovieDetailsByID(imdbID: String) -> MovieDetailsCoreData? {
        
        let fetchRequest: NSFetchRequest<MovieDetailsCoreData> = MovieDetailsCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "imdbID == %@", imdbID)
        fetchRequest.fetchLimit = 1
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)[0]
        } catch {
            return nil
        }
        
    }
    
    func saveMovieCoreData(movie: Movie) -> MovieCoreData {
        
        let newMovie = MovieCoreData(context: persistentContainer.viewContext )
        newMovie.imdbID = movie.imdbID
        newMovie.poster = movie.poster
        newMovie.title = movie.title
        newMovie.type = movie.type
        newMovie.year = movie.year
    
        do {
            try persistentContainer.viewContext.save()
            return newMovie
        } catch {
            print("Failed to save MovieCoreData \(error)")
            return newMovie
        }
    }
    
    func saveImageCoreData(image: Hit) -> ImageCoreData {
        
        let newImage = ImageCoreData(context: persistentContainer.viewContext )
        newImage.webURL = image.webformatURL
        newImage.imageID = String(image.id)
    
        do {
            try persistentContainer.viewContext.save()
            return newImage
        } catch {
            print("Failed to save MovieCoreData \(error)")
            return newImage
        }
    }
        
    
    func getAllImageCoreDatas() -> [ImageCoreData] {
        
        let fetchRequest: NSFetchRequest<ImageCoreData> = ImageCoreData.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    func saveMovieDetailsCoreData(movie: MovieData) -> MovieDetailsCoreData {
        
        let newMovie = MovieDetailsCoreData(context: persistentContainer.viewContext )
        newMovie.imdbID = movie.imdbID
        newMovie.poster = movie.poster
        newMovie.title = movie.title
        newMovie.type = movie.type
        newMovie.year = movie.year
        newMovie.actors = movie.actors
        newMovie.awards = movie.awards
        newMovie.boxOffice = movie.boxOffice
        newMovie.director = movie.director
        newMovie.genre = movie.genre
    
        do {
            try persistentContainer.viewContext.save()
            return newMovie
        } catch {
            print("Failed to save MovieCoreData \(error)")
            return newMovie
        }
    }
        
    
    func saveMoviesCoreData(movies: [Movie]) -> [MovieCoreData] {
        var newMovies :  [MovieCoreData] = []
        
        for movie in movies {
            let newMovie = MovieCoreData(context: persistentContainer.viewContext )
            newMovie.imdbID = movie.imdbID
            newMovie.poster = movie.poster
            newMovie.title = movie.title
            newMovie.type = movie.type
            newMovie.year = movie.year
            newMovies.append(newMovie)
        }
        
        do {
            try persistentContainer.viewContext.save()
            return newMovies
        } catch {
            print("Failed to save MovieCoreData \(error)")
            return []
        }
    }
    
}
