Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CC3348E8E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 12:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCYLJQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCYLIu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 07:08:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A836C06174A;
        Thu, 25 Mar 2021 04:08:50 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:08:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616670528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv0wg4BBDtIp0Fhlk8BfonH9lmiGYRhu8FrQlcso514=;
        b=Axp7VeHNQggxWis0fjI9tUoKq5/KNkSz/bsFA9LpC1Ppxe1m2TvxEff45fJUUI9LVTaPP7
        GXxInFqETjDLOhJba5TI3ygjjQ6Nqk7Bt6IsFDl4NQWQWWszFsIJMdn4ykGZ8hshltA5RA
        RVX38efsRqxsfH++CywE7gh43QarwjbyTHaLhgm/BWDM+3Qv6X/fkkUSwsSJttnBJcVTjh
        uyaJwfpkKOaDbMGLf2CC9HwCnBXk8BybVcmexwkKVO/SaQdgXeDP+gqNYIBgLO3TvUBhP3
        0bd9eU4+P20sGcx/rqXhDoGzOMMDPLzQm8Lyc7B51/Bg7Fhxuzq17KuLrgsNpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616670528;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yv0wg4BBDtIp0Fhlk8BfonH9lmiGYRhu8FrQlcso514=;
        b=BznofWAAp3vlS/8enblG43YyxDI6MuddKT9vrN7CN3bctO+BxSaPl5pKZxS2SJGR4X0Ibr
        ltcF4jMM0ecujQAg==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Fix to check non boostable prefixes correctly
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <161666691162.1120877.2808435205294352583.stgit@devnote2>
References: <161666691162.1120877.2808435205294352583.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <161667052824.398.11248339831534465911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     6dd3b8c9f58816a1354be39559f630cd1bd12159
Gitweb:        https://git.kernel.org/tip/6dd3b8c9f58816a1354be39559f630cd1bd12159
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Thu, 25 Mar 2021 19:08:31 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 11:37:21 +01:00

x86/kprobes: Fix to check non boostable prefixes correctly

There are 2 bugs in the can_boost() function because of using
x86 insn decoder. Since the insn->opcode never has a prefix byte,
it can not find CS override prefix in it. And the insn->attr is
the attribute of the opcode, thus inat_is_address_size_prefix(
insn->attr) always returns false.

Fix those by checking each prefix bytes with for_each_insn_prefix
loop and getting the correct attribute for each prefix byte.
Also, this removes unlikely, because this is a slow path.

Fixes: a8d11cd0714f ("kprobes/x86: Consolidate insn decoder users for copying code")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/161666691162.1120877.2808435205294352583.stgit@devnote2
---
 arch/x86/kernel/kprobes/core.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 3a14e8a..81e1432 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -139,6 +139,8 @@ NOKPROBE_SYMBOL(synthesize_relcall);
 int can_boost(struct insn *insn, void *addr)
 {
 	kprobe_opcode_t opcode;
+	insn_byte_t prefix;
+	int i;
 
 	if (search_exception_tables((unsigned long)addr))
 		return 0;	/* Page fault may occur on this address. */
@@ -151,9 +153,14 @@ int can_boost(struct insn *insn, void *addr)
 	if (insn->opcode.nbytes != 1)
 		return 0;
 
-	/* Can't boost Address-size override prefix */
-	if (unlikely(inat_is_address_size_prefix(insn->attr)))
-		return 0;
+	for_each_insn_prefix(insn, i, prefix) {
+		insn_attr_t attr;
+
+		attr = inat_get_opcode_attribute(prefix);
+		/* Can't boost Address-size override prefix and CS override prefix */
+		if (prefix == 0x2e || inat_is_address_size_prefix(attr))
+			return 0;
+	}
 
 	opcode = insn->opcode.bytes[0];
 
@@ -181,8 +188,8 @@ int can_boost(struct insn *insn, void *addr)
 		/* indirect jmp is boostable */
 		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
 	default:
-		/* CS override prefix and call are not boostable */
-		return (opcode != 0x2e && opcode != 0x9a);
+		/* call is not boostable */
+		return opcode != 0x9a;
 	}
 }
 
