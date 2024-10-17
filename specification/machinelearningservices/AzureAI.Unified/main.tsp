import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.implicit,
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize",
      scopes: ["https://ai.azure.com/.default"],
    }
  ]>
)
@service({
  title: "Azure AI Data Plane",
})
@server(
  "{endpoint}/projects/{projectName}",
  "Azure AI Data Plane APIs",
  {
    @doc("""
      Global endpoint in the form of: https://[hub-id]/api.ai.azure.com
      """)
    endpoint: url,

    @doc("The name of the AI project.")
    projectName: string,
  }
)
@versioned(Versions)
namespace Microsoft.MachineLearningServices;

@doc("Azure AI api versions.")
enum Versions {
  @doc("Azure AI api version 2025-03-01-preview.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2025-03-01-preview`,
}