Return-Path: <linux-tip-commits+bounces-7815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74648CF4B44
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4C2D30F7E66
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD70309F00;
	Mon,  5 Jan 2026 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1C0sy9DA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cr5qH2yB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFC34847B;
	Mon,  5 Jan 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628486; cv=none; b=O9U4DdfMickLzolpAij44Y9QTVqoBrzy/uBEwoF7vxCJ8w3uK6gJBeUfBb4M95MC9UHYDXasgEkiW8z+6Gr/YePNNP09bjBWj5PsXsgugf2iSl/urDN7ZemoMDnqUSVe5+oz9XUeZjqTRB8f4mHkbQejlCaVnRC1iibYKP+0RPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628486; c=relaxed/simple;
	bh=2vmy07BXdz4icnr/sU+tHAytabfdRFEPvlThuuzFop0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EkPae4AAl5CcOgk7n9pCHx3/kLZPvXx2ROh3sHel5BOlycy2fqouaoQbEMm/GocrRYRxURSaW/fwLofL31mC9RP+3YoHDCXotNG1ytlVYojLh2MNZ2OXy90R3FmcUvh96TCuNbU5sFjkIPlg8Vx2MGwtWOpaAwlWRMqUUWPhXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1C0sy9DA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cr5qH2yB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIxdixmYc0p81nUKPLwB18yzzw23jOiZgwLYBky0hHE=;
	b=1C0sy9DABXfFqcvheuDwkcl/+8pGXbvrqfagdduO5RPJM0bGJ8cCW0SjKfhRLbdSB04M/G
	giyhGjR7AiHa0jdqaYmTQOV0CkTbBgrCNWilheoAkFMoqG8g+Wc3vNPYCs71xynHOkQ1j0
	aH+Z8qpQV/45fLez9WBwMHFc+4v87xz5XJNmzLydxBl4YXvBoi8lbyQq+9KF3MtX0yJzm6
	a0P41Fg9oUJH/INAyBZ7DHuML/Xi8OCurZFILlPwMZshDCaYxEaPad54CZ4p/wAbkSk0/E
	RJbCWiJuEe6UStoz4oj+I+1ULv3UMGqp34NYLfOf40Vs3ljSkjg05PARw+8qTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628481;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIxdixmYc0p81nUKPLwB18yzzw23jOiZgwLYBky0hHE=;
	b=Cr5qH2yBmRgFsMKbuOwI7g71Y3OJlEAdhvJbbBwLKc1wiHqz178mMiLZuCJnakjCGy+BrN
	ilkUOsfRzxUCXlBA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwlock, spinlock: Support Clang's context
 analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-9-elver@google.com>
References: <20251219154418.3592607-9-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762847988.510.10923767212269383287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f16a802d402d735a55731f8c94952b3bbb5ddfe8
Gitweb:        https://git.kernel.org/tip/f16a802d402d735a55731f8c94952b3bbb5=
ddfe8
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:39:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:28 +01:00

locking/rwlock, spinlock: Support Clang's context analysis

Add support for Clang's context analysis for raw_spinlock_t,
spinlock_t, and rwlock. This wholesale conversion is required because
all three of them are interdependent.

To avoid warnings in constructors, the initialization functions mark a
lock as acquired when initialized before guarded variables.

The test verifies that common patterns do not generate false positives.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-9-elver@google.com
---
 Documentation/dev-tools/context-analysis.rst |   3 +-
 include/linux/rwlock.h                       |  25 ++--
 include/linux/rwlock_api_smp.h               |  29 +++-
 include/linux/rwlock_rt.h                    |  35 +++--
 include/linux/rwlock_types.h                 |  10 +-
 include/linux/spinlock.h                     |  93 ++++++++++---
 include/linux/spinlock_api_smp.h             |  14 +-
 include/linux/spinlock_api_up.h              |  71 +++++-----
 include/linux/spinlock_rt.h                  |  21 +--
 include/linux/spinlock_types.h               |  10 +-
 include/linux/spinlock_types_raw.h           |   5 +-
 lib/test_context-analysis.c                  | 128 ++++++++++++++++++-
 12 files changed, 347 insertions(+), 97 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev=
-tools/context-analysis.rst
index 47eb547..746a2d2 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -78,7 +78,8 @@ More details are also documented `here
 Supported Kernel Primitives
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-.. Currently the following synchronization primitives are supported:
+Currently the following synchronization primitives are supported:
+`raw_spinlock_t`, `spinlock_t`, `rwlock_t`.
=20
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 5b87c6f..151f9d5 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -22,23 +22,24 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__rwlock_init((lock), #lock, &__key);			\
+	__assume_ctx_lock(lock);				\
 } while (0)
 #else
 # define rwlock_init(lock)					\
-	do { *(lock) =3D __RW_LOCK_UNLOCKED(lock); } while (0)
+	do { *(lock) =3D __RW_LOCK_UNLOCKED(lock); __assume_ctx_lock(lock); } while=
 (0)
 #endif
=20
 #ifdef CONFIG_DEBUG_SPINLOCK
- extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
+ extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
  extern int do_raw_read_trylock(rwlock_t *lock);
- extern void do_raw_read_unlock(rwlock_t *lock) __releases(lock);
+ extern void do_raw_read_unlock(rwlock_t *lock) __releases_shared(lock);
  extern void do_raw_write_lock(rwlock_t *lock) __acquires(lock);
  extern int do_raw_write_trylock(rwlock_t *lock);
  extern void do_raw_write_unlock(rwlock_t *lock) __releases(lock);
 #else
-# define do_raw_read_lock(rwlock)	do {__acquire(lock); arch_read_lock(&(rwlo=
ck)->raw_lock); } while (0)
+# define do_raw_read_lock(rwlock)	do {__acquire_shared(lock); arch_read_lock=
(&(rwlock)->raw_lock); } while (0)
 # define do_raw_read_trylock(rwlock)	arch_read_trylock(&(rwlock)->raw_lock)
-# define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock=
); __release(lock); } while (0)
+# define do_raw_read_unlock(rwlock)	do {arch_read_unlock(&(rwlock)->raw_lock=
); __release_shared(lock); } while (0)
 # define do_raw_write_lock(rwlock)	do {__acquire(lock); arch_write_lock(&(rw=
lock)->raw_lock); } while (0)
 # define do_raw_write_trylock(rwlock)	arch_write_trylock(&(rwlock)->raw_lock)
 # define do_raw_write_unlock(rwlock)	do {arch_write_unlock(&(rwlock)->raw_lo=
ck); __release(lock); } while (0)
@@ -49,7 +50,7 @@ do {								\
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define read_trylock(lock)	__cond_lock(lock, _raw_read_trylock(lock))
+#define read_trylock(lock)	__cond_lock_shared(lock, _raw_read_trylock(lock))
 #define write_trylock(lock)	__cond_lock(lock, _raw_write_trylock(lock))
=20
 #define write_lock(lock)	_raw_write_lock(lock)
@@ -112,12 +113,12 @@ do {								\
 	} while (0)
 #define write_unlock_bh(lock)		_raw_write_unlock_bh(lock)
=20
-#define write_trylock_irqsave(lock, flags) \
-({ \
-	local_irq_save(flags); \
-	write_trylock(lock) ? \
-	1 : ({ local_irq_restore(flags); 0; }); \
-})
+#define write_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, ({				\
+		local_irq_save(flags);			\
+		_raw_write_trylock(lock) ?		\
+		1 : ({ local_irq_restore(flags); 0; });	\
+	}))
=20
 #ifdef arch_rwlock_is_contended
 #define rwlock_is_contended(lock) \
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 31d3d11..6d5cc0b 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -15,12 +15,12 @@
  * Released under the General Public License (GPL).
  */
=20
-void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires(lock);
+void __lockfunc _raw_read_lock(rwlock_t *lock)		__acquires_shared(lock);
 void __lockfunc _raw_write_lock(rwlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_write_lock_nested(rwlock_t *lock, int subclass)	__acqui=
res(lock);
-void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires(lock);
+void __lockfunc _raw_read_lock_bh(rwlock_t *lock)	__acquires_shared(lock);
 void __lockfunc _raw_write_lock_bh(rwlock_t *lock)	__acquires(lock);
-void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires(lock);
+void __lockfunc _raw_read_lock_irq(rwlock_t *lock)	__acquires_shared(lock);
 void __lockfunc _raw_write_lock_irq(rwlock_t *lock)	__acquires(lock);
 unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
@@ -28,11 +28,11 @@ unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t=
 *lock)
 							__acquires(lock);
 int __lockfunc _raw_read_trylock(rwlock_t *lock);
 int __lockfunc _raw_write_trylock(rwlock_t *lock);
-void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock(rwlock_t *lock)	__releases(lock);
-void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)	__releases(lock);
-void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)	__releases(lock);
+void __lockfunc _raw_read_unlock_irq(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock_irq(rwlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
@@ -145,6 +145,7 @@ static inline int __raw_write_trylock(rwlock_t *lock)
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
=20
 static inline void __raw_read_lock(rwlock_t *lock)
+	__acquires_shared(lock) __no_context_analysis
 {
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
@@ -152,6 +153,7 @@ static inline void __raw_read_lock(rwlock_t *lock)
 }
=20
 static inline unsigned long __raw_read_lock_irqsave(rwlock_t *lock)
+	__acquires_shared(lock) __no_context_analysis
 {
 	unsigned long flags;
=20
@@ -163,6 +165,7 @@ static inline unsigned long __raw_read_lock_irqsave(rwloc=
k_t *lock)
 }
=20
 static inline void __raw_read_lock_irq(rwlock_t *lock)
+	__acquires_shared(lock) __no_context_analysis
 {
 	local_irq_disable();
 	preempt_disable();
@@ -171,6 +174,7 @@ static inline void __raw_read_lock_irq(rwlock_t *lock)
 }
=20
 static inline void __raw_read_lock_bh(rwlock_t *lock)
+	__acquires_shared(lock) __no_context_analysis
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
@@ -178,6 +182,7 @@ static inline void __raw_read_lock_bh(rwlock_t *lock)
 }
=20
 static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	unsigned long flags;
=20
@@ -189,6 +194,7 @@ static inline unsigned long __raw_write_lock_irqsave(rwlo=
ck_t *lock)
 }
=20
 static inline void __raw_write_lock_irq(rwlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	local_irq_disable();
 	preempt_disable();
@@ -197,6 +203,7 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
 }
=20
 static inline void __raw_write_lock_bh(rwlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -204,6 +211,7 @@ static inline void __raw_write_lock_bh(rwlock_t *lock)
 }
=20
 static inline void __raw_write_lock(rwlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -211,6 +219,7 @@ static inline void __raw_write_lock(rwlock_t *lock)
 }
=20
 static inline void __raw_write_lock_nested(rwlock_t *lock, int subclass)
+	__acquires(lock) __no_context_analysis
 {
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
@@ -220,6 +229,7 @@ static inline void __raw_write_lock_nested(rwlock_t *lock=
, int subclass)
 #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
=20
 static inline void __raw_write_unlock(rwlock_t *lock)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
@@ -227,6 +237,7 @@ static inline void __raw_write_unlock(rwlock_t *lock)
 }
=20
 static inline void __raw_read_unlock(rwlock_t *lock)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -235,6 +246,7 @@ static inline void __raw_read_unlock(rwlock_t *lock)
=20
 static inline void
 __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -243,6 +255,7 @@ __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned lon=
g flags)
 }
=20
 static inline void __raw_read_unlock_irq(rwlock_t *lock)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -251,6 +264,7 @@ static inline void __raw_read_unlock_irq(rwlock_t *lock)
 }
=20
 static inline void __raw_read_unlock_bh(rwlock_t *lock)
+	__releases_shared(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_read_unlock(lock);
@@ -259,6 +273,7 @@ static inline void __raw_read_unlock_bh(rwlock_t *lock)
=20
 static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
 					     unsigned long flags)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
@@ -267,6 +282,7 @@ static inline void __raw_write_unlock_irqrestore(rwlock_t=
 *lock,
 }
=20
 static inline void __raw_write_unlock_irq(rwlock_t *lock)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
@@ -275,6 +291,7 @@ static inline void __raw_write_unlock_irq(rwlock_t *lock)
 }
=20
 static inline void __raw_write_unlock_bh(rwlock_t *lock)
+	__releases(lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
 	do_raw_write_unlock(lock);
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 7d81fc6..f64d6d3 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -22,28 +22,32 @@ do {							\
 							\
 	init_rwbase_rt(&(rwl)->rwbase);			\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
+	__assume_ctx_lock(rwl);				\
 } while (0)
=20
-extern void rt_read_lock(rwlock_t *rwlock)	__acquires(rwlock);
+extern void rt_read_lock(rwlock_t *rwlock)	__acquires_shared(rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
-extern void rt_read_unlock(rwlock_t *rwlock)	__releases(rwlock);
+extern void rt_read_unlock(rwlock_t *rwlock)	__releases_shared(rwlock);
 extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquires(=
rwlock);
 extern int rt_write_trylock(rwlock_t *rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
=20
 static __always_inline void read_lock(rwlock_t *rwlock)
+	__acquires_shared(rwlock)
 {
 	rt_read_lock(rwlock);
 }
=20
 static __always_inline void read_lock_bh(rwlock_t *rwlock)
+	__acquires_shared(rwlock)
 {
 	local_bh_disable();
 	rt_read_lock(rwlock);
 }
=20
 static __always_inline void read_lock_irq(rwlock_t *rwlock)
+	__acquires_shared(rwlock)
 {
 	rt_read_lock(rwlock);
 }
@@ -55,37 +59,43 @@ static __always_inline void read_lock_irq(rwlock_t *rwloc=
k)
 		flags =3D 0;				\
 	} while (0)
=20
-#define read_trylock(lock)	__cond_lock(lock, rt_read_trylock(lock))
+#define read_trylock(lock)	__cond_lock_shared(lock, rt_read_trylock(lock))
=20
 static __always_inline void read_unlock(rwlock_t *rwlock)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 }
=20
 static __always_inline void read_unlock_bh(rwlock_t *rwlock)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 	local_bh_enable();
 }
=20
 static __always_inline void read_unlock_irq(rwlock_t *rwlock)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 }
=20
 static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
 						   unsigned long flags)
+	__releases_shared(rwlock)
 {
 	rt_read_unlock(rwlock);
 }
=20
 static __always_inline void write_lock(rwlock_t *rwlock)
+	__acquires(rwlock)
 {
 	rt_write_lock(rwlock);
 }
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 static __always_inline void write_lock_nested(rwlock_t *rwlock, int subclass)
+	__acquires(rwlock)
 {
 	rt_write_lock_nested(rwlock, subclass);
 }
@@ -94,12 +104,14 @@ static __always_inline void write_lock_nested(rwlock_t *=
rwlock, int subclass)
 #endif
=20
 static __always_inline void write_lock_bh(rwlock_t *rwlock)
+	__acquires(rwlock)
 {
 	local_bh_disable();
 	rt_write_lock(rwlock);
 }
=20
 static __always_inline void write_lock_irq(rwlock_t *rwlock)
+	__acquires(rwlock)
 {
 	rt_write_lock(rwlock);
 }
@@ -114,33 +126,34 @@ static __always_inline void write_lock_irq(rwlock_t *rw=
lock)
 #define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
=20
 #define write_trylock_irqsave(lock, flags)		\
-({							\
-	int __locked;					\
-							\
-	typecheck(unsigned long, flags);		\
-	flags =3D 0;					\
-	__locked =3D write_trylock(lock);			\
-	__locked;					\
-})
+	__cond_lock(lock, ({				\
+		typecheck(unsigned long, flags);	\
+		flags =3D 0;				\
+		rt_write_trylock(lock);			\
+	}))
=20
 static __always_inline void write_unlock(rwlock_t *rwlock)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 }
=20
 static __always_inline void write_unlock_bh(rwlock_t *rwlock)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 	local_bh_enable();
 }
=20
 static __always_inline void write_unlock_irq(rwlock_t *rwlock)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 }
=20
 static __always_inline void write_unlock_irqrestore(rwlock_t *rwlock,
 						    unsigned long flags)
+	__releases(rwlock)
 {
 	rt_write_unlock(rwlock);
 }
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 1948442..d5e7316 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -22,7 +22,7 @@
  * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
  * Released under the General Public License (GPL).
  */
-typedef struct {
+context_lock_struct(rwlock) {
 	arch_rwlock_t raw_lock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned int magic, owner_cpu;
@@ -31,7 +31,8 @@ typedef struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
-} rwlock_t;
+};
+typedef struct rwlock rwlock_t;
=20
 #define RWLOCK_MAGIC		0xdeaf1eed
=20
@@ -54,13 +55,14 @@ typedef struct {
=20
 #include <linux/rwbase_rt.h>
=20
-typedef struct {
+context_lock_struct(rwlock) {
 	struct rwbase_rt	rwbase;
 	atomic_t		readers;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-} rwlock_t;
+};
+typedef struct rwlock rwlock_t;
=20
 #define __RWLOCK_RT_INITIALIZER(name)					\
 {									\
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4..72aabdd 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -106,11 +106,12 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
+	__assume_ctx_lock(lock);					\
 } while (0)
=20
 #else
 # define raw_spin_lock_init(lock)				\
-	do { *(lock) =3D __RAW_SPIN_LOCK_UNLOCKED(lock); } while (0)
+	do { *(lock) =3D __RAW_SPIN_LOCK_UNLOCKED(lock); __assume_ctx_lock(lock); }=
 while (0)
 #endif
=20
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
@@ -286,19 +287,19 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *l=
ock) __releases(lock)
 #define raw_spin_trylock_bh(lock) \
 	__cond_lock(lock, _raw_spin_trylock_bh(lock))
=20
-#define raw_spin_trylock_irq(lock) \
-({ \
-	local_irq_disable(); \
-	raw_spin_trylock(lock) ? \
-	1 : ({ local_irq_enable(); 0;  }); \
-})
+#define raw_spin_trylock_irq(lock)			\
+	__cond_lock(lock, ({				\
+		local_irq_disable();			\
+		_raw_spin_trylock(lock) ?		\
+		1 : ({ local_irq_enable(); 0;  });	\
+	}))
=20
-#define raw_spin_trylock_irqsave(lock, flags) \
-({ \
-	local_irq_save(flags); \
-	raw_spin_trylock(lock) ? \
-	1 : ({ local_irq_restore(flags); 0; }); \
-})
+#define raw_spin_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, ({				\
+		local_irq_save(flags);			\
+		_raw_spin_trylock(lock) ?		\
+		1 : ({ local_irq_restore(flags); 0; }); \
+	}))
=20
 #ifndef CONFIG_PREEMPT_RT
 /* Include rwlock functions for !RT */
@@ -334,6 +335,7 @@ do {								\
 								\
 	__raw_spin_lock_init(spinlock_check(lock),		\
 			     #lock, &__key, LD_WAIT_CONFIG);	\
+	__assume_ctx_lock(lock);				\
 } while (0)
=20
 #else
@@ -342,21 +344,25 @@ do {								\
 do {						\
 	spinlock_check(_lock);			\
 	*(_lock) =3D __SPIN_LOCK_UNLOCKED(_lock);	\
+	__assume_ctx_lock(_lock);		\
 } while (0)
=20
 #endif
=20
 static __always_inline void spin_lock(spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	raw_spin_lock(&lock->rlock);
 }
=20
 static __always_inline void spin_lock_bh(spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	raw_spin_lock_bh(&lock->rlock);
 }
=20
 static __always_inline int spin_trylock(spinlock_t *lock)
+	__cond_acquires(lock) __no_context_analysis
 {
 	return raw_spin_trylock(&lock->rlock);
 }
@@ -364,14 +370,17 @@ static __always_inline int spin_trylock(spinlock_t *loc=
k)
 #define spin_lock_nested(lock, subclass)			\
 do {								\
 	raw_spin_lock_nested(spinlock_check(lock), subclass);	\
+	__release(spinlock_check(lock)); __acquire(lock);	\
 } while (0)
=20
 #define spin_lock_nest_lock(lock, nest_lock)				\
 do {									\
 	raw_spin_lock_nest_lock(spinlock_check(lock), nest_lock);	\
+	__release(spinlock_check(lock)); __acquire(lock);	\
 } while (0)
=20
 static __always_inline void spin_lock_irq(spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	raw_spin_lock_irq(&lock->rlock);
 }
@@ -379,47 +388,53 @@ static __always_inline void spin_lock_irq(spinlock_t *l=
ock)
 #define spin_lock_irqsave(lock, flags)				\
 do {								\
 	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
+	__release(spinlock_check(lock)); __acquire(lock);	\
 } while (0)
=20
 #define spin_lock_irqsave_nested(lock, flags, subclass)			\
 do {									\
 	raw_spin_lock_irqsave_nested(spinlock_check(lock), flags, subclass); \
+	__release(spinlock_check(lock)); __acquire(lock);		\
 } while (0)
=20
 static __always_inline void spin_unlock(spinlock_t *lock)
+	__releases(lock) __no_context_analysis
 {
 	raw_spin_unlock(&lock->rlock);
 }
=20
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
+	__releases(lock) __no_context_analysis
 {
 	raw_spin_unlock_bh(&lock->rlock);
 }
=20
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
+	__releases(lock) __no_context_analysis
 {
 	raw_spin_unlock_irq(&lock->rlock);
 }
=20
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigne=
d long flags)
+	__releases(lock) __no_context_analysis
 {
 	raw_spin_unlock_irqrestore(&lock->rlock, flags);
 }
=20
 static __always_inline int spin_trylock_bh(spinlock_t *lock)
+	__cond_acquires(lock) __no_context_analysis
 {
 	return raw_spin_trylock_bh(&lock->rlock);
 }
=20
 static __always_inline int spin_trylock_irq(spinlock_t *lock)
+	__cond_acquires(lock) __no_context_analysis
 {
 	return raw_spin_trylock_irq(&lock->rlock);
 }
=20
 #define spin_trylock_irqsave(lock, flags)			\
-({								\
-	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
-})
+	__cond_lock(lock, raw_spin_trylock_irqsave(spinlock_check(lock), flags))
=20
 /**
  * spin_is_locked() - Check whether a spinlock is locked.
@@ -535,86 +550,132 @@ void free_bucket_spinlocks(spinlock_t *locks);
 DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
 		    raw_spin_lock(_T->lock),
 		    raw_spin_unlock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock, __acquires(_T), __releases(*(raw_sp=
inlock_t **)_T))
+#define class_raw_spinlock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinl=
ock, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_try, __acquires(_T), __releases(*(ra=
w_spinlock_t **)_T))
+#define class_raw_spinlock_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_s=
pinlock_try, _T)
=20
 DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
 		    raw_spin_unlock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, __acquires(_T), __releases(*=
(raw_spinlock_t **)_T))
+#define class_raw_spinlock_nested_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(ra=
w_spinlock_nested, _T)
=20
 DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
 		    raw_spin_lock_irq(_T->lock),
 		    raw_spin_unlock_irq(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq, __acquires(_T), __releases(*(ra=
w_spinlock_t **)_T))
+#define class_raw_spinlock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_s=
pinlock_irq, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lo=
ck))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq_try, __acquires(_T), __releases(=
*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irq_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(r=
aw_spinlock_irq_try, _T)
=20
 DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 		    raw_spin_lock_bh(_T->lock),
 		    raw_spin_unlock_bh(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh, __acquires(_T), __releases(*(raw=
_spinlock_t **)_T))
+#define class_raw_spinlock_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_sp=
inlock_bh, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->lock=
))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __acquires(_T), __releases(*=
(raw_spinlock_t **)_T))
+#define class_raw_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(ra=
w_spinlock_bh_try, _T)
=20
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, __acquires(_T), __releases(=
*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(r=
aw_spinlock_irqsave, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
 			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, __acquires(_T), __relea=
ses(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATT=
RS(raw_spinlock_irqsave_try, _T)
=20
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock, __acquires(_T), __releases(*(spinlock_t=
 **)_T))
+#define class_spinlock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_try, __acquires(_T), __releases(*(spinlo=
ck_t **)_T))
+#define class_spinlock_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_=
try, _T)
=20
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 		    spin_lock_irq(_T->lock),
 		    spin_unlock_irq(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq, __acquires(_T), __releases(*(spinlo=
ck_t **)_T))
+#define class_spinlock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_=
irq, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
 			 spin_trylock_irq(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq_try, __acquires(_T), __releases(*(sp=
inlock_t **)_T))
+#define class_spinlock_irq_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinl=
ock_irq_try, _T)
=20
 DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
 		    spin_lock_bh(_T->lock),
 		    spin_unlock_bh(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh, __acquires(_T), __releases(*(spinloc=
k_t **)_T))
+#define class_spinlock_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_b=
h, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(spinlock_bh, _try,
 			 spin_trylock_bh(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __acquires(_T), __releases(*(spi=
nlock_t **)_T))
+#define class_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlo=
ck_bh_try, _T)
=20
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave, __acquires(_T), __releases(*(sp=
inlock_t **)_T))
+#define class_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinl=
ock_irqsave, _T)
=20
 DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
 			 spin_trylock_irqsave(_T->lock, _T->flags))
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, __acquires(_T), __releases(=
*(spinlock_t **)_T))
+#define class_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(s=
pinlock_irqsave_try, _T)
=20
 DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
 		    read_lock(_T->lock),
 		    read_unlock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(read_lock, __acquires(_T), __releases(*(rwlock_t =
**)_T))
+#define class_read_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(read_lock, _=
T)
=20
 DEFINE_LOCK_GUARD_1(read_lock_irq, rwlock_t,
 		    read_lock_irq(_T->lock),
 		    read_unlock_irq(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(read_lock_irq, __acquires(_T), __releases(*(rwloc=
k_t **)_T))
+#define class_read_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(read_loc=
k_irq, _T)
=20
 DEFINE_LOCK_GUARD_1(read_lock_irqsave, rwlock_t,
 		    read_lock_irqsave(_T->lock, _T->flags),
 		    read_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
+DECLARE_LOCK_GUARD_1_ATTRS(read_lock_irqsave, __acquires(_T), __releases(*(r=
wlock_t **)_T))
+#define class_read_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(read=
_lock_irqsave, _T)
=20
 DEFINE_LOCK_GUARD_1(write_lock, rwlock_t,
 		    write_lock(_T->lock),
 		    write_unlock(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(write_lock, __acquires(_T), __releases(*(rwlock_t=
 **)_T))
+#define class_write_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(write_lock,=
 _T)
=20
 DEFINE_LOCK_GUARD_1(write_lock_irq, rwlock_t,
 		    write_lock_irq(_T->lock),
 		    write_unlock_irq(_T->lock))
+DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irq, __acquires(_T), __releases(*(rwlo=
ck_t **)_T))
+#define class_write_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(write_l=
ock_irq, _T)
=20
 DEFINE_LOCK_GUARD_1(write_lock_irqsave, rwlock_t,
 		    write_lock_irqsave(_T->lock, _T->flags),
 		    write_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
+DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irqsave, __acquires(_T), __releases(*(=
rwlock_t **)_T))
+#define class_write_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(wri=
te_lock_irqsave, _T)
=20
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_sm=
p.h
index 9ecb0ab..d19327e 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -34,8 +34,8 @@ unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinloc=
k_t *lock)
 unsigned long __lockfunc
 _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock, int subclass)
 								__acquires(lock);
-int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock);
-int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);
+int __lockfunc _raw_spin_trylock(raw_spinlock_t *lock)		__cond_acquires(lock=
);
+int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(lo=
ck);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
@@ -84,6 +84,7 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned =
long flags)
 #endif
=20
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
+	__cond_acquires(lock)
 {
 	preempt_disable();
 	if (do_raw_spin_trylock(lock)) {
@@ -102,6 +103,7 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 #if !defined(CONFIG_GENERIC_LOCKBREAK) || defined(CONFIG_DEBUG_LOCK_ALLOC)
=20
 static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	unsigned long flags;
=20
@@ -113,6 +115,7 @@ static inline unsigned long __raw_spin_lock_irqsave(raw_s=
pinlock_t *lock)
 }
=20
 static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	local_irq_disable();
 	preempt_disable();
@@ -121,6 +124,7 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lo=
ck)
 }
=20
 static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -128,6 +132,7 @@ static inline void __raw_spin_lock_bh(raw_spinlock_t *loc=
k)
 }
=20
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
 {
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
@@ -137,6 +142,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 #endif /* !CONFIG_GENERIC_LOCKBREAK || CONFIG_DEBUG_LOCK_ALLOC */
=20
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -145,6 +151,7 @@ static inline void __raw_spin_unlock(raw_spinlock_t *lock)
=20
 static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 					    unsigned long flags)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -153,6 +160,7 @@ static inline void __raw_spin_unlock_irqrestore(raw_spinl=
ock_t *lock,
 }
=20
 static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -161,6 +169,7 @@ static inline void __raw_spin_unlock_irq(raw_spinlock_t *=
lock)
 }
=20
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
+	__releases(lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	do_raw_spin_unlock(lock);
@@ -168,6 +177,7 @@ static inline void __raw_spin_unlock_bh(raw_spinlock_t *l=
ock)
 }
=20
 static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
+	__cond_acquires(lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	if (do_raw_spin_trylock(lock)) {
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index 819aeba..018f5aa 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -24,68 +24,77 @@
  * flags straight, to suppress compiler warnings of unused lock
  * variables, and to add the proper checker annotations:
  */
-#define ___LOCK(lock) \
-  do { __acquire(lock); (void)(lock); } while (0)
+#define ___LOCK_void(lock) \
+  do { (void)(lock); } while (0)
=20
-#define __LOCK(lock) \
-  do { preempt_disable(); ___LOCK(lock); } while (0)
+#define ___LOCK_(lock) \
+  do { __acquire(lock); ___LOCK_void(lock); } while (0)
=20
-#define __LOCK_BH(lock) \
-  do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK(lock);=
 } while (0)
+#define ___LOCK_shared(lock) \
+  do { __acquire_shared(lock); ___LOCK_void(lock); } while (0)
=20
-#define __LOCK_IRQ(lock) \
-  do { local_irq_disable(); __LOCK(lock); } while (0)
+#define __LOCK(lock, ...) \
+  do { preempt_disable(); ___LOCK_##__VA_ARGS__(lock); } while (0)
=20
-#define __LOCK_IRQSAVE(lock, flags) \
-  do { local_irq_save(flags); __LOCK(lock); } while (0)
+#define __LOCK_BH(lock, ...) \
+  do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK_##__VA=
_ARGS__(lock); } while (0)
=20
-#define ___UNLOCK(lock) \
+#define __LOCK_IRQ(lock, ...) \
+  do { local_irq_disable(); __LOCK(lock, ##__VA_ARGS__); } while (0)
+
+#define __LOCK_IRQSAVE(lock, flags, ...) \
+  do { local_irq_save(flags); __LOCK(lock, ##__VA_ARGS__); } while (0)
+
+#define ___UNLOCK_(lock) \
   do { __release(lock); (void)(lock); } while (0)
=20
-#define __UNLOCK(lock) \
-  do { preempt_enable(); ___UNLOCK(lock); } while (0)
+#define ___UNLOCK_shared(lock) \
+  do { __release_shared(lock); (void)(lock); } while (0)
=20
-#define __UNLOCK_BH(lock) \
+#define __UNLOCK(lock, ...) \
+  do { preempt_enable(); ___UNLOCK_##__VA_ARGS__(lock); } while (0)
+
+#define __UNLOCK_BH(lock, ...) \
   do { __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); \
-       ___UNLOCK(lock); } while (0)
+       ___UNLOCK_##__VA_ARGS__(lock); } while (0)
=20
-#define __UNLOCK_IRQ(lock) \
-  do { local_irq_enable(); __UNLOCK(lock); } while (0)
+#define __UNLOCK_IRQ(lock, ...) \
+  do { local_irq_enable(); __UNLOCK(lock, ##__VA_ARGS__); } while (0)
=20
-#define __UNLOCK_IRQRESTORE(lock, flags) \
-  do { local_irq_restore(flags); __UNLOCK(lock); } while (0)
+#define __UNLOCK_IRQRESTORE(lock, flags, ...) \
+  do { local_irq_restore(flags); __UNLOCK(lock, ##__VA_ARGS__); } while (0)
=20
 #define _raw_spin_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
-#define _raw_read_lock(lock)			__LOCK(lock)
+#define _raw_read_lock(lock)			__LOCK(lock, shared)
 #define _raw_write_lock(lock)			__LOCK(lock)
 #define _raw_write_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_spin_lock_bh(lock)			__LOCK_BH(lock)
-#define _raw_read_lock_bh(lock)			__LOCK_BH(lock)
+#define _raw_read_lock_bh(lock)			__LOCK_BH(lock, shared)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
 #define _raw_spin_lock_irq(lock)		__LOCK_IRQ(lock)
-#define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock)
+#define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock, shared)
 #define _raw_write_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_spin_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
-#define _raw_read_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
+#define _raw_read_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags, shar=
ed)
 #define _raw_write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
-#define _raw_spin_trylock(lock)			({ __LOCK(lock); 1; })
-#define _raw_read_trylock(lock)			({ __LOCK(lock); 1; })
-#define _raw_write_trylock(lock)			({ __LOCK(lock); 1; })
-#define _raw_spin_trylock_bh(lock)		({ __LOCK_BH(lock); 1; })
+#define _raw_spin_trylock(lock)			({ __LOCK(lock, void); 1; })
+#define _raw_read_trylock(lock)			({ __LOCK(lock, void); 1; })
+#define _raw_write_trylock(lock)			({ __LOCK(lock, void); 1; })
+#define _raw_spin_trylock_bh(lock)		({ __LOCK_BH(lock, void); 1; })
 #define _raw_spin_unlock(lock)			__UNLOCK(lock)
-#define _raw_read_unlock(lock)			__UNLOCK(lock)
+#define _raw_read_unlock(lock)			__UNLOCK(lock, shared)
 #define _raw_write_unlock(lock)			__UNLOCK(lock)
 #define _raw_spin_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_write_unlock_bh(lock)		__UNLOCK_BH(lock)
-#define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock)
+#define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock, shared)
 #define _raw_spin_unlock_irq(lock)		__UNLOCK_IRQ(lock)
-#define _raw_read_unlock_irq(lock)		__UNLOCK_IRQ(lock)
+#define _raw_read_unlock_irq(lock)		__UNLOCK_IRQ(lock, shared)
 #define _raw_write_unlock_irq(lock)		__UNLOCK_IRQ(lock)
 #define _raw_spin_unlock_irqrestore(lock, flags) \
 					__UNLOCK_IRQRESTORE(lock, flags)
 #define _raw_read_unlock_irqrestore(lock, flags) \
-					__UNLOCK_IRQRESTORE(lock, flags)
+					__UNLOCK_IRQRESTORE(lock, flags, shared)
 #define _raw_write_unlock_irqrestore(lock, flags) \
 					__UNLOCK_IRQRESTORE(lock, flags)
=20
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f6499c3..6bab73e 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -20,6 +20,7 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, co=
nst char *name,
 do {								\
 	rt_mutex_base_init(&(slock)->lock);			\
 	__rt_spin_lock_init(slock, name, key, percpu);		\
+	__assume_ctx_lock(slock);				\
 } while (0)
=20
 #define _spin_lock_init(slock, percpu)				\
@@ -40,6 +41,7 @@ extern int rt_spin_trylock_bh(spinlock_t *lock);
 extern int rt_spin_trylock(spinlock_t *lock);
=20
 static __always_inline void spin_lock(spinlock_t *lock)
+	__acquires(lock)
 {
 	rt_spin_lock(lock);
 }
@@ -82,6 +84,7 @@ static __always_inline void spin_lock(spinlock_t *lock)
 	__spin_lock_irqsave_nested(lock, flags, subclass)
=20
 static __always_inline void spin_lock_bh(spinlock_t *lock)
+	__acquires(lock)
 {
 	/* Investigate: Drop bh when blocking ? */
 	local_bh_disable();
@@ -89,6 +92,7 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 }
=20
 static __always_inline void spin_lock_irq(spinlock_t *lock)
+	__acquires(lock)
 {
 	rt_spin_lock(lock);
 }
@@ -101,23 +105,27 @@ static __always_inline void spin_lock_irq(spinlock_t *l=
ock)
 	} while (0)
=20
 static __always_inline void spin_unlock(spinlock_t *lock)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 }
=20
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 	local_bh_enable();
 }
=20
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 }
=20
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 						   unsigned long flags)
+	__releases(lock)
 {
 	rt_spin_unlock(lock);
 }
@@ -132,14 +140,11 @@ static __always_inline void spin_unlock_irqrestore(spin=
lock_t *lock,
 	__cond_lock(lock, rt_spin_trylock(lock))
=20
 #define spin_trylock_irqsave(lock, flags)		\
-({							\
-	int __locked;					\
-							\
-	typecheck(unsigned long, flags);		\
-	flags =3D 0;					\
-	__locked =3D spin_trylock(lock);			\
-	__locked;					\
-})
+	__cond_lock(lock, ({				\
+		typecheck(unsigned long, flags);	\
+		flags =3D 0;				\
+		rt_spin_trylock(lock);			\
+	}))
=20
 #define spin_is_contended(lock)		(((void)(lock), 0))
=20
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index 2dfa35f..b65bb6e 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -14,7 +14,7 @@
 #ifndef CONFIG_PREEMPT_RT
=20
 /* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
-typedef struct spinlock {
+context_lock_struct(spinlock) {
 	union {
 		struct raw_spinlock rlock;
=20
@@ -26,7 +26,8 @@ typedef struct spinlock {
 		};
 #endif
 	};
-} spinlock_t;
+};
+typedef struct spinlock spinlock_t;
=20
 #define ___SPIN_LOCK_INITIALIZER(lockname)	\
 	{					\
@@ -47,12 +48,13 @@ typedef struct spinlock {
 /* PREEMPT_RT kernels map spinlock to rt_mutex */
 #include <linux/rtmutex.h>
=20
-typedef struct spinlock {
+context_lock_struct(spinlock) {
 	struct rt_mutex_base	lock;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
-} spinlock_t;
+};
+typedef struct spinlock spinlock_t;
=20
 #define __SPIN_LOCK_UNLOCKED(name)				\
 	{							\
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_type=
s_raw.h
index 91cb36b..e5644ab 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -11,7 +11,7 @@
=20
 #include <linux/lockdep_types.h>
=20
-typedef struct raw_spinlock {
+context_lock_struct(raw_spinlock) {
 	arch_spinlock_t raw_lock;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned int magic, owner_cpu;
@@ -20,7 +20,8 @@ typedef struct raw_spinlock {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
-} raw_spinlock_t;
+};
+typedef struct raw_spinlock raw_spinlock_t;
=20
 #define SPINLOCK_MAGIC		0xdead4ead
=20
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 68f075d..273fa9d 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -5,6 +5,7 @@
  */
=20
 #include <linux/build_bug.h>
+#include <linux/spinlock.h>
=20
 /*
  * Test that helper macros work as expected.
@@ -16,3 +17,130 @@ static void __used test_common_helpers(void)
 	BUILD_BUG_ON(context_unsafe((void)2, 3) !=3D 3); /* does not swallow commas=
 */
 	context_unsafe(do { } while (0)); /* works with void statements */
 }
+
+#define TEST_SPINLOCK_COMMON(class, type, type_init, type_lock, type_unlock,=
 type_trylock, op)	\
+	struct test_##class##_data {								\
+		type lock;									\
+		int counter __guarded_by(&lock);						\
+		int *pointer __pt_guarded_by(&lock);						\
+	};											\
+	static void __used test_##class##_init(struct test_##class##_data *d)			\
+	{											\
+		type_init(&d->lock);								\
+		d->counter =3D 0;									\
+	}											\
+	static void __used test_##class(struct test_##class##_data *d)				\
+	{											\
+		unsigned long flags;								\
+		d->pointer++;									\
+		type_lock(&d->lock);								\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock(&d->lock);								\
+		type_lock##_irq(&d->lock);							\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock##_irq(&d->lock);							\
+		type_lock##_bh(&d->lock);							\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock##_bh(&d->lock);							\
+		type_lock##_irqsave(&d->lock, flags);						\
+		op(d->counter);									\
+		op(*d->pointer);								\
+		type_unlock##_irqrestore(&d->lock, flags);					\
+	}											\
+	static void __used test_##class##_trylock(struct test_##class##_data *d)		\
+	{											\
+		if (type_trylock(&d->lock)) {							\
+			op(d->counter);								\
+			type_unlock(&d->lock);							\
+		}										\
+	}											\
+	static void __used test_##class##_assert(struct test_##class##_data *d)			\
+	{											\
+		lockdep_assert_held(&d->lock);							\
+		op(d->counter);									\
+	}											\
+	static void __used test_##class##_guard(struct test_##class##_data *d)			\
+	{											\
+		{ guard(class)(&d->lock);		op(d->counter); }			\
+		{ guard(class##_irq)(&d->lock);		op(d->counter); }			\
+		{ guard(class##_irqsave)(&d->lock);	op(d->counter); }			\
+	}
+
+#define TEST_OP_RW(x) (x)++
+#define TEST_OP_RO(x) ((void)(x))
+
+TEST_SPINLOCK_COMMON(raw_spinlock,
+		     raw_spinlock_t,
+		     raw_spin_lock_init,
+		     raw_spin_lock,
+		     raw_spin_unlock,
+		     raw_spin_trylock,
+		     TEST_OP_RW);
+static void __used test_raw_spinlock_trylock_extra(struct test_raw_spinlock_=
data *d)
+{
+	unsigned long flags;
+
+	if (raw_spin_trylock_irq(&d->lock)) {
+		d->counter++;
+		raw_spin_unlock_irq(&d->lock);
+	}
+	if (raw_spin_trylock_irqsave(&d->lock, flags)) {
+		d->counter++;
+		raw_spin_unlock_irqrestore(&d->lock, flags);
+	}
+	scoped_cond_guard(raw_spinlock_try, return, &d->lock) {
+		d->counter++;
+	}
+}
+
+TEST_SPINLOCK_COMMON(spinlock,
+		     spinlock_t,
+		     spin_lock_init,
+		     spin_lock,
+		     spin_unlock,
+		     spin_trylock,
+		     TEST_OP_RW);
+static void __used test_spinlock_trylock_extra(struct test_spinlock_data *d)
+{
+	unsigned long flags;
+
+	if (spin_trylock_irq(&d->lock)) {
+		d->counter++;
+		spin_unlock_irq(&d->lock);
+	}
+	if (spin_trylock_irqsave(&d->lock, flags)) {
+		d->counter++;
+		spin_unlock_irqrestore(&d->lock, flags);
+	}
+	scoped_cond_guard(spinlock_try, return, &d->lock) {
+		d->counter++;
+	}
+}
+
+TEST_SPINLOCK_COMMON(write_lock,
+		     rwlock_t,
+		     rwlock_init,
+		     write_lock,
+		     write_unlock,
+		     write_trylock,
+		     TEST_OP_RW);
+static void __used test_write_trylock_extra(struct test_write_lock_data *d)
+{
+	unsigned long flags;
+
+	if (write_trylock_irqsave(&d->lock, flags)) {
+		d->counter++;
+		write_unlock_irqrestore(&d->lock, flags);
+	}
+}
+
+TEST_SPINLOCK_COMMON(read_lock,
+		     rwlock_t,
+		     rwlock_init,
+		     read_lock,
+		     read_unlock,
+		     read_trylock,
+		     TEST_OP_RO);

