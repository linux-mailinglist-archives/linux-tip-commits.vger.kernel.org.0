Return-Path: <linux-tip-commits+bounces-3378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1AA37D76
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 09:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 890717A2C28
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 08:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9F919DF75;
	Mon, 17 Feb 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJIa/xdM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uDSqMAqm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC89199FA4;
	Mon, 17 Feb 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782318; cv=none; b=XPbpym7pQWgVe5wjttBLuvwE9t2DLmmRLnpVzudW7/5m7f+2PicIjlpgkLFlambcmp6qcihz5i8aDf2QvMHqlbJ71k1oZ7y3kEdCWEyVl4FtbK7xU0j+nLz7KzaUaOY72ddw5N/hUceBYGLQgWEKMttppVeeEZ1qttIi5MWTzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782318; c=relaxed/simple;
	bh=R4cI0QFSAmBiMG7WjpiTVOqfGgUf5ArJy23oW5YvK9Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bfz909Dek5rwoJqWgdZObg7KXgMQfdLePu7dVTPh3kJQr9o5/3EkZp51qI0pQO3GXsv3W9yk7kT3Gw2fCl6dh20XSB9tHPj2+UBkX5CnjMselwE4HtvJlXVVdw5uBmZKhPrlPQ1NSMSQjtJoIFrmrUpZsQlgaGZsqViBOrbl5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJIa/xdM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uDSqMAqm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 08:51:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739782314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INPXfxcGs6hlgodPd9T/Mzb8254opG2yClE6OdwjXqc=;
	b=lJIa/xdMGw6KFATGrGwSKVKF9lHaZ1ibx0cafhdXO3IS3kK8Ve0RoWR7vbyZXbNq8jp2PG
	SoyWDVg5wqO8LjsaycpTr8KHeSF/MwGMBbP1BILvK0/bA1JCS/NtvWhP9HI5Irlr7/RFWJ
	NHhz53+hHYJm4ATUuTWzaoRhnyfM8kSRJT/DLdGN8hKQ2ZzujTweyaasCWQjooquC0IdcY
	n9lSLz/2l6nB0+LElfp/M2Bhu3wT9/Ak1c3mMMKS/n4156uOln3t/RIhfnQi9dOCHrCCV9
	OkQ1H0pmYb+51pYytllZ2Iteor/1mBtXb5GHHUq65yVb5ApTAqhRHRhZWrG3iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739782314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=INPXfxcGs6hlgodPd9T/Mzb8254opG2yClE6OdwjXqc=;
	b=uDSqMAqmbUzVBSkPfpaUnZCzRHBkTpXPZlBhghYaWS6sI3wdukydnueMC19Vr04o/ZiZg1
	B6R4xD87aQIphrCw==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Get rid of the
 _load_microcode_amd() forward declaration
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211163648.30531-5-bp@kernel.org>
References: <20250211163648.30531-5-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173978231370.10177.8551146773378054774.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     b39c387164879eef71886fc93cee5ca7dd7bf500
Gitweb:        https://git.kernel.org/tip/b39c387164879eef71886fc93cee5ca7dd7bf500
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Jan 2025 12:51:37 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 09:42:37 +01:00

x86/microcode/AMD: Get rid of the _load_microcode_amd() forward declaration

Simply move save_microcode_in_initrd() down.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-5-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 54 +++++++++++++---------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 90f93b3..adfea4d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -593,34 +593,6 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
-static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size);
-
-static int __init save_microcode_in_initrd(void)
-{
-	unsigned int cpuid_1_eax = native_cpuid_eax(1);
-	struct cpuinfo_x86 *c = &boot_cpu_data;
-	struct cont_desc desc = { 0 };
-	enum ucode_state ret;
-	struct cpio_data cp;
-
-	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
-		return 0;
-
-	if (!find_blobs_in_containers(&cp))
-		return -EINVAL;
-
-	scan_containers(cp.data, cp.size, &desc);
-	if (!desc.mc)
-		return -EINVAL;
-
-	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
-	if (ret > UCODE_UPDATED)
-		return -EINVAL;
-
-	return 0;
-}
-early_initcall(save_microcode_in_initrd);
-
 static inline bool patch_cpus_equivalent(struct ucode_patch *p,
 					 struct ucode_patch *n,
 					 bool ignore_stepping)
@@ -1004,6 +976,32 @@ static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t siz
 	return ret;
 }
 
+static int __init save_microcode_in_initrd(void)
+{
+	unsigned int cpuid_1_eax = native_cpuid_eax(1);
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+	struct cont_desc desc = { 0 };
+	enum ucode_state ret;
+	struct cpio_data cp;
+
+	if (dis_ucode_ldr || c->x86_vendor != X86_VENDOR_AMD || c->x86 < 0x10)
+		return 0;
+
+	if (!find_blobs_in_containers(&cp))
+		return -EINVAL;
+
+	scan_containers(cp.data, cp.size, &desc);
+	if (!desc.mc)
+		return -EINVAL;
+
+	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
+	if (ret > UCODE_UPDATED)
+		return -EINVAL;
+
+	return 0;
+}
+early_initcall(save_microcode_in_initrd);
+
 /*
  * AMD microcode firmware naming convention, up to family 15h they are in
  * the legacy file:

