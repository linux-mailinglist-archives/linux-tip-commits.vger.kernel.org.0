Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C25533C06C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhCOPs3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EBFC0613D8;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5MJVLEDsCKECrPwl9wk0j94a+XSQfKGHPqaRMUuIGU=;
        b=g2qv8lXTbZB4zDP4AeGwvkaYw1Uej003BXbp7/C2FdfER74Q8IEueQCmziPag28kYJoXRq
        cJV0DOaPaVyd9qAnZMgXaxHmMviZyJpKnwMj48y4toDBF3WtME+S0OCzukofWE4NCrFAH6
        w6shsC7VQ1+ZMsJgNB3QITC+RY+pXOLgWCx29B3OaSoBZSOZo2eD3bI1cpQtFVcS3wa9St
        6GafLxXgByIXifpFL0utltsmaWKSFsLu9d8xFgJ12O+68G9dyySSkJpyZ2JgMbzAWxxSpb
        ik4LRVSbC1f2KM4lXbKPrLRNLG32XM5hR5Ynh5xGUWm7iAnbM/s/MeMubKCstA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5MJVLEDsCKECrPwl9wk0j94a+XSQfKGHPqaRMUuIGU=;
        b=TMWCxqHv4oQeb2A/YL+V6V3Qpu0EeqTekdVwz55ihxzTyE2uzcmejXMEtvq/A7S2hGjGDY
        KgsZnFxzPGO9neCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/traps: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-15-bp@alien8.de>
References: <20210304174237.31945-15-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326607.398.14914389363532335153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0be7f42d6fcce111f487283d596594c6da6588b0
Gitweb:        https://git.kernel.org/tip/0be7f42d6fcce111f487283d596594c6da6588b0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 16 Nov 2020 18:38:45 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 12:00:18 +01:00

x86/traps: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-15-bp@alien8.de
---
 arch/x86/kernel/traps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index ac1874a..0da8d2a 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -498,14 +498,15 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
 {
 	u8 insn_buf[MAX_INSN_SIZE];
 	struct insn insn;
+	int ret;
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip,
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_modrm(&insn);
-	insn_get_sib(&insn);
+	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
+		return GP_NO_HINT;
 
 	*addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 	if (*addr == -1UL)
