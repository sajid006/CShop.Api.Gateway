FROM mcr.microsoft.com/dotnet/sdk:6.0-focal AS build
WORKDIR /source
COPY . .
RUN dotnet restore "./CShop.Api.Gateway/CShop.Api.Gateway.csproj" --disable-parallel
RUN dotnet publish "./CShop.Api.Gateway/CShop.Api.Gateway.csproj" -c release -o /app --no-restore

# serve stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0-focal
WORKDIR /app
COPY --from=build /app ./

EXPOSE 5000

ENTRYPOINT ["dotnet", "CShop.Api.Gateway.dll"]