Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9D33C065
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 16:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhCOPs2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhCOPsB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 11:48:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B5C0613DA;
        Mon, 15 Mar 2021 08:47:52 -0700 (PDT)
Date:   Mon, 15 Mar 2021 15:47:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXePGGUlv2ty27Rqyo48ydo0GX/k8qYIrI8v7pLKKVo=;
        b=Sf9hMfz6Qyzhp4FwecAYX5mVJTMQsDiw1lsuQKaQSadssQG4klLxdL1PFwIsPD4zulQF/5
        kyDS9pN0tq1ohacsQaMFbDkSEOkF974UeHD7xE5/0qgohgze52TT/tcZGy1yl+xh4iBOQR
        WZD70VufCaqtQCEVpQlGB1+tEAQUsBE/j78JALtRgRAPrs3LBgwMP3HPZ3/otVwQiv+Gyd
        W++JkNGBZtr7PVDYT7Sz8c9i0ysMQNybtn73/I13hC9DyTS+xk4Nk61gnrjOznikoqJIx8
        EbkbML1AL0ClnZyaf9dxRhOyHNrGElFOVe3QWbCFvTCo8m3B46NBC8//GqhMmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615823267;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RXePGGUlv2ty27Rqyo48ydo0GX/k8qYIrI8v7pLKKVo=;
        b=OR+LXp5Xvnwa3YhTZS6LZw9w7eQx33MZp7cCiqZ9TB22VZrTY/m05Iv0KaLl/CHo73ZyfC
        Lg3r4kZj3DRAiuDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Convert to insn_decode()
Cc:     Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210304174237.31945-12-bp@alien8.de>
References: <20210304174237.31945-12-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <161582326705.398.15278107484568098311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     77e768ec1391dc0d6cd89822aa60b9a1c1bd8128
Gitweb:        https://git.kernel.org/tip/77e768ec1391dc0d6cd89822aa60b9a1c1bd8128
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 16 Nov 2020 18:10:11 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Mar 2021 11:28:20 +01:00

x86/kprobes: Convert to insn_decode()

Simplify code, improve decoding error checking.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20210304174237.31945-12-bp@alien8.de
---
 arch/x86/kernel/kprobes/core.c | 17 +++++++++++------
 arch/x86/kernel/kprobes/opt.c  |  9 +++++++--
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index df776cd..60a540f 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -265,6 +265,8 @@ static int can_probe(unsigned long paddr)
 	/* Decode instructions */
 	addr = paddr - offset;
 	while (addr < paddr) {
+		int ret;
+
 		/*
 		 * Check if the instruction has been modified by another
 		 * kprobe, in which case we replace the breakpoint by the
@@ -276,8 +278,10 @@ static int can_probe(unsigned long paddr)
 		__addr = recover_probed_instruction(buf, addr);
 		if (!__addr)
 			return 0;
-		kernel_insn_init(&insn, (void *)__addr, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+
+		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
+		if (ret < 0)
+			return 0;
 
 		/*
 		 * Another debugging subsystem might insert this breakpoint.
@@ -301,8 +305,8 @@ static int can_probe(unsigned long paddr)
 int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 {
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	unsigned long recovered_insn =
-		recover_probed_instruction(buf, (unsigned long)src);
+	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src);
+	int ret;
 
 	if (!recovered_insn || !insn)
 		return 0;
@@ -312,8 +316,9 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 			MAX_INSN_SIZE))
 		return 0;
 
-	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
-	insn_get_length(insn);
+	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
+		return 0;
 
 	/* We can not probe force emulate prefixed instruction */
 	if (insn_has_emulate_prefix(insn))
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 08eb230..4299fc8 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -312,6 +312,8 @@ static int can_optimize(unsigned long paddr)
 	addr = paddr - offset;
 	while (addr < paddr - offset + size) { /* Decode until function end */
 		unsigned long recovered_insn;
+		int ret;
+
 		if (search_exception_tables(addr))
 			/*
 			 * Since some fixup code will jumps into this function,
@@ -321,8 +323,11 @@ static int can_optimize(unsigned long paddr)
 		recovered_insn = recover_probed_instruction(buf, addr);
 		if (!recovered_insn)
 			return 0;
-		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+
+		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
+		if (ret < 0)
+			return 0;
+
 		/*
 		 * In the case of detecting unknown breakpoint, this could be
 		 * a padding INT3 between functions. Let's check that all the
