Return-Path: <linux-tip-commits+bounces-1904-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87C99450DC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8BF1C212F5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  1 Aug 2024 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0C1BC9E8;
	Thu,  1 Aug 2024 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cP6jbr9K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5b/kltB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8F1BC060;
	Thu,  1 Aug 2024 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530136; cv=none; b=nYfqVK1FbsJdb6ZRZtf8B+oQmwaXNEwozlfWw5Po2eeR7YRJCdtKehmQ2Y2xIpj8N2QanwZv4mFO03uOsYNOrXOCARsAe92ZGb1GZyZZvilcQ3XtV7IfhpSwSLE9qjclx5I0W8LFp5gd1X6JNUFLxDfoJn9YGxBwl+aufcAdc64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530136; c=relaxed/simple;
	bh=WXn7pOenmYmXNoEcz3FhCvEWXffdAen5E7ABGq4QHfg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qY/HLYRnaeyqnO/tti/CRyOaZbsiY88K0PaAUolcUkGpt4lfjvFA2AsbYKl3JT4prKUN/S3EyiJenw6ENwV78jqDCijyoTpUabPtvebr/3A4DHYFZS43tTN0zdpWNoVzj9voT2YkSjJrDJ/mIxvpIRp+KvwyQh+G6Kq1r6OUBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cP6jbr9K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5b/kltB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 01 Aug 2024 16:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722530132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANfngnPqKOP1wy0WOpKzHct1SOebYBS90PN5GKa40V4=;
	b=cP6jbr9KYdF31NtLyPpJnPtvZ6CSZYes870uqXY2hNfLDr61NxGdDoWuv5rVkba77svcpL
	VWCX63fPE+uMOZIZ2SRfbLGQsLB3SiAwaEf39c7myMy5apYjlNIV1ZHvVpQ8jtfM/CpUqO
	Q0kbvLRgsUhBTWVvQRUI4jSIGa3GTnMkKr2GJ7IKmecQ93lWauvrUaGtVmVBFCANpkZitg
	xtDRcBRk9f5tqzTNOqw2IxhPyLu0+sn65rwnLqZ2dZfKulA6reHhQGe8w43irRKFJjybiP
	JYfmPPhcTQFHEkmQLYUQA3T2trLuKZHs5Bq24lKJVxWX5bNBKLu6ZK2CBb8jew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722530132;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ANfngnPqKOP1wy0WOpKzHct1SOebYBS90PN5GKa40V4=;
	b=X5b/kltBgLLuMog4Or9vZISiNKbvDO7pXZrR0MWUO9H0EJ36pkw+RKvblYuz1qIzff+aBj
	dTLD/BRyNIzmy5Aw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Rename mce_setup() to mce_prep_record()
Cc: Borislav Petkov <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240730182958.4117158-2-yazen.ghannam@amd.com>
References: <20240730182958.4117158-2-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172253013173.2215.13005247955088150446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     5ad21a2497329c2b090d5b02b95394a1316bef53
Gitweb:        https://git.kernel.org/tip/5ad21a2497329c2b090d5b02b95394a1316bef53
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 30 Jul 2024 13:29:56 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 01 Aug 2024 18:20:24 +02:00

x86/mce: Rename mce_setup() to mce_prep_record()

There is no MCE "setup" done in mce_setup(). Rather, this function initializes
and prepares an MCE record.

Rename the function to highlight what it does.

No functional change is intended.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20240730182958.4117158-2-yazen.ghannam@amd.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/include/asm/mce.h     | 2 +-
 arch/x86/kernel/cpu/mce/amd.c  | 2 +-
 arch/x86/kernel/cpu/mce/apei.c | 4 ++--
 arch/x86/kernel/cpu/mce/core.c | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3ad29b1..3b99701 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -221,7 +221,7 @@ static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 					     u64 lapic_id) { return -EINVAL; }
 #endif
 
-void mce_setup(struct mce *m);
+void mce_prep_record(struct mce *m);
 void mce_log(struct mce *m);
 DECLARE_PER_CPU(struct device *, mce_device);
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133e..14bf8c2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -780,7 +780,7 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.status = status;
 	m.misc   = misc;
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 7f7309f..8f509c8 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -44,7 +44,7 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 	else
 		lsb = PAGE_SHIFT;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 	m.bank = -1;
 	/* Fake a memory read error with unknown channel */
 	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | MCI_STATUS_MISCV | 0x9f;
@@ -97,7 +97,7 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
+	mce_prep_record(&m);
 
 	m.extcpu = -1;
 	m.socketid = -1;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b85ec7a..dd5192e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -118,7 +118,7 @@ static struct irq_work mce_irq_work;
 BLOCKING_NOTIFIER_HEAD(x86_mce_decoder_chain);
 
 /* Do initial initialization of a struct mce */
-void mce_setup(struct mce *m)
+void mce_prep_record(struct mce *m)
 {
 	memset(m, 0, sizeof(struct mce));
 	m->cpu = m->extcpu = smp_processor_id();
@@ -436,11 +436,11 @@ static noinstr void mce_wrmsrl(u32 msr, u64 v)
 static noinstr void mce_gather_info(struct mce *m, struct pt_regs *regs)
 {
 	/*
-	 * Enable instrumentation around mce_setup() which calls external
+	 * Enable instrumentation around mce_prep_record() which calls external
 	 * facilities.
 	 */
 	instrumentation_begin();
-	mce_setup(m);
+	mce_prep_record(m);
 	instrumentation_end();
 
 	m->mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);

