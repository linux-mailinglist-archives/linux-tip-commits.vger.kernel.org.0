Return-Path: <linux-tip-commits+bounces-7829-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23384D02AE9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 08 Jan 2026 13:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D45F3037D63
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Jan 2026 12:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B733F0767;
	Thu,  8 Jan 2026 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMCdkNLl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vrk0Y0G9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55313EFD2E;
	Thu,  8 Jan 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767866991; cv=none; b=Np0CVUgm2IC5qlIhOq4nFkDpUL8Lq3m/1jmL4TQ0RUHL7kNSsSq9MCw5/csk5IriXc6LwxatKyJyYJzwDQ1kkR8HPEX+i29SUNRdck18qymt0gLyqCq7xATgag6MuYXmHMmFmiSnF7i3GjN8g10EEY180KdYU1S2i+7GGLATpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767866991; c=relaxed/simple;
	bh=CwUyO/FKUGfV08Qij5iAH1+kR7XP+etimPiGhQjViLY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Jl1WE6cNtMZ+bwku4Ou+q3IIDRQfCIEtSGw9f0mHTM2KieQERpG9fgm0hXXYYoCjsyTmawX4Wii5Q4agZwooOfUU2Et/mdsnjLqEWGHvKhnHrA5O06512kMTbxlcv4MPgh+kADMHNEarjpzMt38joiV89BNJUwtT9XNsp8hWB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMCdkNLl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vrk0Y0G9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Jan 2026 10:09:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767866983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaPdFhHC/1EymCq6Q8ZFc/2p4VlZxy2O5TwfUs97hg4=;
	b=gMCdkNLlJTVf895vlWEgWamlMejwE9ZA5kox6pmwEEDz0xw1JVO26DlE9YENYaeD2UErrT
	tRMotac+Yw4eYGjznKg26lB+n0xZ7ThizO2UTw901x7WjKaWZ9iKV/7viG/1O9LU6bVBB6
	Zl/WBRA5QF11p1j5hCdqZARkZvTgZx98TZHTnnsNmkUFRE3iWkwPuQCsa6l3enKtZMLIYC
	lPtyHE2awcauE4dKjvdK3lRWrP1WudKvRyIPfChsHhhqvLI9IQ+7LcMAEG3BQArjOwRc25
	/ujeOcxuIiFkBjBu4li3fezTxEDu5em1zRkHhez+OYwwlqz5CQ0ino6+oeu4/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767866983;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaPdFhHC/1EymCq6Q8ZFc/2p4VlZxy2O5TwfUs97hg4=;
	b=vrk0Y0G9MWJGSc/7U4YfldSCS9dFNDGDKzyzx2JFt2PkAPeP1//+AfbXpxl2TFcswqKcvB
	JQVwic45bgzFuEAQ==
From: "tip-bot2 for oldzhu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] scripts/atomic: Fix kerneldoc spelling in try_cmpxchg()
Cc: oldzhu <oldrunner999@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260106040158.31461-1-oldrunner999@gmail.com>
References: <20260106040158.31461-1-oldrunner999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176786697837.510.11486972805286097023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0e2036a06dcf61dbd100168830287d6c42cd61e1
Gitweb:        https://git.kernel.org/tip/0e2036a06dcf61dbd100168830287d6c42c=
d61e1
Author:        oldzhu <oldrunner999@gmail.com>
AuthorDate:    Tue, 06 Jan 2026 12:01:58 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:28 +01:00

scripts/atomic: Fix kerneldoc spelling in try_cmpxchg()

Fix a typo in the kerneldoc comment template.

This changes 'occured' to 'occurred' in generated documentation.

Signed-off-by: oldzhu <oldrunner999@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260106040158.31461-1-oldrunner999@gmail.com
---
 include/linux/atomic/atomic-arch-fallback.h | 18 +++++++-------
 include/linux/atomic/atomic-instrumented.h  | 26 ++++++++++----------
 include/linux/atomic/atomic-long.h          | 10 ++++----
 scripts/atomic/kerneldoc/try_cmpxchg        |  2 +-
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atom=
ic/atomic-arch-fallback.h
index 2f9d36b..cdc25f8 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -2121,7 +2121,7 @@ raw_atomic_cmpxchg_relaxed(atomic_t *v, int old, int ne=
w)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
@@ -2155,7 +2155,7 @@ raw_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_acquire() elsewher=
e.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
@@ -2189,7 +2189,7 @@ raw_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, i=
nt new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_release() elsewher=
e.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
@@ -2222,7 +2222,7 @@ raw_atomic_try_cmpxchg_release(atomic_t *v, int *old, i=
nt new)
  *
  * Safe to use in noinstr code; prefer atomic_try_cmpxchg_relaxed() elsewher=
e.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
@@ -4247,7 +4247,7 @@ raw_atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s6=
4 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
@@ -4281,7 +4281,7 @@ raw_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 n=
ew)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_acquire() elsewh=
ere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
@@ -4315,7 +4315,7 @@ raw_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *ol=
d, s64 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_release() elsewh=
ere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
@@ -4348,7 +4348,7 @@ raw_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *ol=
d, s64 new)
  *
  * Safe to use in noinstr code; prefer atomic64_try_cmpxchg_relaxed() elsewh=
ere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
@@ -4690,4 +4690,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
=20
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// b565db590afeeff0d7c9485ccbca5bb6e155749f
+// 206314f82b8b73a5c3aa69cf7f35ac9e7b5d6b58
diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomi=
c/atomic-instrumented.h
index 37ab631..feb3b5d 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1269,7 +1269,7 @@ atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg() there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
@@ -1292,7 +1292,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_acquire() there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
@@ -1314,7 +1314,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int n=
ew)
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_release() there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
@@ -1337,7 +1337,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int n=
ew)
  *
  * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg_relaxed() there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
@@ -2847,7 +2847,7 @@ atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 ne=
w)
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg() there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
@@ -2870,7 +2870,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_acquire() the=
re.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
@@ -2892,7 +2892,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s=
64 new)
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_release() the=
re.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
@@ -2915,7 +2915,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s=
64 new)
  *
  * Unsafe to use in noinstr code; use raw_atomic64_try_cmpxchg_relaxed() the=
re.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
@@ -4425,7 +4425,7 @@ atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old,=
 long new)
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg() there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
@@ -4448,7 +4448,7 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, lo=
ng new)
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_acquire() =
there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
@@ -4470,7 +4470,7 @@ atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long =
*old, long new)
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_release() =
there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
@@ -4493,7 +4493,7 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long =
*old, long new)
  *
  * Unsafe to use in noinstr code; use raw_atomic_long_try_cmpxchg_relaxed() =
there.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
@@ -5050,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
=20
=20
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// f618ac667f868941a84ce0ab2242f1786e049ed4
+// 9dd948d3012b22c4e75933a5172983f912e46439
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic=
-long.h
index f86b29d..6a4e47d 100644
--- a/include/linux/atomic/atomic-long.h
+++ b/include/linux/atomic/atomic-long.h
@@ -1449,7 +1449,7 @@ raw_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long =
old, long new)
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg() elsewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
@@ -1473,7 +1473,7 @@ raw_atomic_long_try_cmpxchg(atomic_long_t *v, long *old=
, long new)
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_acquire() els=
ewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
@@ -1497,7 +1497,7 @@ raw_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, l=
ong *old, long new)
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_release() els=
ewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
@@ -1521,7 +1521,7 @@ raw_atomic_long_try_cmpxchg_release(atomic_long_t *v, l=
ong *old, long new)
  *
  * Safe to use in noinstr code; prefer atomic_long_try_cmpxchg_relaxed() els=
ewhere.
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 static __always_inline bool
 raw_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
@@ -1809,4 +1809,4 @@ raw_atomic_long_dec_if_positive(atomic_long_t *v)
 }
=20
 #endif /* _LINUX_ATOMIC_LONG_H */
-// eadf183c3600b8b92b91839dd3be6bcc560c752d
+// 4b882bf19018602c10816c52f8b4ae280adc887b
diff --git a/scripts/atomic/kerneldoc/try_cmpxchg b/scripts/atomic/kerneldoc/=
try_cmpxchg
index 3ccff29..4dfc7a1 100644
--- a/scripts/atomic/kerneldoc/try_cmpxchg
+++ b/scripts/atomic/kerneldoc/try_cmpxchg
@@ -11,6 +11,6 @@ cat <<EOF
  *
  * ${desc_noinstr}
  *
- * Return: @true if the exchange occured, @false otherwise.
+ * Return: @true if the exchange occurred, @false otherwise.
  */
 EOF

