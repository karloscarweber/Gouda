#  Cheddar Schema

Users, Stores, Tasks, Lists are the core data things that we got here. Because Cheddar data is offline by default, Stores is used to reference 

Users: literally just the single user that uses this app, but maybe more than one user for multiple accounts. (no plans for that at all)

Stores: A record of every remote and local store that we have access to, the keys associated with that store, the percieved permissions, etc... If you're logged in as yourself, there is only one store, if you link up with your personal account on cheddarapp.com, then you have 2 stores, One for local, and one for that remote. If you are part of a group or a member of a list or team, that is also listed in stores. It's considered a separate store.

Tasks: The basic record of Cheddar. It represents a to do item to be done. It can be completed, uncompleted, and archived. In the future Tasks will have a more robust neighbhor, documents. Which are just like longer documents or tasks. The data storage will basically be the same though. Tasks have a List ID as parent by default. Even though can have dynamic collection contents.

Lists: The main collection objects of Cheddar. Lists can be grouped, have members with various permissions (view, edit, admin, own), have their contents reordered, or even be comprised of tasks from across different stores and lists. For example. You can make a list titled #next, that groups every tasks that contain the #next tag. You can still add tasks to the compound list.

Asossociated data.
Users -> Members: Everyone that has general access to a user's space. Team spaces are just users. This is exposed through stores.
Lists -> Members: The members of a list. Usually a list of Users data. You can edit permissions here I guess.
Lists -> ListsUsersPositions: The positions of a user's lists, or the lists that they can see. Not synced between Stores.
Lists -> listsTasksPositions: The individual positions of elements in a list. Lists positions are globalized, why? because individual users can make compound lists that group data from all over the place and that other users can't see. Those lists will also use listsTasksPositions.
Lists -> Items: The item that a list has inside of it. like Tasks, and Documents, even other lists in some cases. Maybe use this instead of ListTasksPositions

******** Below are tables that We only have in client apps, servers shouldn't have these. *******
Users -> UsersStores: The stores that this user is associated with. 
Lists -> ListsStores:  The stores that this list is synced with. // This is unnecessary because Lists belong to users.
Tasks -> TasksStores: This table doesn't actually exist, if it's parent list is syncs with a store, then the task will sync with that store too. // Also unnecessary because Tasks belong to Users

Tokens: The access tokens associated with each store. Locally we don't need an access token. But each token should be securely stored and should reference a store. 

Users-> UsersStoresIds: The id of the user associated with a particular store. Like the remoteID. If the remoteID isn't present then that user isn't synced with that particular store. simple.
Lists -> ListsStoresIds: Remote IDs of the lists associated with a particular store. // unneccesary.
Tasks -> TasksStoresIds: Remote IDs of the tasks associated with a particular store. // Once again we don't need this because tasks belong to users.


## Users, Stores, Tasks, Lists: Schemas: 

User:
```
{
    id: Int,
    firstName: String,
    lastName: String,
    username: String,
    email: String,
    hasPlus: Bool,
    settings: String,
    features: String,
    
    // standardized, every record has them.
    createdAt: DateTime,
    updatedAt: DateTime
}
```

Stores:
```
{
    id: Int,
    url: String,
    remote: Bool,
    personal: Bool, (if you sync your personal stuff or not)
    
    // standardized, every record has them.
    createdAt: DateTime,
    updatedAt: DateTime
}
```

Tokens:
```
{
    id: Int,
    storeId: Int,
    userId: Int,
    token: String
    
    // standardized, every record has them.
    createdAt: DateTime,
    updatedAt: DateTime
}
```

Tasks:
```
{
    id: Int,
    text: String,
    displayText: String,
    completedAt: DateTime,
    archivedAt: DateTime,
    entities: String,
    
    
    // standardized, every record has them.
    createdAt: DateTime,
    updatedAt: DateTime
}
```

Lists:
```
{
    id: Int,
    userId: Int,
    title: String,
    archivedAt: DateTime,
    public: Bool

    // standardized, every record has them.
    createdAt: DateTime,
    updatedAt: DateTime
}
```

ListsUsersPositions:
```
{
    id: Int,
    listId: Int,
    userId: Int,
    position: Int,
}
```

ListsTasksPositions:
```
{
    id: Int,
    listId: Int,
    taskId: Int,
    position: Int
}
```


