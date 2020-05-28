Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEE1E5CC2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 May 2020 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgE1KNa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 May 2020 06:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbgE1KNa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 May 2020 06:13:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDDBC05BD1E;
        Thu, 28 May 2020 03:13:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jeFXT-0003o0-Ob; Thu, 28 May 2020 12:13:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 53C501C0051;
        Thu, 28 May 2020 12:13:27 +0200 (CEST)
Date:   Thu, 28 May 2020 10:13:27 -0000
From:   "tip-bot2 for Wei Liu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/hyperv: Use the correct target for alloc_intr_gate()
Cc:     Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C20200527120918=2Ely5vuhvxzqesdt6j=40liuwe-devbox-d?=
 =?utf-8?q?ebian-v2=2Ej3c5onc20sse1dnehy4noqpfcg=2Ezx=2Einternal=2Ecloud?=
 =?utf-8?q?app=2Enet=3E?=
References: =?utf-8?q?=3C20200527120918=2Ely5vuhvxzqesdt6j=40liuwe-devbox-de?=
 =?utf-8?q?bian-v2=2Ej3c5onc20sse1dnehy4noqpfcg=2Ezx=2Einternal=2Eclouda?=
 =?utf-8?q?pp=2Enet=3E?=
MIME-Version: 1.0
Message-ID: <159066080714.17951.8989624032770050231.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     4bcffde74b6a2ba992a0617bb6b9be054e7f89a2
Gitweb:        https://git.kernel.org/tip/4bcffde74b6a2ba992a0617bb6b9be054e7f89a2
Author:        Wei Liu <wei.liu@kernel.org>
AuthorDate:    Wed, 27 May 2020 12:09:18 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 28 May 2020 12:01:24 +02:00

x86/hyperv: Use the correct target for alloc_intr_gate()

The idtentry rework causes a boot crash, by erroneously using the C entry
point to allocate the interrupt gate for the HYPERVISOR_CALLBACK_VECTOR.

Use the ASM entry point to cure this.

[ tglx: Changelog as it was too late to fold in ]

Fixes: 824ad0f5f390 ("x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC")
Reported-by: Boqun Feng <boqun.feng@gmail.com> 
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Boqun Feng <boqun.feng@gmail.com> 
Link: https://lkml.kernel.org/r/20200527120918.ly5vuhvxzqesdt6j@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net


---
 arch/x86/kernel/cpu/mshyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index a103e1c..af94f05 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -327,7 +327,7 @@ static void __init ms_hyperv_init_platform(void)
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
 	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
+	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
 
 	/* Setup the IDT for reenlightenment notifications */
 	if (ms_hyperv.features & HV_X64_ACCESS_REENLIGHTENMENT) {
