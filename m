Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3533C06A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhCOPs2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37098C0613DC;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JysWEgGNxZmTPSs5p1SH0XF7H+/jU5T93HG7m9N1fiw=;
        b=TybDYXjjSDrufbTZSzI0HekVa07d5Ojiv6eBd5XbYic6d5AUsVpLyzBGJA5vhkFoVpd6w+
        hnsOaZByXB0WdZHq3Dn3QrCWjVoqeveSgjfZoo5LDvpc0nH63RmqR0voWpCiPFfVOzcRG9
        mvJINJkTkhcy6svUjOK5D7YBuKVkOPRF3yIIxE9fMMf56dXACCCD965qJoovcmn2o2sqy/
        +KY7rVrmp6AqsXd8QtAm/X2qJWfMQQYEA48yVpRhHYezpciFb0EnWAL7BMsE0lgpg4dhOO
        n67HtJUJ4+BOuGGJCeCGli6RwkIjsJa37IVmb+4RbCvttQpagdzzCeByfeUzpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JysWEgGNxZmTPSs5p1SH0XF7H+/jU5T93HG7m9N1fiw=;
        b=bl1c26E2cvQp/Te6ie+8kqPhPDRmJBl/IvVyAWjtKtetDEFmAJp/5hjrB140gOtuOT+K+m
        qlZ64wpPy6/HVpCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/mce: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-11-bp@alien8.de>
References: <20210304174237.31945-11-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326730.398.9244226257511278413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1580f488ea8c6a62d002be364248c34c2f2e430b
Gitweb:        https://git.kernel.org/tip/1580f488ea8c6a62d002be364248c34c2f2e430b
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Fri, 06 Nov 2020 19:39:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:26:40 +01:00

x86/mce: Convert to insn_decode()

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210304174237.31945-11-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/severity.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991..a2136ce 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -218,15 +218,15 @@ static struct severity {
 static bool is_copy_from_user(struct pt_regs *regs)
 {
 	u8 insn_buf[MAX_INSN_SIZE];
-	struct insn insn;
 	unsigned long addr;
+	struct insn insn;
+	int ret;
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
 		return false;
 
 	switch (insn.opcode.value) {
@@ -234,10 +234,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	case 0x8A: case 0x8B:
 	/* MOVZ mem,reg */
 	case 0xB60F: case 0xB70F:
-		insn_get_modrm(&insn);
-		insn_get_sib(&insn);
-		if (!insn.modrm.got || !insn.sib.got)
-			return false;
 		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 		break;
 	/* REP MOVS */
