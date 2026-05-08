let ticks = 0;

const syncDB = () => {
  ticks++;
  console.log("Tick every 5 seconds, total:", ticks);

  return ticks;
}

module.exports = {
  syncDB
}