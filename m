Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3A02B9106
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 12:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKSL3h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 06:29:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33140 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKSL3h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 06:29:37 -0500
Date:   Thu, 19 Nov 2020 11:29:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605785374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IbIY711Yov0ynCmz278dJB7zr5YzcSUsZdu5gG3GUU=;
        b=O55ZQlWpa7+XC23gT/tpTf5SnT/LN0dj5CBIRfr5Vvk6M0Is23c4UgnJYmydOrzjTOr68O
        wlKcOsPng4o1BrwSBKw0aT/3aUz8sh2eSAvli/ogcCnSJ4WBOGmEex9xup6fwMLJ8ETl+6
        IyDrYg+jfrtjvybildT6Q8A2fdm5MPKsy186HChgB7VXYuhIssaxbYaat/sJZ3QG3z40eK
        G+0Kms4oHgNyX+Cw1YlNT7wnswwD/D4Ou1JKzkQaC00/9mYUZWIzkpUKL9nA4gkFWNz286
        4HpATGmtdIsexmoo1qVr4htWbsGMDpgyE5ctiAezl+xr4wfB2N2M+o0oLJSnMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605785374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/IbIY711Yov0ynCmz278dJB7zr5YzcSUsZdu5gG3GUU=;
        b=s82rg+SDGSMEe4CGOzzrzkimZA+Nt4ScsPn1RRXEi5tmxkxiRQjZuV/HIfsLM3dzOGdhPo
        JnuFnw0HI8QUjWCA==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/topology: Set cpu_die_id only if DIE_TYPE found
Cc:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201109210659.754018-5-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-5-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <160578537324.11244.15863097690045322196.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     cb09a379724d299c603a7a79f444f52a9a75b8d2
Gitweb:        https://git.kernel.org/tip/cb09a379724d299c603a7a79f444f52a9a75b8d2
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 09 Nov 2020 21:06:59 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 11:43:25 +01:00

x86/topology: Set cpu_die_id only if DIE_TYPE found

CPUID Leaf 0x1F defines a DIE_TYPE level (nb: ECX[8:15] level type == 0x5),
but CPUID Leaf 0xB does not. However, detect_extended_topology() will
set struct cpuinfo_x86.cpu_die_id regardless of whether a valid Die ID
was found.

Only set cpu_die_id if a DIE_TYPE level is found. CPU topology code may
use another value for cpu_die_id, e.g. the AMD NodeId on AMD-based
systems. Code ordering should be maintained so that the CPUID Leaf 0x1F
Die ID value will take precedence on systems that may use another value.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201109210659.754018-5-Yazen.Ghannam@amd.com
---
 arch/x86/kernel/cpu/topology.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d3a0791..1068002 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -96,6 +96,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
 	unsigned int core_select_mask, core_level_siblings;
 	unsigned int die_select_mask, die_level_siblings;
+	bool die_level_present = false;
 	int leaf;
 
 	leaf = detect_extended_topology_leaf(c);
@@ -126,6 +127,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 		if (LEAFB_SUBTYPE(ecx) == DIE_TYPE) {
+			die_level_present = true;
 			die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
@@ -139,8 +141,12 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 
 	c->cpu_core_id = apic->phys_pkg_id(c->initial_apicid,
 				ht_mask_width) & core_select_mask;
-	c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
-				core_plus_mask_width) & die_select_mask;
+
+	if (die_level_present) {
+		c->cpu_die_id = apic->phys_pkg_id(c->initial_apicid,
+					core_plus_mask_width) & die_select_mask;
+	}
+
 	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
 				die_plus_mask_width);
 	/*
