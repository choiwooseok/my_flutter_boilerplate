import express from 'express';
import {graphqlHTTP} from 'express-graphql';
import {GraphQLSchema} from 'graphql';

import {RootMutation, RootQuery} from './schema.js';

const app = express();
const schema = new GraphQLSchema({query: RootQuery, mutation: RootMutation});

app.use('/graphql', graphqlHTTP({schema, graphiql: true}));

const PORT = process.env.PORT || 3946;
app.listen(PORT, () => {
  console.log('listen http://localhost:' + PORT + '/graphql');
});