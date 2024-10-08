Return-Path: <linux-tip-commits+bounces-2365-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 722DB9941F7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF693B26D55
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138002101B6;
	Tue,  8 Oct 2024 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2F3znm55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5NepKel"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424220CCE1;
	Tue,  8 Oct 2024 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374189; cv=none; b=ez3pK35QnHm5vpZxXxlB0xeGpDnRxydFdNKOJcqAyLx+sHHT1YGcupqDAEaF2cdpuQHy1deMiO3KtyckTpNQRe6OuO9ZKcSlzZPmPNJ7848luYwARE64GrtH0yqE2XctUTBj2XzjsBlmgZO+4MkfdiPcr+5H8+1FmzUooeAuQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374189; c=relaxed/simple;
	bh=Q4AD3SLr8crQszBDazTJglcDmiwQvIa5mWJpv1tWiSc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fTiZ7XjFwzrwfhUUIwhTd04bhQdqmQACoJORXACjHKgGZ6Apcw/HTq3d7E3f96DuZWM7xbHna7KkoqN7rX3zWaRF0zpnAq5VljS17OTqQ2/8xLUoiz5iz6FQ1JLWBNmsK93XI7g6IDPWXzqYbIHT7K+IUKRSYDj80P4NRx977SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2F3znm55; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5NepKel; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TJ7dGkLXhKEPHyRn+9R9ECLhfD7twqI06CXK+DeibE=;
	b=2F3znm55Eme0rKXGYHeSqD51oth+qDdBz3YzQQYBA13OWsZRdYGT6YvvaQTqOD6madPlD6
	RGxhotmvukA5sdwv9JFO5dK8hfV3fovQBxryUom7p7Dw5TIH4+iArv0JtLvgcy5/+5GZZS
	TggkGGP7kx5/PjmFEFTRK9X+pyfm3p3tDrEoV7AQR2LDPKZ0drJ6hhXwMiZ5eHx+MKjrLb
	zd6RPpiz6V4GxhO/wLvBjZplBYblo/gZdw9Q5Zn5ALDdhIVd1SEVaQh+XmZpyvNQFkz5Ml
	zNVKtDf+W4N8fgtazqwG6/l7OOlQnafYvfx2LI6qnvGP9Q8c3PXU9BPvkzKsdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TJ7dGkLXhKEPHyRn+9R9ECLhfD7twqI06CXK+DeibE=;
	b=X5NepKelWDb4OtPmT8xIL7i9je0rjSzOApG3jQXp4DB3/fOD5DbUfBwJT1tzHL1wANnMCT
	h99ArKPaunKQNECA==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Improve documentation for
 wake_up_bit/wait_on_bit family of functions
Cc: NeilBrown <neilb@suse.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-3-neilb@suse.de>
References: <20240925053405.3960701-3-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418407.1442.13366117387943725921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3cdee6b359f134da22f7fd4606e0338413cfd79e
Gitweb:        https://git.kernel.org/tip/3cdee6b359f134da22f7fd4606e0338413cfd79e
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:39 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:37 +02:00

sched: Improve documentation for wake_up_bit/wait_on_bit family of functions

This patch revises the documention for wake_up_bit(),
clear_and_wake_up_bit(), and all the wait_on_bit() family of functions.

The new documentation places less emphasis on the pool of waitqueues
used (an implementation detail) and focuses instead on details of how
the functions behave.

The barriers included in the wait functions and clear_and_wake_up_bit()
and those required for wake_up_bit() are spelled out more clearly.

The error statuses returned are given explicitly.

The fact that the wait_on_bit_lock() function sets the bit is made more
obvious.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-3-neilb@suse.de
---
 include/linux/wait_bit.h | 159 ++++++++++++++++++++------------------
 kernel/sched/wait_bit.c  |  34 ++++----
 2 files changed, 107 insertions(+), 86 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 48e1238..723e7bf 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -53,19 +53,21 @@ extern int bit_wait_io_timeout(struct wait_bit_key *key, int mode);
 
 /**
  * wait_on_bit - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that waits on a bit.
- * For instance, if one were to have waiters on a bitflag, one would
- * call wait_on_bit() in threads waiting for the bit to clear.
- * One uses wait_on_bit() where one is waiting for the bit to clear,
- * but has no intention of setting it.
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the target bit, even
+ * if other processes on the same queue are waiting for other bits.
+ *
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
@@ -80,17 +82,20 @@ wait_on_bit(unsigned long *word, int bit, unsigned mode)
 
 /**
  * wait_on_bit_io - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared.  This is similar to wait_on_bit(), but calls
- * io_schedule() instead of schedule() for the actual waiting.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * This is similar to wait_on_bit(), but calls io_schedule() instead of
+ * schedule() for the actual waiting.
  *
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
@@ -104,19 +109,24 @@ wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_timeout - wait for a bit to be cleared or a timeout to elapse
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  * @timeout: timeout, in jiffies
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared. This is similar to wait_on_bit(), except also takes a
- * timeout parameter.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared, or for a timeout to expire.  The
+ * clearing of the bit must be signalled with wake_up_bit(), often as
+ * clear_and_wake_up_bit().
  *
- * Returned value will be zero if the bit was cleared before the
- * @timeout elapsed, or non-zero if the @timeout elapsed or process
- * received a signal and the mode permitted wakeup on that signal.
+ * This is similar to wait_on_bit(), except it also takes a timeout
+ * parameter.
+ *
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal, or %-EAGAIN if the
+ * timeout elapsed.
  */
 static inline int
 wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,
@@ -132,19 +142,21 @@ wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,
 
 /**
  * wait_on_bit_action - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit waited on
+ * @bit: the bit at that address being waited on
  * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared, and allow the waiting action to be specified.
- * This is like wait_on_bit() but allows fine control of how the waiting
- * is done.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * This is similar to wait_on_bit(), but calls @action() instead of
+ * schedule() for the actual waiting.
  *
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or the error code returned by @action if
+ * that call returned non-zero.
  */
 static inline int
 wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,
@@ -157,23 +169,22 @@ wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,
 }
 
 /**
- * wait_on_bit_lock - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @mode: the task state to sleep in
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that waits on a bit
- * when one intends to set it, for instance, trying to lock bitflags.
- * For instance, if one were to have waiters trying to set bitflag
- * and waiting for it to clear before setting it, one would call
- * wait_on_bit() in threads waiting to be able to set the bit.
- * One uses wait_on_bit_lock() where one is waiting for the bit to
- * clear with the intention of setting it, and when done, clearing it.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared.  The clearing of the bit must be
+ * signalled with wake_up_bit(), often as clear_and_wake_up_bit().  As
+ * soon as it is clear, atomically set it and return.
  *
- * Returns zero if the bit was (eventually) found to be clear and was
- * set.  Returns non-zero if a signal was delivered to the process and
- * the @mode allows that signal to wake the process.
+ * This is similar to wait_on_bit(), but sets the bit before returning.
+ *
+ * Returned value will be zero if the bit was successfully set in which
+ * case the call has the same memory sequencing semantics as
+ * test_and_clear_bit(), or %-EINTR if the process received a signal and
+ * the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)
@@ -185,15 +196,18 @@ wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_lock_io - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock_io - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared and then to atomically set it.  This is similar
- * to wait_on_bit(), but calls io_schedule() instead of schedule()
- * for the actual waiting.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared.  The clearing of the bit must be
+ * signalled with wake_up_bit(), often as clear_and_wake_up_bit().  As
+ * soon as it is clear, atomically set it and return.
+ *
+ * This is similar to wait_on_bit_lock(), but calls io_schedule() instead
+ * of schedule().
  *
  * Returns zero if the bit was (eventually) found to be clear and was
  * set.  Returns non-zero if a signal was delivered to the process and
@@ -209,21 +223,19 @@ wait_on_bit_lock_io(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_lock_action - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock_action - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared and then to set it, and allow the waiting action
- * to be specified.
- * This is like wait_on_bit() but allows fine control of how the waiting
- * is done.
+ * This is similar to wait_on_bit_lock(), but calls @action() instead of
+ * schedule() for the actual waiting.
  *
- * Returns zero if the bit was (eventually) found to be clear and was
- * set.  Returns non-zero if a signal was delivered to the process and
- * the @mode allows that signal to wake the process.
+ * Returned value will be zero if the bit was successfully set in which
+ * case the call has the same memory sequencing semantics as
+ * test_and_clear_bit(), or the error code returned by @action if that
+ * call returned non-zero.
  */
 static inline int
 wait_on_bit_lock_action(unsigned long *word, int bit, wait_bit_action_f *action,
@@ -320,12 +332,13 @@ do {									\
 
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
- *
  * @bit: the bit of the word being waited on
- * @word: the word being waited on, a kernel virtual address
+ * @word: the address containing the bit being waited on
  *
- * You can use this helper if bitflags are manipulated atomically rather than
- * non-atomically under a lock.
+ * The designated bit is cleared and any tasks waiting in wait_on_bit()
+ * or similar will be woken.  This call has RELEASE semantics so that
+ * any changes to memory made before this call are guaranteed to be visible
+ * after the corresponding wait_on_bit() completes.
  */
 static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 {
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 058b0e1..bd2fc75 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -128,21 +128,29 @@ void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit
 EXPORT_SYMBOL(__wake_up_bit);
 
 /**
- * wake_up_bit - wake up a waiter on a bit
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wake_up_bit - wake up waiters on a bit
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hash-table's accessor API that wakes up waiters
- * on a bit. For instance, if one were to have waiters on a bitflag,
- * one would call wake_up_bit() after clearing the bit.
+ * Wake up any process waiting in wait_on_bit() or similar for the
+ * given bit to be cleared.
  *
- * In order for this to function properly, as it uses waitqueue_active()
- * internally, some kind of memory barrier must be done prior to calling
- * this. Typically, this will be smp_mb__after_atomic(), but in some
- * cases where bitflags are manipulated non-atomically under a lock, one
- * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
- * because spin_unlock() does not guarantee a memory barrier.
+ * The wake-up is sent to tasks in a waitqueue selected by hash from a
+ * shared pool.  Only those tasks on that queue which have requested
+ * wake_up on this specific address and bit will be woken, and only if the
+ * bit is clear.
+ *
+ * In order for this to function properly there must be a full memory
+ * barrier after the bit is cleared and before this function is called.
+ * If the bit was cleared atomically, such as a by clear_bit() then
+ * smb_mb__after_atomic() can be used, othwewise smb_mb() is needed.
+ * If the bit was cleared with a fully-ordered operation, no further
+ * barrier is required.
+ *
+ * Normally the bit should be cleared by an operation with RELEASE
+ * semantics so that any changes to memory made before the bit is
+ * cleared are guaranteed to be visible after the matching wait_on_bit()
+ * completes.
  */
 void wake_up_bit(unsigned long *word, int bit)
 {

