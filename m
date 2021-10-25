Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2C43921F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Oct 2021 11:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhJYJQx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 25 Oct 2021 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhJYJQw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 25 Oct 2021 05:16:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31358C061745;
        Mon, 25 Oct 2021 02:14:30 -0700 (PDT)
Date:   Mon, 25 Oct 2021 09:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635153258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz7K7AaPZk3bWb2+JOVzqJv7KOaHKmIFauAD1w7CMB8=;
        b=ceao6+j/PEuYCTGgpGRPj6LVlp/P7/ZucOrSwqwd6KL2nQeMiD3LW6XWjYsRPEDEt1wjD4
        aoLK2IiXXJHamGzTWkQdKwp0qF6sQDiU+ja5rvz8stbsHI4seV/5cSw3IcjUn3pzVzDexS
        FeAzz+6ERvUwrM92lq9jVtSY3GUW9dakEKtsU6VR3VNaz7RxNmuhA39JUNRc8/hReuDIiA
        SDQj0gROrnSB/JOC/zw1HDAfjsD7OjOrVJYlI4uZmZ4MKF93jMBK9v5Yjryvy8ziKi3iaI
        NoH8xKlKt6Y6BdzKZ2uPNPMqKTvup2/MJL8Szjzql9yNPpJCdwKndWtzNAx0/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635153258;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gz7K7AaPZk3bWb2+JOVzqJv7KOaHKmIFauAD1w7CMB8=;
        b=kItfxv41HYYLeXo5vKUqvxJFiVdtNTMGwZFsnU8koWVOd5/ADUrRtp7YmtL3r+lDInIuFw
        Gbpx2QWDKlOm2dCg==
From:   "tip-bot2 for Rob Herring" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/of: Kill unused early_init_dt_scan_chosen_arch()
Cc:     Rob Herring <robh@kernel.org>, Borislav Petkov <bp@suse.de>,
        Frank Rowand <frank.rowand@sony.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211022164642.2815706-1-robh@kernel.org>
References: <20211022164642.2815706-1-robh@kernel.org>
MIME-Version: 1.0
Message-ID: <163515325718.626.9514246389734008198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     f2739ca15c414ebad88f4333e3186fd4144c1753
Gitweb:        https://git.kernel.org/tip/f2739ca15c414ebad88f4333e3186fd4144c1753
Author:        Rob Herring <robh@kernel.org>
AuthorDate:    Fri, 22 Oct 2021 11:46:42 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 25 Oct 2021 10:56:37 +02:00

x86/of: Kill unused early_init_dt_scan_chosen_arch()

There are no callers for early_init_dt_scan_chosen_arch(), so remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Link: https://lkml.kernel.org/r/20211022164642.2815706-1-robh@kernel.org
---
 arch/x86/kernel/devicetree.c | 5 -----
 include/linux/of_fdt.h       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 6a4cb71..78b2311 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -31,11 +31,6 @@ char __initdata cmd_line[COMMAND_LINE_SIZE];
 
 int __initdata of_ioapic;
 
-void __init early_init_dt_scan_chosen_arch(unsigned long node)
-{
-	BUG();
-}
-
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
 	BUG();
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index cf6a65b..cf48983 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -65,7 +65,6 @@ extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
-extern void __init early_init_dt_scan_chosen_arch(unsigned long node);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
 extern u64 dt_mem_next_cell(int s, const __be32 **cellp);
 
