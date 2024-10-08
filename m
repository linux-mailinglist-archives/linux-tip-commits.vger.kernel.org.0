Return-Path: <linux-tip-commits+bounces-2373-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B60B994612
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1391C22D68
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357C51D417C;
	Tue,  8 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXxGzI4H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7JOx3tG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F81D12EA;
	Tue,  8 Oct 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385518; cv=none; b=Xy5VOPntcR5nWF7e9VaV6oZ49fHSJib+1xkBmETdNOLfEszCqmcPMpPsYUCNqlVSU7kLMSBASUX6JWe0et6GvZTIAZLD0L0hhH1h6e4to/rzGRZA1QMD+m2HpfViIR6MUrDfk1NQa7MbJSlpqcTeqLe+fAF9RXy4mybsAwA7cCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385518; c=relaxed/simple;
	bh=l1+DTEF0HzsVmGsYPafbjhjXIpTWZatOvSterKM+ohI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qVHy74qHYtUa7vk+TVUKqHyGJeHGzdh1oCLwhtn0bXBwtfFLB+R0M83SsX5DkPUPVocJ7LV/xOF5K5Div7qzqAtEJT4Ipjb73h3ssxoH0ciTuZm6nWvVmvYBQV6Ak+eOWM6LRqq8qv58xkXkIGR0rC8xUECfxEv7p4nBsJ9vP9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXxGzI4H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7JOx3tG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZvGhN+CWdTECM3DCbweuuCQga6QufFNu8+ZLP3eDkA=;
	b=jXxGzI4HW3zHFMSOo+wC21CeYgYvH7LmM2oibKXr/T8Xg5FuYkQlIp0a4n0MOHoYvu1zy5
	+kCXjTForj+5JJ4y9czr+LLPquj/gV9hcHjAN+OMb9ZaZ9hE98gz4JfETY0qQBDM5agZLT
	JXsVzP2ofZIn1g3w53QZo0nV57zoC9tbvY+4oJrsyKOjNvWhVDb9l2UXWIlAJ34bExKVwg
	ueNFUmVYJGDJ16+uokzyiA4YfMLxZEgm2LOGlQ6N3C2Rb192IBKN27/t6tBSAlFk1gu/FQ
	XYGoz/k1XEFMs5WMArINbzOUxL8C0LwbzB04ydcoNjFRahEaa/6QNEefOKPXew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385515;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZvGhN+CWdTECM3DCbweuuCQga6QufFNu8+ZLP3eDkA=;
	b=V7JOx3tGSFdHXSF+4h5YQTSNw+8MymTOREuylQpItxMQuJKraEXjnTcaAjlvh9ku/UHNF6
	PI38KSRAXmIlsYBQ==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: kill the unnecessary
 put_uprobe/xol_free_insn_slot in uprobe_free_utask()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240929144239.GA9475@redhat.com>
References: <20240929144239.GA9475@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551443.1442.17092812194907881401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     430af825ba991730f8acc3c804a4aef82e9f7ff6
Gitweb:        https://git.kernel.org/tip/430af825ba991730f8acc3c804a4aef82e9f7ff6
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 29 Sep 2024 16:42:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:44 +02:00

uprobes: kill the unnecessary put_uprobe/xol_free_insn_slot in uprobe_free_utask()

If pre_ssout() succeeds and sets utask->active_uprobe and utask->xol_vaddr
the task must not exit until it calls handle_singlestep() which does the
necessary put_uprobe() and xol_free_insn_slot().

Remove put_uprobe() and xol_free_insn_slot() from uprobe_free_utask(). With
this change xol_free_insn_slot() can't hit xol_area/utask/xol_vaddr == NULL,
we can kill the unnecessary checks checks and simplify this function more.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144239.GA9475@redhat.com
---
 kernel/events/uprobes.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 3f38be1..03035a8 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1673,28 +1673,16 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 }
 
 /*
- * xol_free_insn_slot - If slot was earlier allocated by
- * @xol_get_insn_slot(), make the slot available for
- * subsequent requests.
+ * xol_free_insn_slot - free the slot allocated by xol_get_insn_slot()
  */
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
-	struct xol_area *area;
-	unsigned long slot_addr;
-	unsigned long offset;
-
-	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
-		return;
-
-	slot_addr = tsk->utask->xol_vaddr;
-	if (unlikely(!slot_addr))
-		return;
+	struct xol_area *area = tsk->mm->uprobes_state.xol_area;
+	unsigned long offset = tsk->utask->xol_vaddr - area->vaddr;
 
 	tsk->utask->xol_vaddr = 0;
-	area = tsk->mm->uprobes_state.xol_area;
-	offset = slot_addr - area->vaddr;
 	/*
-	 * slot_addr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
+	 * xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
 	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
 	 */
 	if (offset < PAGE_SIZE) {
@@ -1764,14 +1752,12 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
-	if (utask->active_uprobe)
-		put_uprobe(utask->active_uprobe);
+	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
 
 	ri = utask->return_instances;
 	while (ri)
 		ri = free_ret_instance(ri);
 
-	xol_free_insn_slot(t);
 	kfree(utask);
 	t->utask = NULL;
 }

