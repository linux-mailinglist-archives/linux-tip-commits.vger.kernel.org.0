Return-Path: <linux-tip-commits+bounces-2364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC769941F5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69671F2B631
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16822101AF;
	Tue,  8 Oct 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1NSHx91";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7UYiLoAx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412120CCDF;
	Tue,  8 Oct 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374189; cv=none; b=M/S2meFFbFD89Gy4MPK4IeiWH+RXbuKPWK2QhrEiahihqhL+XVr+qraSY0P5mK9BtTtNFrBhPPgHL1wn626oJZAL2mioqTs0ymxYU65bUZNO/fHtsHCJbXzOPwaeqAWjCeff3MoJmGSjqqGOlLlm6N7XYyO5o93JkhRSbqzl+U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374189; c=relaxed/simple;
	bh=gn7oURVkPKEg0OYVOQb3S7TGLL79TrGAJf+KBQj1o5k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xs13KxcSxhgqq3G83gtYrCDKoq7rgY8ZMpcCzEtBu+bOJgk1rpeOb5WOOMKfnGqfMmE/aCU6IEXikCFCIGVKjaWCZVZYna5RyS0uBzLtUlru4uNoOA4i7CSS+PMQi4enekmKLMCu72aQkmTT7CkOCNn6/AX3srdJ8vRiMooZ9i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1NSHx91; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7UYiLoAx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtJt0pXi+/QNcqsb26bbuGp1jMNgWTCEjgS1eJBL6Mo=;
	b=t1NSHx91RArwaqCGFxa40B773LanUk4xGqa4YTh8nkQA2CoOwspuCLxwCFtwmAnymj2lBd
	O5IGz70uWPY2Jl71omCvien8FzanbCPu+0aR4tDbEvBcXOzp66B5GF8uMZdFgpWDcvKlgv
	wVDMoHpWNU8iE7JGg49pr7whi59jlUh9UscHBOJ5Ks0LKizsrS67KRl+8L7j1iuYGry5mR
	Q+b4XtPUkANi5YUhqY6dxn84AaS0suk5vtTfR8QPAxkrhDvbUHKB/9ZZsz0oPLXvU4Xpxh
	SR0xfTFsZViCyL0h5EoR7uIFNnlab4GoeKYucYOCRXI7iP5G7eCXMUNewW6f8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtJt0pXi+/QNcqsb26bbuGp1jMNgWTCEjgS1eJBL6Mo=;
	b=7UYiLoAxSY3qWITqUoqc/XnG9Cd54xWt+fyllBhFsZ+jKsb9++AQbQp5yIi5EaC+gA9H2/
	fpDraTBz32oxxmCg==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Document wait_var_event() family of
 functions and wake_up_var()
Cc: NeilBrown <neilb@suse.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-4-neilb@suse.de>
References: <20240925053405.3960701-4-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418342.1442.9502398497537716109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bf39882edc798279765ca31751f6e679b50b97ef
Gitweb:        https://git.kernel.org/tip/bf39882edc798279765ca31751f6e679b50b97ef
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:40 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:38 +02:00

sched: Document wait_var_event() family of functions and wake_up_var()

wake_up_var(), wait_var_event() and related interfaces are not
documented but have important ordering requirements.  This patch adds
documentation and makes these requirements explicit.

The return values for those wait_var_event_* functions which return a
value are documented.  Note that these are, perhaps surprisingly,
sometimes different from comparable wait_on_bit() functions.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-4-neilb@suse.de
---
 include/linux/wait_bit.h | 71 +++++++++++++++++++++++++++++++++++++++-
 kernel/sched/wait_bit.c  | 30 ++++++++++++++++-
 2 files changed, 101 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 723e7bf..06ec99b 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -282,6 +282,22 @@ __out:	__ret;								\
 	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			  schedule())
 
+/**
+ * wait_var_event - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true, only re-checking when a wake up is
+ * received for the given @var (an arbitrary kernel address which need
+ * not be directly related to the given condition, but usually is).
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the given address.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event(var, condition)					\
 do {									\
 	might_sleep();							\
@@ -294,6 +310,24 @@ do {									\
 	___wait_var_event(var, condition, TASK_KILLABLE, 0, 0,		\
 			  schedule())
 
+/**
+ * wait_var_event_killable - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true or a fatal signal to be received,
+ * only re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is
+ * 0 if the condition became true, or %-ERESTARTSYS if a fatal signal
+ * was received.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_killable(var, condition)				\
 ({									\
 	int __ret = 0;							\
@@ -308,6 +342,26 @@ do {									\
 			  TASK_UNINTERRUPTIBLE, 0, timeout,		\
 			  __ret = schedule_timeout(__ret))
 
+/**
+ * wait_var_event_timeout - wait for a variable to be updated or a timeout to expire
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ * @timeout: maximum time to wait in jiffies
+ *
+ * Wait for a @condition to be true or a timeout to expire, only
+ * re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is 0 if
+ * the timeout expired and the condition was still false, or the
+ * remaining time left in the timeout (but at least 1) if the condition
+ * was found to be true.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_timeout(var, condition, timeout)			\
 ({									\
 	long __ret = timeout;						\
@@ -321,6 +375,23 @@ do {									\
 	___wait_var_event(var, condition, TASK_INTERRUPTIBLE, 0, 0,	\
 			  schedule())
 
+/**
+ * wait_var_event_killable - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true or a signal to be received, only
+ * re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is 0 if
+ * the condition became true, or %-ERESTARTSYS if a signal was received.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_interruptible(var, condition)			\
 ({									\
 	int __ret = 0;							\
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index bd2fc75..22ec270 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -196,6 +196,36 @@ void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int 
 }
 EXPORT_SYMBOL(init_wait_var_entry);
 
+/**
+ * wake_up_var - wake up waiters on a variable (kernel address)
+ * @var: the address of the variable being waited on
+ *
+ * Wake up any process waiting in wait_var_event() or similar for the
+ * given variable to change.  wait_var_event() can be waiting for an
+ * arbitrary condition to be true and associates that condition with an
+ * address.  Calling wake_up_var() suggests that the condition has been
+ * made true, but does not strictly require the condtion to use the
+ * address given.
+ *
+ * The wake-up is sent to tasks in a waitqueue selected by hash from a
+ * shared pool.  Only those tasks on that queue which have requested
+ * wake_up on this specific address will be woken.
+ *
+ * In order for this to function properly there must be a full memory
+ * barrier after the variable is updated (or more accurately, after the
+ * condition waited on has been made to be true) and before this function
+ * is called.  If the variable was updated atomically, such as a by
+ * atomic_dec() then smb_mb__after_atomic() can be used.  If the
+ * variable was updated by a fully ordered operation such as
+ * atomic_dec_and_test() then no extra barrier is required.  Otherwise
+ * smb_mb() is needed.
+ *
+ * Normally the variable should be updated (the condition should be made
+ * to be true) by an operation with RELEASE semantics such as
+ * smp_store_release() so that any changes to memory made before the
+ * variable was updated are guaranteed to be visible after the matching
+ * wait_var_event() completes.
+ */
 void wake_up_var(void *var)
 {
 	__wake_up_bit(__var_waitqueue(var), var, -1);

