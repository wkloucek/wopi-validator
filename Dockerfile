FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build

WORKDIR /app/
ADD /wopi-validator-core /app
RUN dotnet build -c Release
RUN find /app/src/WopiValidator/bin/Release


FROM mcr.microsoft.com/dotnet/runtime:6.0-alpine

WORKDIR /app/
COPY --from=build /app/src/WopiValidator/bin/Release/net6.0 /app

ENTRYPOINT [ "/app/Microsoft.Office.WopiValidator"]
