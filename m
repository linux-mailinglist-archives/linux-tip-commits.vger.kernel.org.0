Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02645C710
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Nov 2021 15:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352801AbhKXOVH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Nov 2021 09:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353406AbhKXOSv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Nov 2021 09:18:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5800AC09DAE3;
        Wed, 24 Nov 2021 04:31:00 -0800 (PST)
Date:   Wed, 24 Nov 2021 12:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637757059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSm7vGID6XGog8OGq/Hd4JNcj1vsMae2g0URy7ld/R0=;
        b=HeEwxpR2rHVrKrIe5/K4ju2aXtYEGVHSdVlCRsznMGC3IKwdzGbVM2cQWQ53rLLAebBC2R
        vfX9n/mz/lCsB/GLVbH8N6o7vnpAbty2rIYugLJYlfTU4KZDa5aw4Woe2cK+6tPmuZxpM9
        BRgqzcgU1yT0m5udfhN5UbgVa0NwGoUcz3fL0t6bOoLyCtK8APKVBoZM1n/jANhYjirbmo
        e9UP46jne6yoPgDCnmKx4/B7HmT/hNpBrisdEO+Tx40/sptxKNWPcEQ+79REfjBlhIWWeF
        LGRGYq26h8kOENMNDGnzUle+17gRL28zzi3KLYSEiNuwWspnbon0UOPBizpxmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637757059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSm7vGID6XGog8OGq/Hd4JNcj1vsMae2g0URy7ld/R0=;
        b=kBcBIcCDAGDFZFMxP9WoPZuWFg68QfI9YNJH+BgmTQKRCL4F6qDxd/BC1sY3UBD0aSK+bR
        2w2saWghOEosfBAg==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/boot: Mark prepare_command_line() __init
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YZySgpmBcNNM2qca@zn.tnic>
References: <YZySgpmBcNNM2qca@zn.tnic>
MIME-Version: 1.0
Message-ID: <163775705801.11128.3487083142973026661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c0f2077baa4113f38f008b8e912b9fb3ff8d43df
Gitweb:        https://git.kernel.org/tip/c0f2077baa4113f38f008b8e912b9fb3ff8d43df
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Tue, 23 Nov 2021 08:04:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 24 Nov 2021 12:20:24 +01:00

x86/boot: Mark prepare_command_line() __init

Fix:

  WARNING: modpost: vmlinux.o(.text.unlikely+0x64d0): Section mismatch in reference \
   from the function prepare_command_line() to the variable .init.data:command_line
  The function prepare_command_line() references
  the variable __initdata command_line.
  This is often because prepare_command_line lacks a __initdata
  annotation or the annotation of command_line is wrong.

Apparently some toolchains do different inlining decisions.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YZySgpmBcNNM2qca@zn.tnic
---
 arch/x86/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c410be7..6a190c7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,7 +742,7 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
-static char *prepare_command_line(void)
+static char * __init prepare_command_line(void)
 {
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE
