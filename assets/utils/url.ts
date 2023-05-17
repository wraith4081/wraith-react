import { generatePath } from "react-router-dom";
import routes, { Route } from "routes";

export default function url(path: string, params: object = {}) {
    let url: string = '', lastRoute: Route | undefined;
    path.split('.').forEach(p => {
        if (lastRoute) {
            lastRoute = lastRoute.children?.find(route => route.name === p);
        } else {
            lastRoute = routes.find(route => route.name === p);
        }

        url += `/${(lastRoute as any)?.path || ''}`;
    })

    return generatePath(url.replace(/\/\//g, '/'), params);
}
