Return-Path: <linux-tip-commits+bounces-3669-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F98A45E58
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B433C19C3200
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E5425E452;
	Wed, 26 Feb 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqNoVT87";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LqoTWzyi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4E22356B5;
	Wed, 26 Feb 2025 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571493; cv=none; b=IC/3glQIKmUWHindpNk5Uu73RevRRnHHc8T5VA1cP17zxyopvmi7A5bhWyKb7DabaGAZHOKhHzDpSuzdGQBJ+h7krUqjzNVE2+X0wVGfKTMwRrLa++xPacWh16bo2Hc3Wb4kYWv2B2+NGXoPR2kZxXydppXiJ+lxZm2b84dgqiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571493; c=relaxed/simple;
	bh=f/xzp3L7MwoKYLHqlT/OPJsKUZdiuVQU0Q5rAY429Y4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n7ndnWIsYcMP8lBE6gnWhqFPEMq55hkAyHbWslloVWCmVMgmEMAtqVhcNF2MLVuk0sbqWz9K4X0IEYBoQLD77f/DBnaaDvpnRKGAZtWJvOoeep83iiScbHTTIR9Qjcl6+Vji3qxZ4Hr1DVvzMAi1dXXMMKqHfLbftgPhBUqtYfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqNoVT87; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LqoTWzyi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 12:04:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740571490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQiNCPizvEwE/lNN59Hcty6V4v3CDz60wrb60BLIuwo=;
	b=aqNoVT87u3rYlJhjt3d3f2E12+ToCV3BILR1yjQ2aia1O0slGw+e4i1LFGi7fYnnhr2Wma
	TDDRN9SuEFrvBLH39ptaKjEBFxPWJ2zTXzDKMENx7Z5mH6Z0rUIDPhq9eI/ZKwD9lQ00K5
	8USLJ8p3u5MFpz/8ptcjwBQLOjRXQG0A6WUmJz1MKomGjVJD+D+JsMH2FZ7Qrfs5TEB00S
	2HYounVIps+ijSz/s9aQnvEzqAtWq7LHEVHB9r7ev8dCCxeVctbD/2KdP9OQbDTCIXK/46
	HYDXVPqzfyTepHYck3rELe7sEvwK8XjEeZJah1Oc7AAxtVnA4wdQxruGRT78Rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740571490;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQiNCPizvEwE/lNN59Hcty6V4v3CDz60wrb60BLIuwo=;
	b=LqoTWzyijNPdcxkisuNr5HIA8V1aXptkHerK3mS8FPvUrYwLaoHnaiHCdB89Xzio45gQgE
	ztppsTfEAeOI2bAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Add 'cfi=warn' boot option
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224124159.924496481@infradead.org>
References: <20250224124159.924496481@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174057148993.10177.11418020321616617043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9a54fb31343362f93680543e37afc14484c185d9
Gitweb:        https://git.kernel.org/tip/9a54fb31343362f93680543e37afc14484c185d9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:04 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 12:10:48 +01:00

x86/cfi: Add 'cfi=warn' boot option

Rebuilding with CONFIG_CFI_PERMISSIVE=y enabled is such a pain, esp. since
clang is so slow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250224124159.924496481@infradead.org
---
 arch/x86/kernel/alternative.c | 3 +++
 include/linux/cfi.h           | 2 ++
 kernel/cfi.c                  | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 247ee5f..1142ebd 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1022,6 +1022,9 @@ static __init int cfi_parse_cmdline(char *str)
 			cfi_mode = CFI_FINEIBT;
 		} else if (!strcmp(str, "norand")) {
 			cfi_rand = false;
+		} else if (!strcmp(str, "warn")) {
+			pr_alert("CFI mismatch non-fatal!\n");
+			cfi_warn = true;
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index f0df518..1db17ec 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <asm/cfi.h>
 
+extern bool cfi_warn;
+
 #ifndef cfi_get_offset
 static inline int cfi_get_offset(void)
 {
diff --git a/kernel/cfi.c b/kernel/cfi.c
index 08caad7..19be796 100644
--- a/kernel/cfi.c
+++ b/kernel/cfi.c
@@ -7,6 +7,8 @@
 
 #include <linux/cfi.h>
 
+bool cfi_warn __ro_after_init = IS_ENABLED(CONFIG_CFI_PERMISSIVE);
+
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 				      unsigned long *target, u32 type)
 {
@@ -17,7 +19,7 @@ enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,
 		pr_err("CFI failure at %pS (no target information)\n",
 		       (void *)addr);
 
-	if (IS_ENABLED(CONFIG_CFI_PERMISSIVE)) {
+	if (cfi_warn) {
 		__warn(NULL, 0, (void *)addr, 0, regs, NULL);
 		return BUG_TRAP_TYPE_WARN;
 	}

