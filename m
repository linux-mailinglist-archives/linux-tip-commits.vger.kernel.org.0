Return-Path: <linux-tip-commits+bounces-4741-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B8A7E2AB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4B618999C3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F101E8344;
	Mon,  7 Apr 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCt58oB0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MNILQjjy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF81E7C3F;
	Mon,  7 Apr 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037078; cv=none; b=n4Bi8yrRd/3jjLnE9VCBpwF7yGblYfxkwznaDGEPhzAy8F/CKPf7cvArdSPwpt3EGleiFaxomvVg+2TOl9Wg3BH5LDmLBPEmLVgaTy0GgleRr8o+Aks1+1yV5Vyj1BNHDDydOiib3D/Fg+cHrdvLBnbBprmCs2omBZgLWm6wLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037078; c=relaxed/simple;
	bh=wb5vmLAwjAr6Q5os1/SxsAfNsedbjZxVvWahckqyYwQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iTMEPFdA7sg9cU6NIxlB/x1C4ldPIJGE1lDsYZdv5g1emvsDdiR5Nv181f2869Hcvxghqlmmc60caThFFw54plwJY3vppgGzRONDO862F0SFswIwTmPyHH+SYaSPR74d9j/SlJcH2FPXc4hNXdJL1aXqVT8I88+um+m+Ghmue/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCt58oB0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MNILQjjy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:44:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744037072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3s6DBTjHyxR82bXyvnXgDJ3sQDO7hl6/WU1SEmuqLQ=;
	b=rCt58oB0beAZUK1q8Ue6PuOcPPHE9qJ8tA08JSbrNfeRWlLESkKKCeBwa4Wx6lvMvQwasN
	Q+5enUW+n9BuzW2NOrKvRBh9CCpugkpXDm7a1ULFRv1+P4nyKGzdPEaTcuBQ6OqWWWgjr+
	w64UWOhCBfjBAazDPNmU7WT7U7yhHrPlhDybXeyYnvo6EEKmFnO9CUAVFPzcZwKHkuGoWR
	UBceMBHsZ7/DNww6soTz8uniEG+ul80HVxVeN5JDPYZabbq8Sep2NFEglkfXIETDiZDySZ
	5+OrNejDAvLJfe6badkqX6dPLo022ploTN7dMOniyAN6tFU8TNsX/BPgotjPnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744037072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j3s6DBTjHyxR82bXyvnXgDJ3sQDO7hl6/WU1SEmuqLQ=;
	b=MNILQjjyGscMcijAd6AukIf1UcA7Br+pBQBrU9h46qPaDGNZqgUWFt9Uf8kxPeK5rdnnmZ
	cm8YiHCxClCi52Aw==
From: tip-bot2 for Petr =?utf-8?q?Van=C4=9Bk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/acpi: Don't limit CPUs to 1 for Xen PV guests
 due to disabled ACPI
Cc: arkamar@atlas.cz, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250407132445.6732-2-arkamar@atlas.cz>
References: <20250407132445.6732-2-arkamar@atlas.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403706955.31282.7031075757256146451.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8b37357a78d7fa13d88ea822b35b40137da1c85e
Gitweb:        https://git.kernel.org/tip/8b37357a78d7fa13d88ea822b35b40137da=
1c85e
Author:        Petr Van=C4=9Bk <arkamar@atlas.cz>
AuthorDate:    Mon, 07 Apr 2025 15:24:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:35:21 +02:00

x86/acpi: Don't limit CPUs to 1 for Xen PV guests due to disabled ACPI

Xen disables ACPI for PV guests in DomU, which causes acpi_mps_check() to
return 1 when CONFIG_X86_MPPARSE is not set. As a result, the local APIC is
disabled and the guest is later limited to a single vCPU, despite being
configured with more.

This regression was introduced in version 6.9 in commit 7c0edad3643f
("x86/cpu/topology: Rework possible CPU management"), which added an
early check that limits CPUs to 1 if apic_is_disabled.

Update the acpi_mps_check() logic to return 0 early when running as a Xen
PV guest in DomU, preventing APIC from being disabled in this specific case
and restoring correct multi-vCPU behaviour.

Fixes: 7c0edad3643f ("x86/cpu/topology: Rework possible CPU management")
Signed-off-by: Petr Van=C4=9Bk <arkamar@atlas.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250407132445.6732-2-arkamar@atlas.cz
---
 arch/x86/kernel/acpi/boot.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dae6a73..9fa321a 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,6 +23,8 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
=20
+#include <xen/xen.h>
+
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -1729,6 +1731,15 @@ int __init acpi_mps_check(void)
 {
 #if defined(CONFIG_X86_LOCAL_APIC) && !defined(CONFIG_X86_MPPARSE)
 /* mptable code is not built-in*/
+
+	/*
+	 * Xen disables ACPI in PV DomU guests but it still emulates APIC and
+	 * supports SMP. Returning early here ensures that APIC is not disabled
+	 * unnecessarily and the guest is not limited to a single vCPU.
+	 */
+	if (xen_pv_domain() && !xen_initial_domain())
+		return 0;
+
 	if (acpi_disabled || acpi_noirq) {
 		pr_warn("MPS support code is not built-in, using acpi=3Doff or acpi=3Dnoir=
q or pci=3Dnoacpi may have problem\n");
 		return 1;

