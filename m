Return-Path: <linux-tip-commits+bounces-6555-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CDB52E4A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E577B7B2395
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2630C354;
	Thu, 11 Sep 2025 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGBgpcf6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOnuRHfm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C18B3101B5;
	Thu, 11 Sep 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586535; cv=none; b=gjv6/l/FLGYKvRmAdmI9b6Lj6Ej4ExJlo10SIDhaHZHb2W85+GNdyD4PuL8jUzvT1s5mVgxKrIhOUwLjnyZ4SMC1YKGcoV7VLfueO/FKYPLPmGaPxgonYUynm2dHJOpLM8JH67R4Jy/LAsZUqXl10QaX5L8qpJOZLWha6BRT4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586535; c=relaxed/simple;
	bh=RmicXUIhhdx8kAg4Eo4wu78rKV1avUyUfDLlMUiJSTA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QRQN9LkWMBkhkVG92MSTXnO+5LGoPXAUuFxB5aZjN/QPqw0cd/dUXP5YemkjrwecN0JY4GTtxc3S4TsHZM5SKaNbpMY3nVBLAIEmE3uvPHXCPiIKa+JdOIfFHgv5hfrocPm5LBrrUk61ZctVFRHJPYji/g1zZta1YF4BWR5Fvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGBgpcf6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOnuRHfm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CIbEi5TwcKbecnHd+kowD5fPssRbfWF593Q6bXuBXrw=;
	b=zGBgpcf6+5nIpQ3YBud1pyZ7oGj+7gDIPHRY1UvrzhurC9ep0Jx72sn637IW+CT2+Cz1Ac
	CMYojY656MQebA4UwZFl398oUoiIGjeQ239tyH63/vOneUcr7x9M7ng20UAmNSyh8Dg7/B
	a9UZmyn0jv2OX2RGDSvlYSFJ1zu4H3maF+jtppiBuR+j8iYvwOGy3hFChcbkrNs8xnFu72
	WB1Uy7PLqP4m6HuMf9RW/vSWzF+dsUSzVXxlW6TfhR8IS1kh3DW2ksrp/TvqwtyczAVL5Y
	0iqYbJDRmmpZY1p+Az5imoBQmoPMIPZz5CO3zPrbErlfknVtiFXMg6Cp+2mJIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586531;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CIbEi5TwcKbecnHd+kowD5fPssRbfWF593Q6bXuBXrw=;
	b=IOnuRHfm1AN7aT9fjEAtSpadIP3kDe9ixDN0YDTwrgPTibMMJ63gPzw9W5nItCaiQydTS2
	fZIBnr3ldCwfn6BQ==
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
Message-ID: <175758653019.709179.5480798892670028504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c8f4cea38959dad58e1bb52cac9dab2f2fa45a9a
Gitweb:        https://git.kernel.org/tip/c8f4cea38959dad58e1bb52cac9dab2f2fa=
45a9a
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:43=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:50 +02:00

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

  [ Tony: Small tweak because mce_handle_storm() isn't a pointer now ]
  [ Yazen: Rebase and simplify ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c       | 5 +++++
 arch/x86/kernel/cpu/mce/internal.h  | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index fbdb0ce..b895559 100644
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
index f4a0076..4514459 100644
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

