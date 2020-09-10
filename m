Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56531264286
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 11:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgIJJis (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 05:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbgIJJWS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 05:22:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DC1C0613ED;
        Thu, 10 Sep 2020 02:22:14 -0700 (PDT)
Date:   Thu, 10 Sep 2020 09:22:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrY8M1+Z4n3RPHHGsPnEuPD5IhvzZjRmFIn2Iz8CVmc=;
        b=i/8MQUdjPREBFEKGGTw5SmOILdz932P4ZgvARUzp0zWMe23caB4CRBXnlJyVlG1N0n8VJF
        XiAvINuOzcjED0yaIJR+XGUXemWxVykTVi+3z+YffiFW0j5Nmi76mf5RCkIFp7ZOAkuRsH
        cX+kRimkBYDTaiEv2Yfz5vsdgUh7xz7MMI/9mQQU1Yf3LIvBAGo1L8+3Jr6s3Y9/Hq2Nb2
        EcmqR06L4dwpqG0J/emKs61NV1OPRA8SXEwtG65Nuou9nR9egdnm/X4Qrsum7CHlhfBxNn
        rGECzrwEeJtnL6VyhnNU9Lex2Lao1pLU9hiEzM4JCdYBXGd8vmK5wEcdf30D/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrY8M1+Z4n3RPHHGsPnEuPD5IhvzZjRmFIn2Iz8CVmc=;
        b=2R9sIrJjeXE00AJ5tvYp2Ol+GpIL1/nFZk4Y9nIh7Mezq1rv9FZ7v4l3D69uWR/1PEOt8W
        bEwgFGwe9v7AXADQ==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/kvm: Add KVM-specific VMMCALL handling under SEV-ES
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-64-joro@8bytes.org>
References: <20200907131613.12703-64-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972972598.20229.12880317872521101289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     99419b251e5427b89dbfae103d8a2f469efaa4b2
Gitweb:        https://git.kernel.org/tip/99419b251e5427b89dbfae103d8a2f469efaa4b2
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 07 Sep 2020 15:16:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Sep 2020 11:33:20 +02:00

x86/kvm: Add KVM-specific VMMCALL handling under SEV-ES

Implement the callbacks to copy the processor state required by KVM to
the GHCB.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
[ jroedel@suse.de: - Split out of a larger patch
                   - Adapt to different callback functions ]
Co-developed-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-64-joro@8bytes.org
---
 arch/x86/kernel/kvm.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 08320b0..0f95972 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -36,6 +36,8 @@
 #include <asm/hypervisor.h>
 #include <asm/tlb.h>
 #include <asm/cpuidle_haltpoll.h>
+#include <asm/ptrace.h>
+#include <asm/svm.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
 
@@ -746,13 +748,34 @@ static void __init kvm_init_platform(void)
 	x86_platform.apic_post_init = kvm_apic_init;
 }
 
+#if defined(CONFIG_AMD_MEM_ENCRYPT)
+static void kvm_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* RAX and CPL are already in the GHCB */
+	ghcb_set_rbx(ghcb, regs->bx);
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rdx(ghcb, regs->dx);
+	ghcb_set_rsi(ghcb, regs->si);
+}
+
+static bool kvm_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* No checking of the return state needed */
+	return true;
+}
+#endif
+
 const __initconst struct hypervisor_x86 x86_hyper_kvm = {
-	.name			= "KVM",
-	.detect			= kvm_detect,
-	.type			= X86_HYPER_KVM,
-	.init.guest_late_init	= kvm_guest_init,
-	.init.x2apic_available	= kvm_para_available,
-	.init.init_platform	= kvm_init_platform,
+	.name				= "KVM",
+	.detect				= kvm_detect,
+	.type				= X86_HYPER_KVM,
+	.init.guest_late_init		= kvm_guest_init,
+	.init.x2apic_available		= kvm_para_available,
+	.init.init_platform		= kvm_init_platform,
+#if defined(CONFIG_AMD_MEM_ENCRYPT)
+	.runtime.sev_es_hcall_prepare	= kvm_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish	= kvm_sev_es_hcall_finish,
+#endif
 };
 
 static __init int activate_jump_labels(void)
