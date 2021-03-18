Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1060934102F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhCRWKU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 18:10:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCRWKS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 18:10:18 -0400
Date:   Thu, 18 Mar 2021 22:10:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616105417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVktZ3Po6IaGFDwIIT4G7sFrCrYKd8Lnk+zzea+a/GY=;
        b=KJ8aNcTAR4Mb6HvIovndDXTCj+lokYoQ7AZXlEkU5kiZs0YbuWZRLGpUIknu83hOlU7Gad
        G+3RVvLvkswLRJG7EfRRRwelXEWUA/RL3LdICK0o7y5izLhIWVWF0QZkCXUeg7PMwVHiZ7
        9yYJ7106fV7kG114Bf/7ji9dQtelEXPI18HvG5G5AAVwST6Dvdkt63TQsSp2XndIFC4ibR
        zdBUdtdvG23+H7KXwkDjdID59+eR1I8sRJ9Djwi5HqNxy0+ogGOTMnxkeq7vHcGGpdInDL
        +8HYlrKAJ/KYOq/yVxOAO7XXpr1z/Xzmd9J5KQZ26mRQL3PCZ+Y8HbTBlWBtqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616105417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVktZ3Po6IaGFDwIIT4G7sFrCrYKd8Lnk+zzea+a/GY=;
        b=32viNwUwTUqm1KuB7a/Con4ckv6EdAeqM8dvZBzRzvOsuq/N7Mqiow8lpTlO5XD0bADEhF
        PyGqWQb/HQB8nvDQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Replace open-coded hlt-loops with
 sev_es_terminate()
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-9-joro@8bytes.org>
References: <20210312123824.306-9-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161610541666.398.1516398143382800722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     f15a0a732aefb46f999c2a8aa8f9f16e71cec5b2
Gitweb:        https://git.kernel.org/tip/f15a0a732aefb46f999c2a8aa8f9f16e71cec5b2
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 12 Mar 2021 13:38:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 23:04:12 +01:00

x86/sev-es: Replace open-coded hlt-loops with sev_es_terminate()

There are a few places left in the SEV-ES C code where hlt loops and/or
terminate requests are implemented. Replace them all with calls to
sev_es_terminate().

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-9-joro@8bytes.org
---
 arch/x86/boot/compressed/sev-es.c | 12 +++---------
 arch/x86/kernel/sev-es-shared.c   | 10 +++-------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 27826c2..d904bd5 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -200,14 +200,8 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 	}
 
 finish:
-	if (result == ES_OK) {
+	if (result == ES_OK)
 		vc_finish_insn(&ctxt);
-	} else if (result != ES_RETRY) {
-		/*
-		 * For now, just halt the machine. That makes debugging easier,
-		 * later we just call sev_es_terminate() here.
-		 */
-		while (true)
-			asm volatile("hlt\n");
-	}
+	else if (result != ES_RETRY)
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
 }
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
index 387b716..0aa9f13 100644
--- a/arch/x86/kernel/sev-es-shared.c
+++ b/arch/x86/kernel/sev-es-shared.c
@@ -24,7 +24,7 @@ static bool __init sev_es_check_cpu_features(void)
 	return true;
 }
 
-static void sev_es_terminate(unsigned int reason)
+static void __noreturn sev_es_terminate(unsigned int reason)
 {
 	u64 val = GHCB_SEV_TERMINATE;
 
@@ -206,12 +206,8 @@ void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
 	return;
 
 fail:
-	sev_es_wr_ghcb_msr(GHCB_SEV_TERMINATE);
-	VMGEXIT();
-
-	/* Shouldn't get here - if we do halt the machine */
-	while (true)
-		asm volatile("hlt\n");
+	/* Terminate the guest */
+	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
 }
 
 static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
