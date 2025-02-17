Return-Path: <linux-tip-commits+bounces-3380-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64513A37D77
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 09:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D143A5497
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Feb 2025 08:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C71A2658;
	Mon, 17 Feb 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CLK3jw7n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VpC1y1vC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCAB168B1;
	Mon, 17 Feb 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739782318; cv=none; b=pcjuknBgDvoVw85TXQD9uiLDaUVVP9tTsH3ifTVNSAi5M58tN3timwZ10xtZqcoIN3WO4uskQre2I2w4PlmEDhHdhYrDvqlnakZXX6P1a644PexoxtEYE0cCKab1wUdtfMR77uCfA44fGqUN2uX2Fwprm3oqBrVc9z9HOnHh81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739782318; c=relaxed/simple;
	bh=OX1YlG6p/Gn9pxQgkkJc/gP8P64Frs4hYHehaPg0jTs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cEXpzxZkFcCEWJHNo/W9AaTjfx5DoS544XaiYfuGYHaP/Cs/KPh94Mbj7rV6+bimExun2RgrTTMAwioVNOeJAH3JyBd4Fq6kaTA3/3yeuW8h77g/GShTRjeeJOcaO9mwrxKsJYj71SNRw1JUfKn+m4btkgk6v6T+eSa/9ddsUjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CLK3jw7n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VpC1y1vC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Feb 2025 08:51:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739782315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk6PEiBFsSk/OJHjGmxBkQaJ5UX+EOnKSFZA6zEoMI4=;
	b=CLK3jw7nzaNL4TX7A4Teru52LnLfMd1oHwfWBC/xjuWXgONkHFOUScJ2GEG7ecV14jIrNd
	rs/a+r6HkwUY/AOlZ5qsV7BAfDXQCvI0iC2Uxd4vUOuOnCvAGCnryvr2/AEjzFXonELcxZ
	EXl6+90KyGhk81cydjOSg0EmaqYZD713QVAsUJZCm9rIcW5Z0Lalg/eCk5JQsi5RkWLiBU
	vZbL2Yx4EOOdqmHnf+v8yNOvmgNE23PjOVbFdX3zcsByVYe3bRGVLNw/eBfGHNXt4Knf+6
	Oph81Vh3zQUjmo+LI8R39+bushKQYH81zYmYXHBlz5aF/+eOPWxcD7EIQM1Ahg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739782315;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vk6PEiBFsSk/OJHjGmxBkQaJ5UX+EOnKSFZA6zEoMI4=;
	b=VpC1y1vCc4bHu7H4G40+4l9vMn9TBwvHtU2pQ9Ud0oEb+H3DbIsSfTTzy9tVyLBRd+Q/KP
	EOvyOo0/QrmmnsDQ==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Merge early_apply_microcode()
 into its single callsite
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211163648.30531-4-bp@kernel.org>
References: <20250211163648.30531-4-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173978231454.10177.18358000269632162246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     dc15675074dcfd79a2f10a6e39f96b0244961a01
Gitweb:        https://git.kernel.org/tip/dc15675074dcfd79a2f10a6e39f96b0244961a01
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 23 Jan 2025 12:46:45 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Feb 2025 09:42:34 +01:00

x86/microcode/AMD: Merge early_apply_microcode() into its single callsite

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20250211163648.30531-4-bp@kernel.org
---
 arch/x86/kernel/cpu/microcode/amd.c | 60 ++++++++++++----------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f831c06..90f93b3 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -512,39 +512,6 @@ static bool __apply_microcode_amd(struct microcode_amd *mc, unsigned int psize)
 	return true;
 }
 
-/*
- * Early load occurs before we can vmalloc(). So we look for the microcode
- * patch container file in initrd, traverse equivalent cpu table, look for a
- * matching microcode patch, and update, all in initrd memory in place.
- * When vmalloc() is available for use later -- on 64-bit during first AP load,
- * and on 32-bit during save_microcode_in_initrd() -- we can call
- * load_microcode_amd() to save equivalent cpu table and microcode patches in
- * kernel heap memory.
- *
- * Returns true if container found (sets @desc), false otherwise.
- */
-static bool early_apply_microcode(u32 old_rev, void *ucode, size_t size)
-{
-	struct cont_desc desc = { 0 };
-	struct microcode_amd *mc;
-
-	scan_containers(ucode, size, &desc);
-
-	mc = desc.mc;
-	if (!mc)
-		return false;
-
-	/*
-	 * Allow application of the same revision to pick up SMT-specific
-	 * changes even if the revision of the other SMT thread is already
-	 * up-to-date.
-	 */
-	if (old_rev > mc->hdr.patch_id)
-		return false;
-
-	return __apply_microcode_amd(mc, desc.psize);
-}
-
 static bool get_builtin_microcode(struct cpio_data *cp)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
@@ -582,8 +549,19 @@ static bool __init find_blobs_in_containers(struct cpio_data *ret)
 	return found;
 }
 
+/*
+ * Early load occurs before we can vmalloc(). So we look for the microcode
+ * patch container file in initrd, traverse equivalent cpu table, look for a
+ * matching microcode patch, and update, all in initrd memory in place.
+ * When vmalloc() is available for use later -- on 64-bit during first AP load,
+ * and on 32-bit during save_microcode_in_initrd() -- we can call
+ * load_microcode_amd() to save equivalent cpu table and microcode patches in
+ * kernel heap memory.
+ */
 void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_eax)
 {
+	struct cont_desc desc = { };
+	struct microcode_amd *mc;
 	struct cpio_data cp = { };
 	u32 dummy;
 
@@ -597,7 +575,21 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 	if (!find_blobs_in_containers(&cp))
 		return;
 
-	if (early_apply_microcode(ed->old_rev, cp.data, cp.size))
+	scan_containers(cp.data, cp.size, &desc);
+
+	mc = desc.mc;
+	if (!mc)
+		return;
+
+	/*
+	 * Allow application of the same revision to pick up SMT-specific
+	 * changes even if the revision of the other SMT thread is already
+	 * up-to-date.
+	 */
+	if (ed->old_rev > mc->hdr.patch_id)
+		return;
+
+	if (__apply_microcode_amd(mc, desc.psize))
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 

