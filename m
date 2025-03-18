Return-Path: <linux-tip-commits+bounces-4310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2ABA67C59
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A23A882C89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F162139CF;
	Tue, 18 Mar 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VLEzOWJi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1WgNGaqh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891422135B2;
	Tue, 18 Mar 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324077; cv=none; b=k+VVx5/L6nX0SAqvJhau1zEQkNTd6T9FZe4I9M9d66T2HklvQddi1nkcxoKsj4L/tkVPstk1HvLHXAy1FmNNlL0Ill5e8SVda7ay0zSLBJ2PK1r37AoNkxaYQGaAet+z2ls/hWUbUgyriqA6S59AXAQEzvni6F4f+RnWI7Wrcco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324077; c=relaxed/simple;
	bh=JDdtEBkRtk3DbgEYNLNnIJzyDghQ0rWSPy2qBazIRMU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hFEwBlgxOaL8lf7AYh0zeS1do4lJsinBHcO8d6NpUDGd9gVDvF4Q99oScZJj9Ago7xjHcwal7vehw1dG9HQSCqhLyp/GPhtqwoCtBpDqnOXy9ivspOLCvc0VQ0t6QtagdQYPv4RnXWF+0vYVu9KCpLW4u7Jb0MT14rK22PNXlF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VLEzOWJi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1WgNGaqh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfZfv1Kr4II1wTL03HiCBak6EPJlaJgaY/+fUmFas98=;
	b=VLEzOWJiwNvWCEovPVSRlwX0F4lTAnWRi+DJPfWUH7M3qbXH8m3TELJHV407vnbjBxL2dw
	01qg6uWcvqU3bu9PLbnZ5s+ARpnqkk11+uvdHFhFxnIZWj3sItLL7zESqrLGSY9jL3DRlD
	j9mZfjY300e99ZhdPtMlyseNOhn6mkT+LOIgQDNfn94ABS9hQqFcuWvWEe2k9a7wm3+K5F
	uiRzqOJJYFJMqRYMTpJK1Qs8Ltg6hWFCNEnzpsQ3x3yH2yvlflpud8bNK2/fnZetQ6hP+A
	iXRKnkxSepqvL+ZFTy9GXW8rZFe/wDoHCMk19rVrNONtWPSEUiDYeUwYwDcHIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfZfv1Kr4II1wTL03HiCBak6EPJlaJgaY/+fUmFas98=;
	b=1WgNGaqhY1n3xE0aJ8VUBe8C6ct5VZ8a7BCP0KrvmrqueGeaEyWs5DMWoASQdCgqpoVNTt
	e+5HO+2Q96NOH1DQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/smpboot: Remove confusing quirk usage in INIT delay
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-10-sohil.mehta@intel.com>
References: <20250219184133.816753-10-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232406915.14745.13980684643978831679.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     4f15efe5cecd8b2dc566f1c0c13e3551b72a34e5
Gitweb:        https://git.kernel.org/tip/4f15efe5cecd8b2dc566f1c0c13e3551b72a34e5
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:46 +01:00

x86/smpboot: Remove confusing quirk usage in INIT delay

Very old multiprocessor systems required a 10 msec delay between
asserting and de-asserting INIT but modern processors do not require
this delay.

Over time the usage of the "quirk" wording while setting the INIT delay
has become misleading. The code comments suggest that modern processors
need to be quirked, which clears the default init_udelay of 10 msec,
while legacy processors don't need the quirk and continue to use the
default init_udelay.

With a lot more modern processors, the wording should be inverted if at
all needed. Instead, simplify the comments and the code by getting rid
of "quirk" usage altogether and clarifying the following:

  - Old legacy processors -> Set the "legacy" 10 msec delay
  - Modern processors     -> Do not set any delay

No functional change.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250219184133.816753-10-sohil.mehta@intel.com
---
 arch/x86/kernel/smpboot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ecf1bf..7dccc44 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -634,10 +634,9 @@ static void impress_friends(void)
  * But that slows boot and resume on modern processors, which include
  * many cores and don't require that delay.
  *
- * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
- * Modern processor families are quirked to remove the delay entirely.
+ * Cmdline "cpu_init_udelay=" is available to override this delay.
  */
-#define UDELAY_10MS_DEFAULT 10000
+#define UDELAY_10MS_LEGACY 10000
 
 static unsigned int init_udelay = UINT_MAX;
 
@@ -649,7 +648,7 @@ static int __init cpu_init_udelay(char *str)
 }
 early_param("cpu_init_udelay", cpu_init_udelay);
 
-static void __init smp_quirk_init_udelay(void)
+static void __init smp_set_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
 	if (init_udelay != UINT_MAX)
@@ -663,7 +662,7 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 	}
 	/* else, use legacy delay */
-	init_udelay = UDELAY_10MS_DEFAULT;
+	init_udelay = UDELAY_10MS_LEGACY;
 }
 
 /*
@@ -1074,7 +1073,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	smp_quirk_init_udelay();
+	smp_set_init_udelay();
 
 	speculative_store_bypass_ht_init();
 

