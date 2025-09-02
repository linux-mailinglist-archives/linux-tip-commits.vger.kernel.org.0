Return-Path: <linux-tip-commits+bounces-6407-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFB9B3FCBA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF201B217AF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623822F5484;
	Tue,  2 Sep 2025 10:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUPmuYBj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5d8x3sSd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80582F5305;
	Tue,  2 Sep 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809404; cv=none; b=VQ2qFippWyZyHgPUwCHBsmM1vR6HFgOiMni89rDNLT6QRSYi2Wmj+43F6vKhwXHuH6Oit+Oo/nEQEGX/VVMzdAjJBLGu2E2zB0jcoExTkgjo734LX35TNp/wg/p8rQQGYKEBXZK3S3IzX4OjKniSgG7RI9/P0PaaXq2MZeDQoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809404; c=relaxed/simple;
	bh=DpE+J87DQ2uuM02zl76rUOXHs47isi+hFtEb/mwO84U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uchWmIWpPNkzFA9PSkh4wEHRn+tHn6V0+2ss08usu3qyB5N684S/vc6Z0kluqXHWRMQH50hAX55xPsuh/4xbDTprsVtSibpOybsH2nrpBpJk4vAGlIrfqLMfNa4yNnqAXVVdptdBGsv38rV1RGwaXus9wqOW6CXg8TntMiWluEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUPmuYBj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5d8x3sSd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3l6bze1xxf6ovm1VF0IZ3HcBFm9xIMUL7NzJYdRLOo0=;
	b=cUPmuYBjDSLv0Iko5PbY7hAE1xRlcs7e2tZGl4kB+bfShAZ9Fdi+6QrcQjHybABFmlOO8/
	kZl9QnRDeWGW51ZkxW6Sb0m1t+mHZOP7MVa1Fb7XCctUtA6OvL9IcAHkHq9fdFchCYO2cP
	pOJdJswJgTYNovUjBQcl+LhjF/Z+qzYR8d/NOtoSGeF4BQkkfkjQkhqKAeYW5IlibiLfG3
	VL/a4H8cfDcOWDWeTKZISBYn2jBzQ+UB+o8hsXciG1S4vqJF/dowOgndODRKL70lzpcUNv
	GGswUt5sw1V9QRogBoKvnKIO8t2KoXZnpt8qkoG271NMlirrJR1fjTgqa1Vujg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809401;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3l6bze1xxf6ovm1VF0IZ3HcBFm9xIMUL7NzJYdRLOo0=;
	b=5d8x3sSdTmoun3BKmf5KNl3021RGVdrExbEnAaxzmyDm2DCu+g2+WOhzN8mB4qxwOdwMEn
	k/KVwl3NvlJZn3DQ==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Allow NMI to be injected from hypervisor
 for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828111243.208946-1-Neeraj.Upadhyay@amd.com>
References: <20250828111243.208946-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939965.1920.9206423383986783995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     869e36b9660dd72ab960b74c55d7a200c22588d0
Gitweb:        https://git.kernel.org/tip/869e36b9660dd72ab960b74c55d7a200c22=
588d0
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:42:43 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:57:18 +02:00

x86/apic: Allow NMI to be injected from hypervisor for Secure AVIC

Secure AVIC requires the "AllowedNmi" bit in the Secure AVIC Control MSR to be
set for an NMI to be injected from the hypervisor. So set it.

Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828111243.208946-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/include/asm/msr-index.h    | 3 +++
 arch/x86/kernel/apic/x2apic_savic.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 2a6d4fd..1291e05 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -703,6 +703,9 @@
 #define MSR_AMD64_SNP_SECURE_AVIC	BIT_ULL(MSR_AMD64_SNP_SECURE_AVIC_BIT)
 #define MSR_AMD64_SNP_RESV_BIT		19
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
+#define MSR_AMD64_SAVIC_CONTROL		0xc0010138
+#define MSR_AMD64_SAVIC_ALLOWEDNMI_BIT	1
+#define MSR_AMD64_SAVIC_ALLOWEDNMI	BIT_ULL(MSR_AMD64_SAVIC_ALLOWEDNMI_BIT)
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
 #define MSR_AMD64_RMP_CFG		0xc0010136
diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 8ed56e8..bbaedb4 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -328,6 +328,8 @@ static void savic_setup(void)
 	res =3D savic_register_gpa(gpa);
 	if (res !=3D ES_OK)
 		snp_abort();
+
+	native_wrmsrq(MSR_AMD64_SAVIC_CONTROL, gpa | MSR_AMD64_SAVIC_ALLOWEDNMI);
 }
=20
 static int savic_probe(void)

