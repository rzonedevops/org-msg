# Microsoft Graph SDK for iOS Overview

The Microsoft Graph SDK for iOS is designed to look just like the [Microsoft Graph API](https://github.com/onedrive/onedrive-api-docs/).  

## MSGraphClient

When accessing the Microsoft Graph APIs, all requests will be made through a MSGraphClient object.

## Requests

To make requests against the service, you construct Request objects using RequestBuilder objects depending on the calls you are making. This is meant to mimic creating the URL for any of the Microsoft Graph APIs.

### 1. Request builders

To generate a Request, you chain together calls on request builder objects. You get the first request builder from the `MSGraphClient` object. To get a drive request builder you call:

|Task            | SDK                       | URL                                   |
|:---------------|:-------------------------:|:--------------------------------------|
|Get 'my' drive  | [[graphClient me] drive]  | GET graph.microsoft.com/v1.0/me/drive/|
 
The call will return a `MSGraphDriveRequestBuilder` object. From drive we can continue to chain the requests to get everything else in the API, like an item.

|Task            | SDK                                        | URL                                             |
|:---------------|:------------------------------------------:|:------------------------------------------------|
|Get an item     | [[[graphClient me] drive] items:@"1234"]   | GET graph.microsoft.com/v1.0/me/drive/items/1234|


Here `[[graphClient me] drive]` returns an `MSGraphDriveRequestBuilder` that contains a method `items:` to get an `MSGraphDriveItemRequestBuilder`.


### 2. Request calls

Once you have constructed the request you call the `request` method on the request builder. This will construct the request object needed to make calls against the service.

For a drive item you call:

```objc
MSGraphDriveItemRequest *itemRequest = [[[[graphClient me] drive] items:<item_id>] request];
```

All request builders have a `request` method that can generate a `MSRequest` object. Request objects may have different methods on them depending on the type of request. To get an item you call:

```objc
[itemRequest getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    // This will make the network request and return the item
    // or an error if there was one
}];
```

You could also chain this together with the call above:
```objc
[[[[[graphClient me] drive] items:<item_id>] request] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){

}];
```

See [items](/docs/items.md) for more info on items and [errors](/docs/errors.md) for more info on errors.

## Query options

If you only want to retrieve certain properties of a resource you can select them. Here's how to get only the names and ids of an item:

```objc
[[[[[[graphClient me] drive] items:<item_id>] request] select:@"name,id"] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    // the item object will have nil properties for everything except name and id
}];

```
To expand certain properties on resources you can call a similar expand method, like this:

```objc
[[[[[[graphClient me] drive] items:<item_id>] request] expand:@"thumbnails"] getWithCompletion:^(MSGraphDriveItem *item, NSError *error){
    // the item object will have a non nil thumbnails property if thumbnails exist.
}];

```
