Return-Path: <linux-tip-commits+bounces-2372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 465C6994611
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C06287709
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2DB1D31BB;
	Tue,  8 Oct 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H11/a4Y4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFiGeLG9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F51D095C;
	Tue,  8 Oct 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385517; cv=none; b=JjI+cYluF2ebmbzLA2PFO1WFhDVCi1G76SrVJNka9RLIirDoNl5akvDAgkSqPFZNSoSZRnys7PLOWjAv/d2wOlTcWH6CAemI+HM+X3YYh/3Owj2ba010k0eePf07+d7XdS3cH38pUkUVQ1vj2kNh2bLJm376dSiB2qJe5rhDvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385517; c=relaxed/simple;
	bh=aZAJgpQgf4HUdZMG78O9hW+sOlW02BVWWapoKU5XmyA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nucfWqGv85JoGJ2Hd9UWzz2YMclOI3m0hi8HCioV9lTD4tWsN2GOjvpRjx6G9DFKV7a3QrKvigh5/Wf3s6R2MAFNHD+o5xIS20quke30gGfa0Sn9x4uFQUhUP3tVR85KkJ187pX3jLmma/j2aWUpUeGECFQE6C/SMWdnXfExsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H11/a4Y4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFiGeLG9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVxOHAxCrggI6ttnhJmBF1UOyDJyFHF+h8BwLATTdcM=;
	b=H11/a4Y4O9FlP/4gBrUmBgBJENdzMj8lbFCC9vXxzfTMKx895tHPs3TR16weeLel+wehBX
	KnGnlHJywdcekWG/6SDWCGYtTkMbNLhRPB2kZWkuZfu6wzq/9drs5jmyfdteIiz7/4aa8X
	kkhVK06OnhR5eGCtX8UYWQhXG4uPC0BpxgV+++/Ls7ikCt5KGcZHQ+fPAZvZLX17s84Lfx
	Fl1smtrUgaKFFqpQhuuz5vZBx+4USFicJDJG+rs69FknvqcSylUkhpNcIQByKitwXPx6ev
	lKRqSlS/W+I6G1LCplymWVmHreg2MRp5pGjU7+D864KorXZnJkSvp/CpGObGfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVxOHAxCrggI6ttnhJmBF1UOyDJyFHF+h8BwLATTdcM=;
	b=cFiGeLG9cGUr68ayoOhIT7Z5RyZ9HJg7FrzkNG5RRwrTtVRj6uIQ5YZUQI8oGANxxWwnS+
	0yzvzhv0mTP0J5Cg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: simplify xol_take_insn_slot() and its caller
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240929144244.GA9480@redhat.com>
References: <20240929144244.GA9480@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551379.1442.4244083375147994026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6ffe8c7d871b327d16ae6b6f1db4c8ecb0f15c64
Gitweb:        https://git.kernel.org/tip/6ffe8c7d871b327d16ae6b6f1db4c8ecb0f15c64
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 29 Sep 2024 16:42:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:44 +02:00

uprobes: simplify xol_take_insn_slot() and its caller

The do / while (slot_nr >= UINSNS_PER_PAGE) loop in xol_take_insn_slot()
makes no sense, the checked condition is always true. Change this code
to use the "for (;;)" loop, this way we do not need to change slot_nr if
test_and_set_bit() fails.

Also, kill the unnecessary xol_vaddr != NULL check in xol_get_insn_slot(),
xol_take_insn_slot() never returns NULL.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144244.GA9480@redhat.com
---
 kernel/events/uprobes.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 03035a8..616b5ff 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1628,25 +1628,20 @@ void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
  */
 static unsigned long xol_take_insn_slot(struct xol_area *area)
 {
-	unsigned long slot_addr;
-	int slot_nr;
+	unsigned int slot_nr;
 
-	do {
+	for (;;) {
 		slot_nr = find_first_zero_bit(area->bitmap, UINSNS_PER_PAGE);
 		if (slot_nr < UINSNS_PER_PAGE) {
 			if (!test_and_set_bit(slot_nr, area->bitmap))
 				break;
-
-			slot_nr = UINSNS_PER_PAGE;
 			continue;
 		}
 		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
-	} while (slot_nr >= UINSNS_PER_PAGE);
+	}
 
-	slot_addr = area->vaddr + (slot_nr * UPROBE_XOL_SLOT_BYTES);
 	atomic_inc(&area->slot_count);
-
-	return slot_addr;
+	return area->vaddr + slot_nr * UPROBE_XOL_SLOT_BYTES;
 }
 
 /*
@@ -1663,12 +1658,8 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 		return 0;
 
 	xol_vaddr = xol_take_insn_slot(area);
-	if (unlikely(!xol_vaddr))
-		return 0;
-
 	arch_uprobe_copy_ixol(area->page, xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-
 	return xol_vaddr;
 }
 

