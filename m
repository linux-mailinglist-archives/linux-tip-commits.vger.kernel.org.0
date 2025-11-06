Return-Path: <linux-tip-commits+bounces-7269-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EFDC3B059
	for <lists+linux-tip-commits@lfdr.de>; Thu, 06 Nov 2025 13:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F51188FE74
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Nov 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AD32D0C6;
	Thu,  6 Nov 2025 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f9eYDanA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XY5746Qa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836D32AAA4;
	Thu,  6 Nov 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433581; cv=none; b=aFmDkpAgq3ddBq3N7yrUbpjjEngfiaTweQ8Ya7x4qG1X5FcvMI8gk+13OcewIVVaOtTnySQ9dshlb5z1yq5fOkfFRtENORvoJS8WglfEXPUD4ADfSR5+8nZWOiZIVXWpGE4sdt1WEOCbMnoWBnWyIED9hghVgZhQXiqgn5MuFus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433581; c=relaxed/simple;
	bh=sQshsx2ax2jjy2QELlDoTRv8fjCOO8G0M+h1KjQbw2Q=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LbUOy4DVFPOw9uqg0mvP1CS/vxT9fG/MOboCr7oJ7ZNkWAstZW37LLmrpdGo3gVG3JqhkGExOd1NkorMQestrCHsb8hFlInXHhI3vQBryuaVrEwNrpsyyXIHy97h4jGoOwH+NnZ4BEGzExjfRdUpZ38iOE25qa2RL8DuFWJYgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f9eYDanA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XY5746Qa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Nov 2025 12:52:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762433572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tCiEpCdjDROAd0QyqPBOvwEBFqvfaeViH+MoNG8YbGg=;
	b=f9eYDanApmStE95sBTLQ1/NjlSIcfMKmkeBGasGZlWzXjNnCUpiT5cxSG9frhlkfN5CEYx
	JaxKHYR10OQTKPt/Ko+PSIHpgPXAUQ3Ca/CEryhokYma+dvkFTSaeyXF1JnsQ5U6wrvOTE
	soLcGJhgcaWgmqLXHenD0tGu8EX9l/01hDn2M1tYvBlDodCb1CGEmP23g5rTlpPyfmDuW6
	RVITwHc2QA7EK23Ap50quZKCAUmS68rYW7dd5E1jNRSJMYW341iZGlp6hh2Ra9FKfPsnZR
	iEhJ1NH8QlDPeqy7b/f0sTR4YKYLhx63WjkJWsPqqb1DFcqVAE/IfLMnOmVjCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762433572;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tCiEpCdjDROAd0QyqPBOvwEBFqvfaeViH+MoNG8YbGg=;
	b=XY5746QaDqzl8Y0KFs7ze8UBpvb01grT9hUgzOD15ipOby5BXzwn3jeknh4DKzf7JG3RLO
	DDobLROlrz58prCg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/mce/amd: Define threshold restart function for banks
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
Message-ID: <176243357102.2601451.3504447031194372723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     56f17be67a332d146821d1a812ab16388d07ace7
Gitweb:        https://git.kernel.org/tip/56f17be67a332d146821d1a812ab16388d0=
7ace7
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 04 Nov 2025 14:55:43=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 05 Nov 2025 22:38:31 +01:00

x86/mce/amd: Define threshold restart function for banks

Prepare for CMCI storm support by moving the common bank/block iterator code
to a helper function.

Include a parameter to switch the interrupt enable. This will be used by the
CMCI storm handling function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index af2221b..940d1a0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -471,6 +471,24 @@ static void threshold_restart_block(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
=20
+static void threshold_restart_bank(unsigned int bank, bool intr_en)
+{
+	struct threshold_bank **thr_banks =3D this_cpu_read(threshold_banks);
+	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
+
+	if (!thr_banks || !thr_banks[bank])
+		return;
+
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &thr_banks[bank]->miscj, miscj) {
+		tr.b =3D block;
+		tr.b->interrupt_enable =3D intr_en;
+		threshold_restart_block(&tr);
+	}
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr =3D {
@@ -814,24 +832,7 @@ static void amd_deferred_error_interrupt(void)
=20
 static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp =3D this_cpu_read(threshold_banks);
-	struct threshold_block *block, *tmp;
-	struct thresh_restart tr;
-
-	/*
-	 * Validate that the threshold bank has been initialized already. The
-	 * handler is installed at boot time, but on a hotplug event the
-	 * interrupt might fire before the data has been initialized.
-	 */
-	if (!bp || !bp[bank])
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
-		tr.b =3D block;
-		threshold_restart_block(&tr);
-	}
+	threshold_restart_bank(bank, true);
 }
=20
 /*

