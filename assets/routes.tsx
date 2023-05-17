import PrivateRoute from "components/PrivateRoute";

import Home from "pages/Home";

import HomeLayout from "views/layouts/HomeLayout";

export type Route = IndexRoute | PathRoute;

interface IndexRoute {

    index: true;

    name: string;

    element: JSX.Element;

    children?: Route[];

    auth?: true;

}

interface PathRoute {

    path: string;

    name: string;

    element: JSX.Element;

    children?: Route[];

    auth?: true;

}

const routes: Route[] = [

    {

        name: 'home',

        path: '/',

        element: <HomeLayout />,

        children: [

            {

                name: 'index',

                index: true,

                element: <Home />

            },

            {

                name: 'secret',

                path: 'secret',

                auth: true,

                element: <div>Secret! <Home /></div>

            }

        ]

    }

];

const RouteMap = (routeList: Route[]) => routeList.map(route => {

    if (route?.auth) {

        route.element = <PrivateRoute>{route.element}</PrivateRoute>

    }

    if (route?.children) {

        route.children = RouteMap(route.children);

    }

    return route;

});

export default RouteMap(routes);
