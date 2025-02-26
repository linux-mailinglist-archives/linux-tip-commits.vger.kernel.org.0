Return-Path: <linux-tip-commits+bounces-3644-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC25A45C48
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C765175673
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179027128F;
	Wed, 26 Feb 2025 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1FLMiRwX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jepdv8iP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287D326FD85;
	Wed, 26 Feb 2025 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567267; cv=none; b=TG7XBW1LPLnRUtYsGJ6jbS1N9B/t4z8BB0fVRsFknRSDz3GYvyok617PwDdPhenXD73DA6YtZIl4Zkz832+3wHJlddhZbxWpKWsJo3FKQb1UiOb8eTduUd654Z05KFn6S9caihTiSt+nTYbpueL1Mo2scviPUhQjnD43aR0jh8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567267; c=relaxed/simple;
	bh=UROiS+W0ZalnNDQVlDk6gaX0lUdaLd/4dAR1/K8/rt0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lZVCegOU9j6AtyZjEP54TlHTNpM+gYwfbKW4ikDnJexRpQys//djg5IgWPTnfKkjSpHyrmgSoXjUVVZpqxlngyEoQbGpJ+WCIqO0tehaEd1quPZmxpP/M0GbVl38z1AkTTO7pZ26YMtE1itjv+VwIUCoce5ZXrdq2cRukUCmonw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1FLMiRwX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jepdv8iP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 10:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PgpXSae7O1VWFna0jYT6apG/3Hm/MaP/RddLIoQowM=;
	b=1FLMiRwXVPVIzSk13HjIlWHpkCAVTragpX7TISANO/BrYKLCCXi6QpxAs9orseJDjYk+GJ
	/ILvouM87vW3oH51vacWZCjYarRTu0REnFS27aLRJUMoR1DmzIjAEx/jZp8Apm5to5FnP4
	XHF5BiDu3cnUpo1MC9kazi4HND2a+Ba3z9ImBikw8c7eeNoL7hltmSV5YvggrvaIB8F0Aa
	b31Vle9B1aMhFLIETAat6oLjaHMA6724X2c+HqZgdo8lrDQHAzulDfSpBbznaiv9tOl21p
	IMwDmSBFPsuGyPsNg4UzXIvoWOiuO8u9uCrfBVPNw6eyDSkZjaTeMTbxYYNiUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5PgpXSae7O1VWFna0jYT6apG/3Hm/MaP/RddLIoQowM=;
	b=jepdv8iPm6eC0jWTzYY/G8zST38TqTPqrCJYnkCk9MXFnLQZKlSzvXylAPyuDPLXXAcyJX
	o1NlHfXz/YmW2cCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Add warn option
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224124159.924496481@infradead.org>
References: <20250224124159.924496481@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056726322.10177.14430365702785340054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f003da5d29a179bd1beb4ef87ac93a3ca6ddf734
Gitweb:        https://git.kernel.org/tip/f003da5d29a179bd1beb4ef87ac93a3ca6ddf734
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2025 13:37:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Feb 2025 11:41:53 +01:00

x86/cfi: Add warn option

Rebuilding with CFI_PERMISSIVE toggled is such a pain, esp. since
clang is so slow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

