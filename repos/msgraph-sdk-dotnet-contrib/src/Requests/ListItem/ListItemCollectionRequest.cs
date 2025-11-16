using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Graph;

namespace Graph.Community
{
  public class ListItemCollectionRequest : BaseSharePointAPIRequest, IListItemCollectionRequest
  {
    public ListItemCollectionRequest(
      string requestUrl,
      IBaseClient client,
      IEnumerable<Option> options)
      : base("ListItem", requestUrl, client, options)
    {
      this.Headers.Add(new HeaderOption(SharePointAPIRequestConstants.Headers.AcceptHeaderName, SharePointAPIRequestConstants.Headers.AcceptHeaderValue));
      this.Headers.Add(new HeaderOption(SharePointAPIRequestConstants.Headers.ODataVersionHeaderName, SharePointAPIRequestConstants.Headers.ODataVersionHeaderValue));
    }

    public async Task<IListItemCollectionPage> GetAsync()
    {
      return await this.GetAsync(CancellationToken.None);
    }

    public async Task<IListItemCollectionPage> GetAsync(CancellationToken cancellationToken)
    {
      this.ContentType = "application/json";
      var response = await this.SendAsync<SharePointAPICollectionResponse<IListItemCollectionPage>>(null, cancellationToken).ConfigureAwait(false);

      if (response?.Value?.CurrentPage != null)
      {
        return response.Value;
      }

      return null;
    }
  }
}
