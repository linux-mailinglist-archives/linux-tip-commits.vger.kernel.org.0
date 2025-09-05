Return-Path: <linux-tip-commits+bounces-6489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0A7B456A8
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 13:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21109A433AC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556F7345743;
	Fri,  5 Sep 2025 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cbgSdddh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3agSdF2+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F4632A3FD;
	Fri,  5 Sep 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072451; cv=none; b=U708+4jO+Q282HLhN+MATFFppTWGj52kSS0Rt5V+sEioAQts6BXcDs6RGh4k9yF0ryhhlpNesTcW9GCCvBijp+SzPZbd1SxtytnoVAmm2AtcrnXUNPzSQgi7fh+AdjJBz8/6PAxE12I4aQ6MIqRpaca2g5Aau6qDi8VmSzpEpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072451; c=relaxed/simple;
	bh=BubKwl4F6dvWOEsCuqRSEQxQ291bhfBjKiS5VyHcTZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jz1wVcGOQx3CHATWP5ZKHQmodzhfxHLh5zTXWTZPI27CLLan2f6GBrHx7dQWLgE3Ti1xAzIZqm8TAZSf6hTecgcmfmJ9f4XTjBm0/HJRPFnTlnossROCgiGqXbtxIAmhbOJNU28Epv8V8duA/3x/LL1ifka14DV7jv+70jv8a18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cbgSdddh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3agSdF2+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 11:40:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757072447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86cj7N+nMsR1yk8z6WxDzsz7l4bZLhEhFbHcYX2nznk=;
	b=cbgSdddhYOueYQncOBiPZd5vM+FmHTySjopoSqlr+t9h47PPOznDUclW/vYs3viZBmpup1
	DG/6b+eaYNtkXFDhlF4O8ARhzRoa2G/PL43l8ZlHcaPMphxVPTcKwFwPtjYNXzHB6kcWf2
	xLZTdHeX3yGi3YtItncrfD9eHkviU6jhZHJUNYb18uw417SlOT6Iin+qZBOnPKNTvHPDpS
	59hqvtrUcBVf4rLzc5WGNDVJhJSOWQzthFaRf0GU6y8dyvIcfXGNtPikjuTOEc7MBnJyiH
	FQ/szBQrLdsMNJnwHH7a+BBWk8DflR/M2pAQ3SRuWbU4dyFTjDZxz7bSIIFtvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757072447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=86cj7N+nMsR1yk8z6WxDzsz7l4bZLhEhFbHcYX2nznk=;
	b=3agSdF2+KnyCls5Luzi6tSmeUotkAVk9MgnejkSWCa1F4LMHYy6IUXDU7t0F95HBRwbvIj
	WSZtohnLia+TZUCQ==
From: "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Cleanup bank processing on init
Cc: Borislav Petkov <bp@suse.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-5-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175707244645.1920.4063086360166631353.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     0f134c53246366c00664b640f9edc9be5db255b3
Gitweb:        https://git.kernel.org/tip/0f134c53246366c00664b640f9edc9be5db=
255b3
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 25 Aug 2025 17:33:02=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Sep 2025 12:42:55 +02:00

x86/mce: Cleanup bank processing on init

Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename that
function to what it does now - prepares banks. Do this so that generic and
vendor banks init goes first so that settings done during that init can take
effect before the first bank polling takes place.

Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks() as it
already loops over the banks.

The MCP_DONTLOG flag is no longer needed, since the MCA polling function is
now called only if boot-time logging should be done.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250825-wip-mca-updates-v5-5-865768a2eef8@amd.=
com
---
 arch/x86/include/asm/mce.h     |  3 +--
 arch/x86/kernel/cpu/mce/core.c | 63 +++++++++------------------------
 2 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 752802b..3224f38 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -290,8 +290,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
 enum mcp_flags {
 	MCP_TIMESTAMP	=3D BIT(0),	/* log time stamp */
 	MCP_UC		=3D BIT(1),	/* log uncorrected errors */
-	MCP_DONTLOG	=3D BIT(2),	/* only clear, don't log */
-	MCP_QUEUE_LOG	=3D BIT(3),	/* only queue to genpool */
+	MCP_QUEUE_LOG	=3D BIT(2),	/* only queue to genpool */
 };
=20
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab..311876e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -807,9 +807,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t=
 *b)
 		continue;
=20
 log_it:
-		if (flags & MCP_DONTLOG)
-			goto clear_it;
-
 		mce_read_aux(&err, i);
 		m->severity =3D mce_severity(m, NULL, NULL, false);
 		/*
@@ -1812,7 +1809,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl =3D -1ULL;
 		b->init =3D true;
@@ -1851,21 +1848,8 @@ static void __mcheck_cpu_cap_init(void)
=20
 static void __mcheck_cpu_init_generic(void)
 {
-	enum mcp_flags m_fl =3D 0;
-	mce_banks_t all_banks;
 	u64 cap;
=20
-	if (!mca_cfg.bootlog)
-		m_fl =3D MCP_DONTLOG;
-
-	/*
-	 * Log the machine checks left over from the previous reset. Log them
-	 * only, do not start processing them. That will happen in mcheck_late_init=
()
-	 * when all consumers have been registered on the notifier chain.
-	 */
-	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
-
 	cr4_set_bits(X86_CR4_MCE);
=20
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
@@ -1873,36 +1857,23 @@ static void __mcheck_cpu_init_generic(void)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 }
=20
-static void __mcheck_cpu_init_clear_banks(void)
+static void __mcheck_cpu_init_prepare_banks(void)
 {
 	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
+	u64 msrval;
 	int i;
=20
-	for (i =3D 0; i < this_cpu_read(mce_num_banks); i++) {
-		struct mce_bank *b =3D &mce_banks[i];
+	/*
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init=
()
+	 * when all consumers have been registered on the notifier chain.
+	 */
+	if (mca_cfg.bootlog) {
+		mce_banks_t all_banks;
=20
-		if (!b->init)
-			continue;
-		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+		bitmap_fill(all_banks, MAX_NR_BANKS);
+		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
 	}
-}
-
-/*
- * Do a final check to see if there are any unused/RAZ banks.
- *
- * This must be done after the banks have been initialized and any quirks ha=
ve
- * been applied.
- *
- * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
- * Otherwise, a user who disables a bank will not be able to re-enable it
- * without a system reboot.
- */
-static void __mcheck_cpu_check_banks(void)
-{
-	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
-	u64 msrval;
-	int i;
=20
 	for (i =3D 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b =3D &mce_banks[i];
@@ -1910,6 +1881,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
=20
+		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrq(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init =3D !!msrval;
 	}
@@ -2314,8 +2288,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
=20
@@ -2483,7 +2456,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
=20
 static struct syscore_ops mce_syscore_ops =3D {
@@ -2501,7 +2474,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
=20

