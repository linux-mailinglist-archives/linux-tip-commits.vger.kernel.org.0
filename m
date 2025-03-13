Return-Path: <linux-tip-commits+bounces-4184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB5A5F26C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 12:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6DA19C1051
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Mar 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3B42673B2;
	Thu, 13 Mar 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZG/DtPI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rl7OKhxn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DC266F00;
	Thu, 13 Mar 2025 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865490; cv=none; b=IEpNGvsEtWRPoxfoy8pIkShMU4W0nPPg9mwYQ9fNxT4qsTMKljO4q4mnW9uZ/FPKa2oVpyQExhUdCheT7g4uCpan8ajzxuulzKz+0yo0H5ebWBeCFAcwejsoWrCnno98qzxWVGUCHocfFKiuVw8uGglU89H5WD2SmuPwegmqZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865490; c=relaxed/simple;
	bh=VyyKpvOQneQLDKTqEr/gBnDcoAVrlNMXj0eNWAdKz4k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DTKK6ctK7HpEFA/CaXEsTTUSMZWvBD38ESRqgaVc6nFcr6x3iIBAfjAdU2NdKxIHghInsWW6Qhqw5xugsV9v2etKaAA4CtqeMT8LeY+A9335YVbMSUv9wj1z4ihKAupTQ3vCoxqrMS2bpKRhtT8ZU4LDHJBMbwrcKTvzn2Ku11Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZG/DtPI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rl7OKhxn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 11:31:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741865487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6qdKVbOxSJ2QVDWCTSMOSds3wlVzYNTRZcP3a6jYq8=;
	b=0ZG/DtPIwHX/gE00WSDl/P1f79NrY0GhmC0U/uDzvGdMfIC9LMxv17ou3SpRvEa2NWxZIE
	EKjPC2V8luoTc/KBbguDDziXtocHm+vL4dHc396cf9XOHpmgRUMwdTKd42dHiN4ixqfjzX
	ES9rt23GGwg1NvvJQ8LxzjkiA1QLeTIRSDiHLDGZyniGObvoxTWkcITLJtImSSfg8FP0aJ
	9W6wNUXG0tej+WPv9JU9RjCmTisdy4/dtJhrom29cVGS+b23mIkPtF6nZ1Phsmk6oBOfiU
	NN0jf0hLgvKwkBZn5ga4fPp7wNcUDh70kLSFYLPWzBCXCiT+waspca7OXCdgJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741865487;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6qdKVbOxSJ2QVDWCTSMOSds3wlVzYNTRZcP3a6jYq8=;
	b=rl7OKhxnPuTSPTJy6nAqzNmdjO6Z2LcoEpiihEDTp8t2o9UaAzhjI7s6PAQFQF8blgoJ7S
	/dWGg+lFSm0CyCCg==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Make signal_struct::
 Next_posix_timer_id an atomic_t
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250308155624.151545978@linutronix.de>
References: <20250308155624.151545978@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174186548696.14745.6975760705487032667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     feb864ee99a2d8a22800342388401f3a3b90d42b
Gitweb:        https://git.kernel.org/tip/feb864ee99a2d8a22800342388401f3a3b90d42b
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Sat, 08 Mar 2025 17:48:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 13 Mar 2025 12:07:17 +01:00

posix-timers: Make signal_struct:: Next_posix_timer_id an atomic_t

The global hash_lock protecting the posix timer hash table can be heavily
contended especially when there is an extensive linear search for a timer
ID.

Timer IDs are handed out by monotonically increasing next_posix_timer_id
and then validating that there is no timer with the same ID in the hash
table. Both operations happen with the global hash lock held.

To reduce the hash lock contention the hash will be reworked to a scaled
hash with per bucket locks, which requires to handle the ID counter
lockless.

Prepare for this by making next_posix_timer_id an atomic_t, which can be
used lockless with atomic_inc_return().

[ tglx: Adopted from Eric's series, massaged change log and simplified it ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250219125522.2535263-2-edumazet@google.com
Link: https://lore.kernel.org/all/20250308155624.151545978@linutronix.de


---
 include/linux/sched/signal.h |  2 +-
 kernel/time/posix-timers.c   | 14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d5d03d9..72649d7 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,7 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	unsigned int		next_posix_timer_id;
+	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 991d12a..f9a70c1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -119,21 +119,17 @@ static bool posix_timer_hashed(struct hlist_head *head, struct signal_struct *si
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	struct hlist_head *head;
-	unsigned int cnt, id;
 
 	/*
 	 * FIXME: Replace this by a per signal struct xarray once there is
 	 * a plan to handle the resulting CRIU regression gracefully.
 	 */
-	for (cnt = 0; cnt <= INT_MAX; cnt++) {
-		spin_lock(&hash_lock);
-		id = sig->next_posix_timer_id;
-
-		/* Write the next ID back. Clamp it to the positive space */
-		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
+		/* Get the next timer ID and clamp it to positive space */
+		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
+		struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 
-		head = &posix_timers_hashtable[hash(sig, id)];
+		spin_lock(&hash_lock);
 		if (!posix_timer_hashed(head, sig, id)) {
 			/*
 			 * Set the timer ID and the signal pointer to make

