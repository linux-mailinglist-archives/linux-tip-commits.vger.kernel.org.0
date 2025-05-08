Return-Path: <linux-tip-commits+bounces-5473-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43396AAF7F4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54D321C07D72
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3022688B;
	Thu,  8 May 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IBhda1LL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Sjaz0VH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE87223DC3;
	Thu,  8 May 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700436; cv=none; b=Eu5MliEMsw9MlnOHlbf1SOoGnc3IJzwTy5LxE/zst/lVvZPUkrbsROUZE8Y2tPUuiK3IghCRRRkvTi7EgwKm/k0gJLpLf+vM3gWkEJJvkcXvD83eQP/l6zUdnfxTY40Q1+RYKXcs2E7RhtwIKRYGSACp/SJkff38oYGEUMxdMNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700436; c=relaxed/simple;
	bh=KfX+kpU8rA8REOPsib78F5BpJEZMLV1Ya1sXzehwl80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K2+jPoeORe8LSkIyn9UuGhSCjWMurpaw1xBDFUK9CSe1YvSLAP3FvGa5opjzkMOG3S2n6KgZe2LM0RE/ULWzmtlnjDuN1L6Wlb6892iZtcF2qbBx1e5nCmxOylGaTzmcr5TGrGG+tvyviGl7CDQ9oTx8QznsZO5VvdAD9O23f9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IBhda1LL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Sjaz0VH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYFrQWDYxvhP22Mzv1MBwG89mjHY5+SGxqhHQiixUAQ=;
	b=IBhda1LLNb7CMStklkwe1Gg3oglROZ34y4mqle4vC7OiIBjDPnMYZiOuMU0xoawXE50bE4
	9QYNSudXwMMu+rLG/6yjzBwUmR5loPnOAjj5jwQCD+blM5URmgoeXbzJ8+gkNHZbDUr99/
	TY7d597TG9ip0Q76xBq2JVrPsGYEdsNr9WdaPeYPL5cDQPWlvKBMvAXVvxAmt8aYk+9tV5
	0xjUztob1rXbwp48srnqXEvbOVpGQ1kVzp9E/5PkldhG9sb+QUCZjYfULn+3Rj6FKHjBie
	vNmEtrCMv2f7xDq8F9OwZxflbhW8twkpZeM5008DtPbf9xbDX5r8KsfjfbT57A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYFrQWDYxvhP22Mzv1MBwG89mjHY5+SGxqhHQiixUAQ=;
	b=+Sjaz0VHHRGmTacX2x11y19mIvZVjzkjfGdtS3RQ6CZfAHT/vreRNO92V34Df8cJyuP2aD
	nh6GVbBksL4bSeAg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Allow automatic allocation of process
 wide futex hash
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-14-bigeasy@linutronix.de>
References: <20250416162921.513656-14-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043170.406.136721948401145052.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     7c4f75a21f636486d2969d9b6680403ea8483539
Gitweb:        https://git.kernel.org/tip/7c4f75a21f636486d2969d9b6680403ea8483539
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:08 +02:00

futex: Allow automatic allocation of process wide futex hash

Allocate a private futex hash with 16 slots if a task forks its first
thread.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-14-bigeasy@linutronix.de
---
 include/linux/futex.h |  6 ++++++
 kernel/fork.c         | 22 ++++++++++++++++++++++
 kernel/futex/core.c   | 11 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 8f1be08..1d3f755 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -80,6 +80,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
 
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
+int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
 
 static inline void futex_mm_init(struct mm_struct *mm)
@@ -88,6 +89,7 @@ static inline void futex_mm_init(struct mm_struct *mm)
 }
 
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
+static inline int futex_hash_allocate_default(void) { return 0; }
 static inline void futex_hash_free(struct mm_struct *mm) { }
 static inline void futex_mm_init(struct mm_struct *mm) { }
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
@@ -107,6 +109,10 @@ static inline int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsig
 {
 	return -EINVAL;
 }
+static inline int futex_hash_allocate_default(void)
+{
+	return 0;
+}
 static inline void futex_hash_free(struct mm_struct *mm) { }
 static inline void futex_mm_init(struct mm_struct *mm) { }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 831dfec..1f5d808 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2164,6 +2164,13 @@ static void rv_task_fork(struct task_struct *p)
 #define rv_task_fork(p) do {} while (0)
 #endif
 
+static bool need_futex_hash_allocate_default(u64 clone_flags)
+{
+	if ((clone_flags & (CLONE_THREAD | CLONE_VM)) != (CLONE_THREAD | CLONE_VM))
+		return false;
+	return true;
+}
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2545,6 +2552,21 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 
 	/*
+	 * Allocate a default futex hash for the user process once the first
+	 * thread spawns.
+	 */
+	if (need_futex_hash_allocate_default(clone_flags)) {
+		retval = futex_hash_allocate_default();
+		if (retval)
+			goto bad_fork_core_free;
+		/*
+		 * If we fail beyond this point we don't free the allocated
+		 * futex hash map. We assume that another thread will be created
+		 * and makes use of it. The hash map will be freed once the main
+		 * thread terminates.
+		 */
+	}
+	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
 	 * not want user-space to be able to predict the process start-time by
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 818df74..53b3a00 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1294,6 +1294,17 @@ static int futex_hash_allocate(unsigned int hash_slots, bool custom)
 	return 0;
 }
 
+int futex_hash_allocate_default(void)
+{
+	if (!current->mm)
+		return 0;
+
+	if (current->mm->futex_phash)
+		return 0;
+
+	return futex_hash_allocate(16, false);
+}
+
 static int futex_hash_get_slots(void)
 {
 	struct futex_private_hash *fph;

