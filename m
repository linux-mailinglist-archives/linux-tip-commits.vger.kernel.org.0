Return-Path: <linux-tip-commits+bounces-6411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD50B3FCC6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885B6188F8C4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B922F90F0;
	Tue,  2 Sep 2025 10:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CziRnAwT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkOykWrI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F92F83CB;
	Tue,  2 Sep 2025 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809409; cv=none; b=VZPB3kwMBdQG5eQJ0IfeEa+vJKgbTRhe9jUtkKHvkMGyAvSw+zLE/vnnrsuIYGqoHAK8jU4vpYvyLcevGigqc/dODl9NspVnguHkEZ5MEb9bgppFOg/ycEXOop9NrnJtuabFzxjS2ohX2AfnNTSRuuzUv15mGVji32FHMXkvrRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809409; c=relaxed/simple;
	bh=m4Kwde80GBKe6uFMSfRW/nNG0WCVl/cdNJ9i+MxNvXU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jBydFfZXIkJgzQA/oi0oF9W4Dgm+ImVFd7H+u4UynqioA+5ChVKJOrVXXGmrSwkDkmkxIsFhYJuGjcdW3anlm+WCGCKHyp8Ke1N9/SIkQBIKp9Mioud3vdocDa7Q3h5QlfHMbllTDj1cK7M/ep3GIJ/L+WSW/vi6/G4l8zOfA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CziRnAwT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkOykWrI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0GM7pgT8976vIaTgdf2NEmh0GDcQ9TaHS/t0Q5gfCM=;
	b=CziRnAwTvfMEC3JERWH6GE6Rj0CoqYmYVbr4R5RSYJHNYPGLinWBxnRsxxA+P+ZHbVFCMV
	aCA3WJWTM9ThZzzEBWZ1zN4TP/qwatWCLf+sTzFmcG+POdrTDhCLvQ5AF1lEjxCuN05zqW
	w3+KQnApbTsxoHvVkIruHBdqLZ+B3A3yKTlOiiqB+9PG7FeL8PJexKZBLg1nnxA6C24vWN
	ieopHRPg2WSY7r+UAESyp+Y75Gjql7+2tQ5pzm9ZEDF4rBA1IipR0T0Ou5oQ58E7P1fx2b
	JVn/jNfS3RpeEkxKieXyRTykm/gy6QZ65bT50sWimZaO3sF15exCof12NFAOCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0GM7pgT8976vIaTgdf2NEmh0GDcQ9TaHS/t0Q5gfCM=;
	b=qkOykWrINMBtdTbIP+TH0JjTjFVERTjDo++vaPPtiizx2F9XeW+gFl4qk+m6H5yDQZBZ9Z
	Yxl6ctkYI/NctABQ==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/apic: Add an update_vector() callback for Secure AVIC
Cc: Kishon Vijay Abraham I <kvijayab@amd.com>,
 Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828110255.208779-4-Neeraj.Upadhyay@amd.com>
References: <20250828110255.208779-4-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680940540.1920.6825601315365973347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     8c79a68de1d2d63537f2a318e5a3b27744c835ad
Gitweb:        https://git.kernel.org/tip/8c79a68de1d2d63537f2a318e5a3b27744c=
835ad
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:32:43 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 12:42:11 +02:00

x86/apic: Add an update_vector() callback for Secure AVIC

Add an update_vector() callback to set/clear the ALLOWED_IRR field in a vCPU's
APIC backing page for vectors which are emulated by the hypervisor.

The ALLOWED_IRR field indicates the interrupt vectors which the guest allows
the hypervisor to inject (typically for emulated devices).  Interrupt vectors
used exclusively by the guest itself and the vectors which are not emulated by
the hypervisor, such as IPI vectors, should not be set by the guest in the
ALLOWED_IRR fields.

As clearing/setting state of a vector will also be used in subsequent commits
for other APIC registers (such as APIC_IRR update for sending IPI), add
a common update_vector() in the Secure AVIC driver.

  [ bp: Massage commit message. ]

Co-developed-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828110255.208779-4-Neeraj.Upadhyay@amd.com
---
 arch/x86/kernel/apic/x2apic_savic.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index 56c51ea..942d3aa 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -27,6 +27,22 @@ static int savic_acpi_madt_oem_check(char *oem_id, char *o=
em_table_id)
 	return x2apic_enabled() && cc_platform_has(CC_ATTR_SNP_SECURE_AVIC);
 }
=20
+static inline void *get_reg_bitmap(unsigned int cpu, unsigned int offset)
+{
+	return &per_cpu_ptr(savic_page, cpu)->regs[offset];
+}
+
+static inline void update_vector(unsigned int cpu, unsigned int offset,
+				 unsigned int vector, bool set)
+{
+	void *bitmap =3D get_reg_bitmap(cpu, offset);
+
+	if (set)
+		apic_set_vector(vector, bitmap);
+	else
+		apic_clear_vector(vector, bitmap);
+}
+
 #define SAVIC_ALLOWED_IRR	0x204
=20
 /*
@@ -144,6 +160,11 @@ static void savic_write(u32 reg, u32 data)
 	}
 }
=20
+static void savic_update_vector(unsigned int cpu, unsigned int vector, bool =
set)
+{
+	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
+}
+
 static void savic_setup(void)
 {
 	void *ap =3D this_cpu_ptr(savic_page);
@@ -217,6 +238,8 @@ static struct apic apic_x2apic_savic __ro_after_init =3D {
 	.eoi				=3D native_apic_msr_eoi,
 	.icr_read			=3D native_x2apic_icr_read,
 	.icr_write			=3D native_x2apic_icr_write,
+
+	.update_vector			=3D savic_update_vector,
 };
=20
 apic_driver(apic_x2apic_savic);

