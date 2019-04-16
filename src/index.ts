import { getMaxListeners } from "cluster";
import express from "express";
import { getDefaultSettings } from "http2";

const app = express();
app.use(express.json());
const port = 8080; // default port to listen

interface IPublisher {
    id: string;
    name: string;
    siret: number;
    phone: string;
  }

interface IGame {
    id: string;
    title: string;
    price: number;
    publisher: IPublisher;
    tags: string[];
    releaseDate: Date;
  }

const games = new Map<string, IGame>();

app.get( "/games", ( req, res ) => {
    res.send({ data: Array.from(games.values()) });
} );

app.post("/games", (req, res) => {
    games.set(req.body.id, req.body);
    res.sendStatus(200);
});

app.get( "/games/:id", ( req, res ) => {
    const game = games.get(req.params.id);
    if (game) {
        res.send(game);
    } else {
        res.sendStatus(404);
    }
} );

app.get( "/games/:id/publisher", ( req, res ) => {
    const game = games.get(req.params.id);
    if (game) {
        res.send(game.publisher);
    } else {
        res.sendStatus(404);
    }
} );

app.delete( "/games/:id", ( req, res ) => {
    games.delete(req.params.id);
    res.sendStatus(200);
} );

app.post("/update", (req, res) => {
    games.forEach((value: IGame, key: string) => {
        const today = new Date();
        const date18 = new Date();
        date18.setMonth(date18.getMonth() - 18);
        const date12 = new Date();
        date12.setMonth(date12.getMonth() - 12);
        if (new Date(value.releaseDate) < date18) {
            games.delete(key);
        } else if (new Date(value.releaseDate) < date12) {
            value.price *= .8;
        }
    });
    res.sendStatus(200);
});

// start the Express server
app.listen( port, () => {
    // tslint:disable-next-line:no-console
    console.log( `server started at http://localhost:${ port }` );
} );
