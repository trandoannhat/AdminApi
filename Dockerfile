# ---------- BUILD STAGE ----------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# copy solution & csproj
COPY AdminApi.sln .
COPY AdminApi/AdminApi.csproj AdminApi/

# restore
RUN dotnet restore

# copy all source
COPY . .

# publish
WORKDIR /src/AdminApi
RUN dotnet publish -c Release -o /app/publish

# ---------- RUNTIME STAGE ----------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://0.0.0.0:5000
EXPOSE 5000

ENTRYPOINT ["dotnet", "AdminApi.dll"]
