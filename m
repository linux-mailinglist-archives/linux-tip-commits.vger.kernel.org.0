Return-Path: <linux-tip-commits+bounces-2370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8662899460D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC63CB25202
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91A1D0E1F;
	Tue,  8 Oct 2024 11:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v9T32M11";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9rT9BnKP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63281BA285;
	Tue,  8 Oct 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385516; cv=none; b=XZTABC3D/pWPIgnFjojOzegZMqH6CUJ7ri2GiC4DNWCrwlz63myWnCk812kPrDpaurDa5NUpUejrIcxKRVlTdEoUKo1lbDOnB4OyHVy21KOh53GTtyPYVd5xA7XE47Oo6dKTfxUxajwswEV0LPTfcyEPIXE+5/Qp3D2mxnTTbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385516; c=relaxed/simple;
	bh=0G9B7ZP0SNsI6O8Abf0x7lyS+5z4DLoIvlewSXGTWU0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nv2NYhdbcBG3ylqjIP3yMJ+fbYHuNvkLbZdI/sYJzieJX3arJv5yAO5jgQeseokoHZm+2KuZo+aG6oYs9sTEydD1XJFVckvBN/6e80pERXhEjLtFXILpwY0oPUj8c9p3TWP/rGNlXZ3H8ssPT8qE5aLl5mjCKqOEXC+3gPDjcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v9T32M11; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9rT9BnKP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JkIPTlR0XdZFpi8lbyHeOZeGbkrwQWmnGkyIKMR+9o=;
	b=v9T32M11GHjReQNisfuB49BbTqQn52qMF3upFbS3+9h0SRB3J3FMbUdG8ck875MPQU9WU3
	YpxoBqMJq75nDOqErWba0/q8OEYQuWklfSx+vx+BCEIg87OnQxnrCI8DpbsWb6Tl4ijSBx
	T8VRMlHUjzyMxIatni9oTbZf92t9Ej7NvhimTHpaSZflnKkRwndRutWBYHvjezhwA7hWY7
	mDG/0klzqHYurPPnJppS2n0qy2tKe5DbplHd6rLeG/god2eWj6LTmJMkGUvGyqFFkBIzXO
	7tCaz5XqcwRgVmBmg/+Y9CZR/lsLOSn2O2WHOHeilFSny7kaCpR4CgQq64F8hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JkIPTlR0XdZFpi8lbyHeOZeGbkrwQWmnGkyIKMR+9o=;
	b=9rT9BnKPcwXEHPMlXSkN6FgYNN6jQ6pyfo/CAXzr/43HQfF6VAUodeagRMpA2hVRasCGFD
	D1GJj1Zf4MiCg7Cw==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: pass utask to xol_get_insn_slot() and
 xol_free_insn_slot()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240929144253.GA9487@redhat.com>
References: <20240929144253.GA9487@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551255.1442.11790438272200987982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c5356ab1db28cafc448a50c26ba84442237abb98
Gitweb:        https://git.kernel.org/tip/c5356ab1db28cafc448a50c26ba84442237abb98
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 29 Sep 2024 16:42:53 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:45 +02:00

uprobes: pass utask to xol_get_insn_slot() and xol_free_insn_slot()

Add the "struct uprobe_task *utask" argument to xol_get_insn_slot() and
xol_free_insn_slot(), their callers already have it so we can avoid the
unnecessary dereference and simplify the code.

Kill the "tsk" argument of xol_free_insn_slot(), it is always current.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144253.GA9487@redhat.com
---
 kernel/events/uprobes.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index dfaca30..c9f1e1e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1647,9 +1647,8 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  */
-static bool xol_get_insn_slot(struct uprobe *uprobe)
+static bool xol_get_insn_slot(struct uprobe *uprobe, struct uprobe_task *utask)
 {
-	struct uprobe_task *utask = current->utask;
 	struct xol_area *area = get_xol_area();
 
 	if (!area)
@@ -1664,12 +1663,12 @@ static bool xol_get_insn_slot(struct uprobe *uprobe)
 /*
  * xol_free_insn_slot - free the slot allocated by xol_get_insn_slot()
  */
-static void xol_free_insn_slot(struct task_struct *tsk)
+static void xol_free_insn_slot(struct uprobe_task *utask)
 {
-	struct xol_area *area = tsk->mm->uprobes_state.xol_area;
-	unsigned long offset = tsk->utask->xol_vaddr - area->vaddr;
+	struct xol_area *area = current->mm->uprobes_state.xol_area;
+	unsigned long offset = utask->xol_vaddr - area->vaddr;
 
-	tsk->utask->xol_vaddr = 0;
+	utask->xol_vaddr = 0;
 	/*
 	 * xol_vaddr must fit into [area->vaddr, area->vaddr + PAGE_SIZE).
 	 * This check can only fail if the "[uprobes]" vma was mremap'ed.
@@ -1951,7 +1950,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-	if (!xol_get_insn_slot(uprobe)) {
+	if (!xol_get_insn_slot(uprobe, utask)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
@@ -1959,7 +1958,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	utask->vaddr = bp_vaddr;
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
-		xol_free_insn_slot(current);
+		xol_free_insn_slot(utask);
 		goto err_out;
 	}
 
@@ -2307,7 +2306,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	put_uprobe(uprobe);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
-	xol_free_insn_slot(current);
+	xol_free_insn_slot(utask);
 
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* see uprobe_deny_signal() */

