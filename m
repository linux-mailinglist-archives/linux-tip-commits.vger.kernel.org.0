Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90D33C062
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhCOPsV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9476DC0613E0;
        Mon, 15 Mar 2021 08:47:53 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0CmfTMv32uKhuF8GgJu84FhSTRLRP/F+2E2DxWngC8=;
        b=FQRV5p3AU9kIT4WTSojIJXl0COKvbwlukq6vUvFy3StdxgVoy0F4bxcsZr8pYbcZoa3qOd
        kxws/Q+lXZoeFWTw7nzHEn/ySCMy5ATj86c3hFBp6+H9Ecc1mTC+v51XmncwHrQmLaLMS3
        +F5v3zZmmdsOk9N17bYMkYj7Aocju+nMppEAvb6n+07qbC0w2dwsEZLbHM7+rm2yGIJVfN
        Ftm6SYDfl4taAWIva4Km6IIntke4AKPmdododgY/7+1tGKWCpGN++vPI2HAW3lApvHftJl
        pIGZ9LxnD7aO5w6PSlicR6h/7Nv0DZhTWL131WI3a2RkPvN0QU08R/fLb86NZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823270;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K0CmfTMv32uKhuF8GgJu84FhSTRLRP/F+2E2DxWngC8=;
        b=4ZtAQ1LZtNIev0pMf4gBNwnVvINnhAhGvpA0zSCZL/iZPdHCRtOvXR2pmEajYEOt8wemv4
        sxWCrNA7fLYe+EDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/insn: Rename insn_decode() to insn_decode_from_regs()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-2-bp@alien8.de>
References: <20210304174237.31945-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326994.398.12589749659003414578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     9e761296c52dcdb1aaa151b65bd39accb05740d9
Gitweb:        https://git.kernel.org/tip/9e761296c52dcdb1aaa151b65bd39accb05740d9
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 02 Nov 2020 18:47:34 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 10:53:10 +01:00

x86/insn: Rename insn_decode() to insn_decode_from_regs()

Rename insn_decode() to insn_decode_from_regs() to denote that it
receives regs as param and uses registers from there during decoding.
Free the former name for a more generic version of the function.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-2-bp@alien8.de
---
 arch/x86/include/asm/insn-eval.h | 4 ++--
 arch/x86/kernel/sev-es.c         | 2 +-
 arch/x86/kernel/umip.c           | 2 +-
 arch/x86/lib/insn-eval.c         | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 98b4dae..91d7182 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -25,7 +25,7 @@ int insn_fetch_from_user(struct pt_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
 int insn_fetch_from_user_inatomic(struct pt_regs *regs,
 				  unsigned char buf[MAX_INSN_SIZE]);
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size);
+bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
+			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 225704e..a28922f 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -266,7 +266,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		if (!insn_decode(&ctxt->insn, ctxt->regs, buffer, res))
+		if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
 			return ES_DECODE_FAILED;
 	} else {
 		res = vc_fetch_insn_kernel(ctxt, buffer);
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index f6225bf..8032f5f 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -356,7 +356,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!nr_copied)
 		return false;
 
-	if (!insn_decode(&insn, regs, buf, nr_copied))
+	if (!insn_decode_from_regs(&insn, regs, buf, nr_copied))
 		return false;
 
 	umip_inst = identify_insn(&insn);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 8cec461..422a592 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1488,7 +1488,7 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
 }
 
 /**
- * insn_decode() - Decode an instruction
+ * insn_decode_from_regs() - Decode an instruction
  * @insn:	Structure to store decoded instruction
  * @regs:	Structure with register values as seen when entering kernel mode
  * @buf:	Buffer containing the instruction bytes
@@ -1501,8 +1501,8 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs, unsigned char buf[MAX_IN
  *
  * True if instruction was decoded, False otherwise.
  */
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size)
+bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
+			   unsigned char buf[MAX_INSN_SIZE], int buf_size)
 {
 	int seg_defs;
 
