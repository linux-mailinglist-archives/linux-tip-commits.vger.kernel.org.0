Return-Path: <linux-tip-commits+bounces-4267-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFCFA64A92
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C35B3ADEE1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48302417C7;
	Mon, 17 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a1UWN7ok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f76P/TOB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F90F24168E;
	Mon, 17 Mar 2025 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207698; cv=none; b=Rz39vAbFW7PcdkgZDYSgEpEs0+lNh1ASAAKHqddJ2A3n5StMprpFhnkUIRtgETtXounkWSTF7TPqv+Czm8Gp4St7wN1nXCuICy5HqIdcZp86U5DAEsa4LvgEgojgIQvOck22SeV587LpFbfq/QcNImy2rwXsxsxcf9AS8O6FgxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207698; c=relaxed/simple;
	bh=e9+a99bFhNjBWIodm9/lU/0dQe4nn9fBiWQbM4bK4q0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nULYXFMEZs0idzEMbqVUOiXkn6CpT8ReTG4UZqmSG9v09tWyiZ6AlfqQnDRDL4HwwUkB3+a3pAT6L+bs+HF7PQ8zx7uF+zZo3blwc24hyDP1ho809Xe+nMcgwNAQayNpdekbz69oNnGhfYEkNWqgQKLnxNJ3zf7xAL1gSkCIev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a1UWN7ok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f76P/TOB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaDo96AzcAYq0uxz79Zec+9XBJCewygj7WzZYk+jqls=;
	b=a1UWN7okY5vqUo+YmtpACMlELG3LmN5uFU8qMGgBY3MMh8HEz+aAuxdrwE8ErUV8Ja6SE9
	zVuNGnUXwaIg3PltBpWIiMdLH3Df0dSeVUWcyXGWgRV3AUQb6O/JWIl6DkCqULqLlk/PsE
	dALnmwakIaFmMTvfGy3epVN7tYaWxFt6XU77yoViX0oEqlP0w/h0tt5fjdDaAEKA7Dj1e4
	aoLFEk7ii6R/yD/QOH7RtBcRveZMgCzqlLhSqss2aSYDISEXkiRVr8q+ys5b2i+6sKnFty
	54hwgUgIrbCwZ2o5qSsuYEavhZ9EQ5kllnhiw3l746jicga0PkJa6KF3WL03iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaDo96AzcAYq0uxz79Zec+9XBJCewygj7WzZYk+jqls=;
	b=f76P/TOBXhWilwOa6V0R+f0nOaPxIVkK39g/wxqhFUedS0lKHZ7x5+gLJSlSek8TkN6Zz3
	TCGSiBKs/zMDxeCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64: Rely on generic printing of preemption model
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-5-bigeasy@linutronix.de>
References: <20250314160810.2373416-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220769484.14745.4037981429897103614.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4769437de0e2dd9d2660499a72d5e58b7072b786
Gitweb:        https://git.kernel.org/tip/4769437de0e2dd9d2660499a72d5e58b7072b786
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:39 +01:00

arm64: Rely on generic printing of preemption model

__die() invokes later show_regs() -> show_regs_print_info() which prints
the current preemption model.
Remove it from the initial line.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20250314160810.2373416-5-bigeasy@linutronix.de
---
 arch/arm64/kernel/traps.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4e26bd3..529cff8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -172,14 +172,6 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-#ifdef CONFIG_PREEMPT
-#define S_PREEMPT " PREEMPT"
-#elif defined(CONFIG_PREEMPT_RT)
-#define S_PREEMPT " PREEMPT_RT"
-#else
-#define S_PREEMPT ""
-#endif
-
 #define S_SMP " SMP"
 
 static int __die(const char *str, long err, struct pt_regs *regs)
@@ -187,7 +179,7 @@ static int __die(const char *str, long err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %016lx [#%d]" S_PREEMPT S_SMP "\n",
+	pr_emerg("Internal error: %s: %016lx [#%d] " S_SMP "\n",
 		 str, err, ++die_counter);
 
 	/* trap and error numbers are mostly meaningless on ARM */

