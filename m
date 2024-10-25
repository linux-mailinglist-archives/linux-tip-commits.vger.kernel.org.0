Return-Path: <linux-tip-commits+bounces-2574-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AA59B09D0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 18:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFAF1F211C4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05E114A0A7;
	Fri, 25 Oct 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GAo1CEck";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kyr8t2KD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FF370830;
	Fri, 25 Oct 2024 16:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873454; cv=none; b=C1BTV7hltAu3JjKwf9639PJ447dy0jbDXHYvqjcN9V1NK98Ef1PPOgFHlBABiosSV3h4MhT5L7apVtCUNdTA21QCcglLhANqsYgaYA+/3OGZoR/2xSXg1x4Cl4t7jpLT8xv98ayVCoUI0OWb1JV2vU0nijoQZdi1+eH8FvwVX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873454; c=relaxed/simple;
	bh=1AUzMA1lgBnut9yvvMAhxlbnYNi7Wnh5Oycjbboz52k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fN2CCQz1rH51FouGOCheaCs83F9TpEHtnZtYjyNhpWlRkaiIvExjDWaVzyqO44vRu4E0yfcWC02KnbY+0rCZhqi+FUi4gUkOEFsS9RCUi8kqLm9r9L9Zz/jOXde/wB+dZ/3a7mSx/Imwy/V3EqRqTSX9+jRK8PTGlrneQBj6JRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GAo1CEck; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kyr8t2KD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Oct 2024 16:24:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729873445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwRIzgszYY7oyVQQojRBuBkDuJOmg3Z9fkiO4V/EZHc=;
	b=GAo1CEckq5n3C2W1jq1mRNNErxZg6ehHJZfK6eLd4dOhCfjEBisezzGeV9E4CKYVfBnhCP
	WqzQ6biWShVjh2f7bAUCFDA4OtmwC1F833URTdy4rAGuDq0UUZbi4Ue4EIFUH2+RYzJqWd
	ar8BY6URfE428cndSxC7jYWB1PlX2ysgsKYeGCTS+Gpg9e4z9hjCRG/RguTwNY/L9KC+qw
	VXQdUOFhZRjiLucprFSAt7Jj73J/CPepJB09JQJe5/lw8AtdPsxdQX4Kac3N2GeKcOly4p
	8aIcosb9ObI/EPEIzpvtGye5vlKLMAiQJ3e/i9vSmIN70MlOfoQRs5kvBEP4NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729873445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwRIzgszYY7oyVQQojRBuBkDuJOmg3Z9fkiO4V/EZHc=;
	b=kyr8t2KDGcPbygqDzi9o/xsROfdMF1CtspUcirXFcw9dgD4dEJO1/eB4oI6ZRZ0QmP0bMx
	+kBoslvACDrWHIDg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Remove unnecessary cache
 writeback and invalidation
Cc: Yan Hua Wu <yanhua1.wu@intel.com>, William Xie <william.xie@intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ashok Raj <ashok.raj@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241001161042.465584-2-chang.seok.bae@intel.com>
References: <20241001161042.465584-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172987344401.1442.10090182228431782658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     9a819753b0209c6edebdea447a1aa53e8c697653
Gitweb:        https://git.kernel.org/tip/9a819753b0209c6edebdea447a1aa53e8c697653
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 01 Oct 2024 09:10:36 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 25 Oct 2024 18:12:03 +02:00

x86/microcode/intel: Remove unnecessary cache writeback and invalidation

Currently, an unconditional cache flush is performed during every
microcode update. Although the original changelog did not mention
a specific erratum, this measure was primarily intended to address
a specific microcode bug, the load of which has already been blocked by
is_blacklisted(). Therefore, this cache flush is no longer necessary.

Additionally, the side effects of doing this have been overlooked. It
increases CPU rendezvous time during late loading, where the cache flush
takes between 1x to 3.5x longer than the actual microcode update.

Remove native_wbinvd() and update the erratum name to align with the
latest errata documentation, document ID 334163 Version 022US.

  [ bp: Zap the flaky documentation URL. ]

Fixes: 91df9fdf5149 ("x86/microcode/intel: Writeback and invalidate caches before updating microcode")
Reported-by: Yan Hua Wu <yanhua1.wu@intel.com>
Reported-by: William Xie <william.xie@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Ashok Raj <ashok.raj@intel.com>
Tested-by: Yan Hua Wu <yanhua1.wu@intel.com>
Link: https://lore.kernel.org/r/20241001161042.465584-2-chang.seok.bae@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 815fa67..f3d5348 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -319,12 +319,6 @@ static enum ucode_state __apply_microcode(struct ucode_cpu_info *uci,
 		return UCODE_OK;
 	}
 
-	/*
-	 * Writeback and invalidate caches before updating microcode to avoid
-	 * internal issues depending on what the microcode is updating.
-	 */
-	native_wbinvd();
-
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -574,14 +568,14 @@ static bool is_blacklisted(unsigned int cpu)
 	/*
 	 * Late loading on model 79 with microcode revision less than 0x0b000021
 	 * and LLC size per core bigger than 2.5MB may result in a system hang.
-	 * This behavior is documented in item BDF90, #334165 (Intel Xeon
+	 * This behavior is documented in item BDX90, #334165 (Intel Xeon
 	 * Processor E7-8800/4800 v4 Product Family).
 	 */
 	if (c->x86_vfm == INTEL_BROADWELL_X &&
 	    c->x86_stepping == 0x01 &&
 	    llc_size_per_core > 2621440 &&
 	    c->microcode < 0x0b000021) {
-		pr_err_once("Erratum BDF90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
+		pr_err_once("Erratum BDX90: late loading with revision < 0x0b000021 (0x%x) disabled.\n", c->microcode);
 		pr_err_once("Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 		return true;
 	}

