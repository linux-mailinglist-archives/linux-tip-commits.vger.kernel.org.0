Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D212F2DEC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Jan 2021 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbhALLai (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 06:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbhALLai (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 06:30:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0116C061575;
        Tue, 12 Jan 2021 03:29:57 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:29:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610450996;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91oTihXoxU68dbzytY74015PUJ/bpJqMktPoYOT9K74=;
        b=zY/ge/7G6Q+ij/oTcUlPJFzfBjDWbL2G9nAciNwxTPQF4Nn5hQ+8VMgkd4pkH3Oitj6JxR
        Vq+JQSiUs5l5NH62nPVraazjd39vkZdh8Iki71bFvgC+DXWPlnoK2aKQS/XwCQgy4ufG6r
        u7tzUpgEIX1qXENP2Byz7aLSML8Lvt/iILHyL1U9aQtIXFBvcbbULgoXnX8tLQkE8WEJdx
        JP+GOK0hL449YTWhlEcdokYyaDmobGtfq6ZgNbykctfmqajFuHyp2+ksjczBz+UMLC3js+
        8b3H1J3cpawzFcYYWWPSU8PICt70PTE8mCjJaTQPrAzN7Gi9bdifNw7r2jqVzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610450996;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91oTihXoxU68dbzytY74015PUJ/bpJqMktPoYOT9K74=;
        b=2HQ7IRN86X9hjkWb+cnS45poCdYNYjwrzy8WnNDJLuXNniVfklfh1OrjnuulMQXakNu3Bc
        u2pZW2QWHsIZNxCw==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu/amd: Set __max_die_per_package on AMD
Cc:     Johnathan Smithinovic <johnathan.smithinovic@gmx.at>,
        Rafael Kitover <rkitover@gmail.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210106112106.GE5729@zn.tnic>
References: <20210106112106.GE5729@zn.tnic>
MIME-Version: 1.0
Message-ID: <161045099499.414.11674184748143438343.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     76e2fc63ca40977af893b724b00cc2f8e9ce47a4
Gitweb:        https://git.kernel.org/tip/76e2fc63ca40977af893b724b00cc2f8e9ce47a4
Author:        Yazen Ghannam <Yazen.Ghannam@amd.com>
AuthorDate:    Mon, 11 Jan 2021 11:04:29 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 12 Jan 2021 12:21:01 +01:00

x86/cpu/amd: Set __max_die_per_package on AMD

Set the maximum DIE per package variable on AMD using the
NodesPerProcessor topology value. This will be used by RAPL, among
others, to determine the maximum number of DIEs on the system in order
to do per-DIE manipulations.

 [ bp: Productize into a proper patch. ]

Fixes: 028c221ed190 ("x86/CPU/AMD: Save AMD NodeId as cpu_die_id")
Reported-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Reported-by: Rafael Kitover <rkitover@gmail.com>
Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Johnathan Smithinovic <johnathan.smithinovic@gmx.at>
Tested-by: Rafael Kitover <rkitover@gmail.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=210939
Link: https://lkml.kernel.org/r/20210106112106.GE5729@zn.tnic
Link: https://lkml.kernel.org/r/20210111101455.1194-1-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index f8ca66f..347a956 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -542,12 +542,12 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
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
