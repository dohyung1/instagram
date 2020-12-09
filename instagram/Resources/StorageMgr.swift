//
//  StorageMgr.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import FirebaseStorage

public class StorageMgr{
        
    static let shared = StorageMgr()
    
    private let bucket = Storage.storage().reference()
    
    
    
    
    // MARK: - Public
    
    public func uploadUserPost(mode:UserPost, completion: @escaping (Result<URL,Error>) -> Void){
        
    }
    
    //When is @escaping used
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void){
        
        bucket.child(reference).downloadURL(completion: {url, error in
            guard let url = url, error == nil else{
                completion(.failure(.failedToDownload))
                return
                
            }
            
            completion(.success(url))
        })
                                
    }

}
public enum IGStorageManagerError : Error{
    case failedToDownload
}

public enum UserPostType{
    case photo,video
}

public struct UserPost{
    let postType:UserPostType
    
}


