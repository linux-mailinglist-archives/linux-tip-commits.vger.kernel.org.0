Return-Path: <linux-tip-commits+bounces-4269-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D60A64A91
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2023B2B44
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B0242921;
	Mon, 17 Mar 2025 10:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fAVG6Fxv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxFL5dnv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C42417C4;
	Mon, 17 Mar 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207700; cv=none; b=g5jfph+FlsH4zz08fJ9MsOvc3bUApxbfJ3xhEZPU7KIufp8NL/TlK9geNwgg49lHWbVOmpYsNDlXamUG6rdU8KruV2hrYbRJyY4x9gQsNlPFXi6Dtjs+FIhBrmwYKXkxenp6hXrbSPyVR/GXhYWKXNW1Hk6rwLVIVksagAD8f04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207700; c=relaxed/simple;
	bh=H9TP93YSvN3YQGgAagukkZCStzx5bLgG7DtjR8iAUqs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HBVT//PXmPioYDFd9OBJY0IuWgu03fWBMl/ZlwHR7FIfuN9yTvVd2wT7UmlSWhxwnSX5yjPkh1oRPxA7A6hbjnfxJFRJq0/sEk0joi00PlKDXAdsd/36NEPuKfjP+VDqkCXkH4fKU3jD79MQQlWBCBZ4j3OHD5YaNpgpfHrx9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fAVG6Fxv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxFL5dnv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPRrJ7RstNJG/0hsNxXM+yzNMXRfZBWV/wxll74ZH+E=;
	b=fAVG6FxvQ3TVrjrPRGn8oyh20sadobZGW204PoDyrdJhvci/0FWQvnF6L1N2kUM8j26kHi
	rOtMpNw5eSTuk9doLxTlFe/TjysfgNHh+zZ/WvsjM/QOwVIofg5XgBARaef094swd/3RDh
	vuGFfq2RTnEmoiHKQNThLM0o8SKam4GGUNnTNbUw3Obfsac3+2T3ARqj7jt9r5M3wh8YEj
	bTCKdK9yt4PrTjHOXkgCaeWgywW3vUiR3+F4VIESj4p1YZwB8ssePIHbZ6s4ZypgfPg8Oe
	W2YNoYIRX/ZNU7KyKpCufxmi4JTm84Rc1PPUnrkAbsTX3ll8VdS37v1zEZ/N6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPRrJ7RstNJG/0hsNxXM+yzNMXRfZBWV/wxll74ZH+E=;
	b=WxFL5dnvpp2sGi4D4h1QKxSU+SePNZ71cvXq4PJC8D7KedhuXRAE3pbx/KTxUQ/0ccKqbd
	JhkJ2aq7Utopg+Bg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] lib/dump_stack: Use preempt_model_str()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314160810.2373416-3-bigeasy@linutronix.de>
References: <20250314160810.2373416-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220769598.14745.1929425104985215336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d167706f68ee22635a244bd414927f4202a3e942
Gitweb:        https://git.kernel.org/tip/d167706f68ee22635a244bd414927f4202a3e942
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 14 Mar 2025 17:08:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:39 +01:00

lib/dump_stack: Use preempt_model_str()

Use preempt_model_str() to print the current preemption model. Use
pr_warn() instead of printk() to pass a loglevel. This makes it part of
generic WARN/ BUG traces.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314160810.2373416-3-bigeasy@linutronix.de
---
 lib/dump_stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 388da1a..b3a85fe 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -54,7 +54,7 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT "\n",
+	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s " BUILD_ID_FMT "\n",
 	       log_lvl, raw_smp_processor_id(),
 	       __kuid_val(current_real_cred()->euid),
 	       current->pid, current->comm,
@@ -62,7 +62,7 @@ void dump_stack_print_info(const char *log_lvl)
 	       print_tainted(),
 	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version, BUILD_ID_VAL);
+	       init_utsname()->version, preempt_model_str(), BUILD_ID_VAL);
 
 	if (get_taint())
 		printk("%s%s\n", log_lvl, print_tainted_verbose());

