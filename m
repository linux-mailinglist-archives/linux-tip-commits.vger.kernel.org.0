Return-Path: <linux-tip-commits+bounces-6973-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16337BF5CBB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88026352318
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Oct 2025 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD532D0EA;
	Tue, 21 Oct 2025 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HXLQwEmS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="80QaTZJd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FCD32C33E;
	Tue, 21 Oct 2025 10:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042931; cv=none; b=G8eZ7YLzmhCfCTUc+Z0Y6g83x5a27hX2zJ9LqiVd21y9i69yRQkmtb5co4u6fHZmC8gGuKARNjuBatIIrC7w2cBjBwgZdznUUPlSXdMn12C2ptq53VnnlDiWq8P0tfMFXeIdwU3//uphPDf9OTyp1CbkIGTzB7fI8HBnUX6/F0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042931; c=relaxed/simple;
	bh=v2IbuOvEuvQqoMFDkA+yaL3QBCk9fo/5IwxhzkdVlew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lv9tu48pbM3zzk80MmWCDiEXYF92ElY3EIxuf/lEyd33MlMMiSVUPeeHODd59b0PSSLAM1QrrtMunCsZOdJtlf0LluyY9eTn9UNRUMRyXdrFp/0dgE76/XiC5IKQ3qbllQKpLH71mY1/8OdvnL4CuUiZWWHjJ4qUQloHC4C3zvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HXLQwEmS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=80QaTZJd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 21 Oct 2025 10:35:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761042927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r88f70vg94+Pf3f92FDXH3tjffaP5uI6oHhq4esK5ME=;
	b=HXLQwEmSzb8nGCGtVCi+nLHTSdLI4AAP5WI1u4IJ1otS0ElETNva0cRSJNYvcA3f1v5REH
	1xL1jY81oX/sE+nkXYG8P4gB6LBWasMR4F8OCsdJKg8JR6wxkHvAyYtBSs/6+taOUlFPiO
	zT8225eXcsXA2TgEEtp1gsa2ZluuzsjL4+9s0zsRI1playBdNmLsOIt4NNVa4Xn/50w1NI
	VKuYYIs+2L5/YR8WV7yNN6o7hxWE10VKVgz7lkhZNObH8Czqo088sLhWH7BshB/WmeHpsc
	00jpq/3uZyte63VNfV11UggM6Dsr5CIQG+o55IfIyOypBbGoofIIhq/8WMxtGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761042927;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r88f70vg94+Pf3f92FDXH3tjffaP5uI6oHhq4esK5ME=;
	b=80QaTZJdjN+xC6O/p/OT+IC3bU2yYbKPQypOXZ2bO17qf20ILRy0jwlbI38gT51/g4orx9
	98GyZmEOIyojioCg==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] atomic: Skip alignment check for try_cmpxchg() old arg
Cc: Finn Thain <fthain@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006110740.468309-1-arnd@kernel.org>
References: <20251006110740.468309-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176104292623.2601451.2634511233861010875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     44472d1b83127e579c798ff92a07ae86d98b61b9
Gitweb:        https://git.kernel.org/tip/44472d1b83127e579c798ff92a07ae86d98=
b61b9
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Mon, 06 Oct 2025 13:07:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 21 Oct 2025 12:31:56 +02:00

atomic: Skip alignment check for try_cmpxchg() old arg

The 'old' argument in atomic_try_cmpxchg() and related functions is a
pointer to a normal non-atomic integer number, which does not require
to be naturally aligned, unlike the atomic_t/atomic64_t types themselves.

In order to add an alignment check with CONFIG_DEBUG_ATOMIC into the
normal instrument_atomic_read_write() helper, change this check to use
the non-atomic instrument_read_write(), the same way that was done
earlier for try_cmpxchg() in commit ec570320b09f ("locking/atomic:
Correct (cmp)xchg() instrumentation").

This prevents warnings on m68k calling the 32-bit atomic_try_cmpxchg()
with 16-bit aligned arguments as well as several more architectures
including x86-32 when calling atomic64_try_cmpxchg() with 32-bit
aligned u64 arguments.

Reported-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/cover.1757810729.git.fthain@linux-m68k.org/
---
 include/linux/atomic/atomic-instrumented.h | 26 ++++++++++-----------
 scripts/atomic/gen-atomic-instrumented.sh  | 11 +++++----
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/linux/atomic/atomic-instrumented.h b/include/linux/atomi=
c/atomic-instrumented.h
index 9409a6d..37ab631 100644
--- a/include/linux/atomic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -1276,7 +1276,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg(v, old, new);
 }
=20
@@ -1298,7 +1298,7 @@ static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_acquire(v, old, new);
 }
=20
@@ -1321,7 +1321,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int n=
ew)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_release(v, old, new);
 }
=20
@@ -1343,7 +1343,7 @@ static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_try_cmpxchg_relaxed(v, old, new);
 }
=20
@@ -2854,7 +2854,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg(v, old, new);
 }
=20
@@ -2876,7 +2876,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_acquire(v, old, new);
 }
=20
@@ -2899,7 +2899,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s=
64 new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_release(v, old, new);
 }
=20
@@ -2921,7 +2921,7 @@ static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
=20
@@ -4432,7 +4432,7 @@ atomic_long_try_cmpxchg(atomic_long_t *v, long *old, lo=
ng new)
 {
 	kcsan_mb();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg(v, old, new);
 }
=20
@@ -4454,7 +4454,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_acquire(v, old, new);
 }
=20
@@ -4477,7 +4477,7 @@ atomic_long_try_cmpxchg_release(atomic_long_t *v, long =
*old, long new)
 {
 	kcsan_release();
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_release(v, old, new);
 }
=20
@@ -4499,7 +4499,7 @@ static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
-	instrument_atomic_read_write(old, sizeof(*old));
+	instrument_read_write(old, sizeof(*old));
 	return raw_atomic_long_try_cmpxchg_relaxed(v, old, new);
 }
=20
@@ -5050,4 +5050,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
=20
=20
 #endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
-// 8829b337928e9508259079d32581775ececd415b
+// f618ac667f868941a84ce0ab2242f1786e049ed4
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-a=
tomic-instrumented.sh
index 592f3ec..9c1d53f 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -12,7 +12,7 @@ gen_param_check()
 	local arg=3D"$1"; shift
 	local type=3D"${arg%%:*}"
 	local name=3D"$(gen_param_name "${arg}")"
-	local rw=3D"write"
+	local rw=3D"atomic_write"
=20
 	case "${type#c}" in
 	i) return;;
@@ -20,14 +20,17 @@ gen_param_check()
=20
 	if [ ${type#c} !=3D ${type} ]; then
 		# We don't write to constant parameters.
-		rw=3D"read"
+		rw=3D"atomic_read"
+	elif [ "${type}" =3D "p" ] ; then
+		# The "old" argument in try_cmpxchg() gets accessed non-atomically
+		rw=3D"read_write"
 	elif [ "${meta}" !=3D "s" ]; then
 		# An atomic RMW: if this parameter is not a constant, and this atomic is
 		# not just a 's'tore, this parameter is both read from and written to.
-		rw=3D"read_write"
+		rw=3D"atomic_read_write"
 	fi
=20
-	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\tinstrument_${rw}(${name}, sizeof(*${name}));\n"
 }
=20
 #gen_params_checks(meta, arg...)

