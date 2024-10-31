Return-Path: <linux-tip-commits+bounces-2673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278319B7863
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 11:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5950E1C21F09
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B07195FEC;
	Thu, 31 Oct 2024 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WPS5mr4S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E9nDvX9X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6B01953BB;
	Thu, 31 Oct 2024 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369341; cv=none; b=auZkuzOfn6AcsIXoKIxqiuoTY92Or4QMaVvR7q6gw0CcJbZsVBKWrSCFTOJSPCi4qr6Pi6Oegl3t/OCPwA9rcQV/z1Z+oQ56BBelYS4GPHQWB4Tp3N4kJuFeoey4p5F8cEn0xlVvG3UA+4jp5uduj5iBDjf7RGhFhOgjdMElX3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369341; c=relaxed/simple;
	bh=0uj3gUEQIA3hXacAoaaRe7lOFrA9PM5P6Lr24r0w6IM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OHj5+2Pr9UXERZ2turVLIAPJKV2IdmU4P8Pr3oSmcJxPi0/cRR++eYJwCfROM8y2g0hIQckWA3GaVY/UuQ09T+3QtKID85Toz1Z1H6M07KopWmLDzUe7+Qk28PibPb+RinE6Err8QkleBxkEqW7gURRQQwC/LZn2Ehc1OosFYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WPS5mr4S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E9nDvX9X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 10:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730369338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqRlpw2DI6C5paYhFN3Q5eHXvWHI5GVCrorQPaaunuM=;
	b=WPS5mr4SSzTYY1ni39hoiZUsZRIqB/czD+YW5fIbXQFg5ggqCCV+69BoECWG49nzELsGPJ
	p3u2zCPaI4YRIiFgRiQCN+fJ5qR3s47/usaffTLGmxm+ewIwcCoo8mXm/U/Eq3QBJIroGw
	yStyrDWB2yHJ4oiOUCWPk/DHiMMx12gT3UwHNtgbYzRsvuPYUSgrIhjnbIezs3ssSSpjpp
	VEIcfAt5KsfupgDcH63pzykvnD05Rdp1XIpDJJvoUj40J+D0B7mh/6qeHs8pYdRwgXGlF0
	qhaPC7a1whNm7YE0+3+kiAkfYcAT9pLK0ltzu7KWgqGB9bpcZFEMW3E3tTqdZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730369338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqRlpw2DI6C5paYhFN3Q5eHXvWHI5GVCrorQPaaunuM=;
	b=E9nDvX9XrpODE/W3Qmf24lTDtRNPSAaiQtmXRoby82H+UexLcjy4/nEWE/q68qH7jcTyCf
	BPq64CgijS7/itCQ==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: allow put_uprobe() from non-sleepable
 softirq context
Cc: Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241024044159.3156646-2-andrii@kernel.org>
References: <20241024044159.3156646-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036933725.3137.3413400151949944467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2bf8e5aceff899f5117f14c73e869a61c44d8a69
Gitweb:        https://git.kernel.org/tip/2bf8e5aceff899f5117f14c73e869a61c44d8a69
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Wed, 23 Oct 2024 21:41:58 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Oct 2024 22:42:19 +01:00

uprobes: allow put_uprobe() from non-sleepable softirq context

Currently put_uprobe() might trigger mutex_lock()/mutex_unlock(), which
makes it unsuitable to be called from more restricted context like softirq.

Let's make put_uprobe() agnostic to the context in which it is called,
and use work queue to defer the mutex-protected clean up steps.

RB tree removal step is also moved into work-deferred callback to avoid
potential deadlock between softirq-based timer callback, added in the
next patch, and the rest of uprobe code.

We can rework locking altogher as a follow up, but that's significantly
more tricky, so warrants its own patch set. For now, we need to make
sure that changes in the next patch that add timer thread work correctly
with existing approach, while concentrating on SRCU + timeout logic.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241024044159.3156646-2-andrii@kernel.org
---
 kernel/events/uprobes.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4ef4b51..d7e4892 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -27,6 +27,7 @@
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/workqueue.h>
 
 #include <linux/uprobes.h>
 
@@ -61,7 +62,10 @@ struct uprobe {
 	struct list_head	pending_list;
 	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
-	struct rcu_head		rcu;
+	union {
+		struct rcu_head		rcu;
+		struct work_struct	work;
+	};
 	loff_t			offset;
 	loff_t			ref_ctr_offset;
 	unsigned long		flags;		/* "unsigned long" so bitops work */
@@ -625,10 +629,9 @@ static void uprobe_free_rcu(struct rcu_head *rcu)
 	kfree(uprobe);
 }
 
-static void put_uprobe(struct uprobe *uprobe)
+static void uprobe_free_deferred(struct work_struct *work)
 {
-	if (!refcount_dec_and_test(&uprobe->ref))
-		return;
+	struct uprobe *uprobe = container_of(work, struct uprobe, work);
 
 	write_lock(&uprobes_treelock);
 
@@ -652,6 +655,15 @@ static void put_uprobe(struct uprobe *uprobe)
 	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
 }
 
+static void put_uprobe(struct uprobe *uprobe)
+{
+	if (!refcount_dec_and_test(&uprobe->ref))
+		return;
+
+	INIT_WORK(&uprobe->work, uprobe_free_deferred);
+	schedule_work(&uprobe->work);
+}
+
 static __always_inline
 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
 	       const struct uprobe *r)

