Return-Path: <linux-tip-commits+bounces-2696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799259B9E8D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A47281CD5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5C170A2C;
	Sat,  2 Nov 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GZpHcBi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msWkB2Vr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787C216EBE8;
	Sat,  2 Nov 2024 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542214; cv=none; b=nEv9yohdWfhnbW8SlSW5zsqdKkZs8EOo9yOUqpDnWn15pHBS9cM01pLn3WfmGx70WwvZPxarZMIlTD+ke+pDMA3In2ySwA62INeLJcjUKfdED2de3o6wGu4zcMaNumUvDG3C3g9H13J1mQ0Sc4gTWpGc9zL8I25zTENb5tHf1OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542214; c=relaxed/simple;
	bh=eutfW8H/fYe0thF+vKFtYixlD4bxU3ZuCrVWtLiH6L4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nmyrfPWRv57xQIf0g/3/kCjtxfNwaU2ts4n5YZVtd5FUXd3R4iKTepcEddjt8arexavoY0gJSfyWbxeObs0F6xfmC1x8HcHRTYRctJQOwJ9MR3S5eZxbVeHUZOT68b8mW84bOmxVaXxPTvU0vfjLEi6Sz9TK8+VJMzscwblfVrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GZpHcBi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msWkB2Vr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMPLrNDhki7QFoEQV8JOF4bLLdMjmoUiks8uVPgaSt4=;
	b=0GZpHcBiVxrT3RVNx6Qe7e8UAwCmgISjfugBIDXLiOZqFUkE28SkpHV/cuvfiUNsIyv7js
	aM+Gyjxh57DnmkNq+ypL3VjyMfcKIweufn8uv33o969aYMTWl3ofDP25xRO+RfCh93KNB2
	yq0XsU8EaX56pFZR5X1R7CuB6ysidleLtcK4jsTFXu4ad5O3LymuG2vH6IK2lh5C5drHMJ
	hzJaGVUcSednX0pNUALWXsVTgeYpPMW1pX3beUiUXDNiQSNXB5Fod8ERBf2g0LEAitVscF
	8aoZBigLpHCZY7EkKSx7sB/Ol//1sbmKI2WwGF6QivraMR76kUssNazrxxjPEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542205;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMPLrNDhki7QFoEQV8JOF4bLLdMjmoUiks8uVPgaSt4=;
	b=msWkB2VrGPWkgOpKZ1CCqkafVwgYmZ4ByVFJ364Udbi0BLoriECYytXU+572zzAK7d3+gm
	aoclaTTjHGOBPCCA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] powerpc: Add kconfig option for the systemcfg page
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-25-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-25-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220436.3137.18076488886881935710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ec4943295794f6a5a33e6640ae348f5896752c84
Gitweb:        https://git.kernel.org/tip/ec4943295794f6a5a33e6640ae348f58967=
52c84
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:16 +01:00

powerpc: Add kconfig option for the systemcfg page

The systemcfg page through procfs is only a backwards-compatible
interface for very old applications.
Make it possible to be disabled.

This also creates a convenient config #define to guard any accesses to
the systemcfg page.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-25-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/Kconfig               | 8 ++++++++
 arch/powerpc/kernel/proc_powerpc.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01..5d348e1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1298,6 +1298,14 @@ config MODULES_SIZE
=20
 endmenu
=20
+config PPC64_PROC_SYSTEMCFG
+	def_bool y
+	depends on PPC64 && PROC_FS
+	help
+	  This option enables the presence of /proc/ppc64/systemcfg through
+	  which the systemcfg page can be accessed.
+	  This interface only exists for backwards-compatibility.
+
 if PPC64
 # This value must have zeroes in the bottom 60 bits otherwise lots will break
 config PAGE_OFFSET
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_po=
werpc.c
index 910d208..3bda365 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -14,7 +14,7 @@
 #include <asm/rtas.h>
 #include <linux/uaccess.h>
=20
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
=20
 static loff_t page_map_seek(struct file *file, loff_t off, int whence)
 {
@@ -59,7 +59,7 @@ static int __init proc_ppc64_init(void)
 }
 __initcall(proc_ppc64_init);
=20
-#endif /* CONFIG_PPC64 */
+#endif /* CONFIG_PPC64_PROC_SYSTEMCFG */
=20
 /*
  * Create the ppc64 and ppc64/rtas directories early. This allows us to

