Return-Path: <linux-tip-commits+bounces-6561-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D1B52E54
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C291BC7823
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BC4313277;
	Thu, 11 Sep 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uSJDoxEz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b32s1CXQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56233101B5;
	Thu, 11 Sep 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586540; cv=none; b=WH10rwlms6UcjfoULTbLylI1bB9UN5RRAGvZMsvFcMnb9bUUhbrVFQ4vqp3CamNdrKbslKO1LxJcxCUKrIqoO50exCBmc3xASWma/SlAKgdYcFx7UI1JGwUqfuy1Giglklo3C5t6iVBoEoVe/IpIPjpIKNR/fUvsh/XFr8kD2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586540; c=relaxed/simple;
	bh=lIBLI+cI4NMst+33WXAZkGvjYJ6MylJ8E7cIWVfRWkw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jihwb3GEgYDEbb/oU/jWzvbqCZ151pkKB3cgQH3yuMx+qhlqua/7rICe+EucdFEtlDo5KYupvzR7FfNIuJPd26zbD54rfhMBXr5seo6tirZkaNbupn6P43ftMplOIPRBxwhF+rJAFdmEm0O+Hv53Xbk5+UiYITgy6HwRshj3+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uSJDoxEz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b32s1CXQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=d5LRhWddznfxw7OVv80KwpD1M3Z3ighthZFYbsY2p/s=;
	b=uSJDoxEzUdwu/5TkZTqfZiD+NW6ILw74fPXQr8PYA37xM7sceJGeqAKft96nsMInfl2weY
	XEzHtaEzauc29p1sCVuRcc6nEmh+bzcGVk5J8/Db8WSraBDoeYCweuaeGKXI9H5/5duzoR
	dMW8BjgwuvxICdfCV9VL39+2EjsjgI/OISVLQQujR3gD47KOhkMCHCxbHmqeQbC08pqjUm
	xO+I6MYVF0BHL6LiKgK9OjNW4h/MRywczDhtqdggEewaRt2Z88ydccTAtlgmoMToGgI32M
	qEmY5uAiBk9FB4YXQyqLw2rjE4zWIatqLpopfasak9LokbX7IGqWIuYXp0JW2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586537;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=d5LRhWddznfxw7OVv80KwpD1M3Z3ighthZFYbsY2p/s=;
	b=b32s1CXQBN4KFywTJjo4s5ZAyJTnGuhPXWwcaBQ+hqByux2cX8LNrUTDNOyR5O0xhM2cg+
	wMDHXp5B320h6SAQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Unify AMD DFR handler with MCA Polling
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653590.709179.3424479711461480147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     cf6f155e848b8e014010c1b69338d30368214ab9
Gitweb:        https://git.kernel.org/tip/cf6f155e848b8e014010c1b69338d303682=
14ab9
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:38=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:44 +02:00

x86/mce: Unify AMD DFR handler with MCA Polling

AMD systems optionally support a deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar
to how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the
interrupt, e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT
and MCA_DEADDR, that should be checked for valid errors. This check
should be done whenever MCA registers are polled. Currently, the
deferred error interrupt does this check, but the MCA polling function
does not.

Call the MCA polling function when handling the deferred error
interrupt. This keeps all "polling" cases in a common function.

Call the polling function only for banks that have the deferred error
interrupt enabled.

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends
the common polling flow to find AMD deferred errors.

Remove old code whose functionality is already covered in the common MCA
code.

  [ bp: Zap some repeated comments. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/include/asm/mce.h     |   6 ++-
 arch/x86/kernel/cpu/mce/amd.c  | 108 ++------------------------------
 arch/x86/kernel/cpu/mce/core.c |  36 ++++++++++-
 3 files changed, 50 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 31e3cb5..7d65881 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -166,6 +166,12 @@
 #define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
=20
 /*
+ * Indicates that handler should check and clear Deferred error registers
+ * rather than common ones.
+ */
+#define MCE_CHECK_DFR_REGS	BIT_ULL(8)
+
+/*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
  * debugging tools.  Each entry is only valid when its finished flag
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ac6a98a..1b1b83b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -56,6 +56,7 @@ static bool thresholding_irq_en;
=20
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
+	mce_banks_t     dfr_intr_banks;
 };
=20
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -300,8 +301,10 @@ static void smca_configure(unsigned int bank, unsigned i=
nt cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
+		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 			high |=3D BIT(5);
+		}
=20
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status =3D !!(low & BIT(8));
=20
@@ -792,37 +795,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
=20
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce_hw_err err;
-	struct mce *m =3D &err.m;
-
-	mce_prep_record(&err);
-
-	m->status =3D status;
-	m->misc   =3D misc;
-	m->bank   =3D bank;
-	m->tsc	 =3D rdtsc();
-
-	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr =3D addr;
-
-		smca_extract_err_addr(m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
-		}
-	}
-
-	mce_log(&err);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -832,75 +804,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
=20
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr =3D 0;
-
-	rdmsrq(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrq(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrq(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
-/*
- * We have three scenarios for checking for Deferred errors:
- *
- * 1) Non-SMCA systems check MCA_STATUS and log error if found.
- * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
- *    clear MCA_DESTAT.
- * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, a=
nd
- *    log it.
- */
-static void log_error_deferred(unsigned int bank)
-{
-	if (_log_error_deferred(bank, 0))
-		return;
-
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
-
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	unsigned int bank;
-
-	for (bank =3D 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_ba=
nks);
 }
=20
 static void reset_block(struct threshold_block *block)
@@ -952,7 +859,10 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
=20
-	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+	if (m->kflags & MCE_CHECK_DFR_REGS)
+		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	else
+		mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
=20
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 460e90a..6e48290 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -687,7 +687,10 @@ static noinstr void mce_read_aux(struct mce_hw_err *err,=
 int i)
 		m->misc =3D mce_rdmsrq(mca_msr_reg(i, MCA_MISC));
=20
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr =3D mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			m->addr =3D mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(i));
+		else
+			m->addr =3D mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
=20
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -715,6 +718,34 @@ static noinstr void mce_read_aux(struct mce_hw_err *err,=
 int i)
 DEFINE_PER_CPU(unsigned, mce_poll_count);
=20
 /*
+ * There are three scenarios for checking for Deferred errors:
+ *
+ * 1) Non-SMCA systems check MCA_STATUS and log error if found.
+ * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
+ *    clear MCA_DESTAT.
+ * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, a=
nd
+ *    log it.
+ */
+static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_e=
rr *err)
+{
+	struct mce *m =3D &err->m;
+
+	if (m->status & MCI_STATUS_VAL) {
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+		return true;
+	}
+
+	m->status =3D mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	m->kflags |=3D MCE_CHECK_DFR_REGS;
+	return true;
+}
+
+/*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
  * CPUs should skip over uncorrected errors, but log
@@ -740,6 +771,9 @@ static bool should_log_poll_error(enum mcp_flags flags, s=
truct mce_hw_err *err)
 {
 	struct mce *m =3D &err->m;
=20
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;

