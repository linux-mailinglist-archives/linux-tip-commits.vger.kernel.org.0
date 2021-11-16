Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728D24535E1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbhKPPgV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Nov 2021 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238321AbhKPPgR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Nov 2021 10:36:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA69AC061746;
        Tue, 16 Nov 2021 07:33:18 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:33:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637076796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yqbl9+ljUBLTmz57R77zWZvNAOoMzZVSFiM72yywurc=;
        b=fir7wP6WejSyQkkZPbmMihZK3D2qbDPYGD6Pe03+6VRkkdYaRUzfaufPetIBnhz1Hk/bzu
        h9BEtaR+cuyoUh0/ZDVPX/JKwGOBTLvz7PQZPz+hdTFlDXfZ48RG2xguEL+40IGdKbkycq
        PAwhLofYMNA6nVXdK2OHv3fAhzU1rBn+1NdYO0yyrqosVhmMuQFwcY24FmH+wk0fAJyaQe
        AS3jUXGvbOvXo+F88ydb1r6nRgbOS9NXKRMhyQ1EvbzB3nH2uhsAR6fsd/stxXNlbKlg7g
        fLqlpG44+jDDxRsbTnMeB14E5DUHZ5nVOmlwYY0ARXZJe9AJYX6N49iG2DBt2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637076796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yqbl9+ljUBLTmz57R77zWZvNAOoMzZVSFiM72yywurc=;
        b=ta97Zmu84OV4B7fhfcRuD6yhTIONGxI9ybehkyjWmCA1THU7NdcNqpbaQSA1wU3pklixni
        bXkpUseftIxL/wBA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Remove do_early_exception() forward declarations
Cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110220731.2396491-8-brijesh.singh@amd.com>
References: <20211110220731.2396491-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <163707679484.414.2422536732632230838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     75cc9a84c9eb36e436e3fcee5158fe31d1dfd78f
Gitweb:        https://git.kernel.org/tip/75cc9a84c9eb36e436e3fcee5158fe31d1dfd78f
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 10 Nov 2021 16:06:53 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 21:06:33 +01:00

x86/sev: Remove do_early_exception() forward declarations

There's a perfectly fine prototype in the asm/setup.h header. Use it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211110220731.2396491-8-brijesh.singh@amd.com
---
 arch/x86/kernel/sev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 0a6c82e..03f9aff 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -26,6 +26,7 @@
 #include <asm/fpu/xcr.h>
 #include <asm/processor.h>
 #include <asm/realmode.h>
+#include <asm/setup.h>
 #include <asm/traps.h>
 #include <asm/svm.h>
 #include <asm/smp.h>
@@ -86,9 +87,6 @@ struct ghcb_state {
 static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static __always_inline bool on_vc_stack(struct pt_regs *regs)
 {
 	unsigned long sp = regs->sp;
@@ -209,9 +207,6 @@ static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
 	return ghcb;
 }
 
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
 static inline u64 sev_es_rd_ghcb_msr(void)
 {
 	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
