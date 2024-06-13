Return-Path: <linux-tip-commits+bounces-1390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF1907317
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Jun 2024 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DB2824B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Jun 2024 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D869143747;
	Thu, 13 Jun 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ytyL+Chq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQ1oyxPn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033631EEE0;
	Thu, 13 Jun 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283860; cv=none; b=FZS5TLF9QMtr0m42oXvwnYT1rkhPcwDDJ28y6bt+w7ctqAcWDXOnht2rXhd63ve2p/JBjGnXKD45mzOldPbBSlES2K3p28ewoBRe4oSq6uWZxgNYs4voRPh6W+mIsggyFoGIWZz2mkXNOQGidAxRWd4ySCqmVzV4vV/3PAOvgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283860; c=relaxed/simple;
	bh=mKAl+a9mmmclcosB7j5A0sAeDvfxEAyVo6VDqHuuXQ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Is61WxHVt5U8AaVXfof7js+Kn39r92UFKc7CsX0agAWf2enIZLLMMgFBnJHgHGmKkuUITRTMYN5mgd18dkBqXSeD8GEE+yy6u4dyOGoXXYyZ50XbnBXJRsM6YIAKsAEbeHiwIyFEzhpp16DPT3zBbYhTyzsrk0VM4zyJZJzELkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ytyL+Chq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQ1oyxPn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Jun 2024 13:04:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718283856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/3iuphe/fIWOpdHUippxColCYX9TrQ9EQsd6uv0J2A=;
	b=ytyL+ChqQjidiIFqxK8MU9d8/+448qkLt6zmdtlx7DCkvugCVmSzZrJE/tkf/JYPGHoXuJ
	/bWKWSq0M0MncobM781xP9Bbfcn9MVA/pAXmRwWORjzsAQNlfBCrO4/TL8SpKhRV9ka34o
	t3Oumd0H8MywIFMRf+FjCI+WxdjxrUl8Pju5YwuZwZkWLRnQaFlGXFBZL/Tz2wlzaIvnWi
	XJsJdJZmQh8iU+g5km2qMRQZ8L1z+nTxQQnDtB8LErKL9Y6dX7JwAbu3dv4qRrqniJTETA
	T5N/JeeUsQA2XR99CbxcgpYR5651Y+BzD/jWTJTZLRcuoAaDiyD+Miva4q2x4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718283856;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/3iuphe/fIWOpdHUippxColCYX9TrQ9EQsd6uv0J2A=;
	b=kQ1oyxPnCrsTznNHpdSKLaiJDAw5tOKkaALaGA4Sj4ABZFgh/ATNlL93zdMEa2s1R+UNGB
	wU5oZSIPc2VmXjDQ==
From: "tip-bot2 for Mateusz Guzik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Always inline amd_clear_divider()
Cc: Mateusz Guzik <mjguzik@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240613082637.659133-1-mjguzik@gmail.com>
References: <20240613082637.659133-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171828385610.10875.14518435557314345594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     501bd734f933f4eb5c080b87936e9d43f471d723
Gitweb:        https://git.kernel.org/tip/501bd734f933f4eb5c080b87936e9d43f471d723
Author:        Mateusz Guzik <mjguzik@gmail.com>
AuthorDate:    Thu, 13 Jun 2024 10:26:37 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 13 Jun 2024 14:40:29 +02:00

x86/CPU/AMD: Always inline amd_clear_divider()

The routine is used on syscall exit and on non-AMD CPUs is guaranteed to
be empty.

It probably does not need to be a function call even on CPUs which do need the
mitigation.

  [ bp: Make sure it is always inlined so that noinstr marking works. ]

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240613082637.659133-1-mjguzik@gmail.com
---
 arch/x86/include/asm/processor.h | 12 +++++++++++-
 arch/x86/kernel/cpu/amd.c        | 11 -----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index cb4f6c5..a75a07f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -692,7 +692,17 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
 
 #ifdef CONFIG_CPU_SUP_AMD
 extern u32 amd_get_highest_perf(void);
-extern void amd_clear_divider(void);
+
+/*
+ * Issue a DIV 0/1 insn to clear any division data from previous DIV
+ * operations.
+ */
+static __always_inline void amd_clear_divider(void)
+{
+	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
+		     :: "a" (0), "d" (0), "r" (1));
+}
+
 extern void amd_check_microcode(void);
 #else
 static inline u32 amd_get_highest_perf(void)		{ return 0; }
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 44df3f1..be5889b 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1220,14 +1220,3 @@ void amd_check_microcode(void)
 
 	on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
-
-/*
- * Issue a DIV 0/1 insn to clear any division data from previous DIV
- * operations.
- */
-void noinstr amd_clear_divider(void)
-{
-	asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
-		     :: "a" (0), "d" (0), "r" (1));
-}
-EXPORT_SYMBOL_GPL(amd_clear_divider);

