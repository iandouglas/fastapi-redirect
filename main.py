from fastapi import FastAPI, HTTPException
from starlette.responses import RedirectResponse
from urls import URLS as url_map

app = FastAPI()


@app.get("/")
async def redirect_home():
    return RedirectResponse(url=url_map['*']['url'])


@app.get("/{short_code}+")
async def redirect_url_description(short_code: str):
    if short_code in url_map:
        return {f'{short_code}': url_map[short_code]}
    else:
        raise HTTPException(status_code=404, detail="short URL not found")

@app.get("/{short_code}")
async def redirect_url(short_code: str):
    if short_code in url_map:
        return RedirectResponse(url=url_map[short_code]['url'])
    else:
        raise RedirectResponse(url=url_map['*']['url'])

# You can add more functionality as needed
