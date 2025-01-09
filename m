Return-Path: <linux-tip-commits+bounces-3188-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB54A071CF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8922188783A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1292221577F;
	Thu,  9 Jan 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ZiSurq7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aZYrBByp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB7215764;
	Thu,  9 Jan 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415829; cv=none; b=CnFKhhUpua5cI/KDxUNWtbuMfHsNuLtGoepo6LkO5o9hJSbGkqc9xC/+Nmy6jj+ZVSoMW0L7wRtAXpaAc3LEh44DhK+i4wFVlYc/4RyMYSFDBt/vI6SOaehL+lzWwUQqoxONa1k5enoUX5qr/DWVxmDtlhUOLZm8pB6Uja6D55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415829; c=relaxed/simple;
	bh=TmQZGTaO0Sk+Xjx5w253R4J+NbT0umolIy4O1zPfE0o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iEQd79X6I0Xt1zUh2ErTNKzdXugQJQw54ol09bTV71+n6kUf90SMqTV2xg2o5T8jTo/SgoI0FQ+SupZd3Fsc6Tcdu4bwDW94IGrqLI44S+zDfygzqyjWzrQlLtTfDHgekP0JiaZiWyj4etObaEOZ1iawVxqQEGILFU0EZyP1jOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ZiSurq7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aZYrBByp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 09:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736415825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2i5x07QW5ZqyHN1fh5b0mTI+eU5oCIdoe1qciOrb+7k=;
	b=0ZiSurq7uQDmxfkfx24OcztFt6JqNXB78SzTSZyZP3KDs2v/kkY4r2Lq/5fBIzH/ghhe9C
	I4wsAVVipb9wudPGmyi9PnyKd/ud4OuCMvMBwHwYMDkd3LCDkIUcCoRzdv5oiVAyg02cop
	y2BPpAHYknU7s0bL4Y4ta88mL4IGMzvQ+r16Qkwb974Pk2WLVKvQI//BT/8eaQAmxNoGVs
	oG0kTF3bjrfjlNB1BBsMbENpBw3php9/5MfzG9967YyNquxgtMQnb5T2LiE4Ca8M2D5uVr
	qSam/WwHMkAGOiDiJs6xoQlQ9YDzf/n2cupr5YMXb5aMEVK6wI/PWvpfS/T1fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736415825;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2i5x07QW5ZqyHN1fh5b0mTI+eU5oCIdoe1qciOrb+7k=;
	b=aZYrBBypcJl06VMVDA/Q6tzc5A1rgzQu25O0MlahT5MIwgdhELcAC1efY8ttZfNdtiQJlf
	SEpxWkckU65v8QAg==
From: "tip-bot2 for Nikunj A Dadhania" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/sev] x86/sev: Mark the TSC in a secure TSC guest as reliable
Cc: Nikunj A Dadhania <nikunj@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Peter Gonda <pgonda@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250106124633.1418972-10-nikunj@amd.com>
References: <20250106124633.1418972-10-nikunj@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173641582537.399.13047549744545643127.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0a2a98f691f2c57db5bb321e68787cb1de29c7dd
Gitweb:        https://git.kernel.org/tip/0a2a98f691f2c57db5bb321e68787cb1de29c7dd
Author:        Nikunj A Dadhania <nikunj@amd.com>
AuthorDate:    Mon, 06 Jan 2025 18:16:29 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 07 Jan 2025 21:26:20 +01:00

x86/sev: Mark the TSC in a secure TSC guest as reliable

In SNP guest environment with Secure TSC enabled, unlike other clock sources
(such as HPET, ACPI timer, APIC, etc), the RDTSC instruction is handled
without causing a VM exit, resulting in minimal overhead and jitters. Even
when the host CPU's TSC is tampered with, the Secure TSC enabled guest keeps
on ticking forward. Hence, mark Secure TSC as the only reliable clock source,
bypassing unstable calibration.

  [ bp: Massage. ]

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Peter Gonda <pgonda@google.com>
Link: https://lore.kernel.org/r/20250106124633.1418972-10-nikunj@amd.com
---
 arch/x86/mm/mem_encrypt_amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 774f967..b56c5c0 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -541,6 +541,9 @@ void __init sme_early_init(void)
 	 * kernel mapped.
 	 */
 	snp_update_svsm_ca();
+
+	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)

