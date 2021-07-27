Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C393D779C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbhG0N6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:58:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51426 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhG0N6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:48 -0400
Date:   Tue, 27 Jul 2021 13:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gg1C4gqvqs2JgwQ6TeXXPX5VgOeo/OUyBM1VR7CtlgU=;
        b=I8JWmFQVSozWfFy1RH8jAgjvhrxwgmjLRiw2XyqU46PP9GvAhxL6DB3G303YVv+X40EVfl
        AHzLbz02VHnrE4i19fHR8MwDjw5gbrjsrPo3LgpQ/CPYWEZq36nno3omGwixztbW3YT84g
        GlFHRGf2TQWKc49a5jMIJ3QjjDaAxxJY8bsepFROOenxtA1ca6D38Kz4d0pG3rMfpZXJ1v
        8K5Lo1ck71tN5P01q3jPYTHWeaLMigrWSndZTb6yulZRuKj7KoLPmFFGTGv7KssjgOGHWe
        6KYQhgNeb3nWQPMfliXP8N/KYiZdT91aL+xfunvgF90UUP5wuddOhQ1tLYAgig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394326;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gg1C4gqvqs2JgwQ6TeXXPX5VgOeo/OUyBM1VR7CtlgU=;
        b=OqcbEg2PmCdEfopmEwwoos0W6PuEtoVvg2Hsg8OHTydPdRjJw/dkkjwM2KQnm8Qgu0zCX8
        Zy2to2RZNPbZM7Ag==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/atomic: remove ARCH_ATOMIC remanants
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210713105253.7615-3-mark.rutland@arm.com>
References: <20210713105253.7615-3-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <162739432590.395.3881700007508069068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f3e615b4db1fb7034f1d76dc307b77cc848f040e
Gitweb:        https://git.kernel.org/tip/f3e615b4db1fb7034f1d76dc307b77cc848f040e
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 13 Jul 2021 11:52:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:44 +02:00

locking/atomic: remove ARCH_ATOMIC remanants

Now that gen-atomic-fallback.sh is only used to generate the arch_*
fallbacks, we don't need to also generate the non-arch_* forms, and can
removethe infrastructure this needed.

There is no change to any of the generated headers as a result of this
patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210713105253.7615-3-mark.rutland@arm.com
---
 scripts/atomic/fallbacks/acquire             |  4 +-
 scripts/atomic/fallbacks/add_negative        |  6 +-
 scripts/atomic/fallbacks/add_unless          |  6 +-
 scripts/atomic/fallbacks/andnot              |  4 +-
 scripts/atomic/fallbacks/dec                 |  4 +-
 scripts/atomic/fallbacks/dec_and_test        |  6 +-
 scripts/atomic/fallbacks/dec_if_positive     |  6 +-
 scripts/atomic/fallbacks/dec_unless_positive |  6 +-
 scripts/atomic/fallbacks/fence               |  4 +-
 scripts/atomic/fallbacks/fetch_add_unless    |  8 +-
 scripts/atomic/fallbacks/inc                 |  4 +-
 scripts/atomic/fallbacks/inc_and_test        |  6 +-
 scripts/atomic/fallbacks/inc_not_zero        |  6 +-
 scripts/atomic/fallbacks/inc_unless_negative |  6 +-
 scripts/atomic/fallbacks/read_acquire        |  2 +-
 scripts/atomic/fallbacks/release             |  4 +-
 scripts/atomic/fallbacks/set_release         |  2 +-
 scripts/atomic/fallbacks/sub_and_test        |  6 +-
 scripts/atomic/fallbacks/try_cmpxchg         |  4 +-
 scripts/atomic/gen-atomic-fallback.sh        | 66 ++++++-------------
 scripts/atomic/gen-atomics.sh                |  2 +-
 21 files changed, 71 insertions(+), 91 deletions(-)

diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index 59c0052..ef76408 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,8 +1,8 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}${name}${sfx}_acquire(${params})
+arch_${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
-	${ret} ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${ret} ret = arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index a66635b..15caa2e 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_add_negative - add and test if negative
+ * arch_${atomic}_add_negative - add and test if negative
  * @i: integer value to add
  * @v: pointer of type ${atomic}_t
  *
@@ -9,8 +9,8 @@ cat <<EOF
  * result is greater than or equal to zero.
  */
 static __always_inline bool
-${arch}${atomic}_add_negative(${int} i, ${atomic}_t *v)
+arch_${atomic}_add_negative(${int} i, ${atomic}_t *v)
 {
-	return ${arch}${atomic}_add_return(i, v) < 0;
+	return arch_${atomic}_add_return(i, v) < 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 2ff598a..9e5159c 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${arch}${atomic}_add_unless - add unless the number is already a given value
+ * arch_${atomic}_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -9,8 +9,8 @@ cat << EOF
  * Returns true if the addition was done.
  */
 static __always_inline bool
-${arch}${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	return ${arch}${atomic}_fetch_add_unless(v, a, u) != u;
+	return arch_${atomic}_fetch_add_unless(v, a, u) != u;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 3f18663..5a42f54 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+arch_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-	${retstmt}${arch}${atomic}_${pfx}and${sfx}${order}(~i, v);
+	${retstmt}arch_${atomic}_${pfx}and${sfx}${order}(~i, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index e2e01f0..8c144c8 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+arch_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${arch}${atomic}_${pfx}sub${sfx}${order}(1, v);
+	${retstmt}arch_${atomic}_${pfx}sub${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index e8a5e49..8549f35 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_dec_and_test - decrement and test
+ * arch_${atomic}_dec_and_test - decrement and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically decrements @v by 1 and
@@ -8,8 +8,8 @@ cat <<EOF
  * cases.
  */
 static __always_inline bool
-${arch}${atomic}_dec_and_test(${atomic}_t *v)
+arch_${atomic}_dec_and_test(${atomic}_t *v)
 {
-	return ${arch}${atomic}_dec_return(v) == 0;
+	return arch_${atomic}_dec_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index 527adec..86bdced 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,14 +1,14 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_dec_if_positive(${atomic}_t *v)
+arch_${atomic}_dec_if_positive(${atomic}_t *v)
 {
-	${int} dec, c = ${arch}${atomic}_read(v);
+	${int} dec, c = arch_${atomic}_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, dec));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index dcab684..c531d5a 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-${arch}${atomic}_dec_unless_positive(${atomic}_t *v)
+arch_${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-	${int} c = ${arch}${atomic}_read(v);
+	${int} c = arch_${atomic}_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 3764fc8..07757d8 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,10 +1,10 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}${name}${sfx}(${params})
+arch_${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
 	__atomic_pre_full_fence();
-	ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	ret = arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_post_full_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index 0e0b9ae..68ce13c 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${arch}${atomic}_fetch_add_unless - add unless the number is already a given value
+ * arch_${atomic}_fetch_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -9,14 +9,14 @@ cat << EOF
  * Returns original value of @v
  */
 static __always_inline ${int}
-${arch}${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	${int} c = ${arch}${atomic}_read(v);
+	${int} c = arch_${atomic}_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index 15ec629..3c2c373 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+arch_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${arch}${atomic}_${pfx}add${sfx}${order}(1, v);
+	${retstmt}arch_${atomic}_${pfx}add${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index cecc832..0cf23fe 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_inc_and_test - increment and test
+ * arch_${atomic}_inc_and_test - increment and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1
@@ -8,8 +8,8 @@ cat <<EOF
  * other cases.
  */
 static __always_inline bool
-${arch}${atomic}_inc_and_test(${atomic}_t *v)
+arch_${atomic}_inc_and_test(${atomic}_t *v)
 {
-	return ${arch}${atomic}_inc_return(v) == 0;
+	return arch_${atomic}_inc_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index 50f2d4d..ed8a1f5 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,14 +1,14 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_inc_not_zero - increment unless the number is zero
+ * arch_${atomic}_inc_not_zero - increment unless the number is zero
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
 static __always_inline bool
-${arch}${atomic}_inc_not_zero(${atomic}_t *v)
+arch_${atomic}_inc_not_zero(${atomic}_t *v)
 {
-	return ${arch}${atomic}_add_unless(v, 1, 0);
+	return arch_${atomic}_add_unless(v, 1, 0);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 87629e0..95d8ce4 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-${arch}${atomic}_inc_unless_negative(${atomic}_t *v)
+arch_${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-	${int} c = ${arch}${atomic}_read(v);
+	${int} c = arch_${atomic}_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 341a88d..803ba75 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_read_acquire(const ${atomic}_t *v)
+arch_${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
 }
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index f8906d5..b46feb5 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,8 +1,8 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}${name}${sfx}_release(${params})
+arch_${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
-	${retstmt}${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${retstmt}arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 7606827..86ede75 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline void
-${arch}${atomic}_set_release(${atomic}_t *v, ${int} i)
+arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	smp_store_release(&(v)->counter, i);
 }
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index c580f4c..260f373 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_sub_and_test - subtract value from variable and test result
+ * arch_${atomic}_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
  * @v: pointer of type ${atomic}_t
  *
@@ -9,8 +9,8 @@ cat <<EOF
  * other cases.
  */
 static __always_inline bool
-${arch}${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+arch_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-	return ${arch}${atomic}_sub_return(i, v) == 0;
+	return arch_${atomic}_sub_return(i, v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 06db0f7..890f850 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,9 +1,9 @@
 cat <<EOF
 static __always_inline bool
-${arch}${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+arch_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o = *old;
-	r = ${arch}${atomic}_cmpxchg${order}(v, o, new);
+	r = arch_${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 2601ff4..8e2da71 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -2,11 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ATOMICDIR=$(dirname $0)
-ARCH=$2
 
 . ${ATOMICDIR}/atomic-tbl.sh
 
-#gen_template_fallback(template, meta, pfx, name, sfx, order, arch, atomic, int, args...)
+#gen_template_fallback(template, meta, pfx, name, sfx, order, atomic, int, args...)
 gen_template_fallback()
 {
 	local template="$1"; shift
@@ -15,11 +14,10 @@ gen_template_fallback()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
-	local arch="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local atomicname="${arch}${atomic}_${pfx}${name}${sfx}${order}"
+	local atomicname="arch_${atomic}_${pfx}${name}${sfx}${order}"
 
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
@@ -34,7 +32,7 @@ gen_template_fallback()
 	fi
 }
 
-#gen_proto_fallback(meta, pfx, name, sfx, order, arch, atomic, int, args...)
+#gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
 gen_proto_fallback()
 {
 	local meta="$1"; shift
@@ -65,44 +63,26 @@ gen_proto_order_variant()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
-	local arch="$1"
-	local atomic="$2"
+	local atomic="$1"
 
-	local basename="${arch}${atomic}_${pfx}${name}${sfx}"
+	local basename="arch_${atomic}_${pfx}${name}${sfx}"
 
-	printf "#define arch_${basename}${order} ${basename}${order}\n"
+	printf "#define ${basename}${order} ${basename}${order}\n"
 }
 
-#gen_proto_order_variants(meta, pfx, name, sfx, arch, atomic, int, args...)
+#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
 gen_proto_order_variants()
 {
 	local meta="$1"; shift
 	local pfx="$1"; shift
 	local name="$1"; shift
 	local sfx="$1"; shift
-	local arch="$1"
-	local atomic="$2"
+	local atomic="$1"
 
-	local basename="${arch}${atomic}_${pfx}${name}${sfx}"
+	local basename="arch_${atomic}_${pfx}${name}${sfx}"
 
 	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
-	if [ -z "$arch" ]; then
-		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
-
-		if meta_has_acquire "${meta}"; then
-			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
-		fi
-		if meta_has_release "${meta}"; then
-			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
-		fi
-		if meta_has_relaxed "${meta}"; then
-			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" "$@"
-		fi
-
-		echo ""
-	fi
-
 	# If we don't have relaxed atomics, then we don't bother with ordering fallbacks
 	# read_acquire and set_release need to be templated, though
 	if ! meta_has_relaxed "${meta}"; then
@@ -187,38 +167,38 @@ gen_try_cmpxchg_fallback()
 	local order="$1"; shift;
 
 cat <<EOF
-#ifndef ${ARCH}try_cmpxchg${order}
-#define ${ARCH}try_cmpxchg${order}(_ptr, _oldp, _new) \\
+#ifndef arch_try_cmpxchg${order}
+#define arch_try_cmpxchg${order}(_ptr, _oldp, _new) \\
 ({ \\
 	typeof(*(_ptr)) *___op = (_oldp), ___o = *___op, ___r; \\
-	___r = ${ARCH}cmpxchg${order}((_ptr), ___o, (_new)); \\
+	___r = arch_cmpxchg${order}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r != ___o)) \\
 		*___op = ___r; \\
 	likely(___r == ___o); \\
 })
-#endif /* ${ARCH}try_cmpxchg${order} */
+#endif /* arch_try_cmpxchg${order} */
 
 EOF
 }
 
 gen_try_cmpxchg_fallbacks()
 {
-	printf "#ifndef ${ARCH}try_cmpxchg_relaxed\n"
-	printf "#ifdef ${ARCH}try_cmpxchg\n"
+	printf "#ifndef arch_try_cmpxchg_relaxed\n"
+	printf "#ifdef arch_try_cmpxchg\n"
 
-	gen_basic_fallbacks "${ARCH}try_cmpxchg"
+	gen_basic_fallbacks "arch_try_cmpxchg"
 
-	printf "#endif /* ${ARCH}try_cmpxchg */\n\n"
+	printf "#endif /* arch_try_cmpxchg */\n\n"
 
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_try_cmpxchg_fallback "${order}"
 	done
 
-	printf "#else /* ${ARCH}try_cmpxchg_relaxed */\n"
+	printf "#else /* arch_try_cmpxchg_relaxed */\n"
 
-	gen_order_fallbacks "${ARCH}try_cmpxchg"
+	gen_order_fallbacks "arch_try_cmpxchg"
 
-	printf "#endif /* ${ARCH}try_cmpxchg_relaxed */\n\n"
+	printf "#endif /* arch_try_cmpxchg_relaxed */\n\n"
 }
 
 cat << EOF
@@ -234,14 +214,14 @@ cat << EOF
 
 EOF
 
-for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
+for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
 gen_try_cmpxchg_fallbacks
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
 done
 
 cat <<EOF
@@ -252,7 +232,7 @@ cat <<EOF
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "${ARCH}" "atomic64" "s64" ${args}
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
 
 cat <<EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index f776a57..56b119f 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -10,7 +10,7 @@ LINUXDIR=${ATOMICDIR}/../..
 cat <<EOF |
 gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
 gen-atomic-long.sh              asm-generic/atomic-long.h
-gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
+gen-atomic-fallback.sh          linux/atomic-arch-fallback.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
