Return-Path: <linux-tip-commits+bounces-6562-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F288B52E57
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC987B64E5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA619313523;
	Thu, 11 Sep 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sOslzAdB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7vylxwEz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7C1310631;
	Thu, 11 Sep 2025 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586541; cv=none; b=jC25yJyOZ3Bu969KlnGkWyBL3JDn4qlM1h2NzN/GKpSX4g0rNX1Vf4thLfpebbFPwIpeoDkVzAzk/Thcgb1guvcVakdmrKrjBDJH2JdMXws67M4lVM16OoUV1MJDfY8anPe5q/yU5Li7Gi2NKxYWna90wmOTzbJOjzqJnZz0S8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586541; c=relaxed/simple;
	bh=khpENQWK4wMzqyVF8A51p8uoZMnL8in6Qcr40R+Lyjg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BUStqH1bcF7j9SbXaGQf2Hi0g0Wz6SabPkEEnEqHzYorqlHGK4T56TsqoYaGJ5Q+KHkOwjS/j34arK+Z8/wyXjpmJV/vFPeOg9fAlyzvG2J0AwNgoxlHIh1kn5nn44LOTaU2z8uuXMy5zYWBW55y25c6u+RMcD94T4qzWJpNW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sOslzAdB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7vylxwEz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tbmM3ZvERq+wKLZlAdDYDV07K1aFjr/DTV93Vh7ZiPk=;
	b=sOslzAdBg3carWtgjLpGe8GPAIXOsRLRtd41BR7TNm2lR0JCG++/XLo+Hi416eF5iAZKfS
	I9CeUgIdLRk/rHpEDrU39fP9bSxHBjX3aNNCtOMpHkBjjxhSZABDO5/TXoD3s0owZZ1iHD
	Dmv/nMIZk92Nwx5lvluhZIEpzpyCMceOBTz5J6LK5jNeCv3FbHdaai13gIC4ADtQ4ciNq5
	4kTnikWu7HvgljodYfCqo0X9PnAaXsNeTFJFPivs9F7yIiKvYwskHL2XLe4rtqXkHDCTN4
	mTzaA+xBL4Qngp0zVmHOVMzo5Eg2OecZNXTvc9/7ZvMQUEqDPj4Blq9QzQxBMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586538;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tbmM3ZvERq+wKLZlAdDYDV07K1aFjr/DTV93Vh7ZiPk=;
	b=7vylxwEzYP+FwTEKwYars/pvS5iJp+UfUMAHK44nCmYetNkbxT1Syj02PlmDm/Nk8Ni/p3
	cE9+xzE3TjFELZBw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Unify AMD THR handler with MCA Polling
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653702.709179.13064453960415547516.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     53b3be0e79ef80da524a99eef51a2ca642d4e134
Gitweb:        https://git.kernel.org/tip/53b3be0e79ef80da524a99eef51a2ca642d=
4e134
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:37=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:38 +02:00

x86/mce: Unify AMD THR handler with MCA Polling

AMD systems optionally support an MCA thresholding interrupt. The
interrupt should be used as another signal to trigger MCA polling. This
is similar to how the Intel Corrected Machine Check interrupt (CMCI) is
handled.

AMD MCA thresholding is managed using the MCA_MISC registers within an
MCA bank. The OS will need to modify the hardware error count field in
order to reset the threshold limit and rearm the interrupt. Management
of the MCA_MISC register should be done as a follow up to the basic MCA
polling flow. It should not be the main focus of the interrupt handler.

Furthermore, future systems will have the ability to send an MCA
thresholding interrupt to the OS even when the OS does not manage the
feature, i.e. MCA_MISC registers are Read-as-Zero/Locked.

Call the common MCA polling function when handling the MCA thresholding
interrupt. This will allow the OS to find any valid errors whether or
not the MCA thresholding feature is OS-managed. Also, this allows the
common MCA polling options and kernel parameters to apply to AMD
systems.

Add a callback to the MCA polling function to check and reset any
threshold blocks that have reached their threshold limit.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 51 +++++++++++++++-------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index d690644..ac6a98a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -54,6 +54,12 @@
=20
 static bool thresholding_irq_en;
=20
+struct mce_amd_cpu_data {
+	mce_banks_t     thr_intr_banks;
+};
+
+static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
+
 static const char * const th_names[] =3D {
 	"load_store",
 	"insn_fetch",
@@ -556,6 +562,7 @@ prepare_threshold_block(unsigned int bank, unsigned int b=
lock, u32 addr,
 	if (!b.interrupt_capable)
 		goto done;
=20
+	__set_bit(bank, this_cpu_ptr(&mce_amd_data)->thr_intr_banks);
 	b.interrupt_enable =3D 1;
=20
 	if (!mce_flags.smca) {
@@ -896,12 +903,7 @@ static void amd_deferred_error_interrupt(void)
 		log_error_deferred(bank);
 }
=20
-static void log_error_thresholding(unsigned int bank, u64 misc)
-{
-	_log_error_deferred(bank, misc);
-}
-
-static void log_and_reset_block(struct threshold_block *block)
+static void reset_block(struct threshold_block *block)
 {
 	struct thresh_restart tr;
 	u32 low =3D 0, high =3D 0;
@@ -915,23 +917,14 @@ static void log_and_reset_block(struct threshold_block =
*block)
 	if (!(high & MASK_OVERFLOW_HI))
 		return;
=20
-	/* Log the MCE which caused the threshold event. */
-	log_error_thresholding(block->bank, ((u64)high << 32) | low);
-
-	/* Reset threshold block after logging error. */
 	memset(&tr, 0, sizeof(tr));
 	tr.b =3D block;
 	threshold_restart_block(&tr);
 }
=20
-/*
- * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The inter=
rupt
- * goes off when error_count reaches threshold_limit.
- */
-static void amd_threshold_interrupt(void)
+static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp =3D this_cpu_read(threshold_banks), *thr_bank;
-	unsigned int bank, cpu =3D smp_processor_id();
+	struct threshold_bank **bp =3D this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
=20
 	/*
@@ -939,24 +932,26 @@ static void amd_threshold_interrupt(void)
 	 * handler is installed at boot time, but on a hotplug event the
 	 * interrupt might fire before the data has been initialized.
 	 */
-	if (!bp)
+	if (!bp || !bp[bank])
 		return;
=20
-	for (bank =3D 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
-			continue;
-
-		thr_bank =3D bp[bank];
-		if (!thr_bank)
-			continue;
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
+		reset_block(block);
+}
=20
-		list_for_each_entry_safe(block, tmp, &thr_bank->miscj, miscj)
-			log_and_reset_block(block);
-	}
+/*
+ * Threshold interrupt handler will service THRESHOLD_APIC_VECTOR. The inter=
rupt
+ * goes off when error_count reaches threshold_limit.
+ */
+static void amd_threshold_interrupt(void)
+{
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->thr_intr_ba=
nks);
 }
=20
 void amd_clear_bank(struct mce *m)
 {
+	amd_reset_thr_limit(m->bank);
+
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
=20

