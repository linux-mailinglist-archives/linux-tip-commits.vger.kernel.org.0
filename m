Return-Path: <linux-tip-commits+bounces-3811-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5144A4CB53
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1AF175BA3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920FA2356A7;
	Mon,  3 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EsEr8vB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hlxYCtSX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1853231CB9;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=Uk95Bw/20gjNwuJvjOdgXRobAZgWT3S8nA4yEfOxNELIi+j5lPosC3GwgiY5pK/3deHdKdXYB50EnRtlmLs/FOQKalTHsc4yriupkZVEdF1F3jhhMOISfOh72mTpQmgNmGoF+eP8BzW8JHSB9kn3x6EnCi20QIvnhQ/CF+LbKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=mu/D6mzKMeC6dHDC6NDwYJL3KTPE4DMX9r0ZFOwaTRI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WKIy6+tq+6khJAtzYygfVRG5bUUKpHnAdlqd8mxAZgmQavv0JIErE9V392wJJ27FwlrrRFAZnz6OrLyI2E04RP6Oorhc1H5fg1PuRYHgp2UBaxGxAue1ruwMzfbqrdE2sniLa3JakrzeCtSec53iEhFhU7g+h3BC84rgQ+bsACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EsEr8vB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hlxYCtSX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeIIN3jwviAfOysUrWT1vAqOEFfvCOkvwTc2RdUJwcs=;
	b=EsEr8vB+GI2x4v8Mjvo2FSLm7seBvukSYAF3yEJ0axaeJsEQ+9RcI3bR0FfwbqhlJgUo/D
	HTUSar+qOFxwTqT7OHDzIxfXaG/5bgaK/GlJt5O2hjb51SpUUFxfmfgrR/zS2EsQfJ9RIv
	0KWFD+SByHHrlEzppGAvk5kd3Fo4B2h4v7DQ34Ydu8KVqkoVgGGpf4ET5rrldVxBvUExtE
	B+GJR5IR2+XN/ideU648mMexj3T319TRJuTW56ShfkFX2R8ng0EFAzV43fkPyhoGY1qM5F
	WrPSW5QxqvzTgPWyX2q2T6xnfIjgBJclNqahO13ah57vxCZnf1QKm04hFSGcZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027918;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeIIN3jwviAfOysUrWT1vAqOEFfvCOkvwTc2RdUJwcs=;
	b=hlxYCtSXpVqWxZIpCtQ79ib8qftbSyZmNrO+LE0fBhxaYUra1pFcI+FDOwDozDcOXMg6kF
	f6gbMbmiy4UZxdDw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] locking/lock_events: Add locking events for lockdep
Cc: Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213200228.1993588-3-longman@redhat.com>
References: <20250213200228.1993588-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791763.14745.12136010799514682751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7c17590a20dc9008bf073e86de3be60efdb6dfb4
Gitweb:        https://git.kernel.org/tip/7c17590a20dc9008bf073e86de3be60efdb6dfb4
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 13 Feb 2025 15:02:26 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

locking/lock_events: Add locking events for lockdep

Add some lock events to the lockdep for profiling its behavior.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250213200228.1993588-3-longman@redhat.com
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

