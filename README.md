# Ticket System

## Dev Usage

```bash
truffle develop  # start local blockchain environment
compile
migrate --reset
test
```



## UI Deployment

```bash
npm i  # install dependencies
npm run dev  # dev server
npm run build  # build production server
npm run generate # build static assets (for static hosting)
```

The UI can be deployed to Netlify easily with zero config, simply link this repo to Netlify.

It can also be deploied to Vercel or Cloudflare Pages in a similar way.
