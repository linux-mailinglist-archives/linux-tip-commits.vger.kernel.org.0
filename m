Return-Path: <linux-tip-commits+bounces-1851-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D38941414
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 16:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E6D28505F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 14:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D71A2570;
	Tue, 30 Jul 2024 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SoQXtSlW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rpPWi47p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D064C1A2557;
	Tue, 30 Jul 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348915; cv=none; b=SEGAX1zi71ODg16fxDgbYvaRrEZllSGyxItYbSjuYOfIXCl35cqMMM3C1zD69zmp5vUc4kUEhGbK9r08Pm/i4VqCJ6y6OY8UASmLmHh/e3re66fd+WLUUV4m1H/Si5ejIsOiJlAaaj5sdKzARhtQrnTmN3l0oG2aPOvxmk9lC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348915; c=relaxed/simple;
	bh=yy+oxtEW4u+u20UdrXubdUcftABR1xACyr6VHFjJ7U8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YBcDOD6uKY8mp3T9LyHVrqDqBJHRs2tqf1GCPGQhrmtRuaEICx3/FbymI3seB2oMJuepz1GFpQgRXnzu3uwDeHx+QKsj+KcnvB5IpDJucRIAIWoukx2Zm75s86pVh60DZfFZB+64IVkzW989v3BLTK1TxkapfoiT4I+ag8EOknM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SoQXtSlW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rpPWi47p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 14:15:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722348912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcVvlovwjFygt8fuDBZmiLOMnprgD31lbY9wn5d6qJM=;
	b=SoQXtSlWpJDDIEdudzy/C8NZZjLO91Xea6gWac0yaqD+TyB6sjRDT7b6Wf89Q9/KbhK+9x
	xbYe85flwL+kHsiyY6ghoPmKr+Zvd2FbEGYjCOtLA/IeA4DEWPRsA+yxydts7Wrz9sWE41
	iMq1SJO1L5KZa5nu2aXeIFSMJo7Ml40J05137ncO6uy3rVcTdaYTx/55l3AuexcTYalr3Z
	z4uMuA4XZ3xFAHa0IoqUhTWB6PEtIa+8u32nIfaBZErIvyRlFeWlundkvcmz5L+XQqSQSy
	QntRgde9dLD7ZfsPR0t6hmuPZmgwqczNkp4yhXmWyo07nALQ+GsQzRkaArs8Fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722348912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcVvlovwjFygt8fuDBZmiLOMnprgD31lbY9wn5d6qJM=;
	b=rpPWi47pWfqomSe+7XeM7qElartDRCT3ClBION0P8pirk5a7cGQ22iXCxK8VQ4VO/U39jP
	tr6l3APitnqaJACw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Remove GDS Force Kconfig option
Cc: Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729164105.554296-11-leitao@debian.org>
References: <20240729164105.554296-11-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172234891192.2215.14873791038703677473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     03267a534bb388acdd2ee685101084d144e8384c
Gitweb:        https://git.kernel.org/tip/03267a534bb388acdd2ee685101084d144e8384c
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Mon, 29 Jul 2024 09:40:58 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 30 Jul 2024 14:53:15 +02:00

x86/bugs: Remove GDS Force Kconfig option

Remove the MITIGATION_GDS_FORCE Kconfig option, which aggressively disables
AVX as a mitigation for Gather Data Sampling (GDS) vulnerabilities. This
option is not widely used by distros.

While removing the Kconfig option, retain the runtime configuration ability
through the `gather_data_sampling=force` kernel parameter. This allows users
to still enable this aggressive mitigation if needed, without baking it into
the kernel configuration.

Simplify the kernel configuration while maintaining flexibility for runtime
mitigation choices.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Link: https://lore.kernel.org/r/20240729164105.554296-11-leitao@debian.org
---
 arch/x86/Kconfig           | 19 -------------------
 arch/x86/kernel/cpu/bugs.c |  4 ----
 2 files changed, 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2e72a07..ab5b210 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2610,25 +2610,6 @@ config MITIGATION_SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
-config MITIGATION_GDS_FORCE
-	bool "Force GDS Mitigation"
-	depends on CPU_SUP_INTEL
-	default n
-	help
-	  Gather Data Sampling (GDS) is a hardware vulnerability which allows
-	  unprivileged speculative access to data which was previously stored in
-	  vector registers.
-
-	  This option is equivalent to setting gather_data_sampling=force on the
-	  command line. The microcode mitigation is used if present, otherwise
-	  AVX is disabled as a mitigation. On affected systems that are missing
-	  the microcode any userspace code that unconditionally uses AVX will
-	  break with this option set.
-
-	  Setting this option on systems not vulnerable to GDS has no effect.
-
-	  If in doubt, say N.
-
 config MITIGATION_RFDS
 	bool "RFDS Mitigation"
 	depends on CPU_SUP_INTEL
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a7f20ae..b2e752e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -735,11 +735,7 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
-static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
-#else
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;
-#endif
 
 static const char * const gds_strings[] = {
 	[GDS_MITIGATION_OFF]		= "Vulnerable",

