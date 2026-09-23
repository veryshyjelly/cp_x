(ns lib.cpio
  "Competitive Programming Input/Output DSL for ClojureScript.

  Targets Node.js (tested against nbb — recommended for CP scripting due
  to fast startup). Macros and functions live in the same file, which
  self-hosted runtimes like nbb interpret top-to-bottom without issue.
  If you're on a JVM-hosted toolchain (shadow-cljs, figwheel), split the
  three `defmacro` forms below into a separate `.cljc` file and pull them
  in with `:require-macros`.

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
  [:iarr n] [:larr n] ; typed arrays for zero-boxing overhead
  [:grid-ints n m] [:grid-longs n m] [:grid-doubles n m]
  [:grid-chars n] [:grid-strs n]
  [:pair t1 t2] [:tuple t1 t2 ...]
  [:queries type->spec] or [:queries n type->spec]
  [:edges n] [:wedges n]

  ## Output Helpers
  words lines yes-no case-str print-grid

  ## IMPORTANT — porting caveats vs. the JVM version:
  - `:long` is a plain JS number (double), NOT a true 64-bit integer.
    It is exact only up to 2^53 (~9e15). For anything larger, use
    `:bigint` (backed by native js/BigInt) instead of `:long`.
  - `line-reader` slurps all of stdin upfront and splits into lines.
    It does NOT support truly interactive judges that stream input based
    on your output — synchronous partial reads from stdin aren't
    practical in JS the way they are on the JVM.

  ## See also: with-input for multi-test-case and interactive problems."

  (:require ["fs" :as fs]
            [clojure.string :as str]))

;; @code begin


;; ============================================================
;; 1. TOKEN READER — default, fastest, for 95% of problems
;; ============================================================

(defrecord TokenReader [tokens pos-arr ntokens])

(def ^:private ws-pattern #"\s+")

(defn slurp-stdin
  "Synchronously reads all of stdin. Node.js only."
  []
  (.readFileSync fs 0 "utf8"))

(defn token-reader
  "Creates a fast token reader from stdin or a string.
   Reads everything upfront and splits on whitespace — analogous to
   Python's sys.stdin.read().split(). This is the CP gold standard."
  ([]
   (token-reader (slurp-stdin)))
  ([s]
   (let [s (str/trim s)
         toks (if (str/blank? s)
                (array)
                (.split s ws-pattern))]
     (->TokenReader toks (js/Int32Array. 1) (alength toks)))))

(defn has-more?
  "Returns true if there are unread tokens (useful for read-until-EOF)."
  [r]
  (< (aget (.-pos-arr r) 0) (.-ntokens r)))

(defn remaining
  "Number of tokens yet to be consumed."
  [r]
  (- (.-ntokens r) (aget (.-pos-arr r) 0)))

(defn- next-tok!
  "Reads next token or throws on EOF."
  [r]
  (let [pos-arr (.-pos-arr r)
        i (aget pos-arr 0)]
    (if (< i (.-ntokens r))
      (do (aset pos-arr 0 (inc i))
          (aget (.-tokens r) i))
      (throw (ex-info "Unexpected EOF while reading token"
                      {:consumed i :total (.-ntokens r)})))))

;; -----------------------------------------------------------
;; Core read dispatcher
;; -----------------------------------------------------------

(declare read-buf)

(defn- read-vec
  [r spec n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc (read-buf r spec))))))

(defn- read-int-arr
  [r n]
  (let [arr (js/Int32Array. n)]
    (loop [i 0]
      (when (< i n)
        (aset arr i (read-buf r :int))
        (recur (inc i))))
    arr))

(defn- read-long-arr
  [r n]
  (let [arr (js/Float64Array. n)]
    (loop [i 0]
      (when (< i n)
        (aset arr i (read-buf r :long))
        (recur (inc i))))
    arr))

(defn- read-grid
  [r spec n m]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc (read-vec r spec m))))))

(defn- read-queries
  [r spec]
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
  [r n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc [(read-buf r :int) (read-buf r :int)])))))

(defn- read-wedges
  [r n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc [(read-buf r :int) (read-buf r :int) (read-buf r :long)])))))

(defn read-buf
  "Reads from a TokenReader based on a spec.
  Specs can be keywords (:int, :long, :str, etc.), or vectors like [:ints n], [:grid-ints n m].

  NOTE: :long returns a plain JS number, exact only up to 2^53. Use
  :bigint for values that may exceed that."
  [r spec]
  (cond
    (keyword? spec)
    (case spec
      :int    (js/parseInt (next-tok! r) 10)
      :long   (js/parseInt (next-tok! r) 10)
      :double (js/parseFloat (next-tok! r))
      :str    (next-tok! r)
      :char   (first (next-tok! r))
      :bigint (js/BigInt (next-tok! r)))

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
        (throw (ex-info (str "Unknown spec tag: " tag) {:tag tag}))))

    :else (throw (ex-info (str "Unknown spec: " spec) {:spec spec}))))

;; -----------------------------------------------------------
;; Bulk readers (for EOF patterns)
;; -----------------------------------------------------------

(defn read-all-ints
  "Read all remaining tokens as an Int32Array."
  [r]
  (let [tokens (.-tokens r)
        n (.-ntokens r)
        pos-arr (.-pos-arr r)
        start (aget pos-arr 0)
        cnt (- n start)]
    (aset pos-arr 0 n)
    (let [arr (js/Int32Array. cnt)]
      (loop [i 0]
        (when (< i cnt)
          (aset arr i (js/parseInt (aget tokens (+ start i)) 10))
          (recur (inc i))))
      arr)))

(defn read-all-longs
  "Read all remaining tokens as a Float64Array.
   NOTE: exact only up to 2^53 — see the :long caveat above."
  [r]
  (let [tokens (.-tokens r)
        n (.-ntokens r)
        pos-arr (.-pos-arr r)
        start (aget pos-arr 0)
        cnt (- n start)]
    (aset pos-arr 0 n)
    (let [arr (js/Float64Array. cnt)]
      (loop [i 0]
        (when (< i cnt)
          (aset arr i (js/parseInt (aget tokens (+ start i)) 10))
          (recur (inc i))))
      arr)))

;; ============================================================
;; 2. LINE READER — for raw string grids, line-structured input, etc.
;; ============================================================

(defrecord LineReader [lines pos-arr nlines])

(defn line-reader
  "Creates a line-based reader by reading all of stdin upfront and
   splitting into lines. Use when:
   - Grid rows contain spaces (e.g., '. . # .')
   - You must preserve exact line structure.

   Unlike the JVM version, this cannot service truly interactive judges
   (where input arrives incrementally based on your output) — see the
   ns docstring."
  ([]
   (line-reader (slurp-stdin)))
  ([s]
   (let [norm (str/replace s "\r\n" "\n")
         lns (.split norm "\n")]
     (->LineReader lns (js/Int32Array. 1) (alength lns)))))

(defn read-line!
  "Read next raw line (returns nil on EOF)."
  [r]
  (let [pos-arr (.-pos-arr r)
        i (aget pos-arr 0)]
    (if (< i (.-nlines r))
      (do (aset pos-arr 0 (inc i))
          (aget (.-lines r) i))
      nil)))

(defn read-lines!
  "Read n raw lines as a vector. Throws on unexpected EOF."
  [r n]
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
  [r n]
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

(defn out "Print without newline. For interactive output." [x] (print x))
(defn outln "Print with newline. For interactive output." [x] (println x))

;; ============================================================
;; 4. SYNTACTIC SUGAR / DSL MACROS
;; ============================================================

(defn resolve-spec [spec values]
  (if (vector? spec)
    (mapv #(if (symbol? %)
             (get values %)
             %)
          spec)
    spec))

(defn with-input
  "Bind tokens to names, evaluate body. No implicit output.
     Use this for multi-test-cases or when you need custom output formatting."
  [bindings f]
  (let [r (token-reader)]
    (loop [xs (partition 2 bindings)
           values {}
           args []]
      (if (empty? xs)
        (apply f args)
        (let [[name spec] (first xs)
              spec (resolve-spec spec values)
              value (read-buf r spec)]
          (recur (rest xs)
                 (assoc values name value)
                 (conj args value)))))))


(defn with-tokens
  "Bind tokens, call f with bound args, println the result.
   Shortcut for simple single-output problems."
  [bindings f]
  (let [res (with-input bindings f)]
       (println res)))

(defn with-test-cases
  "Read count, then repeat body count times.
   Shortcut for standard multi-test-case problems."
  [bindings f]
  (with-input '[t :int]
    #(dotimes [_ %]
       (println (with-input bindings f)))))

;; @code end