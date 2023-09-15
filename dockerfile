FROM mcr.microsoft.com/dotnet/sdk:7.0 as dev

RUN mkdir /work/
WORKDIR /WORK

COPY ./MyWebApp.csproj /work/MyWebApp.csproj
RUN dotnet restore /work/MyWebApp.csproj

COPY ./ /work
RUN mkdir /out/

RUN dotnet publish /work/MyWebApp.csproj --no-restore --output /out/ --configuration Release

FROM mcr.microsoft.com/dotnet/sdk:7.0 as prod

RUN mkdir /app/
WORKDIR /app/

COPY --from=dev /out/ /app/
RUN chmod +x /app/
CMD dotnet MyWebApp.dll