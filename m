Return-Path: <linux-tip-commits+bounces-3576-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C842DA3F8E8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333D03A7249
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF18D21171C;
	Fri, 21 Feb 2025 15:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBAGsdPP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w7ejTtFK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C2212FB2;
	Fri, 21 Feb 2025 15:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151759; cv=none; b=F8PoiVpw3QuvIelL+Sf9RGsFKn8j8DiLfKKocUn+OdcnekXaYbg60ZRLnDEUYhHly3Sfls2ZllifqBsaIl4dEiGsXidVcVJI3izMqmroHD22Fz9ZztVB7yXuC1BczsHH7NQY/kb9RnIkuQNB/DCGpMPrzkpD/3Wjl+pPJfH8d70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151759; c=relaxed/simple;
	bh=Sgb4lRNOsH9ev03x6BLtr2ijGeo8RxWdQEtTFJy1oPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=H1WHoE3zXoWVKhk2C5ct6mXQJ8NvwYjlTqVv9r+otG9X3Cn3UoYIsXhCLf18JcE/7aPnWrQZW9qqb2rxSAyea4JnWW9CPfm6aE3PEtntnLayEstvhRy8p5+l4yURrdTJUh3WFf4w6mK7NjLA2GpETQzlT9B9tre6HMtKpsBsmTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBAGsdPP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w7ejTtFK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:29:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740151756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItqkKD3hqEcV/WAXnBzwfgjapNbA8d2EOk+m9pooXCg=;
	b=xBAGsdPPh9Xn2EQbUXVB3yVkYs/E5I84s3dkM+5mYdf/IfeUHSpzqDYs9oPjKoDO7cU1KD
	gfoA6NnziReu6RnifZTj94z0YAei/M/gQPjl3UjBi9fS5fZ4pdvyvS4epgPVQcFHSJEJKF
	YZyUjA+h7jb4csY975LLndpcFh9OS98+pumV63EAmS3MzaERBjpCEnQs5dUhosRqBac0jQ
	54k4tW1yT3u7dSg3aXVg/6/4bxzyfVsi+TUL/Y5ymkIiY0A+UVXSkKtfWRhiXXxnr3HgcZ
	Ur4FFpGbES4oUvxAoPvBJt38kV7VY9+m3uvs7YR0wmOgmaBD5xHIvaR3mif7zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740151756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ItqkKD3hqEcV/WAXnBzwfgjapNbA8d2EOk+m9pooXCg=;
	b=w7ejTtFKTn0rywKxunxDMGSDd88sqDeBw1fgEJxzbFaxBZjMEdLguRB4NBgT7rLnqcpFHb
	DSs52/SsKnF6chAg==
From: "tip-bot2 for Mike Rapoport (Microsoft)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Split kernel resources setup into the
 setup_kernel_resources() helper function
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214090651.3331663-3-rppt@kernel.org>
References: <20250214090651.3331663-3-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015175568.10177.15710753609296534257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     297fb82ebaad50e1c40aab7ac61897bf372842ba
Gitweb:        https://git.kernel.org/tip/297fb82ebaad50e1c40aab7ac61897bf372842ba
Author:        Mike Rapoport (Microsoft) <rppt@kernel.org>
AuthorDate:    Fri, 14 Feb 2025 11:06:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:05:00 +01:00

x86/boot: Split kernel resources setup into the setup_kernel_resources() helper function

Makes setup_arch() a bit easier to comprehend.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250214090651.3331663-3-rppt@kernel.org
---
 arch/x86/kernel/setup.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4baadea..3d95946 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -527,6 +527,23 @@ void __init reserve_standard_io_resources(void)
 
 }
 
+static void __init setup_kernel_resources(void)
+{
+	code_resource.start = __pa_symbol(_text);
+	code_resource.end = __pa_symbol(_etext)-1;
+	rodata_resource.start = __pa_symbol(__start_rodata);
+	rodata_resource.end = __pa_symbol(__end_rodata)-1;
+	data_resource.start = __pa_symbol(_sdata);
+	data_resource.end = __pa_symbol(_edata)-1;
+	bss_resource.start = __pa_symbol(__bss_start);
+	bss_resource.end = __pa_symbol(__bss_stop)-1;
+
+	insert_resource(&iomem_resource, &code_resource);
+	insert_resource(&iomem_resource, &rodata_resource);
+	insert_resource(&iomem_resource, &data_resource);
+	insert_resource(&iomem_resource, &bss_resource);
+}
+
 static bool __init snb_gfx_workaround_needed(void)
 {
 #ifdef CONFIG_PCI
@@ -845,15 +862,6 @@ void __init setup_arch(char **cmdline_p)
 		root_mountflags &= ~MS_RDONLY;
 	setup_initial_init_mm(_text, _etext, _edata, (void *)_brk_end);
 
-	code_resource.start = __pa_symbol(_text);
-	code_resource.end = __pa_symbol(_etext)-1;
-	rodata_resource.start = __pa_symbol(__start_rodata);
-	rodata_resource.end = __pa_symbol(__end_rodata)-1;
-	data_resource.start = __pa_symbol(_sdata);
-	data_resource.end = __pa_symbol(_edata)-1;
-	bss_resource.start = __pa_symbol(__bss_start);
-	bss_resource.end = __pa_symbol(__bss_stop)-1;
-
 	/*
 	 * x86_configure_nx() is called before parse_early_param() to detect
 	 * whether hardware doesn't support NX (so that the early EHCI debug
@@ -897,11 +905,11 @@ void __init setup_arch(char **cmdline_p)
 	tsc_early_init();
 	x86_init.resources.probe_roms();
 
-	/* after parse_early_param, so could debug it */
-	insert_resource(&iomem_resource, &code_resource);
-	insert_resource(&iomem_resource, &rodata_resource);
-	insert_resource(&iomem_resource, &data_resource);
-	insert_resource(&iomem_resource, &bss_resource);
+	/*
+	 * Add resources for kernel text and data to the iomem_resource.
+	 * Do it after parse_early_param, so it can be debugged.
+	 */
+	setup_kernel_resources();
 
 	e820_add_kernel_range();
 	trim_bios_range();

