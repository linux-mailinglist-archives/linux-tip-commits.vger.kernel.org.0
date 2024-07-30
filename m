Return-Path: <linux-tip-commits+bounces-1865-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3B941C61
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 19:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1660F2823AB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 17:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684DE189539;
	Tue, 30 Jul 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUDOFqF5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1sYaUrA6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E11E86F;
	Tue, 30 Jul 2024 17:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359190; cv=none; b=LAmvu5ck+SaWA/Y/+FhIzD36S4tjFmKIJUyOZbHVIlxwuQckCPZBv7AmeuNoiCtphWnp4kIrj6QM9lT8ES4XWDhxEhYRaDmC5VGIOcFBGPrlTt519c8vV64enjisBRSQ2RDDPKESgFGV8CD6fp0NVaRTGdUKZ1yqkDcqTXKsgIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359190; c=relaxed/simple;
	bh=FrBPukyxE+9AYstEbbOJPvikSKSNu9B3b7eFCTVk78w=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jckTrANgfvAxE3eIp31XC7UK4TfMVZmsxSK8iTgRPc4ityug7OSZFdiShnTlBUNV8WaA66xZ1Z/U/2eaz0QS/LfNCiyPGHphwbYVhoZzivWaBi8KUfmHASQSbMxC4syTQfCxV4Zy2EDXEzpV/u29jMIeOCASax7EbK+4FUjzsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUDOFqF5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1sYaUrA6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 17:06:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722359187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cFzetcd40du1vIK/kN7lQnubEFeCpqBSnkjuV3VSEZQ=;
	b=GUDOFqF5DKpg/uFOhpkPCDylWkI/hgdgzpUz1AosHkzQhdbdaSSvY3G+TL4HD+znacyX6q
	X/LYsQwKPTe6OlwbXNso4y13f2vdai7xcuyTN0tflo4h6Gp0SSY13CZjshRuPBUT3zN+F1
	nE1lLXARYSdCvfo8XoBvvu4BmYlRJHqZGxktaWsIEGzp5vWre2NEk45u+TsaKIIDvh4U4q
	IF9ACV+Ri8uTx488p1TI2uI15piQn3SIYXTSxhbz2glBmV2T/3tqHKvcKerMfDWCmdPqSD
	EAGOulqF8uoc9yLM/vBAdQf6uuAHU6aRkRZ3sUzsvf5CcNMQ9vc0Wm2gjlqSog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722359187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cFzetcd40du1vIK/kN7lQnubEFeCpqBSnkjuV3VSEZQ=;
	b=1sYaUrA64Smb8sgD1txaaWZFeUlOP/VfUdXV22yPveR/gWQiP+vwxBwNBeyXcHJnZDXRim
	YL8JkrIgb6VDqnCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] signal: Replace BUG_ON()s
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172235918649.2215.17324753340395823379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7f8af7bac5380f2d95a63a6f19964e22437166e1
Gitweb:        https://git.kernel.org/tip/7f8af7bac5380f2d95a63a6f19964e22437166e1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 10 Jun 2024 18:42:34 +02:00
Committer:     Frederic Weisbecker <frederic@kernel.org>
CommitterDate: Mon, 29 Jul 2024 21:57:35 +02:00

signal: Replace BUG_ON()s

These really can be handled gracefully without killing the machine.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/signal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 897765b..6f3a5aa 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1938,10 +1938,11 @@ struct sigqueue *sigqueue_alloc(void)
 
 void sigqueue_free(struct sigqueue *q)
 {
-	unsigned long flags;
 	spinlock_t *lock = &current->sighand->siglock;
+	unsigned long flags;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return;
 	/*
 	 * We must hold ->siglock while testing q->list
 	 * to serialize with collect_signal() or with
@@ -1969,7 +1970,10 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	unsigned long flags;
 	int ret, result;
 
-	BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
+	if (WARN_ON_ONCE(!(q->flags & SIGQUEUE_PREALLOC)))
+		return 0;
+	if (WARN_ON_ONCE(q->info.si_code != SI_TIMER))
+		return 0;
 
 	ret = -1;
 	rcu_read_lock();
@@ -2004,7 +2008,6 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 		 * If an SI_TIMER entry is already queue just increment
 		 * the overrun count.
 		 */
-		BUG_ON(q->info.si_code != SI_TIMER);
 		q->info.si_overrun++;
 		result = TRACE_SIGNAL_ALREADY_PENDING;
 		goto out;

