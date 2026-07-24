(ns lib.cpio
  "Competitive Programming Input DSL for Clojure.
   Token-based by default (fastest). Line-based available for grids/interactive.")

;; @code begin
(require '[clojure.string :as str])
(import '[java.io BufferedReader InputStreamReader])

;; ============================================================
;; 1. TOKEN READER — default, fastest, for 95% of problems
;; ============================================================

(defrecord TokenReader [tokens pos])

(defn token-reader
  "Creates a fast token reader from *in* or a string.
   Reads everything upfront and splits on whitespace — analogous to
   Python's sys.stdin.read().split(). This is the CP gold standard."
  (^TokenReader []
   (token-reader (slurp *in*)))
  (^TokenReader [^String s]
   (let [s (str/trim s)
         tokens (if (str/blank? s) [] (str/split s #"\s+"))]
     (->TokenReader tokens (atom 0)))))

(defn- next-tok [^TokenReader r]
  (let [i @(.pos r)]
    (when (< i (count (.tokens r)))
      (swap! (.pos r) inc)
      (nth (.tokens r) i))))

(defn- peek-tok [^TokenReader r]
  (let [i @(.pos r)]
    (when (< i (count (.tokens r)))
      (nth (.tokens r) i))))

(defn has-more?
  "Returns true if there are unread tokens (useful for read-until-EOF)."
  [^TokenReader r]
  (some? (peek-tok r)))

(defn remaining
  "Number of tokens yet to be consumed."
  [^TokenReader r]
  (- (count (.tokens r)) @(.pos r)))

;; -----------------------------------------------------------
;; Core read dispatcher
;; -----------------------------------------------------------

(defn read
  "Read from a TokenReader according to a spec.

   Primitives (keyword):
     :int      → Integer
     :long     → Long (64-bit, use this for 'long long')
     :double   → Double
     :str      → String
     :char     → Character (first char of next token)
     :bigint   → java.math.BigInteger

   Vectors (counted collections):
     [:ints n]      → vector of n ints
     [:longs n]     → vector of n longs
     [:doubles n]   → vector of n doubles
     [:strs n]      → vector of n strings
     [:chars n]     → vector of n chars

   Grids (2D collections):
     [:grid-strs n]     → n strings, as a vector (each row is one token)
     [:grid-chars n]    → n rows, each a vector of chars (from string tokens)
     [:grid-ints n m]   → n rows × m ints
     [:grid-longs n m]  → n rows × m longs
     [:grid-doubles n m]→ n rows × m doubles"
  [^TokenReader r spec]
  (cond
    (keyword? spec)
    (case spec
      :int    (Integer/parseInt (next-tok r))
      :long   (Long/parseLong (next-tok r))
      :double (Double/parseDouble (next-tok r))
      :str    (next-tok r)
      :char   (first (next-tok r))
      :bigint (java.math.BigInteger. (next-tok r)))

    (and (vector? spec) (= 2 (count spec)))
    (let [[tag n] spec]
      (case tag
        :ints      (vec (repeatedly n #(read r :int)))
        :longs     (vec (repeatedly n #(read r :long)))
        :doubles   (vec (repeatedly n #(read r :double)))
        :strs      (vec (repeatedly n #(read r :str)))
        :chars     (vec (repeatedly n #(read r :char)))
        :grid-strs (vec (repeatedly n #(read r :str)))
        :grid-chars (vec (repeatedly n #(vec (read r :str))))))

    (and (vector? spec) (= 3 (count spec)))
    (let [[tag n m] spec]
      (case tag
        :grid-ints     (vec (repeatedly n #(read r [:ints m])))
        :grid-longs    (vec (repeatedly n #(read r [:longs m])))
        :grid-doubles  (vec (repeatedly n #(read r [:doubles m])))))

    :else (throw (IllegalArgumentException. (str "Unknown read spec: " spec)))))

;; -----------------------------------------------------------
;; Bulk readers (for EOF patterns)
;; -----------------------------------------------------------

(defn read-all-ints
  "Read all remaining tokens as ints."
  [^TokenReader r]
  (let [res (transient [])]
    (while (has-more? r)
      (conj! res (read r :int)))
    (persistent! res)))

(defn read-all-longs
  "Read all remaining tokens as longs."
  [^TokenReader r]
  (let [res (transient [])]
    (while (has-more? r)
      (conj! res (read r :long)))
    (persistent! res)))

;; ============================================================
;; 2. LINE READER — for interactive, raw string grids, etc.
;; ============================================================

(defrecord LineReader [buffered-reader])

(defn line-reader
  "Creates a line-based reader. Use when:
   - The problem is interactive (you read, compute, flush, repeat)
   - Grid rows contain spaces (e.g., '. . # .')
   - You must preserve exact line structure."
  (^LineReader []
   (->LineReader (BufferedReader. (InputStreamReader. System/in))))
  (^LineReader [^BufferedReader br]
   (->LineReader br)))

(defn read-line
  "Read next raw line (returns nil on EOF)."
  [^LineReader r]
  (.readLine (.buffered-reader r)))

(defn read-lines
  "Read n raw lines as a vector."
  [^LineReader r n]
  (vec (repeatedly n #(read-line r))))

(defn read-grid-raw
  "Read n lines, converting each to a char vector.
   Ideal for standard string grids (e.g., '....#')."
  [^LineReader r n]
  (vec (repeatedly n #(vec (read-line r)))))

;; ============================================================
;; 3. OUTPUT UTILITIES
;; ============================================================

(defn out
  "Print without newline; flush immediately. For interactive output."
  [x]
  (print x)
  (flush))

(defn outln
  "Print with newline; flush immediately. For interactive output."
  [x]
  (println x)
  (flush))

(def Words #(str/join " " (map str %)))
(def Lines #(str/join "\n" (map str %)))

(defn print-grid-chars
  "Print a 2D char grid, one row per line, no spaces."
  [grid]
  (doseq [row grid]
    (println (apply str row))))

;; ============================================================
;; 4. SYNTACTIC SUGAR
;; ============================================================

(defmacro with-tokens
  "Binds name to a token-reader and executes body."
  [[name] & body]
  `(let [~name (token-reader)]
     ~@body))

(defmacro with-lines
  "Binds name to a line-reader and executes body."
  [[name] & body]
  `(let [~name (line-reader)]
     ~@body))

;; @code end
