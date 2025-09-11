Return-Path: <linux-tip-commits+bounces-6560-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46600B52E53
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC39A8184A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B853128C1;
	Thu, 11 Sep 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EbOX/DvU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W5she/Fe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67D0311969;
	Thu, 11 Sep 2025 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586539; cv=none; b=mMb2mSYvKFHTm7yVV85KwrXP5hsw9+z7/+U1E9XMKQiginjxFQBYD9XLc+NHEX4IPKxE9LWJt50YJWOfXNTGehcrPS7iq8bKnLze2UJwRZbxI6l6wqniAUOcLC16r7o9uhHE0jak6pAK5dHnQIHFavPjGJOTRLoxwKwA06WaTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586539; c=relaxed/simple;
	bh=Z52D73/W+066kJuNbbFi6YO+y0aiN8hxUM3/SjUExI4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BQFU5E1CD/a/VILBp1AvEVmgiwDk9jLeun+E0IKQAun6IbEfdoMXh9l2+9wnTuh3SYksS/gsYb7adsdwhkgHmgm6IjM6atDzyEZGIsJE1EfEjcEzxsDRaK4h7D2Ddg0HZCOz/PObyZkn8cu5PXKElwUmyWrEXbOlC25iJDlsWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EbOX/DvU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W5she/Fe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=liYd/NY69Wa4O5/xF3z43TArOcdw9feVKy73/Dch/nY=;
	b=EbOX/DvUTHAILcIEVm3Xp2oyGTxtTOaJ4xlcXhIfjyoX8E4Pq+vua06c3C9HViILZiv3Qa
	QO7rFwGPsMRmDTY7F+8A5R3yp8uuZAGGDW8V2BODdP8OuwGFJTM/nj3WOb/hy+Nyk4ioso
	CjAiaIK9BNCNNmnIe/PHzgtpGmk2zCXBosXEBjFgrLb05j+Jgq35C+H7hudpv4/pLN2bfB
	G8lwCbKwjljb/Lr2YtOW94w/Q48aOaVbemQC7XGltit5zTlkEaB69JwCUo8V6ps1IkqEEb
	ULTMeZcfB7u4qCo2Sngtv2HsAaSKxV22R856cmO2FX5idNi6pV2kqMLUQpguOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586536;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=liYd/NY69Wa4O5/xF3z43TArOcdw9feVKy73/Dch/nY=;
	b=W5she/Fe9BhWbSsMf+dz5Vv6KibnnqQsLHfPhDfBojo9oGxa7XVNtZVUg7TfMNfBS3ORaY
	C9H1gJ2Iysp+V0DQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Enable interrupt vectors once per-CPU on
 SMCA systems
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653474.709179.3966627128731278316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     fe02d3d00b06850b131d6baafaae64ca80eddd71
Gitweb:        https://git.kernel.org/tip/fe02d3d00b06850b131d6baafaae64ca80e=
ddd71
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:39=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:45 +02:00

x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems

Scalable MCA systems have a per-CPU register that gives the APIC LVT
offset for the thresholding and deferred error interrupts.

Currently, this register is read once to set up the deferred error
interrupt and then read again for each thresholding block. Furthermore,
the APIC LVT registers are configured each time, but they only need to
be configured once per-CPU.

Move the APIC LVT setup to the early part of CPU init, so that the
registers are set up once. Also, this ensures that the kernel is ready
to service the interrupts before the individual error sources (each MCA
bank) are enabled.

Apply this change only to SMCA systems to avoid breaking any legacy
behavior. The deferred error interrupt is technically advertised by the
SUCCOR feature. However, this was first made available on SMCA systems.
Therefore, only set up the deferred error interrupt on SMCA systems and
simplify the code.

Guidance from hardware designers is that the LVT offsets provided from
the platform should be used. The kernel should not try to enforce
specific values. However, the kernel should check that an LVT offset is
not reused for multiple sources.

Therefore, remove the extra checking and value enforcement from the MCE
code. The "reuse/conflict" case is already handled in
setup_APIC_eilvt().

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 121 ++++++++++++++-------------------
 1 file changed, 53 insertions(+), 68 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1b1b83b..a6f5c93 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -43,9 +43,6 @@
 /* Deferred error settings */
 #define MSR_CU_DEF_ERR		0xC0000410
 #define MASK_DEF_LVTOFF		0x000000F0
-#define MASK_DEF_INT_TYPE	0x00000006
-#define DEF_LVT_OFF		0x2
-#define DEF_INT_TYPE_APIC	0x2
=20
 /* Scalable MCA: */
=20
@@ -57,6 +54,10 @@ static bool thresholding_irq_en;
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
 	mce_banks_t     dfr_intr_banks;
+
+	u32		thr_intr_en: 1,
+			dfr_intr_en: 1,
+			__resv: 30;
 };
=20
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -271,6 +272,7 @@ void (*deferred_error_int_vector)(void) =3D default_defer=
red_error_interrupt;
=20
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data =3D this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts =3D this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -301,8 +303,8 @@ static void smca_configure(unsigned int bank, unsigned in=
t cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+		if ((low & BIT(5)) && !((high >> 5) & 0x3) && data->dfr_intr_en) {
+			__set_bit(bank, data->dfr_intr_banks);
 			high |=3D BIT(5);
 		}
=20
@@ -377,6 +379,14 @@ static bool lvt_off_valid(struct threshold_block *b, int=
 apic, u32 lo, u32 hi)
 {
 	int msr =3D (hi & MASK_LVTOFF_HI) >> 20;
=20
+	/*
+	 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
+	 * the BIOS provides the value. The original field where LVT offset
+	 * was set is reserved. Return early here:
+	 */
+	if (mce_flags.smca)
+		return false;
+
 	if (apic < 0) {
 		pr_err(FW_BUG "cpu %d, failed to setup threshold interrupt "
 		       "for bank %d, block %d (MSR%08X=3D0x%x%08x)\n", b->cpu,
@@ -385,14 +395,6 @@ static bool lvt_off_valid(struct threshold_block *b, int=
 apic, u32 lo, u32 hi)
 	}
=20
 	if (apic !=3D msr) {
-		/*
-		 * On SMCA CPUs, LVT offset is programmed at a different MSR, and
-		 * the BIOS provides the value. The original field where LVT offset
-		 * was set is reserved. Return early here:
-		 */
-		if (mce_flags.smca)
-			return false;
-
 		pr_err(FW_BUG "cpu %d, invalid threshold interrupt offset %d "
 		       "for bank %d, block %d (MSR%08X=3D0x%x%08x)\n",
 		       b->cpu, apic, b->bank, b->block, b->address, hi, lo);
@@ -473,41 +475,6 @@ static int setup_APIC_mce_threshold(int reserved, int ne=
w)
 	return reserved;
 }
=20
-static int setup_APIC_deferred_error(int reserved, int new)
-{
-	if (reserved < 0 && !setup_APIC_eilvt(new, DEFERRED_ERROR_VECTOR,
-					      APIC_EILVT_MSG_FIX, 0))
-		return new;
-
-	return reserved;
-}
-
-static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
-{
-	u32 low =3D 0, high =3D 0;
-	int def_offset =3D -1, def_new;
-
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &low, &high))
-		return;
-
-	def_new =3D (low & MASK_DEF_LVTOFF) >> 4;
-	if (!(low & MASK_DEF_LVTOFF)) {
-		pr_err(FW_BUG "Your BIOS is not setting up LVT offset 0x2 for deferred err=
or IRQs correctly.\n");
-		def_new =3D DEF_LVT_OFF;
-		low =3D (low & ~MASK_DEF_LVTOFF) | (DEF_LVT_OFF << 4);
-	}
-
-	def_offset =3D setup_APIC_deferred_error(def_offset, def_new);
-	if ((def_offset =3D=3D def_new) &&
-	    (deferred_error_int_vector !=3D amd_deferred_error_interrupt))
-		deferred_error_int_vector =3D amd_deferred_error_interrupt;
-
-	if (!mce_flags.smca)
-		low =3D (low & ~MASK_DEF_INT_TYPE) | DEF_INT_TYPE_APIC;
-
-	wrmsr(MSR_CU_DEF_ERR, low, high);
-}
-
 static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 			     unsigned int bank, unsigned int block,
 			     unsigned int cpu)
@@ -543,12 +510,10 @@ static u32 get_block_address(u32 current_addr, u32 low,=
 u32 high,
 	return addr;
 }
=20
-static int
-prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
-			int offset, u32 misc_high)
+static int prepare_threshold_block(unsigned int bank, unsigned int block, u3=
2 addr,
+				   int offset, u32 misc_high)
 {
 	unsigned int cpu =3D smp_processor_id();
-	u32 smca_low, smca_high;
 	struct threshold_block b;
 	int new;
=20
@@ -568,18 +533,10 @@ prepare_threshold_block(unsigned int bank, unsigned int=
 block, u32 addr,
 	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable =3D 1;
=20
-	if (!mce_flags.smca) {
-		new =3D (misc_high & MASK_LVTOFF_HI) >> 20;
-		goto set_offset;
-	}
-
-	/* Gather LVT offset for thresholding: */
-	if (rdmsr_safe(MSR_CU_DEF_ERR, &smca_low, &smca_high))
-		goto out;
-
-	new =3D (smca_low & SMCA_THR_LVT_OFF) >> 12;
+	if (mce_flags.smca)
+		goto done;
=20
-set_offset:
+	new =3D (misc_high & MASK_LVTOFF_HI) >> 20;
 	offset =3D setup_APIC_mce_threshold(offset, new);
 	if (offset =3D=3D new)
 		thresholding_irq_en =3D true;
@@ -587,7 +544,6 @@ set_offset:
 done:
 	mce_threshold_block_init(&b, offset);
=20
-out:
 	return offset;
 }
=20
@@ -678,6 +634,32 @@ static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
 		mce_banks[0].ctl =3D 0;
 }
=20
+/*
+ * Enable the APIC LVT interrupt vectors once per-CPU. This should be done b=
efore hardware is
+ * ready to send interrupts.
+ *
+ * Individual error sources are enabled later during per-bank init.
+ */
+static void smca_enable_interrupt_vectors(void)
+{
+	struct mce_amd_cpu_data *data =3D this_cpu_ptr(&mce_amd_data);
+	u64 mca_intr_cfg, offset;
+
+	if (!mce_flags.smca || !mce_flags.succor)
+		return;
+
+	if (rdmsrq_safe(MSR_CU_DEF_ERR, &mca_intr_cfg))
+		return;
+
+	offset =3D (mca_intr_cfg & SMCA_THR_LVT_OFF) >> 12;
+	if (!setup_APIC_eilvt(offset, THRESHOLD_APIC_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->thr_intr_en =3D 1;
+
+	offset =3D (mca_intr_cfg & MASK_DEF_LVTOFF) >> 4;
+	if (!setup_APIC_eilvt(offset, DEFERRED_ERROR_VECTOR, APIC_EILVT_MSG_FIX, 0))
+		data->dfr_intr_en =3D 1;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -689,10 +671,16 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
=20
 	mce_flags.amd_threshold	 =3D 1;
=20
+	smca_enable_interrupt_vectors();
+
 	for (bank =3D 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (mce_flags.smca)
+		if (mce_flags.smca) {
 			smca_configure(bank, cpu);
=20
+			if (!this_cpu_ptr(&mce_amd_data)->thr_intr_en)
+				continue;
+		}
+
 		disable_err_thresholding(c, bank);
=20
 		for (block =3D 0; block < NR_BLOCKS; ++block) {
@@ -713,9 +701,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 			offset =3D prepare_threshold_block(bank, block, address, offset, high);
 		}
 	}
-
-	if (mce_flags.succor)
-		deferred_error_interrupt_enable(c);
 }
=20
 void smca_bsp_init(void)

