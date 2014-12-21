/**
 * Ajout de fonctions aux numbers javascript
 */

if (typeof Number.prototype.abs != 'function') {
    Number.prototype.abs = function(){
        return Math.abs(this);
    };
}