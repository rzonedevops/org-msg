Drive Items in the Microsoft Graph SDK for iOS
=====

Drive Items in the Microsoft Graph SDK for iOS behave just like drive items through the API.

The examples below assume that you have [Authenticated](/docs/auth.md) your MSGraphClient instance.

* [Get an Item](#get-an-item)
* [Delete an Item](#delete-an-item)
* [Get Children for an Item](#get-children-for-an-item)
* [Downloading and uploading contents](#downloading-and-uploading-contents)
* [Moving and updating an Item](#moving-and-updating-an-item)

Get an Item
---------------
### 1. By ID

```objc
[[[[[graphClient me] drive] items:<item_id>] request] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    //Returns a MSGraphDriveItem object or an error if there was one.
}];
```

### 2. By path

```objc
[[[[graphClient me] drive] items:@"root"] itemByPath:@"Documents/Foo.txt"] request] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    //Returns a MSGraphDriveItem object or an error if there was one.
}];

```

Access an item by path from a folder item:

```objc
[[[[[graphClient me] drive] items:<item_id>] itemByPath:@"relative/path/to/file.txt"] request] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    //Returns a MSGraphDriveItem object or an error if there was one.
}];

```

Delete an Item
---------------
```objc
[[[[[graphClient me] drive] items:<item_id>] request] deleteWithCompletion:^(NSError *error){
    //Returns an error if there was one.
}];

```

Get Children for an Item
-------------------------

More info about collections [here](/docs/collections.md).

```objc
[[[[[graphClient me] drive] items:<item_id>] children] getWithCompletion:
    ^(MSCollection *children, MSGraphDriveItemChildrenCollectionRequest *nextRequest, NSError *error){
        // Returns a MSCollection,
        // another children request if there are more children to get,
        // and an error if one occurred.
    }];
```

Downloading and uploading contents
------------------------------

```objc
MSGraphDriveItemContentRequest *request = [[[[graphClient me] drive] items:<item_id>] contentRequest];

[request downloadWithCompletion:^(NSURL *filePath, NSURLResponse *urlResponse, NSError *error){
   // The file path to the item on disk. This is a temporary file and will be removed
   // after the block is done executing.
}];

[request uploadFromFile:<file_path> completion:^(MSGraphDriveItem *item, NSError *error){
    // Returns the item that was just uploaded.
}];

[request uploadFromData:<data_object> completion:*(MSGraphDriveItem *item, NSError *error){
    // Returns the item that was just uploaded from memory.
}];

```
Upload and download requests return an MSURLSessionProgressTask, which contain an NSProgress object to monitor.

Moving and updating an Item
--------------
To [move](https://dev.onedrive.com/items/move.htm) an item you must update its parent reference.

```objc
MSGraphDriveItem *updatedItem = [MSGraphDriveItem alloc] init];
updatedItem.id = <item_id>;
updatedItem.parentReference = [MSGraphItemReference alloc] init];
updatedItem.parentReference.id = <new_parent_id>;

[[[[[graphClient me] drive] items:updatedItem.id] request] update:updatedItem withCompletion:
    ^(MSGraphDriveItem *newItem, NSError *error){

}];
```

To change an item's name or other property you could:

```objc
MSGraphDriveItem *updatedItem = [MSGraphDriveItem alloc] init];
updatedItem.id = <item_id>;
updatedItem.name = @"New Item Name!";

[[[[[graphClient me] drive] items:updatedItem.id] request] update:updatedItem withCompletion:
    ^(MSGraphDriveItem *newItem, NSError *error){

}];

```
