Return-Path: <linux-tip-commits+bounces-4911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABC7A86F01
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BCE19E4E79
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 18:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFC6224B01;
	Sat, 12 Apr 2025 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rYdaY5+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3MibZVl6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67014AD20;
	Sat, 12 Apr 2025 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483621; cv=none; b=YWZK145sgbNvOHvwJDbsdtfSF9dzEM92WG6j+6H5CbVGi0wpL4UfHIEcy2+/O1wcO0FRTbxrdoLIbrguSooiHFnwqpdJxzI2H4fxal+hx2vXW0FGHBe2U7gAHWsl2CCdLKHRqTqjjXHaiA/IPoHR4Qqk96ObsMNqvU3Yodr6Xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483621; c=relaxed/simple;
	bh=j46hwc/Vjomt/pqHJ6Fr1IMoW9Ufx5YOej65KLQ5tpY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fHfA11X8SRPlwk/0YtjQ230iCnKQxxHJXO46qoAYnLYVDp2uBn874VpnQb8c97FP7aGMljFIdKMpu5Kd7pahVRGcLRFguj131HUO2tUPUmd6wIdEO2YVEE6i1YGZiEEjaKYFEzboQ9Tr/wBxlRaUJYyRxgRBaPtPUaMBECyxzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rYdaY5+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3MibZVl6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 18:46:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744483618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuYiJ7p7letDCh7223xHHWSfo+zFdmWmcwBhRUywMFQ=;
	b=2rYdaY5+f547/iCq2i6VKRv/AmhTPD49FnxZsQlhfbhc3SxtZMQ8hSC+5Ju/DtNKhTOnSp
	0XgZ7DoYWBjYjnJr0q6Ds6dx/gClqYj/JvId6p7PMhzURcrLnvldYBmwisMn/8y8NgN/tR
	DLNK/kheeDsbLXS80KrpT/YU0dZrH2foY1LjFezvABmcqNVDAPrBx1UkzRHR30/WGsfGbA
	yX7/Sfm2MkoKjGQAoO3+Y/Y7Q9Ti0mziHWs5+3o6JpZQ9y8PBKUuVN1EyF2w4NX37Q+IXo
	pJuR5LXR3cyDWmd/xpnd1PNVbAOe+P0WfKmNljq/4L5+sjMyu4nBTlvIoElVKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744483618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UuYiJ7p7letDCh7223xHHWSfo+zFdmWmcwBhRUywMFQ=;
	b=3MibZVl6W533egfVdErdYHFpfD8ifzexVLS4O+lsfIyR5t1AL5Afro/Sib8WtKAYQdAztP
	Hsse732Enny2xODQ==
From: "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/events, x86/insn-eval: Remove incorrect
 current->active_mm references
Cc: Andy Lutomirski <luto@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402094540.3586683-3-mingo@kernel.org>
References: <20250402094540.3586683-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448361789.31282.10406016673269368609.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     81e3cbdef230fd9adfa8569044b07290afd66708
Gitweb:        https://git.kernel.org/tip/81e3cbdef230fd9adfa8569044b07290afd66708
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 02 Apr 2025 11:45:35 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 10:05:46 +02:00

x86/events, x86/insn-eval: Remove incorrect current->active_mm references

When decoding an instruction or handling a perf event that references an
LDT segment, if we don't have a valid user context, trying to access the
LDT by any means other than SLDT is racy.  Certainly, using
current->active_mm is wrong, as active_mm can point to a real user mm when
CR3 and LDTR no longer reference that mm.

Clean up the code.  If nmi_uaccess_okay() says we don't have a valid
context, just fail.  Otherwise use current->mm.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402094540.3586683-3-mingo@kernel.org
---
 arch/x86/events/core.c   |  9 ++++++++-
 arch/x86/lib/insn-eval.c | 13 ++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6866cc5..95118b5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2803,8 +2803,15 @@ static unsigned long get_segment_base(unsigned int segment)
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 		struct ldt_struct *ldt;
 
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return 0;
+
 		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = READ_ONCE(current->active_mm->context.ldt);
+		ldt = smp_load_acquire(&current->mm->context.ldt);
 		if (!ldt || idx >= ldt->nr_entries)
 			return 0;
 
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 98631c0..f786401 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -631,14 +631,21 @@ static bool get_desc(struct desc_struct *out, unsigned short sel)
 		/* Bits [15:3] contain the index of the desired entry. */
 		sel >>= 3;
 
-		mutex_lock(&current->active_mm->context.lock);
-		ldt = current->active_mm->context.ldt;
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return false;
+
+		mutex_lock(&current->mm->context.lock);
+		ldt = current->mm->context.ldt;
 		if (ldt && sel < ldt->nr_entries) {
 			*out = ldt->entries[sel];
 			success = true;
 		}
 
-		mutex_unlock(&current->active_mm->context.lock);
+		mutex_unlock(&current->mm->context.lock);
 
 		return success;
 	}

