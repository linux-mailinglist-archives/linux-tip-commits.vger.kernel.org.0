Return-Path: <linux-tip-commits+bounces-2538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE19AE120
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49EDB2333C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 09:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3A1C879E;
	Thu, 24 Oct 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LzvZjIdc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qoslzmvK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2776B18B46D;
	Thu, 24 Oct 2024 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762632; cv=none; b=hAiMsMq7yM5BvtYCRI9fCcxNUG3vBjgP/N+nbSsgi3En7eAfTBXe6xrQdolc47t2Z+tcvN1+1T1j46PuEFJ9ECmE8Dffe1bZwbkYkgwn9Got9B1mGfHLUXb98np76RyVVLlcNT3gsFRpMa8ES3GG5dlIsmbGosfff0pcvPAkP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762632; c=relaxed/simple;
	bh=9vWWcUG0DDdd5gZSPP6to5l5OHbi1a1a3nDwiMGCwgo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ItjYCEAGUhX5myejc5C2qdWR/BxGa5XuZ8b72s1A8Epkiy12x4gxE0rsY4R2+U7YV+gT/wS79XMpjaCK/A/+Ajk23iXdiWi7EchJEjpbRt+F+1oBcfCoZPK/vLv1csZfpk6iYuYNWU1BP703JnK3qszyIw+a1pIKg4g7A5BbiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LzvZjIdc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qoslzmvK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 09:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729762628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0CJTf6p3TcFLhLDFnV3Xs0SYQVFkz0M2QHR+ZSI6Tw=;
	b=LzvZjIdckejNX9NhutP3VEjqx5Qp4rFK8guhc5ai7dm2wh6x5Kn7yLPCH8tSHFdoKWI2z9
	dU/MOCB4TOKYDhbRVbfqdcxYmpU1xw8mhGIpexI77F9nmbyWtdxTxR8oBCylJCFN7kkBfW
	Spv1o+N24w/JNTEeCBcv4jneXeV7cNxl0CfhPx8ssDa+lSveiiHN5BH7RkuzCUfsvIZTj/
	JzRXX8O88wO9bWO/MOcr3liTsLpO/opRVCTNucwKR0prD/cIWt+ccbnjnHIrTTvMZH/Qcz
	kBfcPtx3iNtPQp+twpk6tad9wyGWsGJo64CDPqxOG+S2Ou1tgBONo24/AmJC8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729762628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0CJTf6p3TcFLhLDFnV3Xs0SYQVFkz0M2QHR+ZSI6Tw=;
	b=qoslzmvKfgwqJBnNPor6fjrmlkUazDEDk4tv4BJSZTTMR3pADE0c/PfOvLFDpX0Te8QcU4
	eFK46S9JPjfs22AA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rt: Add sparse annotation PREEMPT_RT's
 sleeping locks.
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240812104200.2239232-2-bigeasy@linutronix.de>
References: <20240812104200.2239232-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976262776.1442.16420209741219015912.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     52e0874fc16bd26e9ea1871e30ffb2c6dff187cf
Gitweb:        https://git.kernel.org/tip/52e0874fc16bd26e9ea1871e30ffb2c6dff187cf
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Mon, 12 Aug 2024 12:39:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 11:27:01 +02:00

locking/rt: Add sparse annotation PREEMPT_RT's sleeping locks.

The sleeping locks on PREEMPT_RT (rt_spin_lock() and friends) lack
sparse annotation. Therefore a missing spin_unlock() won't be spotted by
sparse in a PREEMPT_RT build while it is noticed on a !PREEMPT_RT build.

Add the __acquires/__releases macros to the lock/ unlock functions. The
trylock functions already use the __cond_lock() wrapper.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812104200.2239232-2-bigeasy@linutronix.de

---
 include/linux/rwlock_rt.h   | 10 +++++-----
 include/linux/spinlock_rt.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 8544ff0..7d81fc6 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -24,13 +24,13 @@ do {							\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
 } while (0)
 
-extern void rt_read_lock(rwlock_t *rwlock);
+extern void rt_read_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
-extern void rt_read_unlock(rwlock_t *rwlock);
-extern void rt_write_lock(rwlock_t *rwlock);
-extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
+extern void rt_read_unlock(rwlock_t *rwlock)	__releases(rwlock);
+extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
+extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquires(rwlock);
 extern int rt_write_trylock(rwlock_t *rwlock);
-extern void rt_write_unlock(rwlock_t *rwlock);
+extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
 
 static __always_inline void read_lock(rwlock_t *rwlock)
 {
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 61c49b1..babc3e0 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -32,10 +32,10 @@ do {								\
 	__rt_spin_lock_init(slock, #slock, &__key, true);	\
 } while (0)
 
-extern void rt_spin_lock(spinlock_t *lock);
-extern void rt_spin_lock_nested(spinlock_t *lock, int subclass);
-extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock);
-extern void rt_spin_unlock(spinlock_t *lock);
+extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
+extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock);
+extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
+extern void rt_spin_unlock(spinlock_t *lock)	__releases(lock);
 extern void rt_spin_lock_unlock(spinlock_t *lock);
 extern int rt_spin_trylock_bh(spinlock_t *lock);
 extern int rt_spin_trylock(spinlock_t *lock);

