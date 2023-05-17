import { useMain } from "context/Main";
import { Navigate } from "react-router-dom";
import url from "utils/url";

export default function PrivateRoute({ children }: { children: JSX.Element }) {
    /*
    const { user } = useMain();

    if (!user) {
        return <Navigate to={url('home')} />
    }
    */

    return children;
}
