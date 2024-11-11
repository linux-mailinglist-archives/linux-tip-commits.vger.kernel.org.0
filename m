Return-Path: <linux-tip-commits+bounces-2831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A0D9C3C82
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715CA1F215A9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1496175D34;
	Mon, 11 Nov 2024 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9Ux/U3Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vj+YfZe7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4E16EBED;
	Mon, 11 Nov 2024 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322686; cv=none; b=SFrvsUvJgc87qheGHL/5iSCQ5Sq9MruX+6aVifTguRngt+oN3aGc9UTeRy3awhLGGIjFYiEBdIZqShjZgZ0k9l01SFjzT9YUiBgIFiWBeGDCcmrve+/lVnr11mnLgrklv0bpO2s2sGivjUsx4EmdUd/Y50qqaXChf22wEYspPgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322686; c=relaxed/simple;
	bh=YT1dJBtg3VfeCDPOh5PbeJ8yKqMR++yP5XbA2aF23LU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fq6pzcb7H6szsqWsUWBFJ547+Rw4t1pTUWSjY8lOy+AF29DvqKG68vOmbftTBbonAQKAwibYwZoJ4LjnNUTOiP+TXfL8eTcWyrcZ/xb9VSt/+KeDkOrb54d3pVMnHuTNiEV61QoBm7olHLENEMWQWS05xixBj6VxVcqfCxAlXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9Ux/U3Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vj+YfZe7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:58:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0mJr8ruuIECWzwzkYq7FeiwALMqMdpoUcKx9NQTlbc=;
	b=j9Ux/U3ZSGTjVeFrnnTe8yw/8sJwsXJrm0sfTY2mbjamoDRloFJdoXrbyiy8U4T1oloMOQ
	4SEmEOo+8L8H/fvSPXDB9Gs8oFM6l3vWpct95pAnGjDZkESp6W07VGwQr34PGP/OT1mWJR
	fuaZnvk0A0wOR35z8szGMWcjSmouxk/bgUwthE5Ye6EArlWfl/zCpG8OcLjjfR7aaJYj9e
	MZzWwW36eX6stT/OAyrHILglQUWdLaLy65tm6CVPhg1VabSrcucTjvaMFX55L1s62kGCaj
	qbRC6l/qsLVKdfV9yCQI1P5X8Bajr49pWD/W4tKXKaKZlzTSFSBwzMeXQJfspw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322683;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0mJr8ruuIECWzwzkYq7FeiwALMqMdpoUcKx9NQTlbc=;
	b=vj+YfZe7NPXoFyvOx5k6l2kpx/8nNBvCyadHLj5ZoDSCGmLDXusl2AnqehQfTqwmyy1n0o
	Z4KsfScaFFkQK5BQ==
From: "tip-bot2 for Eder Zulian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rust: helpers: Avoid raw_spin_lock initialization
 for PREEMPT_RT
Cc: kernel test robot <lkp@intel.com>, Eder Zulian <ezulian@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241107163223.2092690-2-ezulian@redhat.com>
References: <20241107163223.2092690-2-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132268241.32228.2951825322377955708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5c2e7736e20d9b348a44cafbfa639fe2653fbc34
Gitweb:        https://git.kernel.org/tip/5c2e7736e20d9b348a44cafbfa639fe2653fbc34
Author:        Eder Zulian <ezulian@redhat.com>
AuthorDate:    Thu, 07 Nov 2024 17:32:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:46 +01:00

rust: helpers: Avoid raw_spin_lock initialization for PREEMPT_RT

When PREEMPT_RT=y, spin locks are mapped to rt_mutex types, so using
spinlock_check() + __raw_spin_lock_init() to initialize spin locks is
incorrect, and would cause build errors.

Introduce __spin_lock_init() to initialize a spin lock with lockdep
rquired information for PREEMPT_RT builds, and use it in the Rust
helper.

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
Closes: https://lore.kernel.org/oe-kbuild-all/202409251238.vetlgXE9-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eder Zulian <ezulian@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Tested-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241107163223.2092690-2-ezulian@redhat.com
---
 include/linux/spinlock_rt.h | 15 +++++++--------
 rust/helpers/spinlock.c     |  8 ++++++--
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f9f14e1..f6499c3 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -16,22 +16,21 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 }
 #endif
 
-#define spin_lock_init(slock)					\
+#define __spin_lock_init(slock, name, key, percpu)		\
 do {								\
-	static struct lock_class_key __key;			\
-								\
 	rt_mutex_base_init(&(slock)->lock);			\
-	__rt_spin_lock_init(slock, #slock, &__key, false);	\
+	__rt_spin_lock_init(slock, name, key, percpu);		\
 } while (0)
 
-#define local_spin_lock_init(slock)				\
+#define _spin_lock_init(slock, percpu)				\
 do {								\
 	static struct lock_class_key __key;			\
-								\
-	rt_mutex_base_init(&(slock)->lock);			\
-	__rt_spin_lock_init(slock, #slock, &__key, true);	\
+	__spin_lock_init(slock, #slock, &__key, percpu);	\
 } while (0)
 
+#define spin_lock_init(slock)		_spin_lock_init(slock, false)
+#define local_spin_lock_init(slock)	_spin_lock_init(slock, true)
+
 extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
 extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock);
 extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index acc1376..92f7fc4 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -7,10 +7,14 @@ void rust_helper___spin_lock_init(spinlock_t *lock, const char *name,
 				  struct lock_class_key *key)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
+# if defined(CONFIG_PREEMPT_RT)
+	__spin_lock_init(lock, name, key, false);
+# else /*!CONFIG_PREEMPT_RT */
 	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
-#else
+# endif /* CONFIG_PREEMPT_RT */
+#else /* !CONFIG_DEBUG_SPINLOCK */
 	spin_lock_init(lock);
-#endif
+#endif /* CONFIG_DEBUG_SPINLOCK */
 }
 
 void rust_helper_spin_lock(spinlock_t *lock)

