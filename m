Return-Path: <linux-tip-commits+bounces-2147-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 682DC969916
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7691F251A9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692EE1B985C;
	Tue,  3 Sep 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M8rWNNTC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZnUdrJU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769661C9840;
	Tue,  3 Sep 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725355930; cv=none; b=XAUsAHZSO3mqQhELmeYCXhvLCtHkUV7Vd75uVqBEAsfubIO/DjAAfb5ealaMAO9ZiJ2/6HB3uxuwmKJZcQjQJJufSmdWfY+Bdn5tKU2LqO00b+rXvlrVumwlOrq9J0NyTW3xLIRi1o4Svkvd3bdBMhouFfzCCYCwfvwWDIr6BFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725355930; c=relaxed/simple;
	bh=64xchpbFw2siCbs5GIutraMFHS46mu7+NsdP/xvrvJA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IdHuqW7ciG0kxDxnp4kQhh4H4XsAZYOtO07J52Kz2MgV0RjpQ//Xj3ugIzkPQKApkGxkQ52VlAMDvr9rPINP8VP4qwRwQRk1Gor1ii2fpUz1G3Uc0cjbmyS3UnFes5lmnYFTx76qz/aFLDQJ8cqCJ19Mqmq+pvEoP9ipBrK1Ga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M8rWNNTC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZnUdrJU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 09:32:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725355926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHztj4Fa63Q5XQYTcl6Oz6APF6I4kXDwMU4FPyuq77g=;
	b=M8rWNNTC/joIz8y468YdnXJB5LMe4q2TxaCzDM3FLgzqEfpHPfbG7RNiD0SbsGzvRgHBAY
	CB1sUfWSnWsqrDM1zyvAz3Hw7Plul5+s6d/BJlMCOZL3GNGn3Ldvmf1zNDYzNkAp9aZiYR
	lkgrFMDqnuSs+OG84zZPJYVBHr/tNieFHjdjvA/WDrB3RWORQVaxyGHZHaCu7kkkRGaJxE
	U1In36n/PFjGlU9i9FzAETREl2hEutpEWWxIUi7GpuZR1kRKyJ7FxZG6k7DftpLJEJ+/jk
	Kd7F7iDL/Yb2IidURRKHKkxH74+vRwxAAM5pSXO/PFPWR9LiU00GPtqIRDwW0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725355926;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHztj4Fa63Q5XQYTcl6Oz6APF6I4kXDwMU4FPyuq77g=;
	b=1ZnUdrJUe83BoLK3HDjNmXJFINS3mIKwEWXKQGSTISFsWBXlEBkj/fmmN2RShS8zMTqNOt
	PJTMy6TjgrQ4CyCA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Replace PAT erratum model/family magic
 numbers with symbolic IFM references
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240829220042.1007820-1-dave.hansen@linux.intel.com>
References: <20240829220042.1007820-1-dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172535592591.2215.9909836777026903684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     fd82221a59fa5ce9dc7523e11c5e995104a28cb0
Gitweb:        https://git.kernel.org/tip/fd82221a59fa5ce9dc7523e11c5e995104a28cb0
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Thu, 29 Aug 2024 15:00:42 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Sep 2024 11:18:58 +02:00

x86/cpu/intel: Replace PAT erratum model/family magic numbers with symbolic IFM references

There's an erratum that prevents the PAT from working correctly:

   https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-dual-core-specification-update.pdf
   # Document 316515 Version 010

The kernel currently disables PAT support on those CPUs, but it
does it with some magic numbers.

Replace the magic numbers with the new "IFM" macros.

Make the check refer to the last affected CPU (INTEL_CORE_YONAH)
rather than the first fixed one. This makes it easier to find the
documentation of the erratum since Intel documents where it is
broken and not where it is fixed.

I don't think the Pentium Pro (or Pentium II) is actually affected.
But the old check included them, so it can't hurt to keep doing the
same.  I'm also not completely sure about the "Pentium M" CPUs
(models 0x9 and 0xd).  But, again, they were included in in the
old checks and were close Pentium III derivatives, so are likely
affected.

While we're at it, revise the comment referring to the erratum name
and making sure it is a quote of the language from the actual errata
doc.  That should make it easier to find in the future when the URL
inevitably changes.

Why bother with this in the first place? It actually gets rid of one
of the very few remaining direct references to c->x86{,_model}.

No change in functionality intended.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Len Brown <len.brown@intel.com>
Link: https://lore.kernel.org/r/20240829220042.1007820-1-dave.hansen@linux.intel.com
---
 arch/x86/include/asm/intel-family.h |  2 ++
 arch/x86/kernel/cpu/intel.c         | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f81a851..27bdf3b 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -47,6 +47,8 @@
 /* Wildcard match for FAM6 so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+#define INTEL_PENTIUM_PRO		IFM(6, 0x01)
+
 #define INTEL_FAM6_CORE_YONAH		0x0E
 #define INTEL_CORE_YONAH		IFM(6, 0x0E)
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 08b95a3..e7656cb 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -311,16 +311,18 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 	}
 
 	/*
-	 * There is a known erratum on Pentium III and Core Solo
-	 * and Core Duo CPUs.
-	 * " Page with PAT set to WC while associated MTRR is UC
-	 *   may consolidate to UC "
-	 * Because of this erratum, it is better to stick with
-	 * setting WC in MTRR rather than using PAT on these CPUs.
+	 * PAT is broken on early family 6 CPUs, the last of which
+	 * is "Yonah" where the erratum is named "AN7":
 	 *
-	 * Enable PAT WC only on P4, Core 2 or later CPUs.
+	 * 	Page with PAT (Page Attribute Table) Set to USWC
+	 * 	(Uncacheable Speculative Write Combine) While
+	 * 	Associated MTRR (Memory Type Range Register) Is UC
+	 * 	(Uncacheable) May Consolidate to UC
+	 *
+	 * Disable PAT and fall back to MTRR on these CPUs.
 	 */
-	if (c->x86 == 6 && c->x86_model < 15)
+	if (c->x86_vfm >= INTEL_PENTIUM_PRO &&
+	    c->x86_vfm <= INTEL_CORE_YONAH)
 		clear_cpu_cap(c, X86_FEATURE_PAT);
 
 	/*

