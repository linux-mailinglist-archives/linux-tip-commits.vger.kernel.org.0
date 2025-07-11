Return-Path: <linux-tip-commits+bounces-6075-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F1B02143
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE72A63405
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DC2EF28F;
	Fri, 11 Jul 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kfr/86rM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nxI/1eBN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00F2ED859;
	Fri, 11 Jul 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250172; cv=none; b=qW2WJVtJ+WXA9LqgeTEskKYJeY6brZCx4uLUWifhGU1VC1eLcitZ7WNjzfZSrwJZfn3OFYXP1iQUHW/sW7foKDD66sjQ6RWlEN6+QymaGj1xd1k2ooSlRfuOXyU/rFaMRmynaLtviMC/P02/UGMr9FCxgPUX6UxQ6vCr3ehIy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250172; c=relaxed/simple;
	bh=4WNuSBADclKfbalDaaBv22SnEAG/kxJMz/CgqOSeTks=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EmCImZrzC1QqDJ+rMX2Ic/0NSnvSj3MPv2I0XayMZvRFwEd4f4OVH4cDC3HvhmRStRt6wqbKqMt4ylVm8bLQU4Eq+f4S1GYIcbgLaCDaJedbZAvkFXJLyB2a4tu3amsZB/hiCe6fcy00wiKtKa6ni3fdlPc0SRdGuFzlsTpimQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kfr/86rM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nxI/1eBN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xs5nJO+Xf4zEJDzwsxiLcaSKgJXrO9jsxNxPxdlLNE=;
	b=kfr/86rM9AzwKgkDkFRxHWe5Tecb06rQMseOHMJSS+lBhskaaOQncOnnhtF4DFpcwiHGNZ
	1K3ZQmxOOTf9t9odiSAqV5X3rEL6ApLUbwu4P7x4Ix9Mtr4hg1F2R9UDF9EhvkXNSoxsS8
	kO3xLwcZw6gPQGmJ9Xavj6cUfKQZduP+1h/5dpB7/VVWAINzHf+UHb962GyIfSzw5xp2Lf
	cPIJjlTUd9k8GChFHnOoLy1aWO5Gnbp9HpA4ApIVD7w+SACTnQ3MIZopHRB3GrLNjob8Mb
	0Sqdh9QnBdLYCptYElFsL8cz8iWAxYOdaviTLpWHM/ygYWux/8tqBXqNdTocXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250169;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xs5nJO+Xf4zEJDzwsxiLcaSKgJXrO9jsxNxPxdlLNE=;
	b=nxI/1eBNgojMpbJOIOCMZTyiS2ps2Djqk6Aas4kI7F7Ln0SsdjoEghI7mrU/nsGk/wfF4c
	iOO3j36+Wc0vWxBA==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Print enabled attack vectors
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-21-david.kaplan@amd.com>
References: <20250707183316.1349127-21-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225016803.406.8310997854845822581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     a026dc61cffd98541e048f3c88d3280bcd105bd4
Gitweb:        https://git.kernel.org/tip/a026dc61cffd98541e048f3c88d3280bcd105bd4
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:33:15 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:41 +02:00

x86/bugs: Print enabled attack vectors

Print the status of enabled attack vectors and SMT mitigation status in the
boot log for easier reporting and debugging.  This information will also be
available through sysfs.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-21-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index b9d0509..b74bf93 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -189,6 +189,39 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
 DEFINE_STATIC_KEY_FALSE(cpu_buf_vm_clear);
 EXPORT_SYMBOL_GPL(cpu_buf_vm_clear);
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"mitigations: " fmt
+
+static void __init cpu_print_attack_vectors(void)
+{
+	pr_info("Enabled attack vectors: ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL))
+		pr_cont("user_kernel, ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER))
+		pr_cont("user_user, ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST))
+		pr_cont("guest_host, ");
+
+	if (cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST))
+		pr_cont("guest_guest, ");
+
+	pr_cont("SMT mitigations: ");
+
+	switch (smt_mitigations) {
+	case SMT_MITIGATIONS_OFF:
+		pr_cont("off\n");
+		break;
+	case SMT_MITIGATIONS_AUTO:
+		pr_cont("auto\n");
+		break;
+	case SMT_MITIGATIONS_ON:
+		pr_cont("on\n");
+	}
+}
+
 void __init cpu_select_mitigations(void)
 {
 	/*
@@ -209,6 +242,8 @@ void __init cpu_select_mitigations(void)
 
 	x86_arch_cap_msr = x86_read_arch_cap_msr();
 
+	cpu_print_attack_vectors();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();

