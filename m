Return-Path: <linux-tip-commits+bounces-2371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D399460F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4FB61C22D41
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F41D278C;
	Tue,  8 Oct 2024 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="buaF46Y9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VS//w837"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6761CFEA5;
	Tue,  8 Oct 2024 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385517; cv=none; b=q4iRpfoUK9H9BcY+Y+13vujulOWICE9GV7x0u+6uDfFloUaufAYoIZgRbctLLL368RPeRJmnAjwl0WnJsnTh5BNUocNd9MyqhXwCmDPNCIFSLPg6SRsj6nxClJvKkFRUXA978l87Rcwvkb89VlCOHoJOoNXPPlnF5l7ZgRe1/UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385517; c=relaxed/simple;
	bh=q13f/4sa6vjQdaExegNDLCVzhjCjub3agfLFBzINxlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AggRaphaT7U278HXQ4hb27WrPga7xup7MArSK99imB9GYZaOjSrxpeJio5Y12pfi4t3N6wfx/G8SA0MPHmuapeySNUMLxJqN+hlC+X1AAjLflp2KBA4okgRfr6SOqDHWbXLS6Hjqg4/aE2q7fUPSoNtuLp2X/sAVA+j8PHHR/vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=buaF46Y9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VS//w837; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/UpulPXLqmDZ1ApagfOOULd/hOPHLX9lZ8eYuZ+Z94=;
	b=buaF46Y95mDFuzENqc2sryiBvRGm8HlPEwcdDBj5nrnhxr57u187yxTCRWjIB9H3ng6d2I
	NtD5/zZth6j7CN+Mpc1HT3EIg/OS0c7hOKcpKehbW7+0S24McYdCdYUBYJ1uEPDjeEbSPb
	nSTEREg3PMztAhYU02r2n9PmZrSKFq+KNQ0apGrrx8My5K6058bwXWV+MLDnJPHpvyv4bO
	rImRUxZlewo+zTztsbbmrRU0A4bLK66acP5C2dLn6QL7H5PR8ezOWlZfxr8/QLAQU/wRIw
	ExAAN5kIKo5X/fgjwKsrXlLacLDoAKLdkMPWi+gcuFODJf+Dl4iwp/UeiEt6ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385513;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/UpulPXLqmDZ1ApagfOOULd/hOPHLX9lZ8eYuZ+Z94=;
	b=VS//w837S9EYznJtIKUfigzyXyVbJGBS5fIA6YzChMQDOpJFyzCvPVCPLfyLQ0wTAnt2F2
	u3Zh/DodjhH7TgDw==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: move the initialization of utask->xol_vaddr
 from pre_ssout() to xol_get_insn_slot()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240929144248.GA9483@redhat.com>
References: <20240929144248.GA9483@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551320.1442.5655983346564181959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1cee988c1d21eabc936d1401811012522083e36f
Gitweb:        https://git.kernel.org/tip/1cee988c1d21eabc936d1401811012522083e36f
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 29 Sep 2024 16:42:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:45 +02:00

uprobes: move the initialization of utask->xol_vaddr from pre_ssout() to xol_get_insn_slot()

This simplifies the code and makes xol_get_insn_slot() symmetric with
xol_free_insn_slot() which clears utask->xol_vaddr.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144248.GA9483@redhat.com
---
 kernel/events/uprobes.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 616b5ff..dfaca30 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1646,21 +1646,19 @@ static unsigned long xol_take_insn_slot(struct xol_area *area)
 
 /*
  * xol_get_insn_slot - allocate a slot for xol.
- * Returns the allocated slot address or 0.
  */
-static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
+static bool xol_get_insn_slot(struct uprobe *uprobe)
 {
-	struct xol_area *area;
-	unsigned long xol_vaddr;
+	struct uprobe_task *utask = current->utask;
+	struct xol_area *area = get_xol_area();
 
-	area = get_xol_area();
 	if (!area)
-		return 0;
+		return false;
 
-	xol_vaddr = xol_take_insn_slot(area);
-	arch_uprobe_copy_ixol(area->page, xol_vaddr,
+	utask->xol_vaddr = xol_take_insn_slot(area);
+	arch_uprobe_copy_ixol(area->page, utask->xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
-	return xol_vaddr;
+	return true;
 }
 
 /*
@@ -1948,21 +1946,17 @@ static int
 pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 {
 	struct uprobe_task *utask = current->utask;
-	unsigned long xol_vaddr;
 	int err;
 
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-	xol_vaddr = xol_get_insn_slot(uprobe);
-	if (!xol_vaddr) {
+	if (!xol_get_insn_slot(uprobe)) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 
-	utask->xol_vaddr = xol_vaddr;
 	utask->vaddr = bp_vaddr;
-
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
 	if (unlikely(err)) {
 		xol_free_insn_slot(current);

