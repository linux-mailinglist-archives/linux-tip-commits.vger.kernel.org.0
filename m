Return-Path: <linux-tip-commits+bounces-2687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DAC9B906B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 12:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16AB91C21352
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE719CD08;
	Fri,  1 Nov 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONHfZDgH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVEK2sGi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6119C549;
	Fri,  1 Nov 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461271; cv=none; b=lB1iaXMQkho9gniEs4xjz9WInMwGG6t+LSc7LhDge73vMtZgel0NF0UPaAsCjBeqMiQoLAEOAD3oTAFIrWZqcsIddN51R4CUtYXMFawi7mLETadAYicRnWy3rb5bUW6P+V9wwuGjVqC7BGi2sPQ0f+Qei9WgPyDx66zF1bfnRV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461271; c=relaxed/simple;
	bh=Xh+TtsKAT6++LrPtfNmqnuK8rY/pVBqegvXFGwBuxT4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G+r0I352gUOFNndCrL7nfODihRDQKr52biNrQPIUj0FP7tBaDtuCc1flIqMCWqm/8+j5gLlvZ9egEfbQUc79VCOnptBSuOEa34maPm47RSoh6Ao/+0ASr2j+PuiO5judLQLWABwUpg3VexzanyemqfgkW8lO6InaooRis9S45Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONHfZDgH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVEK2sGi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Nov 2024 11:41:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730461265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FaPbUAP6UEIaJ1GoyaZT03XVrZSpVmZRZmJjsl2TXg=;
	b=ONHfZDgH6XpwvlYQRBmNevGWfmLW7RBbbL4PrkGb3+5dnYTWRq+rCyo7PrKaOC9/lCCa8N
	NPuF4hLIMUu3vUa0IZBXkPgQ2sjgUOT1WC3qcQvRedspB1+rNLlpw28NbqABKiz/Ysku+F
	E5D44jKbBqacTQ22qn486n/1AcmYfaGanwQX7Jf0UJnQpapVlIzKygUHuHUjOXriCwVCVF
	j/efop7QdjgnIZ90Yo61tTdDvVRhuMLS+vjNNNsnDe2UzxrXMV3KvcZLoxKrq1zTAgP4Jj
	Ufwd0uOdRBMCU8MH9bejIKscTyMz/cUC598aXFiO2w3BewLBx3CLNW4tAUWGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730461265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+FaPbUAP6UEIaJ1GoyaZT03XVrZSpVmZRZmJjsl2TXg=;
	b=zVEK2sGiopiaKnMRXXavToxmLnXY2FRi25lMO++l3qtnTVMXT0Iop5Cn/fd2tlyyNelIRB
	Tt7mTvRLm9REx9Dg==
From: "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/MCE/AMD: Add support for new MCA_SYND{1,2} registers
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Avadhut Naik <avadhut.naik@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241022194158.110073-4-avadhut.naik@amd.com>
References: <20241022194158.110073-4-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173046126509.3137.9972747278395091217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     d4fca1358ea9096f2f6ed942e2cb3a820073dfc1
Gitweb:        https://git.kernel.org/tip/d4fca1358ea9096f2f6ed942e2cb3a820073dfc1
Author:        Avadhut Naik <avadhut.naik@amd.com>
AuthorDate:    Tue, 22 Oct 2024 19:36:29 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 31 Oct 2024 10:36:07 +01:00

x86/MCE/AMD: Add support for new MCA_SYND{1,2} registers

Starting with Zen4, AMD's Scalable MCA systems incorporate two new registers:
MCA_SYND1 and MCA_SYND2.

These registers will include supplemental error information in addition to the
existing MCA_SYND register. The data within these registers is considered
valid if MCA_STATUS[SyndV] is set.

Userspace error decoding tools like rasdaemon gather related hardware error
information through the tracepoints.

Therefore, export these two registers through the mce_record tracepoint so
that tools like rasdaemon can parse them and output the supplemental error
information like FRU text contained in them.

  [ bp: Massage. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20241022194158.110073-4-avadhut.naik@amd.com
---
 arch/x86/include/asm/mce.h      | 21 +++++++++++++++++++++
 arch/x86/include/uapi/asm/mce.h |  3 ++-
 arch/x86/kernel/cpu/mce/amd.c   |  5 ++++-
 arch/x86/kernel/cpu/mce/core.c  |  9 ++++++++-
 drivers/edac/mce_amd.c          |  8 ++++++--
 include/trace/events/mce.h      |  7 +++++--
 6 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 4e45f45..4d936ee 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -122,6 +122,9 @@
 #define MSR_AMD64_SMCA_MC0_DESTAT	0xc0002008
 #define MSR_AMD64_SMCA_MC0_DEADDR	0xc0002009
 #define MSR_AMD64_SMCA_MC0_MISC1	0xc000200a
+/* Registers MISC2 to MISC4 are at offsets B to D. */
+#define MSR_AMD64_SMCA_MC0_SYND1	0xc000200e
+#define MSR_AMD64_SMCA_MC0_SYND2	0xc000200f
 #define MSR_AMD64_SMCA_MCx_CTL(x)	(MSR_AMD64_SMCA_MC0_CTL + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_STATUS(x)	(MSR_AMD64_SMCA_MC0_STATUS + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_ADDR(x)	(MSR_AMD64_SMCA_MC0_ADDR + 0x10*(x))
@@ -132,6 +135,8 @@
 #define MSR_AMD64_SMCA_MCx_DESTAT(x)	(MSR_AMD64_SMCA_MC0_DESTAT + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_DEADDR(x)	(MSR_AMD64_SMCA_MC0_DEADDR + 0x10*(x))
 #define MSR_AMD64_SMCA_MCx_MISCy(x, y)	((MSR_AMD64_SMCA_MC0_MISC1 + y) + (0x10*(x)))
+#define MSR_AMD64_SMCA_MCx_SYND1(x)	(MSR_AMD64_SMCA_MC0_SYND1 + 0x10*(x))
+#define MSR_AMD64_SMCA_MCx_SYND2(x)	(MSR_AMD64_SMCA_MC0_SYND2 + 0x10*(x))
 
 #define XEC(x, mask)			(((x) >> 16) & mask)
 
@@ -190,9 +195,25 @@ enum mce_notifier_prios {
 /**
  * struct mce_hw_err - Hardware Error Record.
  * @m:		Machine Check record.
+ * @vendor:	Vendor-specific error information.
+ *
+ * Vendor-specific fields should not be added to struct mce. Instead, vendors
+ * should export their vendor-specific data through their structure in the
+ * vendor union below.
+ *
+ * AMD's vendor data is parsed by error decoding tools for supplemental error
+ * information. Thus, current offsets of existing fields must be maintained.
+ * Only add new fields at the end of AMD's vendor structure.
  */
 struct mce_hw_err {
 	struct mce m;
+
+	union vendor_info {
+		struct {
+			u64 synd1;		/* MCA_SYND1 MSR */
+			u64 synd2;		/* MCA_SYND2 MSR */
+		} amd;
+	} vendor;
 };
 
 #define	to_mce_hw_err(mce) container_of(mce, struct mce_hw_err, m)
diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index db9adc0..cb6b48a 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -8,7 +8,8 @@
 /*
  * Fields are zero when not available. Also, this struct is shared with
  * userspace mcelog and thus must keep existing fields at current offsets.
- * Only add new fields to the end of the structure
+ * Only add new, shared fields to the end of the structure.
+ * Do not add vendor-specific fields.
  */
 struct mce {
 	__u64 status;		/* Bank's MCi_STATUS MSR */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5b4d266..6ca80ff 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -797,8 +797,11 @@ static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 	if (mce_flags.smca) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			rdmsrl(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
+			rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
+		}
 	}
 
 	mce_log(&err);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 28e28b6..7fb5556 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -202,6 +202,10 @@ static void __print_mce(struct mce_hw_err *err)
 	if (mce_flags.smca) {
 		if (m->synd)
 			pr_cont("SYND %llx ", m->synd);
+		if (err->vendor.amd.synd1)
+			pr_cont("SYND1 %llx ", err->vendor.amd.synd1);
+		if (err->vendor.amd.synd2)
+			pr_cont("SYND2 %llx ", err->vendor.amd.synd2);
 		if (m->ipid)
 			pr_cont("IPID %llx ", m->ipid);
 	}
@@ -678,8 +682,11 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 	if (mce_flags.smca) {
 		m->ipid = mce_rdmsrl(MSR_AMD64_SMCA_MCx_IPID(i));
 
-		if (m->status & MCI_STATUS_SYNDV)
+		if (m->status & MCI_STATUS_SYNDV) {
 			m->synd = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND(i));
+			err->vendor.amd.synd1 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND1(i));
+			err->vendor.amd.synd2 = mce_rdmsrl(MSR_AMD64_SMCA_MCx_SYND2(i));
+		}
 	}
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 8130c3d..194d9fd 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -793,6 +793,7 @@ static int
 amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 {
 	struct mce *m = (struct mce *)data;
+	struct mce_hw_err *err = to_mce_hw_err(m);
 	unsigned int fam = x86_family(m->cpuid);
 	int ecc;
 
@@ -850,8 +851,11 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		pr_emerg(HW_ERR "IPID: 0x%016llx", m->ipid);
 
-		if (m->status & MCI_STATUS_SYNDV)
-			pr_cont(", Syndrome: 0x%016llx", m->synd);
+		if (m->status & MCI_STATUS_SYNDV) {
+			pr_cont(", Syndrome: 0x%016llx\n", m->synd);
+			pr_emerg(HW_ERR "Syndrome1: 0x%016llx, Syndrome2: 0x%016llx",
+				 err->vendor.amd.synd1, err->vendor.amd.synd2);
+		}
 
 		pr_cont("\n");
 
diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 65aba1a..c1c50df 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -43,6 +43,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
 		__field(	u32,		microcode	)
+		__dynamic_array(u8, v_data, sizeof(err->vendor))
 	),
 
 	TP_fast_assign(
@@ -65,9 +66,10 @@ TRACE_EVENT(mce_record,
 		__entry->bank		= err->m.bank;
 		__entry->cpuvendor	= err->m.cpuvendor;
 		__entry->microcode	= err->m.microcode;
+		memcpy(__get_dynamic_array(v_data), &err->vendor, sizeof(err->vendor));
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016llx, IPID: %016llx, ADDR: %016llx, MISC: %016llx, SYND: %016llx, RIP: %02x:<%016llx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x, vendor data: %s",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -83,7 +85,8 @@ TRACE_EVENT(mce_record,
 		__entry->walltime,
 		__entry->socketid,
 		__entry->apicid,
-		__entry->microcode)
+		__entry->microcode,
+		__print_dynamic_array(v_data, sizeof(u8)))
 );
 
 #endif /* _TRACE_MCE_H */

