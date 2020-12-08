//
//  AuthMgr.swift
//  instagram
//
//  Created by Administrator on 12/6/20.
//

import FirebaseAuth

public class AuthMgr{
        
    static let shared = AuthMgr()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool)->Void){
        
        /*
         - Check if username is available
         - Check if email is available
         - Create account
         - Insert account to database
         */
        
        DatabaseMgr.shared.canCreateNewUser(with: email, username: username){canCreate in
            if canCreate{
                /*
                 - Create Account
                 - Insert account to database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else{
                        
                        //Firebase Auth could not create account
                        completion(false)
                        return
                    }
                    //insert into db
                    DatabaseMgr.shared.insertNewUser(with: email, username: username) { inserted in
                        
                        if inserted{
                            completion(true)
                            return
                        }
                        else{
                            completion(false)
                            return
                        }
                    }
                    
                }
            }
            else{
                //either username of email doesn't exist
                completion(false)
            }
            
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        
        if let email = email{
            //email login
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
            }
            
        }
        else if let username = username{
            //username login
            print(username)
        }
        
    }
    
    //Attempt to log out firebase user
    public func logOut(completion: (Bool) -> Void){
        do{
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            completion(false)
            print(error)
        }
    }


}
