Return-Path: <linux-tip-commits+bounces-6563-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552FCB52E5A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68281890E43
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39A5313E16;
	Thu, 11 Sep 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KceqD+LH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/oma/NNo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51D431352D;
	Thu, 11 Sep 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586543; cv=none; b=nErqXvt2pEg5OPcEHrIxT6/LesNH6z8gwlIZmtFgBKc7DnQLO1pY8xnz9EjW/6fybCQ90sg5Oqqt8JiqTqnDRy1oMSDafphVE3BPbruRo5phjM/6RLXZQPWVweDYtDFjuAHItZ7dnrhD11MzyapXnlU+MFwqVH6NrF0Uo0+d9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586543; c=relaxed/simple;
	bh=ver00Z+/WDvOfDS4QM+SRSXiUZDzjdEaFJkDsaTYtcI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Xen8nw3vCrSCFxzmqAKYJXM8QNplOMr4Idmv7jKxcM2kj00RRoMM5fvwEoDcki/zdkF7Aqe4QfJX0FXSbTAktCbNAVbuxYuFEuUZNdWUxorl7khpEuIi2Nq5+FS3KXjFpJIYhzBgRhTle3qizKYKEsjES5UFwW1shlqbGs4aq7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KceqD+LH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/oma/NNo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3LUDvG+OOMD79GnjMC3DeJSd/V8x/lg4iGXk4H/RbwQ=;
	b=KceqD+LHWrR01o3aix75/9RTNw4dDtEp/qBsYZyZjvhWQiItFz5noZj1s4aNRykU1b8cwr
	zNP9Uw3YQysASDFJRnPl3K6N2yyqyAwEskF3hxAAp3EDpS/cHAVmAI3DaRBhn0vO/OxJPq
	v++gvWYdPjcTf+LHMWQswJI91dz57kkp1ZnRi9n5IhDJos3gv1F4elWcpaymhDbayZmBee
	zH1yPF0LLT03GDRDRCY1FKOflEC1ss07Vwzw38pWP+REkZ+fAJHBXvYNph7+vbHM0CoX04
	86S3BUWHrnNOtod4XTn90IKbVIZNDlN08J+fZR5E5C2fMwBHZr6MNesqkOmnLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586539;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3LUDvG+OOMD79GnjMC3DeJSd/V8x/lg4iGXk4H/RbwQ=;
	b=/oma/NNokgww5Q/zfEdvE4YbSAzrUzQnHs0CFTEqnoxEs460CnRpXrFRFLCpxwhkAholLF
	1NN8XE82TN6UBqDA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add a clear_bank() helper
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653807.709179.9583676711429503136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     5c6f123c419b6e20f84ac1683089a52f449273aa
Gitweb:        https://git.kernel.org/tip/5c6f123c419b6e20f84ac1683089a52f449=
273aa
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:36=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:30 +02:00

x86/mce: Add a clear_bank() helper

Add a helper at the end of the MCA polling function to collect vendor and/or
feature actions.

Start with a basic skeleton for now. Actions for AMD thresholding and deferred
errors will be added later.

  [ bp: Drop the obvious comment too. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c      |  5 +++++
 arch/x86/kernel/cpu/mce/core.c     | 15 ++++++++++-----
 arch/x86/kernel/cpu/mce/internal.h |  3 +++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b8aed0a..d690644 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -955,6 +955,11 @@ static void amd_threshold_interrupt(void)
 	}
 }
=20
+void amd_clear_bank(struct mce *m)
+{
+	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+}
+
 /*
  * Sysfs Interface
  */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5dec0da..460e90a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -423,7 +423,7 @@ noinstr u64 mce_rdmsrq(u32 msr)
 	return EAX_EDX_VAL(val, low, high);
 }
=20
-static noinstr void mce_wrmsrq(u32 msr, u64 v)
+noinstr void mce_wrmsrq(u32 msr, u64 v)
 {
 	u32 low, high;
=20
@@ -760,6 +760,14 @@ static bool should_log_poll_error(enum mcp_flags flags, =
struct mce_hw_err *err)
 	return true;
 }
=20
+static void clear_bank(struct mce *m)
+{
+	if (m->cpuvendor =3D=3D X86_VENDOR_AMD)
+		return amd_clear_bank(m);
+
+	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+}
+
 /*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
@@ -831,10 +839,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_=
t *b)
 			mce_log(&err);
=20
 clear_it:
-		/*
-		 * Clear state for this bank.
-		 */
-		mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+		clear_bank(m);
 	}
=20
 	/*
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/int=
ernal.h
index 6cb2995..b0e00ec 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -269,6 +269,7 @@ void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
+void amd_clear_bank(struct mce *m);
=20
 /*
  * If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
@@ -300,6 +301,7 @@ static inline void mce_threshold_create_device(unsigned i=
nt cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
+static inline void amd_clear_bank(struct mce *m) { }
 static inline void smca_extract_err_addr(struct mce *m) { }
 static inline void smca_bsp_init(void) { }
 #endif
@@ -319,6 +321,7 @@ static __always_inline void winchip_machine_check(struct =
pt_regs *regs) {}
 #endif
=20
 noinstr u64 mce_rdmsrq(u32 msr);
+noinstr void mce_wrmsrq(u32 msr, u64 v);
=20
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {

