const fs = require('fs');
const path = require('path');
const child_process = require('child_process');

const buildConfigPath = path.join(__dirname, 'src/buildconfig.json');

const buildJson = JSON.parse(fs.readFileSync(buildConfigPath, 'utf8'));

const now = new Date();
const options = { month: 'short', year: 'numeric', hour: '2-digit', minute: '2-digit' };
const buildDate = getOrdinalSuffix(now.getDate()) + ' ' + now.toLocaleDateString('en-GB', options);
const commitHash = child_process.execSync('git rev-parse HEAD').toString().trim();

buildJson.buildDate = buildDate.replace(/,/g, '');
buildJson.commitHash = commitHash;

fs.writeFileSync(buildConfigPath, JSON.stringify(buildJson, null, 2) + '\n');

function getOrdinalSuffix(day) {
    let suffix = 'th';
    if (day % 10 === 1 && day !== 11) {
        suffix = 'st';
    } else if (day % 10 === 2 && day !== 12) {
        suffix = 'nd';
    } else if (day % 10 === 3 && day !== 13) {
        suffix = 'rd';
    }
    return day + suffix;
}
