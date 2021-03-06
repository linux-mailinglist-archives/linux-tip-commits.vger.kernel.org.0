Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993E032FA67
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 13:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCFMBM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 07:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCFMBB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 07:01:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D62C06174A;
        Sat,  6 Mar 2021 04:01:00 -0800 (PST)
Date:   Sat, 06 Mar 2021 12:00:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615032059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zECPSplBSNZdsm/OdC/wa6DIU88yUWrFmBdrisgu6gM=;
        b=sOJXWfyjt9YfMG3b7cUuiLgeOB8O5XuJRQXQPLTKUYwIVndaZ8eI6blW+XiSBTu5g+/TNl
        /kaMQPXkStd7cwiheWcSHa4MSeMl8kMoi0O5FZ1vmuLZQM4jE6A2gdt4DB4aORIb9fA7oO
        CGqVet882LBdmKotZ7pq+tq9xwoSLgY/Pvv/OGMSrkVtCBtqTAX5+w5e4053BYdBq5+sRp
        P+6F+4YsQclQ6KwNeAXWzOiEg0nm8nkkWVgNrleN/DRVx3E5Mjqs8zd84zYTvauF0zr6pT
        NUMg4NyHBrEoUw5t0RuNqo+vBJXDR4rLT1131iHt3mluk7m5WF5zHYH6YHF6Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615032059;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zECPSplBSNZdsm/OdC/wa6DIU88yUWrFmBdrisgu6gM=;
        b=Xit/Lt5QgtR5haIRVJXl70yBG/kKc+k4/ISz0oSpXCMqH+lxLDNZ20eH3Y89ONoYNc72MK
        ZxkIV4Zw+aPf2dAw==
From:   "tip-bot2 for Pu Wen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/hygon: Set __max_die_per_package on Hygon
Cc:     Pu Wen <puwen@hygon.cn>, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210302020217.1827-1-puwen@hygon.cn>
References: <20210302020217.1827-1-puwen@hygon.cn>
MIME-Version: 1.0
Message-ID: <161503205896.398.4716836736710504611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     59eca2fa1934de42d8aa44d3bef655c92ea69703
Gitweb:        https://git.kernel.org/tip/59eca2fa1934de42d8aa44d3bef655c92ea69703
Author:        Pu Wen <puwen@hygon.cn>
AuthorDate:    Tue, 02 Mar 2021 10:02:17 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:54:59 +01:00

x86/cpu/hygon: Set __max_die_per_package on Hygon

Set the maximum DIE per package variable on Hygon using the
nodes_per_socket value in order to do per-DIE manipulations for drivers
such as powercap.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
