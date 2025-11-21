Return-Path: <linux-tip-commits+bounces-7458-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D73C7BB5A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 22:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA89A4E2481
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 21:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FCF305978;
	Fri, 21 Nov 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zl+8P9Kp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8PB0KJsd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087772EA156;
	Fri, 21 Nov 2025 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763759107; cv=none; b=gCoxqkZuNA+Ukhp27wINnTpYSlIuD53G4cTC6+kndtIsO2lGSV+E2HlNQNQ0tcqkGZq/KJOVlAMXm0FI5/rdaSrX7QGFWokONAml0v1/NQZzN9I/krbmlW7LTRoWYYamxuirCc6mDTYIFoisg5pAn3luNr/ihLstr0q0GRoThVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763759107; c=relaxed/simple;
	bh=k8+bJoKWIK7a5VxGqb9TLWdeJYBT8GDOj3TM+L47/Ns=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KetRxszeaDxOnlPKdiLm5HH0/yyv/laoIB1ls67Uk6sBCPmZri096Ux7p9o28IbJE0QlNSNbo2n19G1HXIfJFpFQq/41M0wV7oY8iq4NufELVCtfaFX4txO4ROB56ckAdmpxeHCH3U9FO7lquNGWmzA1G6cNkaQL7y744oOdKxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zl+8P9Kp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8PB0KJsd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 21:05:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763759102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgA/OuWbfNRSsSkKBNwnOWQzjdWC7D/ZQx3ATZH1wGE=;
	b=Zl+8P9KpRs+0g8JKTinLXR2id8C8tr1sOmeJJb9DI/xJXc6UDeVwRkyxsKXB6DqQpnwqMg
	YofG/wp+mgpLbVoJsOS/fQunACCXdBVl/SBw2gnCqUzJms3foAqf4KQwz0+8DQaPYTugFD
	hRnBiosBg+MF8N0htpcyX0qaehyI+bjcjzcRX5y9zKf8Dy71n3gifS0zJ+LPgVcvo0J7E9
	GmkucCvbNvgAdwgnoS7O80b/5x6WHzgd2thhf2wEufXOIZRQWhSbVYiC+UZtltDQ4apcsN
	HSpklPCYEFjrK06wXb0toajVlN6thrfIkBhcZ0ZJrtYpg0NNwRgzxYaQOo6d4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763759102;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgA/OuWbfNRSsSkKBNwnOWQzjdWC7D/ZQx3ATZH1wGE=;
	b=8PB0KJsdlVWChO0z5Duvbdu7Hz5lCwxAnbYrN5808mkAGsb69v4Dnv/Kmf8NkEAZjWO+8I
	WXW4hwNe1NtzGKAg==
From: "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Handle AMD threshold interrupt storms
Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251121190542.2447913-3-avadhut.naik@amd.com>
References: <20251121190542.2447913-3-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176375910068.498.6194543935296705561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     5c4663ed1eac01987a1421f059380db48ab7b1a3
Gitweb:        https://git.kernel.org/tip/5c4663ed1eac01987a1421f059380db48ab=
7b1a3
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Fri, 21 Nov 2025 19:04:05=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 20:41:10 +01:00

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
  [ Avadhut: Remove check to not clear bank's bit in mce_poll_banks and fix
    checkpatch warnings. ]

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://patch.msgid.link/20251121190542.2447913-3-avadhut.naik@amd.com
---
 arch/x86/kernel/cpu/mce/amd.c       | 5 +++++
 arch/x86/kernel/cpu/mce/internal.h  | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5c3287a..3f1dda3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -852,6 +852,11 @@ static void amd_deferred_error_interrupt(void)
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
index 4cf16fa..a31cf98 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -269,6 +269,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce=
 *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_clear_bank(struct mce *m);
@@ -301,6 +302,7 @@ void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_clear_bank(struct mce *m) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/th=
reshold.c
index f19dd5b..0d13c9f 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -76,6 +76,9 @@ static void mce_handle_storm(unsigned int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_AMD:
+		mce_amd_handle_storm(bank, on);
+		break;
 	}
 }
=20

