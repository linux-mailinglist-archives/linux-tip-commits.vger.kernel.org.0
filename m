Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D5340E4F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhCRTer (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhCRTef (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:35 -0400
Date:   Thu, 18 Mar 2021 19:34:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyd+Djq4UlHTst5lHL4o+YTdeMzf9M7JW9UK6UHRpmo=;
        b=xERZasULvF7NIqlmY55FZ0y91sZFHi/wsJXD+ViKCeIKdjsaodv506oU+RXQXi88RuiCQe
        BpyQl1BrawEIKvlrvVhevndePX6DEwI78AwXhmnev3C2ckp/49wI8XdyK2TUPgFCxMzPbo
        274Z4yacQULYecUWiQEhY7CTOSpWv4CQOGFhN4Qt/E2pC9QMduT/xxoHOhrAf0xSzoAHKS
        S9/zMKWUa1EI75vQ6f+m+b+tmzwuveqpzNywWs0I1boPpoil0JL5eeO7kmpRqvOnggEBoM
        gpzU1U9165MYiofx3C/jJtDXI4WR6fFZtxftHOPHxeBspLfISH39AcbX6oZmnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xyd+Djq4UlHTst5lHL4o+YTdeMzf9M7JW9UK6UHRpmo=;
        b=o3C6V5C0zGqemXkIAqpIQbwo2VlqI55NWOO31UYBBlK7JSrNfNmucFeDqob8/eqGG4+FPe
        Pqk+u1swk7MKuSAQ==
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
Message-ID: <161609607306.398.2919629380735380401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     4fbe2c3b9dd04f44608d710ad2ae83d7f1c04182
Gitweb:        https://git.kernel.org/tip/4fbe2c3b9dd04f44608d710ad2ae83d7f1c04182
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Fri, 12 Mar 2021 13:38:24 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:59 +01:00

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
