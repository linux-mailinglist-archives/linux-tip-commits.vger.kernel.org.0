Return-Path: <linux-tip-commits+bounces-7268-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFEDC3B0C3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984B8424FAE
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 12:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26E232C327;
	Thu,  6 Nov 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vGKRYLPl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ZwRfiJC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38903309DC5;
	Thu,  6 Nov 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433579; cv=none; b=i+GYPMdilJ3Q4tih+1aSClq9paW0km9jpEiSLSdi7wZmbKLwrN/WuFYaFHdPDfBrhZcjPU6TQXlJK5Tph+zVLE7Km+SXEpisUUcR70+ae6g6VeVff1AhVFq+u/qKqrDKTtgeOu5qKkjbtqDIoTKyPU2VYn+BQTslhnQQgi8cJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433579; c=relaxed/simple;
	bh=To+oyemkEeA/7fdhvUQm3hiGgtleFO1L3sYOZxp+Qa8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TxIoGHgWa8kqJovV4niCxBa2euxEd4vDO9Y7+gS5ifBBlRbQC7F1Wu6mYZLhDtMcGZEuCwGwoGeAsS4J0rcp8jTcz2C+/KtZp70TIwdr/TdyCLeKc9muhvgZPHy65TJNky/V+CiWEguLqSQ/gV5H5+5w+T5liIClj5GfKiWyn8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vGKRYLPl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ZwRfiJC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 12:52:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762433571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6yyzbdvGvw6JVeK4T4jxr6O5Ta+B2OTAYqOSqPzayVQ=;
	b=vGKRYLPlAtMI4U5Xn7m8eMJC4RfteZHQenk5AGP6xh8Iv4W6rn5rij4jHjJUy3SlxxDdyy
	CCTYGOHO2T1wi6KakXYgUCKYSHJzh8xAsRzfLEtkpdgORr7FJCL0tQ9dPB+13KV6i0UgRV
	GKQZMVTHK1fXiFSN9bFTJSKMs6P+xjJebdx8W4XEQpnvfrNamvW8NnXEtW6VOX/iB1fSYN
	YJdPTU6M55u1Dtwj8zqF3Qdz1JOKQ/7quurPU7n8KG7Nw+utD+l1Tj6ByMXYOvLA7EfXWW
	TBLvA1dFKeLmEa9SW4mdx2i4OQNTpPNVsiZ1w+yf7s6KGoo2sURks8RiuexUAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762433571;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6yyzbdvGvw6JVeK4T4jxr6O5Ta+B2OTAYqOSqPzayVQ=;
	b=/ZwRfiJCTlilmd6ULoYPPNjsC36zJRnKH2SSjt4y1wzbCOTD9pAL0sN+19/XMAyy3qU23E
	9N1W2QVKm8RBh4BQ==
From: "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Handle AMD threshold interrupt storms
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176243356968.2601451.11559805061162819633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a5834a5458aa004866e7da402c6bc2dfe2f3737e
Gitweb:        https://git.kernel.org/tip/a5834a5458aa004866e7da402c6bc2dfe2f=
3737e
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Tue, 04 Nov 2025 14:55:44=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 22:39:40 +01:00

x86/mce: Handle AMD threshold interrupt storms

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Rely on the similar approach as of Intel's CMCI to mitigate storms per CPU and
per bank. But, unlike CMCI, do not set thresholds and reduce interrupt rate on
a storm. Rather, disable the interrupt on the corresponding CPU and bank.
Re-enable back the interrupts if enough consecutive polls of the bank show no
corrected errors (30, as programmed by Intel).

Turning off the threshold interrupts would be a better solution on AMD systems
as other error severities will still be handled even if the threshold
interrupts are disabled.

Also, AMD systems currently allow banks to be managed by both polling and
interrupts. So don't modify the polling banks set after a storm ends.

  [Tony: Small tweak because mce_handle_storm() isn't a pointer now]
  [Yazen: Rebase and simplify]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c       | 5 +++++
 arch/x86/kernel/cpu/mce/internal.h  | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 6 +++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 940d1a0..ec54175 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -830,6 +830,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_ba=
nks);
 }
=20
+void mce_amd_handle_storm(unsigned int bank, bool on)
+{
+	threshold_restart_bank(bank, on);
+}
+
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	threshold_restart_bank(bank, true);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/int=
ernal.h
index b0e00ec..9920ee5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -267,6 +267,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce=
 *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_clear_bank(struct mce *m);
@@ -299,6 +300,7 @@ void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_clear_bank(struct mce *m) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/th=
reshold.c
index f4a0076..22930a8 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -63,6 +63,9 @@ static void mce_handle_storm(unsigned int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_AMD:
+		mce_amd_handle_storm(bank, on);
+		break;
 	}
 }
=20
@@ -85,7 +88,8 @@ void cmci_storm_end(unsigned int bank)
 {
 	struct mca_storm_desc *storm =3D this_cpu_ptr(&storm_desc);
=20
-	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	if (!mce_flags.amd_threshold)
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
 	storm->banks[bank].history =3D 0;
 	storm->banks[bank].in_storm_mode =3D false;
=20

