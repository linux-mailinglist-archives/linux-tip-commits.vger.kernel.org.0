Return-Path: <linux-tip-commits+bounces-7560-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9E3C93D34
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Nov 2025 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 122E54E108F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Nov 2025 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01E275B1A;
	Sat, 29 Nov 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bb60VA7u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GR21/nQu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD71CFBA;
	Sat, 29 Nov 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764416990; cv=none; b=GKn5zS/hBtmlesflLpgt3CaPD3bEROblNBz64d9AKtGkXsiHz15JjV4uWj7BMsoUk4ziXOt8ld+o8h/xBMFqFXKgaMz6vZeiOJDU9W5TiAC9qsWRPvckj93ZljXjwjihiHXwLbypSXErYjyl2tK3FWUlZDHQP4XwjrsAoPZu824=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764416990; c=relaxed/simple;
	bh=Y1ITZBAbySBBBYPn2in96VW/ok4hAZIVAcy3aQH5RtM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ShICs/vf+3HyRlctZcbF+I3T1TtFAiIZAoK7CUaPCkU552NVZk1bUcBZBjG56rkra5/g0A0I0VWYMT01SYDGFqa8ZbzE6C0xC6MaCHFYciZn/2XN0s/O4UbA9980ZIER70qrdXfeUSFPPfh1o6S4HTDUXFX+jWs6qpgmDRDyAsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bb60VA7u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GR21/nQu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Nov 2025 11:49:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764416980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/eQYYdrT9yHqH4KWJAt04UeXjB4jrVesFEPIlXwsxE=;
	b=bb60VA7utfP6KgoUhNPuj+ZjrL5Nln4csf1L7+nBD3i2zS8TkYGsPZk33NmOzi4VJ0RpzL
	4qwh1+7vsEsV71sWtGwMpaF4ZwegSlCIe9eWx4mPqmOBm9YL8YzPUYRClCW5+VQZGkf+Ft
	Rlw8gK6kgj+hWJ6ZiAkW/gGfkQHzuV9cPvPY9vzlGl+HKmmpeu5Bd8r2V0g9N4Ha6KHHaQ
	7f1lK3D0cQQ/bRQkiBiT69swR5Son+KLD4fREhpYV+qK2LmfLQPXO2HuC7l4iE+ALd39Tb
	rvf5nMCsCb5fqHpTzSL861xYc0HkJWZoeOifDinoPO/gmSPaMLXDczRoTMcfZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764416980;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/eQYYdrT9yHqH4KWJAt04UeXjB4jrVesFEPIlXwsxE=;
	b=GR21/nQuOW3SEAVBUkm5faCFzKdkhuLxCJwEKZFK45+ldSX3zjFbhRcrdhMlH10pPL1wQD
	JADDuMKbLoQCfPCw==
From: "tip-bot2 for Vincent Mailhol" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/local_lock: s/l/__l/ and s/tl/__tl/ to
 reduce risk of shadowing
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127144140.215722-3-bigeasy@linutronix.de>
References: <20251127144140.215722-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176441697926.498.16028633398899763353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     4b9405200ced4d5c90d3dfe61036833ed6fb439c
Gitweb:        https://git.kernel.org/tip/4b9405200ced4d5c90d3dfe61036833ed6f=
b439c
Author:        Vincent Mailhol <mailhol@kernel.org>
AuthorDate:    Thu, 27 Nov 2025 15:41:40 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 28 Nov 2025 11:09:02 +01:00

locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce risk of shadowing

The Linux kernel coding style advises to avoid common variable
names in function-like macros to reduce the risk of collisions.

Throughout local_lock_internal.h, several macros use the rather common
variable names 'l' and 'tl'. This already resulted in an actual
collision: the __local_lock_acquire() function like macro is currently
shadowing the parameter 'l' of the:

  class_##_name##_t class_##_name##_constructor(_type *l)

function factory from linux/cleanup.h.

Rename the variable 'l' to '__l' and the variable 'tl' to '__tl'
throughout the file to fix the current name collision and to prevent
future ones.

[ bigeasy: Rebase, update all l and tl instances in macros ]

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251127144140.215722-3-bigeasy@linutronix.de
---
 include/linux/local_lock_internal.h | 62 ++++++++++++++--------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index a4dc479..8f82b4e 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -99,18 +99,18 @@ do {								\
=20
 #define __local_lock_acquire(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l =3D (local_lock_t *)(lock);				\
-		tl =3D (local_trylock_t *)l;				\
+		__l =3D (local_lock_t *)(lock);				\
+		__tl =3D (local_trylock_t *)__l;				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired =3D=3D 0);	\
-				WRITE_ONCE(tl->acquired, 1);		\
+				lockdep_assert(__tl->acquired =3D=3D 0);	\
+				WRITE_ONCE(__tl->acquired, 1);		\
 			}),						\
 			local_lock_t *: (void)0);			\
-		local_lock_acquire(l);					\
+		local_lock_acquire(__l);				\
 	} while (0)
=20
 #define __local_lock(lock)					\
@@ -133,36 +133,36 @@ do {								\
=20
 #define __local_trylock(lock)					\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		preempt_disable();				\
-		tl =3D (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl =3D (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			preempt_enable();			\
-			tl =3D NULL;				\
+			__tl =3D NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
=20
 #define __local_trylock_irqsave(lock, flags)			\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		local_irq_save(flags);				\
-		tl =3D (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl =3D (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			local_irq_restore(flags);		\
-			tl =3D NULL;				\
+			__tl =3D NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
=20
 /* preemption or migration must be disabled before calling __local_lock_is_l=
ocked */
@@ -170,16 +170,16 @@ do {								\
=20
 #define __local_lock_release(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l =3D (local_lock_t *)(lock);				\
-		tl =3D (local_trylock_t *)l;				\
-		local_lock_release(l);					\
+		__l =3D (local_lock_t *)(lock);				\
+		__tl =3D (local_trylock_t *)__l;				\
+		local_lock_release(__l);				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired =3D=3D 1);	\
-				WRITE_ONCE(tl->acquired, 0);		\
+				lockdep_assert(__tl->acquired =3D=3D 1);	\
+				WRITE_ONCE(__tl->acquired, 0);		\
 			}),						\
 			local_lock_t *: (void)0);			\
 	} while (0)
@@ -223,12 +223,12 @@ typedef spinlock_t local_trylock_t;
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 #define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
=20
-#define __local_lock_init(l)					\
+#define __local_lock_init(__l)					\
 	do {							\
-		local_spin_lock_init((l));			\
+		local_spin_lock_init((__l));			\
 	} while (0)
=20
-#define __local_trylock_init(l)			__local_lock_init(l)
+#define __local_trylock_init(__l)			__local_lock_init(__l)
=20
 #define __local_lock(__lock)					\
 	do {							\

