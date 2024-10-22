Return-Path: <linux-tip-commits+bounces-2524-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B29AB367
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 18:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01BF1F21933
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Oct 2024 16:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B0C19C555;
	Tue, 22 Oct 2024 16:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="afFEOdO/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQwPQUqZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F9F13BAD5;
	Tue, 22 Oct 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613311; cv=none; b=qwxER2gGC5s0e9W6WpoDohll0lkizUKkelE+yEvn6DfsVi7VGA3Ocrm839HDiCaqFlPhAEzoDqY47CGAVb9P9DpXUelu4FUGvcsgc6+xzE1mZvrxLdNL2Y5f3i48+BjXslCrap7wGEFmKb2/Lfd5c79EwW6OGAJB3fIhzAzPCBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613311; c=relaxed/simple;
	bh=hrhp9NP6Rib1dW/lfG+OKfT6tht6k+S9fywvd9xW3RU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yqh8QzQNM0tsV1co8bTydrGxWhXl6RFoXxKeebsEo1szaXZMnAA2XMCXNHn23zoeEoVBTa2w6wW9kQunEjyUjur1WSh3sG1FRvm4vZy+hRtIbIgRZrnueO2CwfUYp2K1whoB7ctshXG24qoE5kvRVzbmKUiQDCBKdTNKarJNnNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=afFEOdO/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQwPQUqZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Oct 2024 16:08:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729613307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lF7N2zpOwHU063JxwOv2Yrbncs/tCrwzCIEEizDScM=;
	b=afFEOdO/rUWLs93gH8oKoI/q0RuyAolkmVfEaT93nXk090/d1A17w/QqHdt6bIbVroR9lu
	B2HqzPBDa1bpuYpobZeU9AkCu2HKbMXV5GCuia/SHgR4Fcat+Hg+QuoKjfZkD98Tpl9s6K
	spiWZBgCjZBtARtvoBr2/sj1S30RxcthJIZMoVhm67IAf8CVCDLoSgkRcqrPc71wfoUElk
	APbTJQbMxB0OTJVUESdfXQcqZFg+xGeSO+pgfvf4yxK8sHIADTLkGB1ykRzEwFge3w9f+o
	Wzpz0XGfCLXqdYcmU1M6h31DxvoQvAP8vkTuZhSgDdOOaGCsyRRxdTyd2UGJNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729613307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5lF7N2zpOwHU063JxwOv2Yrbncs/tCrwzCIEEizDScM=;
	b=PQwPQUqZptgBcyoG8vq0MLsmlq0CvI5HwMb/iF2EVbUJMVv7P2/fgXFYxZ8eBT6qkNNcnP
	HabupB2ozdHR/ECg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/microcode/AMD: Split load_microcode_amd()
Cc: Jens Axboe <axboe@kernel.dk>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
References: <91194406-3fdf-4e38-9838-d334af538f74@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172961330616.1442.11027156153026818626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1d81d85d1a19e50d5237dc67d6b825c34ae13de8
Gitweb:        https://git.kernel.org/tip/1d81d85d1a19e50d5237dc67d6b825c34ae13de8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 21 Oct 2024 10:38:21 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 22 Oct 2024 16:48:00 +02:00

x86/microcode/AMD: Split load_microcode_amd()

This function should've been split a long time ago because it is used in
two paths:

1) On the late loading path, when the microcode is loaded through the
   request_firmware interface

2) In the save_microcode_in_initrd() path which collects all the
   microcode patches which are relevant for the current system before
   the initrd with the microcode container has been jettisoned.

   In that path, it is not really necessary to iterate over the nodes on
   a system and match a patch however it didn't cause any trouble so it
   was left for a later cleanup

However, that later cleanup was expedited by the fact that Jens was
enabling "Use L3 as a NUMA node" in the BIOS setting in his machine and
so this causes the NUMA CPU masks used in cpumask_of_node() to be
generated *after* 2) above happened on the first node. Which means, all
those masks were funky, wrong, uninitialized and whatnot, leading to
explosions when dereffing c->microcode in load_microcode_amd().

So split that function and do only the necessary work needed at each
stage.

Fixes: 94838d230a6c ("x86/microcode/AMD: Use the family,model,stepping encoded in the patch ID")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/r/91194406-3fdf-4e38-9838-d334af538f74@kernel.dk
---
 arch/x86/kernel/cpu/microcode/amd.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 1ae36ab..31a7371 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -584,7 +584,7 @@ void __init load_ucode_amd_bsp(struct early_load_data *ed, unsigned int cpuid_1_
 		native_rdmsr(MSR_AMD64_PATCH_LEVEL, ed->new_rev, dummy);
 }
 
-static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size);
+static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size);
 
 static int __init save_microcode_in_initrd(void)
 {
@@ -605,7 +605,7 @@ static int __init save_microcode_in_initrd(void)
 	if (!desc.mc)
 		return -EINVAL;
 
-	ret = load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
+	ret = _load_microcode_amd(x86_family(cpuid_1_eax), desc.data, desc.size);
 	if (ret > UCODE_UPDATED)
 		return -EINVAL;
 
@@ -954,21 +954,30 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	return UCODE_OK;
 }
 
-static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
+static enum ucode_state _load_microcode_amd(u8 family, const u8 *data, size_t size)
 {
-	struct cpuinfo_x86 *c;
-	unsigned int nid, cpu;
-	struct ucode_patch *p;
 	enum ucode_state ret;
 
 	/* free old equiv table */
 	free_equiv_cpu_table();
 
 	ret = __load_microcode_amd(family, data, size);
-	if (ret != UCODE_OK) {
+	if (ret != UCODE_OK)
 		cleanup();
+
+	return ret;
+}
+
+static enum ucode_state load_microcode_amd(u8 family, const u8 *data, size_t size)
+{
+	struct cpuinfo_x86 *c;
+	unsigned int nid, cpu;
+	struct ucode_patch *p;
+	enum ucode_state ret;
+
+	ret = _load_microcode_amd(family, data, size);
+	if (ret != UCODE_OK)
 		return ret;
-	}
 
 	for_each_node(nid) {
 		cpu = cpumask_first(cpumask_of_node(nid));

