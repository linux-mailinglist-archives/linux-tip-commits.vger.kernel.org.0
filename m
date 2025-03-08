Return-Path: <linux-tip-commits+bounces-4066-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB30A57692
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 01:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BFE3B6A39
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 00:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F5A286A9;
	Sat,  8 Mar 2025 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKWP21F/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Hglsecd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FFEACD;
	Sat,  8 Mar 2025 00:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392491; cv=none; b=UeDF2/rzv2RivAOIUTVIPb8KwGsZtdvqW5MlKpebBp/Q0GogXYpZ85eAFmxX3w/MImV8oOsTqJuG19V+w6q93PenvtH+fj4OXbhMa+LRBxTZ/LaILyjgAZuY7ehC7yYgblcx2pvdF9ZxeDHGiCgaUhna5c22PPKqvJJWrHHOy5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392491; c=relaxed/simple;
	bh=c0NqB6CF+ue+4CbqOdqgDsD7lzwUax7DRqFAxWrBgiA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b5DFxmCkJLnGW7bjPiCHdIhB4APZwnZanNEnU/P+yeDXm+oEqh5Nq+ko9s4peg23EMS6M8C0Lfv+yVtm8e2+BKrobiWGAnrLxfH9uAkMhmsbiofex2h1IlYLSmaC4/eEEhSWlulaoetF/wXNxXdclOPwrT4aVJTXEbjJUuTjiLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKWP21F/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Hglsecd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 00:08:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741392487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoXqXAypsvzEIa1eHB8gIQ36LC9ITn+x1iV+Tykh4Bw=;
	b=uKWP21F/2HP3QfJvjVi2hD1CR2mrIwo4VdPtPGkVe5dEVHFl3fec3qu4FM0son2J9dZa70
	aox1XkVz7ZoWCYJOrhSXRjpeRLJQJGWBGDfv18pwOAs3qJz43aLPvUvEezV4rpzjaSitBi
	UZgXII6DJrENWUz8836amNHZ8pYW130aKdVN1RqFB8pyKAyeToJHMC63z93jWKjhFCIWgx
	DKUpxsKwpqo5GCSt7GCUNjXqBGv8/szNLNU6TOGrYCXOyse6Q+Dy/6UqRT3Q3GqP9BlQnY
	Jvhwgk//KIm5I11SaCBIbcux0dlwtvWStrU5AAGLsQiVyfknwYkp3lU59DJzRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741392487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoXqXAypsvzEIa1eHB8gIQ36LC9ITn+x1iV+Tykh4Bw=;
	b=/HglsecdUdK95behu0Mg+8iRjPz47tynfv/+sutXPMsqipxlPYMNzVL0jrFmUOanqzHaU4
	f4CWGxzqHEURdBBA==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/lock_events: Add locking events for lockdep
Cc: Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250307232717.1759087-5-boqun.feng@gmail.com>
References: <20250307232717.1759087-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174139248654.14745.6049947955619993643.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a94d32446ab5e85c7ba97e48a8c9bd85be4fe889
Gitweb:        https://git.kernel.org/tip/a94d32446ab5e85c7ba97e48a8c9bd85be4fe889
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 07 Mar 2025 15:26:54 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 08 Mar 2025 00:55:03 +01:00

locking/lock_events: Add locking events for lockdep

Add some lock events to lockdep to profile its behavior.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250307232717.1759087-5-boqun.feng@gmail.com
---
 kernel/locking/lock_events_list.h | 7 +++++++
 kernel/locking/lockdep.c          | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 80b11f1..9ef9850 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -88,3 +88,10 @@ LOCK_EVENT(rtmutex_slow_acq3)	/* # of locks acquired in *block()	*/
 LOCK_EVENT(rtmutex_slow_sleep)	/* # of sleeps				*/
 LOCK_EVENT(rtmutex_slow_wake)	/* # of wakeup's			*/
 LOCK_EVENT(rtmutex_deadlock)	/* # of rt_mutex_handle_deadlock()'s	*/
+
+/*
+ * Locking events for lockdep
+ */
+LOCK_EVENT(lockdep_acquire)
+LOCK_EVENT(lockdep_lock)
+LOCK_EVENT(lockdep_nocheck)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680..8436f01 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -61,6 +61,7 @@
 #include <asm/sections.h>
 
 #include "lockdep_internals.h"
+#include "lock_events.h"
 
 #include <trace/events/lock.h>
 
@@ -170,6 +171,7 @@ static struct task_struct *lockdep_selftest_task_struct;
 static int graph_lock(void)
 {
 	lockdep_lock();
+	lockevent_inc(lockdep_lock);
 	/*
 	 * Make sure that if another CPU detected a bug while
 	 * walking the graph we dont change it (while the other
@@ -5091,8 +5093,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(lock->key == &__lockdep_no_track__))
 		return 0;
 
-	if (!prove_locking || lock->key == &__lockdep_no_validate__)
+	lockevent_inc(lockdep_acquire);
+
+	if (!prove_locking || lock->key == &__lockdep_no_validate__) {
 		check = 0;
+		lockevent_inc(lockdep_nocheck);
+	}
 
 	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
 		class = lock->class_cache[subclass];

