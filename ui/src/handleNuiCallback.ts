declare function GetParentResourceName(): string;

export function handleNuiCallback<T>(callback: string, data?: T) {
    if (process.env.NODE_ENV === "development") {
        //toast.info(`NUI Callback: ${callback}`);
        return;
    }
    fetch(`https://${GetParentResourceName()}/${callback}`, {
        method: "POST",
        body: data ? JSON.stringify(data) : undefined,
    });
}