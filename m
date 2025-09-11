Return-Path: <linux-tip-commits+bounces-6568-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D3EB52E61
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9A17B74B4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48603164AA;
	Thu, 11 Sep 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fcfv4dFA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xOnUlLBS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C4314A95;
	Thu, 11 Sep 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586547; cv=none; b=hzrcLAlhIyF8NZfV7Y/l0xIMxSA5yh/dx+rBxpeLUh8J483vOQpLYrOJpEGygZ4/JTuu3BDJBJIV7Ii2pFihLVU4AIHJvtIppxAlp2Jo6TwOCcbb1mO7DXtudsqsyuzetC3wwmOixkw9HCbDLFgEwy9s5MNxBsMx8aB1Br46dpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586547; c=relaxed/simple;
	bh=E2Jx2MkgmjGf4awIecnaPOhR9uw6GXOjckrkBG/cqHo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZI8O85/Ml6ywn9ZBFsKIZNoJEYVqHyXKzEGSIlr31k5iDeNVgocEW2hFGE1prQN1YbxxVMstOKBDdP+f1jTz57jg+ZfaEmfQtIT0n2Tv0/lX8aJLfA+D/IQknP7Bdgse4AjEhRlTdOB+4CPufc2wxBd6+TR7d352+tfa8QU3bQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fcfv4dFA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOnUlLBS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yPAhqI6G0F7Yx/ZvlMZMVuLg/ouf8qyUlWfyS2rD9H8=;
	b=Fcfv4dFAZGwboizTrxu+KNSygdpnBPMU13V5HN0Kjv3OTuFMNEdNXqGq3/0dPd48e6M2o5
	X1iYF8sRZYOvTvoQEDVSS1WpTor86PDdTXTEsUi/xq8nAmlAsw8iNcGazAE+E6MB/o8r9w
	vEoxBYJgqBkMTeNultYYkdsmtY0VbDwCcQ/klA3xVjkeCthosM2VXiDb54P06esy9gvbgG
	JeT2+9zkhKlR2OTWwi/xLE4nwmlgvgO3ev+yKDiAf7NjhL5U8yWAReCYK3ITnfgy+ypPoz
	uD1+d5+LNUnl/LJWjU+bfoDKN2ERGNrf0HhJ3k0R+BAm9B9eNIXxVIRYR2E/MA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586544;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=yPAhqI6G0F7Yx/ZvlMZMVuLg/ouf8qyUlWfyS2rD9H8=;
	b=xOnUlLBST9rcD3QAj5TJOwFFoLX+k8/OlFYZqG0HLEZ0wpFbkpxMWc3jwgVXwifpnIDCea
	0wRAGlgSHFqaUtAg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Define BSP-only init
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758654328.709179.6461024887306094247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     669ce4984b729ad5b4c6249d4a8721ae52398bfb
Gitweb:        https://git.kernel.org/tip/669ce4984b729ad5b4c6249d4a8721ae523=
98bfb
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:31=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:22:37 +02:00

x86/mce: Define BSP-only init

Currently, MCA initialization is executed identically on each CPU as
they are brought online. However, a number of MCA initialization tasks
only need to be done once.

Define a function to collect all 'global' init tasks and call this from
the BSP only. Start with CPU features.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/include/asm/mce.h     |  2 ++
 arch/x86/kernel/cpu/common.c   |  1 +
 arch/x86/kernel/cpu/mce/amd.c  |  3 ---
 arch/x86/kernel/cpu/mce/core.c | 28 +++++++++++++++++++++-------
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 3224f38..31e3cb5 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -241,12 +241,14 @@ struct cper_ia_proc_ctx;
=20
 #ifdef CONFIG_X86_MCE
 int mcheck_init(void);
+void mca_bsp_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
 			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
+static inline void mca_bsp_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_in=
fo,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 34a0541..8bbfde0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1784,6 +1784,7 @@ static void __init early_identify_cpu(struct cpuinfo_x8=
6 *c)
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
=20
 	detect_nopl();
+	mca_bsp_init(c);
 }
=20
 void __init init_cpu_devs(void)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index aa13c93..3c6c19e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -653,9 +653,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low =3D 0, high =3D 0, address =3D 0;
 	int offset =3D -1;
=20
-	mce_flags.overflow_recov =3D cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV=
);
-	mce_flags.succor	 =3D cpu_feature_enabled(X86_FEATURE_SUCCOR);
-	mce_flags.smca		 =3D cpu_feature_enabled(X86_FEATURE_SMCA);
 	mce_flags.amd_threshold	 =3D 1;
=20
 	for (bank =3D 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 9e31834..79f3dd7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1837,13 +1837,6 @@ static void __mcheck_cpu_cap_init(void)
 	this_cpu_write(mce_num_banks, b);
=20
 	__mcheck_cpu_mce_banks_init();
-
-	/* Use accurate RIP reporting if available. */
-	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >=3D 9)
-		mca_cfg.rip_msr =3D MSR_IA32_MCG_EIP;
-
-	if (cap & MCG_SER_P)
-		mca_cfg.ser =3D 1;
 }
=20
 static void __mcheck_cpu_init_generic(void)
@@ -2240,6 +2233,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
 }
 #endif
=20
+void mca_bsp_init(struct cpuinfo_x86 *c)
+{
+	u64 cap;
+
+	if (!mce_available(c))
+		return;
+
+	mce_flags.overflow_recov =3D cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV=
);
+	mce_flags.succor	 =3D cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 =3D cpu_feature_enabled(X86_FEATURE_SMCA);
+
+	rdmsrq(MSR_IA32_MCG_CAP, cap);
+
+	/* Use accurate RIP reporting if available. */
+	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >=3D 9)
+		mca_cfg.rip_msr =3D MSR_IA32_MCG_EIP;
+
+	if (cap & MCG_SER_P)
+		mca_cfg.ser =3D 1;
+}
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:

