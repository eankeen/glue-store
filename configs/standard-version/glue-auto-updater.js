module.exports.readVersion = function(/** @type string */ content) {
	const contentArray = content.split("\n")

	for (let i = 0; i < contentArray.length; i++) {
		const line = contentArray[i];

		if (line.match(/[ \t]*version[ \t]*=/u)) {
			const start = line.indexOf('"');
			const last = line.lastIndexOf('"');
			return line.slice(start + 1, last);
		}
	}

	return ''
}

module.exports.writeVersion = function(/** @type string */ content, /** @type string */ version) {
	const contentArray = content.split("\n")

	for (let i = 0; i < contentArray.length; i++) {
		if (contentArray[i].match(/[ \t]*version[ \t]*=/u)) {
			contentArray[i] = `version = "${version}"`
		}
	}

	return contentArray.join('\n')
}
