Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8B32B0AD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352298AbhCCDjP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578593AbhCBPZZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 10:25:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207BCC06178C;
        Tue,  2 Mar 2021 07:08:56 -0800 (PST)
Date:   Tue, 02 Mar 2021 15:08:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614697734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuS1JAajLUcwXhI+KdoLBOQoNFpkk5UfoFrjQAZQVN4=;
        b=aI7LRuAT347YN/9wleQ2bOdPKIG4c2KPcsxRTemv/6cRmLCH/DStoRS1xfRMW0lf7wczRn
        kWnK52i/gWkWX2Os6Z11c7EqeEEIMwigNK6oEkGO8oZ5t8Tuo7dIYlRTg7WvrWP2w+O6tZ
        OMtayOlxOj2lDxLKbnok2SXqZuTJ2kg/NyilUyFkVWl/CuRcMCwLm8oWEDNVJA+QFby9ia
        vja8tRiuQfMk0NDqtWSlTVCEGBGFptBErE9ZAu0uVw+Ezhh/NeozKXrxJe4Qe++1UtXjMb
        enzADLpiNXxf7lnY8rxJwOpECajOsi6qSYxb71f2t3AB2bVDeL1KoF7SYwFLwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614697734;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuS1JAajLUcwXhI+KdoLBOQoNFpkk5UfoFrjQAZQVN4=;
        b=+vzt7HWLFL36YC8SW45NNWM6n5BUswfmC7rHWRdYbDIi7fa6ZDsMKNRrFxyQP+8Ef5CnwT
        liZ4jEcQNl4qzFCQ==
From:   "tip-bot2 for Pu Wen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/hygon: Set __max_die_per_package on Hygon
Cc:     Pu Wen <puwen@hygon.cn>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210302020217.1827-1-puwen@hygon.cn>
References: <20210302020217.1827-1-puwen@hygon.cn>
MIME-Version: 1.0
Message-ID: <161469773394.20312.2430395515863224708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     191d799ecaca4d5c7f87c624ae36581237ab8a87
Gitweb:        https://git.kernel.org/tip/191d799ecaca4d5c7f87c624ae36581237ab8a87
Author:        Pu Wen <puwen@hygon.cn>
AuthorDate:    Tue, 02 Mar 2021 10:02:17 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 02 Mar 2021 15:57:39 +01:00

x86/cpu/hygon: Set __max_die_per_package on Hygon

Set the maximum DIE per package variable on Hygon using the
nodes_per_socket value in order to do per-DIE manipulations for drivers
such as powercap.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210302020217.1827-1-puwen@hygon.cn
---
 arch/x86/kernel/cpu/hygon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ae59115..0bd6c74 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -215,12 +215,12 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 		u32 ecx;
 
 		ecx = cpuid_ecx(0x8000001e);
-		nodes_per_socket = ((ecx >> 8) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((ecx >> 8) & 7) + 1;
 	} else if (boot_cpu_has(X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		nodes_per_socket = ((value >> 3) & 7) + 1;
+		__max_die_per_package = nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
 	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
