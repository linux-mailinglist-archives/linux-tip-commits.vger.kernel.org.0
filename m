Return-Path: <linux-tip-commits+bounces-2369-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA899460B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC801B24FB4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E604D1D0496;
	Tue,  8 Oct 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1uVuqRRm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1WYCa+pS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DF18C936;
	Tue,  8 Oct 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385515; cv=none; b=CIfbDdS7eTQMDTsV9tjSbHwir09dyRf86sxEyPPRXq88v26O6TKJWWlfpa3aiQigg31AiVsjX6zZIf/XfzpqmO5DY8kaTVmOj4dX/Qx+VFVl6ffUJ8sLvkXYiTPYOq4GpjAkcScpIdAo8j1UK3RCDpM/q7f+G59tp5+h8LK0Meg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385515; c=relaxed/simple;
	bh=Eo+lXc2UA7YZ1DIjL8jw6Ux+0b/QlLoBZOJbmmgMBlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=atzBzhF4w5M5USPbp58XS7siNWIBGGqmGqNOnhh3LoZrwWwRr8q6olaH+V8E1ZdKrF9UBGAX2GwOBDthw8X5Sd9PUCbCbhO/wgbRZZnCcZmoaaix3J/67cZhDxj87EtGW3Rdu1dZqBShOvyMcG30vfkF1+op5VRrf4OFQizjX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1uVuqRRm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1WYCa+pS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2RDptQXu5nqImJo5B+wc7ZmoveR2NlQ7RcxuRF8OCM=;
	b=1uVuqRRmqtvWFFeGMmGSLowyEFUP/h7QmNSpnhWynz6L5bZECSkUjUdAnUeAA3nUfVU2xY
	U0Qhzl/8l1GwZTO7ITjHqTQkD+5I3vnzsVqkAlU8Pg/9t86uokmAFltZE3JrLClM8pKY7F
	0Jv2dqnNbqegAQ43Pxab7e3ddSmLSohLcAH1cSp2WIyBYgR8ooWzVazpSDhl8Tfffu92uG
	uDZxm3khkzOQA1YmzI2fTcS+TMVJht0kRo7GNsG4o1LnEZkHBmATeSWab9NX/YanoUK3jZ
	WvUSqtnEo90wFHI5IZCUqDeM9GDT0qDqoB7Zsrx3t7XUokiuKmlP7NtPuwXMhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/2RDptQXu5nqImJo5B+wc7ZmoveR2NlQ7RcxuRF8OCM=;
	b=1WYCa+pS2OmWigvlfamRk4QNeLS/QkO5dzVNJPjENVnm3GHQw+2LozBfGvf1JxW5Ai1Qd8
	hTzjmq+HvBdPZrDA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: deny mremap(xol_vma)
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240929144258.GA9492@redhat.com>
References: <20240929144258.GA9492@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551195.1442.350213837766810311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c16e2fdd746c78f5b2ce3c2ab8a26a61b6ed09e5
Gitweb:        https://git.kernel.org/tip/c16e2fdd746c78f5b2ce3c2ab8a26a61b6ed09e5
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 29 Sep 2024 16:42:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:45 +02:00

uprobes: deny mremap(xol_vma)

kernel/events/uprobes.c assumes that xol_area->vaddr is always correct but
a malicious application can remap its "[uprobes]" vma to another adress to
confuse the kernel. Introduce xol_mremap() to make this impossible.

With this change utask->xol_vaddr in xol_free_insn_slot() can't be invalid,
we can turn the offset check into WARN_ON_ONCE(offset >= PAGE_SIZE).

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144258.GA9492@redhat.com
---
 kernel/events/uprobes.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index c9f1e1e..d3538b6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1472,9 +1472,15 @@ static vm_fault_t xol_fault(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int xol_mremap(const struct vm_special_mapping *sm, struct vm_area_struct *new_vma)
+{
+	return -EPERM;
+}
+
 static const struct vm_special_mapping xol_mapping = {
 	.name = "[uprobes]",
 	.fault = xol_fault,
+	.mremap = xol_mremap,
 };
 
 /* Slot allocation for XOL */
@@ -1667,21 +1673,19 @@ static void xol_free_insn_slot(struct uprobe_task *utask)
 {
 	struct xol_area *area = current->mm->uprobes_state.xol_area;
 	unsigned long offset = utask->xol_vaddr - area->vaddr;
+	unsigned int slot_nr;
 
 	utask->xol_vaddr = 0;
-	/*
-	 * xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
-	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
-	 */
-	if (offset < PAGE_SIZE) {
-		int slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
-
-		clear_bit(slot_nr, area->bitmap);
-		atomic_dec(&area->slot_count);
-		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
-		if (waitqueue_active(&area->wq))
-			wake_up(&area->wq);
-	}
+	/* xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE) */
+	if (WARN_ON_ONCE(offset >= PAGE_SIZE))
+		return;
+
+	slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
+	clear_bit(slot_nr, area->bitmap);
+	atomic_dec(&area->slot_count);
+	smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
+	if (waitqueue_active(&area->wq))
+		wake_up(&area->wq);
 }
 
 void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,

