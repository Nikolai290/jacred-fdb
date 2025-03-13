FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /DockerSource

COPY *.sln .
COPY *.csproj .
RUN dotnet restore --runtime linux-x64

COPY . .
RUN dotnet publish -c release --runtime linux-x64 --self-contained true -o /DockerOutput/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /DockerOutput
COPY --from=build /DockerOutput/publish ./
ENTRYPOINT ["dotnet", "JacRed.dll"]