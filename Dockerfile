FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app/src
# copy csproj only so restored project will be cached
COPY src/DirSizeExporter/DirSizeExporter.csproj /app/src/DirSizeExporter/
RUN dotnet restore DirSizeExporter/DirSizeExporter.csproj
COPY src/ /app/src
RUN dotnet publish -c Release DirSizeExporter/DirSizeExporter.csproj -o /app/build

FROM mcr.microsoft.com/dotnet/runtime:6.0
WORKDIR /app
COPY --from=build /app/build/ ./
ENTRYPOINT ["dotnet", "DirSizeExporter.dll"]