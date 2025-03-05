Return-Path: <linux-tip-commits+bounces-4021-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C8A50DD5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 525F83A8DCF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Mar 2025 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC225DAE3;
	Wed,  5 Mar 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QnnBBmRx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pj+0ul+2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A125D1F8;
	Wed,  5 Mar 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210592; cv=none; b=OTi+4eSr80wQ9lo/toUTsN4wOL5nrqTQJI43QGhpY5xSVYjB/wMrHV/5e4Dmo7iULZEyx5oEc3329/feEHvWNRWdeX1tD5EkNVeEFhVdcO9VnwFwdRlG0sWLbIC4UalcxOQ/Yd7B9BxStIm6dFYcgWmqaKeNdaSE+/KFwYkOZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210592; c=relaxed/simple;
	bh=NJHNZCo5BY7tuDIVC8wcNrW4XiWgEClAKumL1f/vOk0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NQ7A42hgdued3ZWQ2y2T/72RQvjBRkYEd5RUdGAT2Gpomc8ZxBSSFUdpg8TzzyZ1usLqghoBGuyz7Og6IH4QYLaKvYUywrq04tgUrKzDQS50FWYsf/viAq+9wqELKEf4nYcvjc0wNKkOQn8f+yIOrw56iNgJc9Xz346T8xQH4Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QnnBBmRx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pj+0ul+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Mar 2025 21:36:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741210588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOAFlYtZBJezadPMMPBPlgpPEL3UdUpPBfeM+Nw6NDw=;
	b=QnnBBmRxZ0Mud1tVZVSWi3NW3DkLbkcQOsn09PiUmJCUdhKZFsthhzn9QAIbQLqUS8Jzq5
	TSsB2Kwd9WTXIHGCaw2HV8LUt8E1GtR+e4GNNEIqmt00BgjLvGD/8Wy0PyTIxS+t3hd2Q7
	DIFxvpJsJPibvQBtoPgmRJumEBun/QYtyVvWT4vdt1jn/N/RU0UKwsxXANqYdEFoMSvUHe
	+IUyiYENHDS9jbNodjT6rJZstTXRMLGhOVI4HoObNm6L5cVXsfTAqClgNSPLIXk0DRawdO
	uu5B0Mq3QX3XIKU2uUyLlFyNOHYSS/+VPBGkXspg8gfDbzfObJ35McoIas828Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741210588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOAFlYtZBJezadPMMPBPlgpPEL3UdUpPBfeM+Nw6NDw=;
	b=pj+0ul+21qGEWdG7gJGgRcr+jv+Q3mHJ7AE0CziV9HJYR+/BuijF7tOS+OrLQIPGl8OW27
	fOL/2Bq1ZWw3YCAw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Consolidate full flush threshold decision
Cc: Dave Hansen <dave.hansen@intel.com>, Rik van Riel <riel@surriel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226030129.530345-2-riel@surriel.com>
References: <20250226030129.530345-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174121058815.14745.1995524860475217029.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     fd521566cc0cd5e327683fea70cba93b1966ebac
Gitweb:        https://git.kernel.org/tip/fd521566cc0cd5e327683fea70cba93b1966ebac
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Tue, 25 Feb 2025 22:00:36 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 04 Mar 2025 11:39:38 +01:00

x86/mm: Consolidate full flush threshold decision

Reduce code duplication by consolidating the decision point for whether to do
individual invalidations or a full flush inside get_flush_tlb_info().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Link: https://lore.kernel.org/r/20250226030129.530345-2-riel@surriel.com
---
 arch/x86/mm/tlb.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index ffc25b3..dbcb5c9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1000,6 +1000,15 @@ static struct flush_tlb_info *get_flush_tlb_info(struct mm_struct *mm,
 	BUG_ON(this_cpu_inc_return(flush_tlb_info_idx) != 1);
 #endif
 
+	/*
+	 * If the number of flushes is so large that a full flush
+	 * would be faster, do a full flush.
+	 */
+	if ((end - start) >> stride_shift > tlb_single_page_flush_ceiling) {
+		start = 0;
+		end = TLB_FLUSH_ALL;
+	}
+
 	info->start		= start;
 	info->end		= end;
 	info->mm		= mm;
@@ -1026,17 +1035,8 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				bool freed_tables)
 {
 	struct flush_tlb_info *info;
+	int cpu = get_cpu();
 	u64 new_tlb_gen;
-	int cpu;
-
-	cpu = get_cpu();
-
-	/* Should we flush just the requested range? */
-	if ((end == TLB_FLUSH_ALL) ||
-	    ((end - start) >> stride_shift) > tlb_single_page_flush_ceiling) {
-		start = 0;
-		end = TLB_FLUSH_ALL;
-	}
 
 	/* This is also a barrier that synchronizes with switch_mm(). */
 	new_tlb_gen = inc_mm_tlb_gen(mm);
@@ -1089,22 +1089,19 @@ static void do_kernel_range_flush(void *info)
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	/* Balance as user space task's flush, a bit conservative */
-	if (end == TLB_FLUSH_ALL ||
-	    (end - start) > tlb_single_page_flush_ceiling << PAGE_SHIFT) {
-		on_each_cpu(do_flush_tlb_all, NULL, 1);
-	} else {
-		struct flush_tlb_info *info;
+	struct flush_tlb_info *info;
+
+	guard(preempt)();
 
-		preempt_disable();
-		info = get_flush_tlb_info(NULL, start, end, 0, false,
-					  TLB_GENERATION_INVALID);
+	info = get_flush_tlb_info(NULL, start, end, PAGE_SHIFT, false,
+				  TLB_GENERATION_INVALID);
 
+	if (info->end == TLB_FLUSH_ALL)
+		on_each_cpu(do_flush_tlb_all, NULL, 1);
+	else
 		on_each_cpu(do_kernel_range_flush, info, 1);
 
-		put_flush_tlb_info();
-		preempt_enable();
-	}
+	put_flush_tlb_info();
 }
 
 /*

