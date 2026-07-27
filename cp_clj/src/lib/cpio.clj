(ns lib.cpio
  "Competitive Programming Input/Output DSL for Clojure.

  ;; Simple single-case:
  (with-tokens [n :int] solve)

  ;; Complex multi-case or interactive:
  (with-input [t :int]
    (dotimes [i t]
      (with-input [n :int arr [:ints n]]
        (println (solve n arr)))))

  ## Specs
  :int :long :double :str :char :bigint
  [:ints n] [:longs n] [:doubles n] [:strs n] [:chars n]
  [:iarr n] [:larr n] ; primitive arrays for zero-boxing overhead
  [:grid-ints n m] [:grid-longs n m] [:grid-doubles n m]
  [:grid-chars n] [:grid-strs n]
  [:pair t1 t2] [:tuple t1 t2 ...]
  [:queries type->spec] or [:queries n type->spec]
  [:edges n] [:wedges n]

  ## Output Helpers
  words lines yes-no case-str print-grid

  ## See also: with-input for multi-test-case and interactive problems.")

;; @code begin

(require '[clojure.string :as str])
(import [java.io BufferedReader InputStreamReader]
        [java.util.regex Pattern])

;; ============================================================
;; 1. TOKEN READER — default, fastest, for 95% of problems
;; ============================================================

(defrecord TokenReader [^"[Ljava.lang.String;" tokens ^ints pos-arr ^long ntokens])

(def ^:private ^Pattern ws-pattern #"\s+")

(defn token-reader
  "Creates a fast token reader from *in* or a string.
   Reads everything upfront and splits on whitespace — analogous to
   Python's sys.stdin.read().split(). This is the CP gold standard."
  (^TokenReader []
   (token-reader (slurp *in*)))
  (^TokenReader [^String s]
   (let [s (str/trim s)
         toks (if (str/blank? s)
                (make-array String 0)
                (.split ws-pattern s))]
     (->TokenReader toks (int-array [0]) (alength toks)))))

(defn has-more?
  "Returns true if there are unread tokens (useful for read-until-EOF)."
  [^TokenReader r]
  (< (aget ^ints (.pos-arr r) 0) (.ntokens r)))

(defn remaining
  "Number of tokens yet to be consumed."
  [^TokenReader r]
  (- (.ntokens r) (aget ^ints (.pos-arr r) 0)))

(defn- next-tok!
  "Reads next token or throws on EOF."
  [^TokenReader r]
  (let [^ints pos-arr (.pos-arr r)
        i (aget pos-arr 0)]
    (if (< i (.ntokens r))
      (do (aset pos-arr 0 (inc i))
          (aget (.tokens r) i))
      (throw (ex-info "Unexpected EOF while reading token"
                      {:consumed i :total (.ntokens r)})))))

;; -----------------------------------------------------------
;; Core read dispatcher
;; -----------------------------------------------------------

(declare read-buf)

(defn- read-vec
  [^TokenReader r spec ^long n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc (read-buf r spec))))))

(defn- read-int-arr
  [^TokenReader r ^long n]
  (let [arr (int-array n)]
    (loop [i 0]
      (when (< i n)
        (aset arr i (read-buf r :int))
        (recur (inc i))))
    arr))

(defn- read-long-arr
  [^TokenReader r ^long n]
  (let [arr (long-array n)]
    (loop [i 0]
      (when (< i n)
        (aset arr i (read-buf r :long))
        (recur (inc i))))
    arr))

(defn- read-grid
  [^TokenReader r spec ^long n ^long m]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc (read-vec r spec m))))))

(defn- read-queries
  [^TokenReader r spec]
  (let [[_ n-or-type-map :as full-spec] spec
        [n type-map] (if (= 3 (count full-spec))
                       [(second full-spec) (nth full-spec 2)]
                       [(read-buf r :int) n-or-type-map])]
    (loop [i 0 acc (transient [])]
      (if (= i n)
        (persistent! acc)
        (let [code (read-buf r :int)
              [tag & specs] (get type-map code)]
          (when-not tag
            (throw (ex-info "Unknown query type code"
                            {:code code :known (keys type-map)})))
          (recur (inc i)
                 (conj! acc (vec (cons tag (map #(read-buf r %) specs))))))))))

(defn- read-edges
  [^TokenReader r ^long n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc [(read-buf r :int) (read-buf r :int)])))))

(defn- read-wedges
  [^TokenReader r ^long n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc [(read-buf r :int) (read-buf r :int) (read-buf r :long)])))))

(defn read-buf
  "Reads from a TokenReader based on a spec.
  Specs can be keywords (:int, :long, :str, etc.), or vectors like [:ints n], [:grid-ints n m]."
  [^TokenReader r spec]
  (cond
    (keyword? spec)
    (case spec
      :int    (Integer/parseInt (next-tok! r))
      :long   (Long/parseLong (next-tok! r))
      :double (Double/parseDouble (next-tok! r))
      :str    (next-tok! r)
      :char   (first (next-tok! r))
      :bigint (BigInteger. (next-tok! r)))

    (vector? spec)
    (let [tag (first spec)]
      (case tag
        :ints         (read-vec r :int (nth spec 1))
        :longs        (read-vec r :long (nth spec 1))
        :doubles      (read-vec r :double (nth spec 1))
        :strs         (read-vec r :str (nth spec 1))
        :chars        (read-vec r :char (nth spec 1))
        :iarr         (read-int-arr r (nth spec 1))
        :larr         (read-long-arr r (nth spec 1))
        :grid-ints    (read-grid r :int (nth spec 1) (nth spec 2))
        :grid-longs   (read-grid r :long (nth spec 1) (nth spec 2))
        :grid-doubles (read-grid r :double (nth spec 1) (nth spec 2))
        :grid-chars   (let [n (nth spec 1)]
                        (loop [i 0 acc (transient [])]
                          (if (= i n)
                            (persistent! acc)
                            (recur (inc i) (conj! acc (vec (read-buf r :str)))))))
        :grid-strs    (read-vec r :str (nth spec 1))
        :pair         (mapv #(read-buf r %) (rest spec))
        :tuple        (mapv #(read-buf r %) (rest spec))
        :queries      (read-queries r spec)
        :edges        (read-edges r (nth spec 1))
        :wedges       (read-wedges r (nth spec 1))
        (throw (IllegalArgumentException. (str "Unknown spec tag: " tag)))))

    :else (throw (IllegalArgumentException. (str "Unknown spec: " spec)))))

;; -----------------------------------------------------------
;; Bulk readers (for EOF patterns)
;; -----------------------------------------------------------

(defn read-all-ints
  "Read all remaining tokens as a primitive int array."
  [^TokenReader r]
  (let [tokens ^"[Ljava.lang.String;" (.tokens r)
        n (.ntokens r)
        start (aget ^ints (.pos-arr r) 0)
        cnt (- n start)]
    (aset ^ints (.pos-arr r) 0 n)
    (let [arr (int-array cnt)]
      (loop [i 0]
        (when (< i cnt)
          (aset arr i (Integer/parseInt (aget tokens (+ start i))))
          (recur (inc i))))
      arr)))

(defn read-all-longs
  "Read all remaining tokens as a primitive long array."
  [^TokenReader r]
  (let [tokens ^"[Ljava.lang.String;" (.tokens r)
        n (.ntokens r)
        start (aget ^ints (.pos-arr r) 0)
        cnt (- n start)]
    (aset ^ints (.pos-arr r) 0 n)
    (let [arr (long-array cnt)]
      (loop [i 0]
        (when (< i cnt)
          (aset arr i (Long/parseLong (aget tokens (+ start i))))
          (recur (inc i))))
      arr)))

;; ============================================================
;; 2. LINE READER — for interactive, raw string grids, etc.
;; ============================================================

(defrecord LineReader [^BufferedReader br])

(defn line-reader
  "Creates a line-based reader. Use when:
   - The problem is interactive (you read, compute, flush, repeat)
   - Grid rows contain spaces (e.g., '. . # .')
   - You must preserve exact line structure."
  (^LineReader []
   (->LineReader (BufferedReader. *in*)))
  (^LineReader [r]
   (->LineReader (BufferedReader. r))))

(defn read-line!
  "Read next raw line (returns nil on EOF)."
  [^LineReader r]
  (.readLine (.br r)))

(defn read-lines!
  "Read n raw lines as a vector. Throws on unexpected EOF."
  [^LineReader r ^long n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (if-let [line (read-line! r)]
        (recur (inc i) (conj! acc line))
        (throw (ex-info "Unexpected EOF reading lines"
                        {:expected n :read i}))))))

(defn read-grid-raw
  "Read n lines, converting each to a char vector.
   Ideal for standard string grids (e.g., '....#')."
  [^LineReader r ^long n]
  (mapv vec (read-lines! r n)))

;; ============================================================
;; 3. OUTPUT UTILITIES
;; ============================================================

(defn words "Join coll with spaces." [coll] (str/join " " coll))
(defn lines "Join coll with newlines." [coll] (str/join "\n" coll))
(defn yes-no "Return \"Yes\" if truthy, \"No\" otherwise." [x] (if x "Yes" "No"))

(defn print-grid
  "Print a 2D char grid, one row per line, no spaces."
  [grid]
  (doseq [row grid]
    (println (apply str row))))

(defn out "Print without newline; flush immediately. For interactive output." [x] (print x) (flush))
(defn outln "Print with newline; flush immediately. For interactive output." [x] (println x) (flush))

;; ============================================================
;; 4. SYNTACTIC SUGAR / DSL MACROS
;; ============================================================

(defmacro with-input
  "Bind tokens to names, evaluate body. No implicit output.
   Use this for multi-test-cases or when you need custom output formatting."
  [bindings & body]
  {:pre [(even? (count bindings))]}
  (let [r (gensym "reader")
        pairs (partition 2 bindings)
        lets (mapcat (fn [[sym spec]] [sym `(read-buf ~r ~spec)]) pairs)]
    `(let [~r (token-reader)
           ~@lets]
       ~@body)))

(defmacro with-tokens
  "Bind tokens, call f with bound args, println the result.
   Shortcut for simple single-output problems."
  [bindings f]
  (let [pairs (partition 2 bindings)
        args (map first pairs)]
    `(with-input ~bindings
       (println (~f ~@args)))))

(defmacro with-test-cases
  "Read count, then repeat body count times.
   Shortcut for standard multi-test-case problems."
  [count-binding bindings f]
  (let [t (gensym "t")
        pairs (partition 2 bindings)
        args (map first pairs)]
    `(with-input [~count-binding :int]
       (dotimes [~t ~count-binding]
         (with-input ~bindings
           (println (~f ~@args)))))))

;; @code end
