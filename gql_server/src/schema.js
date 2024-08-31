import {GraphQLBoolean, GraphQLInt, GraphQLList, GraphQLObjectType, GraphQLString} from 'graphql';

import {users} from './data.js';

const PageInfoType = new GraphQLObjectType({
  name: 'PageInfo',
  fields: {
    size: {type: GraphQLInt},
    currentPage: {type: GraphQLInt},
    totalPage: {type: GraphQLInt},
    hasNext: {type: GraphQLBoolean},
  }
});

const createPageInfo = (args, users) => ({
  size: args.size,
  currentPage: args.page,
  totalPage: Math.ceil(users.length / args.size) - 1,
  hasNext: users.length > (args.page + 1) * args.size
});

const UserType = new GraphQLObjectType({
  name: 'User',
  fields: {
    id: {type: GraphQLInt},
    name: {type: GraphQLString},
  }
});

const UsersType = new GraphQLObjectType({
  name: 'Users',
  fields: {
    contents: {type: new GraphQLList(UserType)},
    pageInfo: {type: PageInfoType},
  }
});

export const RootQuery = new GraphQLObjectType({
  name: 'RootQuery',
  fields: {
    users: {
      type: UsersType,
      args: {
        page: {type: GraphQLInt},
        size: {type: GraphQLInt},
      },
      resolve: (_parent, args) => {
        const pageInfo = createPageInfo(args, users);
        const paginatedUsers = users.slice(
            args.page * args.size,
            args.page * args.size + args.size,
        );
        return {contents: paginatedUsers, pageInfo};
      }
    },
    user: {
      type: UserType,
      args: {id: {type: GraphQLInt}},
      resolve: (_parent, args) => {
        return users.find(user => user.id === args.id);
      },
    }
  }
});

export const RootMutation = new GraphQLObjectType({
  name: 'RootMutation',
  fields: {
    addUser: {
      type: UserType,
      args: {name: {type: GraphQLString}},
      resolve: (_parent, args) => {
        const id = users.length;
        const user = {id, name: args.name};
        users.push(user);
        return user;
      },
    },
    deleteUser: {
      type: GraphQLBoolean,
      args: {id: {type: GraphQLInt}},
      resolve: (_parent, args) => {
        const user = users.find(user => user.id === args.id);
        const idx = users.indexOf(user);
        if (idx > -1) {
          users.splice(idx, 1);
          return true;
        }
        return false;
      }
    }
  }
});
