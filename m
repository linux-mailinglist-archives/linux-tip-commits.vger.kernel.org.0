Return-Path: <linux-tip-commits+bounces-7085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A93C19C50
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A131C859F4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A6234CFD9;
	Wed, 29 Oct 2025 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T92jSK2t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnjEPCDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB2F34BA50;
	Wed, 29 Oct 2025 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733451; cv=none; b=lVZk1CJ54sEbYucDc0Q5NS+4jlc8Pi2OF3iqbnjzMGJrbezwixm1pxduXmRPSlAlk63dMZokKauokgRDiwy0h9vIRLyQ0vG9GrBAmfesi+hYr9xlb5QVc2AuN0bRnkGoIQphLD1rMmBorYO4UyqgFygI6ezIL4qmz3hERplM9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733451; c=relaxed/simple;
	bh=bKl1eWHbvkwKWWGmDSjBwne5RyW+I9e1gSt7Z81aSGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N6ArRnCLF0Jv7hkTgFVB6raW0+uBuFEazlVJr2xAFtxqFQLFRpcGihMQjeFyUGoUAzj58uLv8s62fsCPIUnYQEpmMdBTXthtLVuGS7OhF7FM2N2CCM9iGL+aZMWwUZ9JM1dgxkd67xFIl3+uASI/Rtovh+yC5iVkofXSNWoML3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T92jSK2t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XnjEPCDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmmR47tV/ei2QO6KTZlph/2Aa8nPO6RQFf+IRLlOOZg=;
	b=T92jSK2tmPvvsr0sk8U972nXe1fBGetdba1xsMfK9lvhXM4JmH27InulkFeMv/ThwhyFSW
	AyUnzm9OTcryxYj8Gf+ODEYisvpRkvodr7l8/nehB3gobrG4CS/vwBdJpHXaRQgHgsH9VT
	1u06nHNokIuSHezNMruD6e5WtVs+Zh4tlsF/RvCPC5buGWH+jPGnuApBjAj3uA6TwJIBWD
	UkJitrG9q+MYsB2u9MxjdmMzxJWL5L3YQL8N190PNWUrx1af4dhPsY41Z1yz69tPbvKnPG
	XnwjCmOclkl2sIfrxgfyRFfbkrYmOV6sfGD3ZgzMXmjLIrjA1/LbPN0GcXbQVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UmmR47tV/ei2QO6KTZlph/2Aa8nPO6RQFf+IRLlOOZg=;
	b=XnjEPCDZgdNJy89OIWSxT7PEXdM+ml3IrAdt69FM3NOaBSRijmkN0Hxz1jOgRZyYTSFQV7
	ETw0WCxWDYjXFAAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] futex: Convert to get/put_user_inline()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027083745.736737934@linutronix.de>
References: <20251027083745.736737934@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344660.2601451.5718059126503367083.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     536e6a70108b609e36866efe8c401d1ed32759ea
Gitweb:        https://git.kernel.org/tip/536e6a70108b609e36866efe8c401d1ed32=
759ea
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:10 +01:00

futex: Convert to get/put_user_inline()

Replace the open coded implementation with the new get/put_user_inline()
helpers. This might be replaced by a regular get/put_user(), but that needs
a proper performance evaluation.

No functional change intended

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251027083745.736737934@linutronix.de
---
 kernel/futex/core.c  |  4 +--
 kernel/futex/futex.h | 58 ++-----------------------------------------
 2 files changed, 5 insertions(+), 57 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 125804f..ebcccb1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -581,7 +581,7 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, =
union futex_key *key,
 	if (flags & FLAGS_NUMA) {
 		u32 __user *naddr =3D (void *)uaddr + size / 2;
=20
-		if (futex_get_value(&node, naddr))
+		if (get_user_inline(node, naddr))
 			return -EFAULT;
=20
 		if ((node !=3D FUTEX_NO_NODE) &&
@@ -601,7 +601,7 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, =
union futex_key *key,
 			node =3D numa_node_id();
 			node_updated =3D true;
 		}
-		if (node_updated && futex_put_value(node, naddr))
+		if (node_updated && put_user_inline(node, naddr))
 			return -EFAULT;
 	}
=20
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 2cd5709..30c2afa 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -281,63 +281,11 @@ static inline int futex_cmpxchg_value_locked(u32 *curva=
l, u32 __user *uaddr, u32
 	return ret;
 }
=20
-/*
- * This does a plain atomic user space read, and the user pointer has
- * already been verified earlier by get_futex_key() to be both aligned
- * and actually in user space, just like futex_atomic_cmpxchg_inatomic().
- *
- * We still want to avoid any speculation, and while __get_user() is
- * the traditional model for this, it's actually slower than doing
- * this manually these days.
- *
- * We could just have a per-architecture special function for it,
- * the same way we do futex_atomic_cmpxchg_inatomic(), but rather
- * than force everybody to do that, write it out long-hand using
- * the low-level user-access infrastructure.
- *
- * This looks a bit overkill, but generally just results in a couple
- * of instructions.
- */
-static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
-{
-	u32 val;
-
-	if (can_do_masked_user_access())
-		from =3D masked_user_access_begin(from);
-	else if (!user_read_access_begin(from, sizeof(*from)))
-		return -EFAULT;
-	unsafe_get_user(val, from, Efault);
-	user_read_access_end();
-	*dest =3D val;
-	return 0;
-Efault:
-	user_read_access_end();
-	return -EFAULT;
-}
-
-static __always_inline int futex_put_value(u32 val, u32 __user *to)
-{
-	if (can_do_masked_user_access())
-		to =3D masked_user_access_begin(to);
-	else if (!user_write_access_begin(to, sizeof(*to)))
-		return -EFAULT;
-	unsafe_put_user(val, to, Efault);
-	user_write_access_end();
-	return 0;
-Efault:
-	user_write_access_end();
-	return -EFAULT;
-}
-
+/* Read from user memory with pagefaults disabled */
 static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
 {
-	int ret;
-
-	pagefault_disable();
-	ret =3D futex_get_value(dest, from);
-	pagefault_enable();
-
-	return ret;
+	guard(pagefault)();
+	return get_user_inline(*dest, from);
 }
=20
 extern void __futex_unqueue(struct futex_q *q);

