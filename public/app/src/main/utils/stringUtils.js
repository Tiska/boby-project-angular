/**
 * Ajout de fonctions aux String javascript
 */

// startsWith
if (typeof String.prototype.startsWith != 'function') {
    String.prototype.startsWith = function (str){
        return this.slice(0, str.length) == str;
    };
}

// endsWith
if (typeof String.prototype.endsWith != 'function') {
    String.prototype.endsWith = function (str){
        return this.slice(-str.length) == str;
    };
}

// contains
if (typeof String.prototype.contains != 'function') {
    String.prototype.contains = function(str) {
        return this.indexOf(str) > -1;
    };
}

// takeRight (retourne les n derniers caractères)
if (typeof String.prototype.takeRight != 'function') {
    String.prototype.takeRight = function(n) {
        return this.substring(this.length - n, this.length);
    }
}

// takeLeft (retourne les n premiers caractères)
if (typeof String.prototype.takeLeft != 'function') {
    String.prototype.takeLeft = function(n) {
        return this.substring(0, n);
    }
}
