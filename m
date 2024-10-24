Return-Path: <linux-tip-commits+bounces-2537-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8169AE11E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A565C1F21160
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0332D1C4A37;
	Thu, 24 Oct 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mp+i7Uyc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5X9ShSVI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06EE14C5B3;
	Thu, 24 Oct 2024 09:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762630; cv=none; b=IsWFX+My8j/wM5thsH5+VfZX6LskPgNQ6r2P22LtOlAVjiIy0wZ29WCFy2f6lZU4KR7pJbiUTpetPfGttG4LuikafBXzpW3GeBKETmDf3IFEVcaL+FQt9nDpSOh3LHQMKOE6fqrDmoIVX6VNH1Po1xoYP87iBoD377u9AfZYs9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762630; c=relaxed/simple;
	bh=0yhYUgVBIRP2FSomWs1J9BvZixN19p87f0pNqeyA48c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mr4he/gaw/0JsgTUwUejUfrPRk9woi8bPsyXGEpfb2l+0c/N/47RHFFLfg76x/LZ3FhC7xRVXuSPQ27hjIe/TlYOsKL//DqZknZVR/vw5HK3VCiInn/vhzQYNx9W4+gmdH/lz1PSyFSPJb9WZHVI9/cy2mwM6SUlHGs2zDS5gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mp+i7Uyc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5X9ShSVI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 09:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729762627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwMXz9609Vr09pxnCmOChUWADhv3eIbRQpEisCvzXVM=;
	b=Mp+i7UycMhd2U5aO/xHw72guuByM8/6yM915ML1GhTPUhR1ub0CE65Iw4DtzTIdaRqw0uy
	x7yFB03YAhkTWGLWgzFx2a3TdFPVIzVp1czY/XzKaPXDxmWclvLJ/u28d8IUl4Ti6Q/Ef0
	ZEd9Hi36mChm4uPj2kkN62aibMskaHH1bUEn6DYGxMk9foaPlJV7MqUe+h96vTogFrlMQS
	rFkYABO+EQCZ7FuAM3yEeDfWELYmjk7DsQVHOcv9do9GVWWGoopNF9fw3aCmMqGNJCCBZ4
	napSQScCGZDlZ+oO9hIBO0KhincKCPOo55heZlKcbVHUvj1JOaRq0DH8n3o+XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729762627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwMXz9609Vr09pxnCmOChUWADhv3eIbRQpEisCvzXVM=;
	b=5X9ShSVIMpllvNUdp07OXlPusPGAxrxWWYHnhkqC77Xu2Vc6nFzeM2OjJv85ddYxg+cuXC
	wtbD5Btm15tCMODQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rt: Add sparse annotation for RCU.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812104200.2239232-4-bigeasy@linutronix.de>
References: <20240812104200.2239232-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976262647.1442.12633197284362217278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     168660b826a77fda28235e0b0b3027041d6a5240
Gitweb:        https://git.kernel.org/tip/168660b826a77fda28235e0b0b3027041d6a5240
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 12:39:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 11:27:02 +02:00

locking/rt: Add sparse annotation for RCU.

Every lock, that becomes a sleeping lock on PREEMPT_RT, starts a RCU read
side critical section. There is no sparse annotation for this and sparse
complains about unbalanced locking.

Add __acquires/ __releases for the RCU lock. This covers all but the
trylock functions. A __cond_acquires() annotation didn't work.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812104200.2239232-4-bigeasy@linutronix.de

---
 kernel/locking/spinlock_rt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 38e2924..d1cf8b2 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -51,7 +51,7 @@ static __always_inline void __rt_spin_lock(spinlock_t *lock)
 	migrate_disable();
 }
 
-void __sched rt_spin_lock(spinlock_t *lock)
+void __sched rt_spin_lock(spinlock_t *lock) __acquires(RCU)
 {
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	__rt_spin_lock(lock);
@@ -75,7 +75,7 @@ void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
 EXPORT_SYMBOL(rt_spin_lock_nest_lock);
 #endif
 
-void __sched rt_spin_unlock(spinlock_t *lock)
+void __sched rt_spin_unlock(spinlock_t *lock) __releases(RCU)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
@@ -225,7 +225,7 @@ int __sched rt_write_trylock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_trylock);
 
-void __sched rt_read_lock(rwlock_t *rwlock)
+void __sched rt_read_lock(rwlock_t *rwlock) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
@@ -235,7 +235,7 @@ void __sched rt_read_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_lock);
 
-void __sched rt_write_lock(rwlock_t *rwlock)
+void __sched rt_write_lock(rwlock_t *rwlock) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
@@ -246,7 +246,7 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 EXPORT_SYMBOL(rt_write_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
+void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
@@ -257,7 +257,7 @@ void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
 EXPORT_SYMBOL(rt_write_lock_nested);
 #endif
 
-void __sched rt_read_unlock(rwlock_t *rwlock)
+void __sched rt_read_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
@@ -266,7 +266,7 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_unlock);
 
-void __sched rt_write_unlock(rwlock_t *rwlock)
+void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	rcu_read_unlock();

