Return-Path: <linux-tip-commits+bounces-4264-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F38AA64A89
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8DB3B3C40
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A386A23F43C;
	Mon, 17 Mar 2025 10:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Srsqoznj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubtMDLTK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB223F369;
	Mon, 17 Mar 2025 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207690; cv=none; b=bA3piAGdo0iJj3Zkx4VwgZZFFtyvpeFyAnDLn35sYHs2Etqcsk8aKEHhrG0hdVbJBVNE7rN/xYFORkD8Gu724mbaiVAHwg3aoP98fC0dSmylz6uNzcmmwtfxIPkCOkL+ZKZHxEGOgqKfcRh9ltNu+e92OzSP13yyCKmY95IoOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207690; c=relaxed/simple;
	bh=bNNdVpeI0AEKjGbiz45QX7IaehLfV6UVNfe5Z47DGBI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fDHXbcvRm+pWVbs/bjexMuezQSy3I5xyVNjB33KVoKQcSphiEODhglissytmO6384OHh0eOevp/Tl78/Lp+hFy+4Sf82tUhOsgYebloXQpNVM5CU/GdM5RWerhQL28sKAcD2kgMEb/5pjd4kymdUpaS76rdUTQe0SaMI+wQsbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Srsqoznj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ubtMDLTK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnUB7haMZeUM3HEP18c+WnSkWqa+Mi+uo5L8kSx0LwY=;
	b=Srsqoznjm+oKClRmttRXInMnlRAtsQjXLbj/XEU1CtzBEydMt3hEi/upgXHjggew2hQ9P+
	tTuEN4F9NqRqnEFQgatQlkvE3qMZjdGYwAwcJzvlYN5gnVFiGNrxNLC4F0uHW2BjBAh8tx
	CWobaii6TF5StyHZMTJ3kc7kvJioIoCf6JspQgtB8tr+/c/NYoIAFuJVTNKbwhourJ/OD0
	0PMmHJPiJrdhbPeQ7cwhdCCce/WNkQwtlqdh4EtA8X7jcLDhUg+ISa6EBqPk1I0gKI9BDC
	qkuCffcdmI/VlXQRvHKTNQQxvdWgpHWj/U0uOvabnyQGQUwcBupwunSPse2qTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207687;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rnUB7haMZeUM3HEP18c+WnSkWqa+Mi+uo5L8kSx0LwY=;
	b=ubtMDLTKilrJpTKp/h+jHygfy1NpUrusRRnqZfxr2oWGEarC1u8YiDwotYSV6E3qiJU8jk
	qYLjJuW5b1yQzIBA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] x86: Rely on generic printing of preemption model
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-8-bigeasy@linutronix.de>
References: <20250314160810.2373416-8-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768643.14745.14273144531923361118.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     96389cf365915b53a53ac88c48b620f7db2e1eff
Gitweb:        https://git.kernel.org/tip/96389cf365915b53a53ac88c48b620f7db2e1eff
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:40 +01:00

x86: Rely on generic printing of preemption model

After __die_header(), __die_body() is always invoked. There we have
show_regs() -> show_regs_print_info() which prints the current
preemption model.
Remove it from the initial line.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314160810.2373416-8-bigeasy@linutronix.de
---
 arch/x86/kernel/dumpstack.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d5626..91639d1 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -395,18 +395,13 @@ NOKPROBE_SYMBOL(oops_end);
 
 static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
-	const char *pr = "";
-
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
 		exec_summary_regs = *regs;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
-
 	printk(KERN_DEFAULT
-	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
-	       ++die_counter, pr,
+	       "Oops: %s: %04lx [#%d]%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",

