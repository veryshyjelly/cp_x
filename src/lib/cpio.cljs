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
  [:many n spec] ; n repeats of ANY spec, e.g. [:many n [:tuple :str :int]]
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

(defn slurp-stdin [] (.readFileSync fs 0 "utf-8"))   
(defn slurp-stdin-buf [] (.readFileSync fs 0))   ; Buffer, no utf8 decode

(defrecord TokenReader [buf pos-arr len])

(defn token-reader
  "Creates a fast token reader from stdin or a string.
   Reads everything upfront and splits on whitespace — analogous to
   Python's sys.stdin.read().split(). This is the CP gold standard."
  ([] (token-reader (slurp-stdin-buf)))
  ([s]
   (let [b (if (string? s) (js/Buffer.from s "utf8") s)]
     (->TokenReader b (js/Int32Array. 1) (.-length b)))))

(defn- skip-ws [buf i n]
  (loop [i i]
    (if (and (< i n) (<= (aget buf i) 32)) (recur (inc i)) i)))

(defn has-more?
  "Returns true if there are unread tokens (useful for read-until-EOF)."
  [r]
  (let [n (.-len r)]
    (< (skip-ws (.-buf r) (aget (.-pos-arr r) 0) n) n)))

(defn- next-int!
  "Parse an integer straight from bytes. Exact up to 2^53."
  [r]
  (let [buf (.-buf r) pa (.-pos-arr r) n (.-len r)
        i (skip-ws buf (aget pa 0) n)]
    (when (>= i n) (throw (ex-info "Unexpected EOF while reading token" {})))
    (let [neg? (== (aget buf i) 45)
          i (if neg? (inc i) i)]
      (loop [i i acc 0]
        (let [c (if (< i n) (aget buf i) 32)]
          (if (and (>= c 48) (<= c 57))
            (recur (inc i) (+ (* acc 10) (- c 48)))
            (do (aset pa 0 i)
                (if neg? (- 0 acc) acc))))))))

(defn- next-str! [r]
  (let [buf (.-buf r) pa (.-pos-arr r) n (.-len r)
        s (skip-ws buf (aget pa 0) n)]
    (when (>= s n) (throw (ex-info "Unexpected EOF while reading token" {})))
    (let [e (loop [i s] (if (and (< i n) (> (aget buf i) 32)) (recur (inc i)) i))]
      (aset pa 0 e)
      (.toString buf "utf8" s e))))

;; -----------------------------------------------------------
;; Core read dispatcher
;; -----------------------------------------------------------

(declare read-buf)

(defn- read-ints [r n]
  (loop [i 0 acc (transient [])]
    (if (= i n) (persistent! acc) (recur (inc i) (conj! acc (next-int! r))))))

(defn- read-int-arr [r n]
  (let [arr (js/Int32Array. n)]
    (dotimes [i n] (aset arr i (next-int! r)))
    arr))

(defn- read-long-arr [r n]
  (let [arr (js/Float64Array. n)]
    (dotimes [i n] (aset arr i (next-int! r)))
    arr))

(defn- read-edges [r n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (let [a (next-int! r) b (next-int! r)]
        (recur (inc i) (conj! acc [a b]))))))

(defn- read-wedges [r n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (let [a (next-int! r) b (next-int! r) w (next-int! r)]
        (recur (inc i) (conj! acc [a b w]))))))

(defn- read-grid-ints [r n m]
  (loop [i 0 acc (transient [])]
    (if (= i n) (persistent! acc) (recur (inc i) (conj! acc (read-ints r m))))))

(defn- read-vec
  [r spec n]
  (loop [i 0 acc (transient [])]
    (if (= i n)
      (persistent! acc)
      (recur (inc i) (conj! acc (read-buf r spec))))))

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


(defn read-buf
  "Reads from a TokenReader based on a spec.
  Specs can be keywords (:int, :long, :str, etc.), or vectors like [:ints n], [:grid-ints n m].

  NOTE: :long returns a plain JS number, exact only up to 2^53. Use
  :bigint for values that may exceed that."
  [r spec]
  (cond
    (keyword? spec)
    (case spec
      :int    (next-int! r)
      :double (js/parseFloat (next-str! r))
      :str    (next-str! r)
      :char   (first (next-str! r))
      :bigint (js/BigInt (next-str! r)))

    (vector? spec)
    (let [tag (first spec)]
      (case tag
        :ints         (read-ints r (nth spec 1))
        :doubles      (read-vec r :double (nth spec 1))
        :bigints (read-vec r :bigint (nth spec 1))
        :strs         (read-vec r :str (nth spec 1))
        :chars        (read-vec r :char (nth spec 1))
        :iarr         (read-int-arr r (nth spec 1))
        :larr         (read-long-arr r (nth spec 1))
        :grid-ints    (read-grid-ints r (nth spec 1) (nth spec 2))
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
        :many         (read-vec r (nth spec 2) (nth spec 1))
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
  (let [acc (array)]
    (while (has-more? r) (.push acc (next-int! r)))
    (js/Int32Array.from acc)))

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

(defn words [coll] (.join (to-array coll) " "))
(defn lines [coll] (.join (to-array coll) "\n"))
(defn- write! [s] (.write js/process.stdout s))
(defn lines-of-words "print lines of words" [coll] (lines (map words coll)))
(defn yes-no "Return \"Yes\" if truthy, \"No\" otherwise." [x] (if x "Yes" "No"))

;; ============================================================
;; 4. SYNTACTIC SUGAR / DSL MACROS
;; ============================================================

(def ^:private spec-ops
  {'+ +, '- -, '* *, 'quot quot, 'rem rem, 'mod mod,
   'inc inc, 'dec dec, 'max max, 'min min})

(defn resolve-spec
  "Resolves names and simple arithmetic in a spec against already-read values.
   e.g. [:ints (* 5 n)] with {n 3} => [:ints 15]"
  [form values]
  (cond
    (symbol? form)
    (if (contains? values form)
      (get values form)
      (throw (ex-info (str "Unbound name in spec: " form) {:name form})))

    (seq? form)
    (let [[op & args] form
          f (get spec-ops op)]
      (when-not f
        (throw (ex-info (str "Unsupported operator in spec: " op) {:op op})))
      (apply f (map #(resolve-spec % values) args)))

    (vector? form) (mapv #(resolve-spec % values) form)

    :else form))

(defn- run-bindings [r bindings f]
  (loop [xs (partition 2 bindings) values {} args []]
    (if (empty? xs)
      (apply f args)
      (let [[name spec] (first xs)
            value (read-buf r (resolve-spec spec values))]
        (recur (rest xs) (assoc values name value) (conj args value))))))

(defn with-input [bindings f]
  (run-bindings (token-reader) bindings f))

(defn with-tokens [bindings f]
  (write! (str (with-input bindings f) "\n")))

(defn with-test-cases [bindings f]
  (let [r (token-reader)
        t (read-buf r :int)
        out (array)]
    (dotimes [_ t] (.push out (str (run-bindings r bindings f))))
    (write! (str (.join out "\n") "\n"))))

;; @code end