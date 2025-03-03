Return-Path: <linux-tip-commits+bounces-3810-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7D7A4CB52
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FC17A8E77
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 18:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558BA23535C;
	Mon,  3 Mar 2025 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M4SbrorJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZJgOOo56"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81979230BFB;
	Mon,  3 Mar 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027928; cv=none; b=rBdgVgx9B11lrh4fH5Cs+xo7Olpz/iGNgJzPFoSYZnFG4RiY7jBHafTQep+M5PrWg+mwbF+Anx+UOnPljKflI5fGPjinGdziVpYVY84AM9ivPXe/rJTBEj2MNe6NPY4FoTCulf8J6T7HN8z0lACHOXVLk+RYJaTA6GCIrMbjDAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027928; c=relaxed/simple;
	bh=adUB6xPHoRKYcm7t2WVza3iErcOIS8cmW8WfBGqDKJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W4mfO+fH5v9era8astYSjq1wbIYn3oaGMui7e1UzitVYq8PKXijlMF6HPgqN+MKkRQEavcUXK2zOAKwqnZ5WVZOr+RxV+yAYht5ueoIQH/d2CLTBlTwEFd/xPSRRq33gv3DkCLvzelNNJDZtBgMKzpAy+aA91SMJfJdEI0bybKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M4SbrorJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZJgOOo56; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 18:51:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741027917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPFJTLltVzC7PyxSpTQg5otV+IeK6LK4Zcr1NN5g1t8=;
	b=M4SbrorJ7x6lNr843BYg2wogL88Wt+AgaKDyrnAiyn9GVATvHIWqWGivQ2qpVenMP+//kA
	QXmY31ki0lHmKXswnjwHMVetb7gzVnD8TdRHHvHwSrO3UfnZBpJlDtrD6Z6nDob0HJt8Gc
	RbkXY4T1QOZkqhe3ZAf7c4BcF7G4X4baoD1EsbyAIdpYxtugCJcmw+goPkyQNSqtVLiy4I
	kO8UmOBe++qiO57fWcF5obo6YOyQe7OJM/mRSFCtY3Im/lWnaA8b0gfgjYK2Gmit16uJ9c
	H97j8CyXmHYm3llTNC0Cnvr8lEl6qYLIGXFU2Kt6F97/fd8dQ5OYlHaKviRxmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741027917;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPFJTLltVzC7PyxSpTQg5otV+IeK6LK4Zcr1NN5g1t8=;
	b=ZJgOOo560qVKGWhohlrTdN75ChZ4oqqK3Mv2aQZWPiQ9d/lLK5EJy/P2PATqQiWp3zPfXW
	wBZAsyr8CVT2iSAQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Add kasan_check_byte() check in
 lock_acquire()
Cc: Marco Elver <elver@google.com>, Waiman Long <longman@redhat.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214195242.2480920-1-longman@redhat.com>
References: <20250214195242.2480920-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102791660.14745.9286305165627700375.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8ca5e9186d367807336c5a40a086aef163c18800
Gitweb:        https://git.kernel.org/tip/8ca5e9186d367807336c5a40a086aef163c18800
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Fri, 14 Feb 2025 14:52:42 -05:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Sun, 23 Feb 2025 18:24:46 -08:00

locking/lockdep: Add kasan_check_byte() check in lock_acquire()

KASAN instrumentation of lockdep has been disabled as we don't need
KASAN to check the validity of lockdep internal data structures and
incur unnecessary performance overhead. However, the lockdep_map pointer
passed in externally may not be valid (e.g. use-after-free) and we run
the risk of using garbage data resulting in false lockdep reports.

Add kasan_check_byte() call in lock_acquire() for non kernel core data
object to catch invalid lockdep_map and print out a KASAN report before
any lockdep splat, if any.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250214195242.2480920-1-longman@redhat.com
---
 kernel/locking/lockdep.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8436f01..b15757e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,6 +57,7 @@
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
 #include <linux/console.h>
+#include <linux/kasan.h>
 
 #include <asm/sections.h>
 
@@ -5830,6 +5831,14 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!debug_locks)
 		return;
 
+	/*
+	 * As KASAN instrumentation is disabled and lock_acquire() is usually
+	 * the first lockdep call when a task tries to acquire a lock, add
+	 * kasan_check_byte() here to check for use-after-free and other
+	 * memory errors.
+	 */
+	kasan_check_byte(lock);
+
 	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {

