Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3934BE7F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Mar 2021 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC1TP3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 28 Mar 2021 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhC1TO5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 28 Mar 2021 15:14:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B178C061756;
        Sun, 28 Mar 2021 12:14:57 -0700 (PDT)
Date:   Sun, 28 Mar 2021 19:14:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616958894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9A5lc1WoC3kflBmrgTZh6RBlAGESo5RzmR20p9Pc60o=;
        b=x6AvkTOsiEQgx3q9M7OXDg9fLCt5YDzWLFj5KH2yjniHCvVdHXxVECJ9i8807ENuS676WW
        O+wF7zsHZInZJgjkcxE6RJ2xXK4TB48hiKb8VizeyY/XoGqwdiELnqGnfUp4L/Lx9y3wmk
        R8vEqQTthtkHt6TtPtGApGZdDiSk2sSxUAgoCVQcSWvAn/+/5+TYpoI+KVpDdligsRaGbL
        H0Dtz273p5o2ZcWiCdvJEm+Y34Zd67WEb7fvONSIt5gNS2amGzvq35P3vO+A8UYHcsMqhZ
        9GIg+Bb4pabrOZwSgakevtxwgOQDC8H+mYx9qKUya2zB9Gz/8IINbZphI7m+yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616958894;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9A5lc1WoC3kflBmrgTZh6RBlAGESo5RzmR20p9Pc60o=;
        b=kF/DupYeM/p8Ltjaw2xkcvRoTve5KfHOOpN/TPYoke5IFYBvF1vDrdB8tjlI0Gr1sbYv2w
        4MXeqBCRfVuRunBA==
From:   "tip-bot2 for Alexey Makhalov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/vmware] x86/vmware: Avoid TSC recalibration when frequency is known
Cc:     Alexey Makhalov <amakhalov@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210105004752.131069-1-amakhalov@vmware.com>
References: <20210105004752.131069-1-amakhalov@vmware.com>
MIME-Version: 1.0
Message-ID: <161695889422.398.4252650912091762671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/vmware branch of tip:

Commit-ID:     0b4a285e2c65c2c9449c6eccb87298e385213e7b
Gitweb:        https://git.kernel.org/tip/0b4a285e2c65c2c9449c6eccb87298e385213e7b
Author:        Alexey Makhalov <amakhalov@vmware.com>
AuthorDate:    Mon, 04 Jan 2021 16:47:52 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 28 Mar 2021 21:11:43 +02:00

x86/vmware: Avoid TSC recalibration when frequency is known

When the TSC frequency is known because it is retrieved from the
hypervisor, skip TSC refined calibration by setting X86_FEATURE_TSC_KNOWN_FREQ.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210105004752.131069-1-amakhalov@vmware.com

---
 arch/x86/kernel/cpu/vmware.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c6ede3b..8316411 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -378,6 +378,8 @@ static void __init vmware_set_capabilities(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	if (vmware_tsc_khz)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
