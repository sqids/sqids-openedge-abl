# Sqids OpenEdge ABL

[Sqids](https://sqids.org/abl) (*pronounced "squids"*) is a small library that lets you **generate unique IDs from numbers**. It's good for link shortening, fast & URL-safe ID generation and decoding back into numbers for quicker database lookups.

Features:

- **Encode multiple numbers** - generate short IDs from one or several non-negative numbers
- **Quick decoding** - easily decode IDs back into numbers
- **Unique IDs** - generate unique IDs by shuffling the alphabet once
- **ID padding** - provide minimum length to make IDs more uniform
- **URL safe** - auto-generated IDs do not contain common profanity
- **Randomized output** - Sequential input provides nonconsecutive IDs
- **Many implementations** - Support for [40+ programming languages](https://sqids.org/)

## 🧰 Use-cases

Good for:

- Generating IDs for public URLs (eg: link shortening)
- Generating IDs for internal systems (eg: event tracking)
- Decoding for quicker database lookups (eg: by primary keys)

Not good for:

- Sensitive data (this is not an encryption library)
- User IDs (can be decoded revealing user count)

## 🚀 Getting started



## 👩‍💻 Examples

Simple encode & decode:

```abl
DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
DEFINE VARIABLE numbers AS INTEGER   EXTENT 3 NO-UNDO.
DEFINE VARIABLE id      AS CHARACTER NO-UNDO.

sqids = NEW Sqids(). 

ASSIGN 
    numbers[1] = 1
    numbers[2] = 2
    numbers[3] = 3.
    
id = sqids:Encode(numbers).  // '86Rf07'.
numbers =  sqids:Decode(id). // [1, 2, 3]

```

> **Note**
> 🚧 Because of the algorithm's design, **multiple IDs can decode back into the same sequence of numbers**. If it's important to your design that IDs are canonical, you have to manually re-encode decoded numbers and check that the generated ID matches.

Enforce a *minimum* length for IDs:

```abl
DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
DEFINE VARIABLE numbers AS INTEGER   EXTENT 3 NO-UNDO.
DEFINE VARIABLE id      AS CHARACTER NO-UNDO.

sqids = NEW Sqids('', 10). 

ASSIGN 
    numbers[1] = 1
    numbers[2] = 2
    numbers[3] = 3.
    
id = sqids:Encode(numbers).  // '86Rf07xd4z'.
numbers =  sqids:Decode(id). // [1, 2, 3]

```

Randomize IDs by providing a custom alphabet:

```abl
DEFINE VARIABLE numbers AS INTEGER   EXTENT 3 NO-UNDO.
DEFINE VARIABLE id      AS CHARACTER NO-UNDO.

sqids = NEW Sqids('FxnXM1kBN6cuhsAvjW3Co7l2RePyY8DwaU04Tzt9fHQrqSVKdpimLGIJOgb5ZE'). 

ASSIGN 
    numbers[1] = 1
    numbers[2] = 2
    numbers[3] = 3.
    
id = sqids:Encode(numbers).  // 'B4aajs'.
numbers =  sqids:Decode(id). // [1, 2, 3]
```

Prevent specific words from appearing anywhere in the auto-generated IDs:

```abl
DEFINE VARIABLE numbers    AS INTEGER   EXTENT 3 NO-UNDO.
DEFINE VARIABLE id         AS CHARACTER NO-UNDO.
DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 1 NO-UNDO INITIAL ['86Rf07'].

sqids = NEW Sqids('', 0 cBlackList). 

ASSIGN 
    numbers[1] = 1
    numbers[2] = 2
    numbers[3] = 3.
    
id = sqids:Encode(numbers).  // 'se8ojk'.
numbers =  sqids:Decode(id). // [1, 2, 3]
```

## 📝 License

[MIT](LICENSE)