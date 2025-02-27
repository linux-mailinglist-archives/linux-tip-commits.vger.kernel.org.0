Return-Path: <linux-tip-commits+bounces-3697-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E903A479DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB787A293D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566622A808;
	Thu, 27 Feb 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4qFygvNN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOZYoEZe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E0229B0E;
	Thu, 27 Feb 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740651129; cv=none; b=oLBkVtdVWvuu6/f+p3N2Ghy1mYx73HV8k52/MEiMhyajVxi3KGdmyWoygB2ynnZ9bMlI15Zu5oEC/QT0ZH4jSqV6RtQJ39nnFn0H0D3JbyNJ9gzMp2uxrGmdkuNgFVvS6PnQfIHP8OoRINWZmWo2wFJbExbCk5hS6n/f+G6EQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740651129; c=relaxed/simple;
	bh=grcMpM8XGtUmgUhTzWj7xiTewmqmUgfqm8g7kP73kEw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FQTQuf6dMKAH6xXWmfTnC+3xO6rxJwhT+XSZnzt2ZYkmCpKZnb9uwFSLP5v/rbRWkbZ4CmOWdMSfkpP4ZhPqfoQBq0L8BTeiLMkj+xOHQRc5n7U2gRuzvY3GXQ4xmspQ9O2y8PofqLrzv6u4a19xa3anglnLWpsBP6F/7P8Twy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4qFygvNN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOZYoEZe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740651124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBCrGgmQtV0Mvy2fT1s7TpwBCLhBgoFXpiDUARS1C54=;
	b=4qFygvNNEkOMXP6DDBkXYb5RW8PivnzUnaBL2vb5pAEFrsnhi+my0ya9Un7RpHWl6oLIPf
	EUKqEE4dPViVumkB6GVLHeWxQHAg/7YAWjfokcR5aUokijYcb/jWpu3aTHMI70/9g7yt0K
	K1lbjvPLGWhNSt28F9PTzZGXEtP6xbtQA1p8sIO5QJgLJIELRQ4fVOlLyiBC2/ll5x7P9J
	Y/bS0pmSbiTyG1qbd3GVgWaNbZTnZk5Ubv5RyctJJvpkHl5bWUHbLusOI+49wRdcRR8E0F
	TjL2CGqtigt8tMphuO/eiQ7W/6ekLeJDxjXXH4VGDT2P4EDJJNg6kh1iClpC0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740651124;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBCrGgmQtV0Mvy2fT1s7TpwBCLhBgoFXpiDUARS1C54=;
	b=UOZYoEZejUBpW9oeE4h2ETDJMfUUktxCMNnJKpebx2ojMNCtADTptWLOSD+vAApisGRcv9
	VZgAGe3OjVmahmAQ==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/mm: Remove X86_FEATURE_USE_IBPB checks in
 cond_mitigation()
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250227012712.3193063-3-yosry.ahmed@linux.dev>
References: <20250227012712.3193063-3-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065112425.10177.5617289587754238222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a48dc42614cad39fac1ef55d690847fd07f0e3c6
Gitweb:        https://git.kernel.org/tip/a48dc42614cad39fac1ef55d690847fd07f0e3c6
Author:        Yosry Ahmed <yosry.ahmed@linux.dev>
AuthorDate:    Thu, 27 Feb 2025 01:27:08 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 10:57:20 +01:00

x86/mm: Remove X86_FEATURE_USE_IBPB checks in cond_mitigation()

The check is performed when either switch_mm_cond_ibpb or
switch_mm_always_ibpb is set. In both cases, X86_FEATURE_USE_IBPB is
always set. Remove the redundant check.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250227012712.3193063-3-yosry.ahmed@linux.dev
---
 arch/x86/mm/tlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4f61d11..3070807 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -437,8 +437,7 @@ static void cond_mitigation(struct task_struct *next)
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
-		    (next_mm | prev_mm) & LAST_USER_MM_IBPB &&
-		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
 	}
 
@@ -448,8 +447,7 @@ static void cond_mitigation(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) != (unsigned long)next->mm &&
-		    cpu_feature_enabled(X86_FEATURE_USE_IBPB))
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) != (unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
 	}
 

