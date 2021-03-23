Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67529346296
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhCWPPZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbhCWPPM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:15:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17228C061574;
        Tue, 23 Mar 2021 08:15:12 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:15:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5f+JtearIqagJ1GzYNc6HBNnuwqttJZd1Nb7+jvtuU=;
        b=2Mo7Dxh8Ql+GW+9HUJ03Bn9DCfOinilRo0168v0xoRCJOxnoapzMvHOlNiXTOWqJeW0RTm
        ZbTzGd3rqMbb4mtKuz36L4xhOz5Ad4WK6f2F371RpgARJeM2PI9vjIr10LCOpakRypeD1P
        iUXjFGZ8l5t8K1OBjHGkHzse4cd7P2wXnzgPZStQMsC/cq+QzsHoY9+q83BhGfTJXVSPY0
        x51qMkvmrNE6T3Zfv61vHdksiQ6Lw7E+tOBh8A43OI2ltY6R78Fx+XQgiyBjMNfq1SS0BX
        WYXLs5nVpI7HVYoslwRpDO9OfnsE813GB7TPDbqP+Bwne0lfWT/PYBlz8P/ZXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512510;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5f+JtearIqagJ1GzYNc6HBNnuwqttJZd1Nb7+jvtuU=;
        b=xIuwY5mysWhTNRPOwfA+qMDmUcPiY/ZO3oH9xc+KZaGwrldYe9OWHJ8p1EyKrID15F69ZN
        Y3H2GCoXE52T5UCA==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Retrieve correct opcode for group instruction
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <161469872400.49483.18214724458034233166.stgit@devnote2>
References: <161469872400.49483.18214724458034233166.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <161651250981.398.14785132555334741464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     d60ad3d46f1d04a282c56159f1deb675c12733fd
Gitweb:        https://git.kernel.org/tip/d60ad3d46f1d04a282c56159f1deb675c12733fd
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Wed, 03 Mar 2021 00:25:24 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:07:55 +01:00

x86/kprobes: Retrieve correct opcode for group instruction

Since the opcodes start from 0xff are group5 instruction group which is
not 2 bytes opcode but the extended opcode determined by the MOD/RM byte.

The commit abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
used insn->opcode.bytes[1], but that is not correct. We have to refer
the insn->modrm.bytes[1] instead.

Fixes: abd82e533d88 ("x86/kprobes: Do not decode opcode in resume_execution()")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/161469872400.49483.18214724458034233166.stgit@devnote2
---
 arch/x86/kernel/kprobes/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 60a540f..9b31790 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -453,7 +453,11 @@ static void set_resume_flags(struct kprobe *p, struct insn *insn)
 		break;
 #endif
 	case 0xff:
-		opcode = insn->opcode.bytes[1];
+		/*
+		 * Since the 0xff is an extended group opcode, the instruction
+		 * is determined by the MOD/RM byte.
+		 */
+		opcode = insn->modrm.bytes[0];
 		if ((opcode & 0x30) == 0x10) {
 			/*
 			 * call absolute, indirect
