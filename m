Return-Path: <linux-tip-commits+bounces-2363-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE79941F4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A4CF1F28FCA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DEF21019E;
	Tue,  8 Oct 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9GhyhgY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q1IBcOz2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841BB20CCE0;
	Tue,  8 Oct 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374189; cv=none; b=d/dVrbQZUTt7IL95UAr+Zch8eqsv6XpdGrFHTeWRjdKObsDoM0IW3pA/ZeU8cAjfBd+AoH/wmrDXVfXF3o1hjehVuBVA/yD+BsiTZZ8V1DB49IHkJ9MS+fk9FgoVSon55v8T6JSWwkc92a8ZRtZM3u2BYEWGP09DwesoI5hTcgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374189; c=relaxed/simple;
	bh=GyiXyblQSDeuIiM9qzQzeotdhIXAer8o5OxR0ztHFH4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DtWfoPlBtbZGcguyjcYpFfVUvXoV76gB0sxqp7T+nrPyreUIIgkNk3OHT7ceMWlTjo7Z0TrfzL0TGmHXzG06WDdI13yySnUFfOXP4ns3RRZehDMehkDghjj72MnXC0Uc6wd+MrY0YIfAKQ3wXtF4N3MOFiKoiR5ZuE0OqtcWfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9GhyhgY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q1IBcOz2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ipuzteb/y6h9VYagSTzRvpcnt3bXfIKEoFGa5v+4TM=;
	b=c9GhyhgYuaU73mpSvhp1OPTPTIPpZs0Sdi2ompaMV6xJxNjnUR+xBsr54j7fqEgMBns1oh
	peCcBWZXm1yD/sQNXKZoN90lUyQnTUK0e+EQHM1HbqtmA08Vo1MZEgE5rtep7aPILx4iAZ
	c7AaMbj9EDVYHjG/qDIEd4PiAhBuA5yrw2yXw7RjDvT6whkKe9EBelpzklcqCiJbiY+65C
	6RAuEE2B6bQ/33LQpQLu+tnNmDEQIkKIWavtfvNKjnMedtOXAIePvSuOTPu8z45631d0/e
	ujfVJHNTJFxhPmCDxJsqGmniXWD/GbBM6R+gEchwy+s0QT9U3A5s82uIoOoeNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374185;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Ipuzteb/y6h9VYagSTzRvpcnt3bXfIKEoFGa5v+4TM=;
	b=Q1IBcOz2C5bRHeCCdmaMIV+Stfj/lbS2134dZ8fGn+8AsZaseG8n5RC1By6k7RiJ4bsYs3
	FtngSDjfcdhHQaBA==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: change wake_up_bit() and related function to
 expect unsigned long *
Cc: Linus Torvalds <torvalds@linux-foundation.org>, NeilBrown <neilb@suse.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-2-neilb@suse.de>
References: <20240925053405.3960701-2-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418466.1442.11617718153560736412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2382d68d7d43873ba856baf567cab0d5c523f23b
Gitweb:        https://git.kernel.org/tip/2382d68d7d43873ba856baf567cab0d5c523f23b
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:38 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:37 +02:00

sched: change wake_up_bit() and related function to expect unsigned long *

wake_up_bit() currently allows a "void *".  While this isn't strictly a
problem as the address is never dereferenced, it is inconsistent with
the corresponding wait_on_bit() which requires "unsigned long *" and
does dereference the pointer.

Any code that needs to wait for a change in something other than an
unsigned long would be better served by wake_up_var()/wait_var_event().

This patch changes all related "void *" to "unsigned long *".

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-2-neilb@suse.de
---
 include/linux/wait_bit.h | 16 ++++++++--------
 kernel/sched/wait_bit.c  | 12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b75..48e1238 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -8,7 +8,7 @@
 #include <linux/wait.h>
 
 struct wait_bit_key {
-	void			*flags;
+	unsigned long		*flags;
 	int			bit_nr;
 	unsigned long		timeout;
 };
@@ -23,14 +23,14 @@ struct wait_bit_queue_entry {
 
 typedef int wait_bit_action_f(struct wait_bit_key *key, int mode);
 
-void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit);
+void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit);
 int __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
 int __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
-void wake_up_bit(void *word, int bit);
-int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
-int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
-int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
-struct wait_queue_head *bit_waitqueue(void *word, int bit);
+void wake_up_bit(unsigned long *word, int bit);
+int out_of_line_wait_on_bit(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
+int out_of_line_wait_on_bit_timeout(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
+int out_of_line_wait_on_bit_lock(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
+struct wait_queue_head *bit_waitqueue(unsigned long *word, int bit);
 extern void __init wait_bit_init(void);
 
 int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
@@ -327,7 +327,7 @@ do {									\
  * You can use this helper if bitflags are manipulated atomically rather than
  * non-atomically under a lock.
  */
-static inline void clear_and_wake_up_bit(int bit, void *word)
+static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 {
 	clear_bit_unlock(bit, word);
 	/* See wake_up_bit() for which memory barrier you need to use. */
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 134d711..058b0e1 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -9,7 +9,7 @@
 
 static wait_queue_head_t bit_wait_table[WAIT_TABLE_SIZE] __cacheline_aligned;
 
-wait_queue_head_t *bit_waitqueue(void *word, int bit)
+wait_queue_head_t *bit_waitqueue(unsigned long *word, int bit)
 {
 	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
 	unsigned long val = (unsigned long)word << shift | bit;
@@ -55,7 +55,7 @@ __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched out_of_line_wait_on_bit(void *word, int bit,
+int __sched out_of_line_wait_on_bit(unsigned long *word, int bit,
 				    wait_bit_action_f *action, unsigned mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -66,7 +66,7 @@ int __sched out_of_line_wait_on_bit(void *word, int bit,
 EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
 int __sched out_of_line_wait_on_bit_timeout(
-	void *word, int bit, wait_bit_action_f *action,
+	unsigned long *word, int bit, wait_bit_action_f *action,
 	unsigned mode, unsigned long timeout)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -108,7 +108,7 @@ __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry 
 }
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
-int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
+int __sched out_of_line_wait_on_bit_lock(unsigned long *word, int bit,
 					 wait_bit_action_f *action, unsigned mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -118,7 +118,7 @@ int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
 
-void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit)
+void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
 
@@ -144,7 +144,7 @@ EXPORT_SYMBOL(__wake_up_bit);
  * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
  * because spin_unlock() does not guarantee a memory barrier.
  */
-void wake_up_bit(void *word, int bit)
+void wake_up_bit(unsigned long *word, int bit)
 {
 	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
 }

