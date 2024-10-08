Return-Path: <linux-tip-commits+bounces-2375-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4EE99461B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA121F275E6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2450E1DE2D9;
	Tue,  8 Oct 2024 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k7kA1+wj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rmgja+lx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0E1D618C;
	Tue,  8 Oct 2024 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385520; cv=none; b=JWSu1uB9CqHB2aAAdfa9snT1YhnHs6dtunwRuAYxy9q30rBhmRGGOcSHPda5RMLUzHjHr19sIPG24UXWyvj279ozJlgjuoM8aeG4V+0oJM9PRe/MYvElG2D7XEV6ES+sDJmliS+wrbNdrmF4YqNBbxfNAHlOLsr4U4/h1SMBYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385520; c=relaxed/simple;
	bh=ojMZjiu1C8XbsZSjdG5JCuKddFmxIwPEmT4ukA82NfA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RlboeqcqN8hnyB+HHNabSyWt56+55LOa/LUFLKnuyxS/iO7vgD+4VosJQo0hRvsu/6qo2Joc4N3bNHyvNmwZTi+UiUCv7OainaFvasdrYI1E8RG/ykq4Qk8+SxtFfHpw9u4CtjCb8kM6xmTdZ5ElYpzWlPyWLPxSCKMsoxRCStk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k7kA1+wj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rmgja+lx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iezi4UX0RI8x/Jg66tLPq80r6H+aokcz2qBoDSggV1I=;
	b=k7kA1+wj3wo0HGza5v7f06yh+c/YxmrhQzfsH4782PXGGWQzUItwJviBRzC7H0SAM/AZ1o
	IJL0S2zCqsC3qIiBBoTM/2skQ44unVlCd+qBx6YuqQkJ8598UCLiGLCY7UUZTIbEPL1O9/
	NA8QNlydcFY1cKfIsVOWcJsUdt9KTD04Z6ckXE6967Ix2H2wwn8/5lIriWUZXCQt73shYH
	xoQs3YaQ2ouYv/T2TGQqlxPmn76CnGFMWPE/eXZUSQ6mo621GcT2J1CEHdxhO8E/Z/KaY8
	j/+JACqfJbEDBS7cd6uKmXBytSAboUmqBXgr+0vN6uO2HRP3iO8xNf1MjtNu2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iezi4UX0RI8x/Jg66tLPq80r6H+aokcz2qBoDSggV1I=;
	b=rmgja+lxOJhX4YR1nVSsLS+n/aXInX60+FWV73TrukRNZ9UnXgM7a8qbcmr8ctN1+MKSSA
	irElmLkxm4d9jzAg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: don't abuse get_utask() in pre_ssout() and
 prepare_uretprobe()
Cc: Oleg Nesterov <oleg@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240929144230.GA9468@redhat.com>
References: <20240929144230.GA9468@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551619.1442.10049185498465124240.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b302d5a6fff5dd7ddb1e4752d60c0eaa4cc4f7f3
Gitweb:        https://git.kernel.org/tip/b302d5a6fff5dd7ddb1e4752d60c0eaa4cc4f7f3
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 29 Sep 2024 16:42:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:44 +02:00

uprobes: don't abuse get_utask() in pre_ssout() and prepare_uretprobe()

handle_swbp() calls get_utask() before prepare_uretprobe() or pre_ssout()
can be called, they can simply use current->utask which can't be NULL.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240929144230.GA9468@redhat.com
---
 kernel/events/uprobes.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5106dc1..15e91a3 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1905,18 +1905,14 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 {
-	struct return_instance *ri;
-	struct uprobe_task *utask;
+	struct uprobe_task *utask = current->utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
+	struct return_instance *ri;
 	bool chained;
 
 	if (!get_xol_area())
 		return;
 
-	utask = get_utask();
-	if (!utask)
-		return;
-
 	if (utask->depth >= MAX_URETPROBE_DEPTH) {
 		printk_ratelimited(KERN_INFO "uprobe: omit uretprobe due to"
 				" nestedness limit pid/tgid=%d/%d\n",
@@ -1977,14 +1973,10 @@ fail:
 static int
 pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 {
-	struct uprobe_task *utask;
+	struct uprobe_task *utask = current->utask;
 	unsigned long xol_vaddr;
 	int err;
 
-	utask = get_utask();
-	if (!utask)
-		return -ENOMEM;
-
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 

