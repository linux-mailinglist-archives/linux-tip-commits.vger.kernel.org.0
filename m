Return-Path: <linux-tip-commits+bounces-4194-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A037A5F281
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72A47A46EE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A2D267F45;
	Thu, 13 Mar 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ghepBKr+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+gE0IM8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99CC266579;
	Thu, 13 Mar 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865498; cv=none; b=JfcaFW86MIVbHh5cOGCAUTMlvyMlGHLTSoJ1zsfXDl+VO9A8v8TDBHSR+04CdsVt/jdX0REA8up9tsduqveN7iQPV0eQwwNPEGenotWaeOUsz8AG0uLeRaxbyoRqZFx1l7ioY/1K/S3ApZqZMto0D2qD8GiyddmwVoE1YRgSJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865498; c=relaxed/simple;
	bh=DOcduC+45Qo5Ao5+dg9W+0SR4qUCi6BXAkLgwtkY8nE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LWF3AvHbQ4ysXwSGnjijImy+AKj2yJBczdjezzs753NBRPNd2pU1YRnOCYIlREQxw7TwHNMJUpTVK9ltLpmZIIwq8TzDP33xfJ1XLqjmCzlc3xXkMn0bzqVwBXD3OGeF2n+ixkCj0d+pp6PHDPJ10Bnkmhkp9Y+cz5+qAqM4pc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ghepBKr+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+gE0IM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RpGykXpMIapLAOv8sS2QTXHhsHGrYnPlnoCPGKg+Q4=;
	b=ghepBKr+ZQKHvrvFh4PrIq1WdyKzRqHosdWYb7JRPTiaua2YOoDhVMGCUNdDuovcMuiUeu
	j4gPorEl2YMuCZth79c4RQgfrG994+8MgYOunCu9W3XBXmSdQvfXKNY2GRwaLPl7H//MKQ
	HXyf57f8fl2JLCu1tH6j4T2R/qtXiG+RUZ2rH+wlkTChfjqrup21UME9CLgHfd8iEIJTrt
	m6hBSG5vsfn8pq5JBCk3WVeCCRfbCYeA6XPmK1sWDzXIPnMdgVgDhUs2N08nTBxPs7Okoz
	PisgmUN0sar7oNATxcTd3DwmJokiaIaCAlu9FmrEBqxt/wU3yFOMFBJ5Ly4IEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865495;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RpGykXpMIapLAOv8sS2QTXHhsHGrYnPlnoCPGKg+Q4=;
	b=g+gE0IM8tTj2+oZzircbtnO5QB5uXWB/A2YvQIx74GiDHXVqpze+zPPD5pFrjtKw3r9uZp
	B7cFAcChuAfFgbCQ==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Initialise timer before adding it to
 the hash table
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155623.572035178@linutronix.de>
References: <20250308155623.572035178@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186549472.14745.6146782726272613824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     45ece9933d4a8e0e8b3da8d1c3bbb1878be216c4
Gitweb:        https://git.kernel.org/tip/45ece9933d4a8e0e8b3da8d1c3bbb1878be216c4
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Sat, 08 Mar 2025 17:48:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:16 +01:00

posix-timers: Initialise timer before adding it to the hash table

A timer is only valid in the hashtable when both timer::it_signal and
timer::it_id are set to their final values, but timers are added without
those values being set.

The timer ID is allocated when the timer is added to the hash in invalid
state. The ID is taken from a monotonically increasing per process counter
which wraps around after reaching INT_MAX. The hash insertion validates
that there is no timer with the allocated ID in the hash table which
belongs to the same process. That opens a mostly theoretical race condition:

If other threads of the same process manage to create/delete timers in
rapid succession before the newly created timer is fully initialized and
wrap around to the timer ID which was handed out, then a duplicate timer ID
will be inserted into the hash table.

Prevent this by:

  1) Setting timer::it_id before inserting the timer into the hashtable.
 
  2) Storing the signal pointer in timer::it_signal with bit 0 set before
     inserting it into the hashtable.

     Bit 0 acts as a invalid bit, which means that the regular lookup for
     sys_timer_*() will fail the comparison with the signal pointer.

     But the lookup on insertion masks out bit 0 and can therefore detect a
     timer which is not yet valid, but allocated in the hash table.  Bit 0
     in the pointer is cleared once the initialization of the timer
     completed.

[ tglx: Fold ID and signal iniitializaion into one patch and massage change
  	log and comments. ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250219125522.2535263-3-edumazet@google.com
Link: https://lore.kernel.org/all/20250308155623.572035178@linutronix.de

---
 kernel/time/posix-timers.c | 56 +++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 6bf468b..24d7eab 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -72,13 +72,13 @@ static int hash(struct signal_struct *sig, unsigned int nr)
 	return hash_32(hash32_ptr(sig) ^ nr, HASH_BITS(posix_timers_hashtable));
 }
 
-static struct k_itimer *__posix_timers_find(struct hlist_head *head,
-					    struct signal_struct *sig,
-					    timer_t id)
+static struct k_itimer *posix_timer_by_id(timer_t id)
 {
+	struct signal_struct *sig = current->signal;
+	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+	hlist_for_each_entry_rcu(timer, head, t_hash) {
 		/* timer->it_signal can be set concurrently */
 		if ((READ_ONCE(timer->it_signal) == sig) && (timer->it_id == id))
 			return timer;
@@ -86,12 +86,26 @@ static struct k_itimer *__posix_timers_find(struct hlist_head *head,
 	return NULL;
 }
 
-static struct k_itimer *posix_timer_by_id(timer_t id)
+static inline struct signal_struct *posix_sig_owner(const struct k_itimer *timer)
 {
-	struct signal_struct *sig = current->signal;
-	struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
+	unsigned long val = (unsigned long)timer->it_signal;
+
+	/*
+	 * Mask out bit 0, which acts as invalid marker to prevent
+	 * posix_timer_by_id() detecting it as valid.
+	 */
+	return (struct signal_struct *)(val & ~1UL);
+}
+
+static bool posix_timer_hashed(struct hlist_head *head, struct signal_struct *sig, timer_t id)
+{
+	struct k_itimer *timer;
 
-	return __posix_timers_find(head, sig, id);
+	hlist_for_each_entry_rcu(timer, head, t_hash, lockdep_is_held(&hash_lock)) {
+		if ((posix_sig_owner(timer) == sig) && (timer->it_id == id))
+			return true;
+	}
+	return false;
 }
 
 static int posix_timer_add(struct k_itimer *timer)
@@ -112,7 +126,19 @@ static int posix_timer_add(struct k_itimer *timer)
 		sig->next_posix_timer_id = (id + 1) & INT_MAX;
 
 		head = &posix_timers_hashtable[hash(sig, id)];
-		if (!__posix_timers_find(head, sig, id)) {
+		if (!posix_timer_hashed(head, sig, id)) {
+			/*
+			 * Set the timer ID and the signal pointer to make
+			 * it identifiable in the hash table. The signal
+			 * pointer has bit 0 set to indicate that it is not
+			 * yet fully initialized. posix_timer_hashed()
+			 * masks this bit out, but the syscall lookup fails
+			 * to match due to it being set. This guarantees
+			 * that there can't be duplicate timer IDs handed
+			 * out.
+			 */
+			timer->it_id = (timer_t)id;
+			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
 			return id;
@@ -406,8 +432,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 
 	/*
 	 * Add the timer to the hash table. The timer is not yet valid
-	 * because new_timer::it_signal is still NULL. The timer id is also
-	 * not yet visible to user space.
+	 * after insertion, but has a unique ID allocated.
 	 */
 	new_timer_id = posix_timer_add(new_timer);
 	if (new_timer_id < 0) {
@@ -415,7 +440,6 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 		return new_timer_id;
 	}
 
-	new_timer->it_id = (timer_t) new_timer_id;
 	new_timer->it_clock = which_clock;
 	new_timer->kclock = kc;
 	new_timer->it_overrun = -1LL;
@@ -453,7 +477,7 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	}
 	/*
 	 * After succesful copy out, the timer ID is visible to user space
-	 * now but not yet valid because new_timer::signal is still NULL.
+	 * now but not yet valid because new_timer::signal low order bit is 1.
 	 *
 	 * Complete the initialization with the clock specific create
 	 * callback.
@@ -470,7 +494,11 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	 */
 	scoped_guard (spinlock_irq, &new_timer->it_lock) {
 		guard(spinlock)(&current->sighand->siglock);
-		/* This makes the timer valid in the hash table */
+		/*
+		 * new_timer::it_signal contains the signal pointer with
+		 * bit 0 set, which makes it invalid for syscall operations.
+		 * Store the unmodified signal pointer to make it valid.
+		 */
 		WRITE_ONCE(new_timer->it_signal, current->signal);
 		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
 	}

