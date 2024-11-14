Return-Path: <linux-tip-commits+bounces-2859-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27449C86C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 11:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B1C28239D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 10:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D42A1F80CC;
	Thu, 14 Nov 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="csPxeLC8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qJcH82Sk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451381F708C;
	Thu, 14 Nov 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578473; cv=none; b=T9YSbYPsKpbLrHHG8sqW5CphkqHrEt74+22ktBEXhjkOj8MssvvGSxAOjD+Cgl1JumOTFCKNJl2W10Sgm0IvhoeXtEwCfLMMXgpfWgC6Y1Vh185seK/l99u9S2oN/XIfa0s9br5/wn2K7C4XydYJen62jIXeQWUygLE3SDPXEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578473; c=relaxed/simple;
	bh=8EGnY8hpgrmrXQh2w3RyxjyQB/KZYZNMVs9KXdgu2oQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pZoNlvYMVI9geghpFc9EkQ0Zyy4R/7APCosgbKjxdf8XedlwzVPJ34T94mdK1ZR9EQkU1oWIb1hcyoeSK4Io2bQjpgippFnXZUhDCS50kQTaYG6IUn9hKZP/9tVvyIuywqNhBARAW0s5ToltlivdRxg3GHgPeqcxBGTjHPUfYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=csPxeLC8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qJcH82Sk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 14 Nov 2024 10:01:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731578470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EH2PFKRcpByzZSBLYczrDQWuF+7dQcj6qz1vfLj17T0=;
	b=csPxeLC8c/RUzR/t7oF5GmL6ZH/fUoT1Ge4lTfOhHw0EmFoOpcNWr5tV+Net7ecc8g89ti
	Y+ImGDucFKcbFM1qSLXBsyC5IqPkPc3YgwrQSy3uRZREyGac3jKmbYDNaetR4RMtXdnfaR
	Twmux7aN5G8b8WXJBVrhbfwGGkg2V6vDc7GR8Zy/SA8QhMD2u9sDe6TJYFoqVKzhLswmvH
	r8FDcmKbBKTH5Iz8djOACT7Ayf32/GBH3IpvJLLRbeq9OHQv8gN3KWwdvmxIdE2TdQ0viR
	Yzoc+rZFUpeyloe3rq+Vqepqo/A9abocPcZaZ1WMi9OSdCQdl/ZOMH7F3J0JaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731578470;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EH2PFKRcpByzZSBLYczrDQWuF+7dQcj6qz1vfLj17T0=;
	b=qJcH82SkGxGPvAXPfAKaQ9I2yLmyOsOuy4VW/GVtsrpF6W/GjcYYUM+ZqlmzPs8hvRPt2Z
	C88j0VvsMPYpWcDg==
From: "tip-bot2 for Colton Lewis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Refactor misc flag assignments
Cc: Colton Lewis <coltonlewis@google.com>, Ingo Molnar <mingo@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Kan Liang <kan.liang@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241113190156.2145593-5-coltonlewis@google.com>
References: <20241113190156.2145593-5-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173157846913.32228.2469044903650545034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     baff01f3d75ff3948a0465853dcaa71c394c5c46
Gitweb:        https://git.kernel.org/tip/baff01f3d75ff3948a0465853dcaa71c394c5c46
Author:        Colton Lewis <coltonlewis@google.com>
AuthorDate:    Wed, 13 Nov 2024 19:01:54 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 14 Nov 2024 10:40:01 +01:00

perf/x86: Refactor misc flag assignments

Break the assignment logic for misc flags into their own respective
functions to reduce the complexity of the nested logic.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
Acked-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20241113190156.2145593-5-coltonlewis@google.com
---
 arch/x86/events/core.c            | 59 +++++++++++++++++++++---------
 arch/x86/include/asm/perf_event.h |  2 +-
 2 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d19e939..bfc0a35 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -3011,27 +3011,52 @@ unsigned long perf_arch_instruction_pointer(struct pt_regs *regs)
 	return regs->ip + code_segment_base(regs);
 }
 
-unsigned long perf_arch_misc_flags(struct pt_regs *regs)
+static unsigned long common_misc_flags(struct pt_regs *regs)
 {
-	unsigned int guest_state = perf_guest_state();
-	int misc = 0;
+	if (regs->flags & PERF_EFLAGS_EXACT)
+		return PERF_RECORD_MISC_EXACT_IP;
 
-	if (guest_state) {
-		if (guest_state & PERF_GUEST_USER)
-			misc |= PERF_RECORD_MISC_GUEST_USER;
-		else
-			misc |= PERF_RECORD_MISC_GUEST_KERNEL;
-	} else {
-		if (user_mode(regs))
-			misc |= PERF_RECORD_MISC_USER;
-		else
-			misc |= PERF_RECORD_MISC_KERNEL;
-	}
+	return 0;
+}
 
-	if (regs->flags & PERF_EFLAGS_EXACT)
-		misc |= PERF_RECORD_MISC_EXACT_IP;
+static unsigned long guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long guest_state = perf_guest_state();
+
+	if (!(guest_state & PERF_GUEST_ACTIVE))
+		return 0;
+
+	if (guest_state & PERF_GUEST_USER)
+		return PERF_RECORD_MISC_GUEST_USER;
+	else
+		return PERF_RECORD_MISC_GUEST_KERNEL;
+
+}
+
+static unsigned long host_misc_flags(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		return PERF_RECORD_MISC_USER;
+	else
+		return PERF_RECORD_MISC_KERNEL;
+}
+
+unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
+{
+	unsigned long flags = common_misc_flags(regs);
+
+	flags |= guest_misc_flags(regs);
+
+	return flags;
+}
+
+unsigned long perf_arch_misc_flags(struct pt_regs *regs)
+{
+	unsigned long flags = common_misc_flags(regs);
+
+	flags |= host_misc_flags(regs);
 
-	return misc;
+	return flags;
 }
 
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index feb87bf..d95f902 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -538,7 +538,9 @@ struct x86_perf_regs {
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_arch_misc_flags(struct pt_regs *regs);
+extern unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs);
 #define perf_arch_misc_flags(regs)	perf_arch_misc_flags(regs)
+#define perf_arch_guest_misc_flags(regs)	perf_arch_guest_misc_flags(regs)
 
 #include <asm/stacktrace.h>
 

