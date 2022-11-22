public with sharing class UserController {
    
    @AuraEnabled(cacheable=true)
    public static List<User> getUsers() {
        List<User> UserList = [
            SELECT Id, Name, UserRole.Name
            FROM User
            WHERE City != null
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];
        return UserList;
    }

    @AuraEnabled(cacheable=true)
    public static List<UserRole> getRoles(){
        List<UserRole> RoleList = [
            SELECT Id, Name
            FROM UserRole
            WITH SECURITY_ENFORCED
            ORDER BY Name
        ];
        return RoleList;
    }

}

