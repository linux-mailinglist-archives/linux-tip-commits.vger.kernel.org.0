Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9481A2B9108
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Nov 2020 12:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgKSL3j (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Nov 2020 06:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKSL3i (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Nov 2020 06:29:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B9C0613CF;
        Thu, 19 Nov 2020 03:29:38 -0800 (PST)
Date:   Thu, 19 Nov 2020 11:29:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605785374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbjN0lyu/A5+qrVL2PNaOWmt2/qokUNPLwDDwUFeabc=;
        b=4zDmSIU2tFg3+lUAlWCq0YV0LncTVyEccler3/4wyywHRANyrBwG+hjJUKGsGgzTiNrdth
        KeoRWvX4uuJgIK5baGJVznY9Qrh3AolPAdi9yTP+110qEjRYBFg5JF4zUom/hq+91TJZZx
        xG5MqSjEWqAmBPLzJqc1eb/A0YT/YWGcjQmAFcJemXi0nnpfl5BMHkqhE3Ra+kDLqzXBuF
        o+IWcxLsVOMcmErkPjNo2H0biyPlq64vOrA/C0o5yJDgJbeATqDB9t4uykseGXW2DI7Iii
        smDpbOvKDo4aBBRKR6pQ7vhrqTgsCzd1zpv40Dl5XDalgcV+RD+NM/0J9BsKxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605785374;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JbjN0lyu/A5+qrVL2PNaOWmt2/qokUNPLwDDwUFeabc=;
        b=5QM0Yw49ndaVGCUEuP0jv2nmapHe9f2GSmtctucLBIveWWYEQ0amrkAKK8eshQvt3SrldD
        1azL1cTwUx/e3CCQ==
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] EDAC/mce_amd: Use struct cpuinfo_x86.cpu_die_id for AMD NodeId
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201109210659.754018-4-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <160578537393.11244.3051334765030838702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8de0c9917cc1297bc5543b61992d5bdee4ce621a
Gitweb:        https://git.kernel.org/tip/8de0c9917cc1297bc5543b61992d5bdee4ce621a
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 09 Nov 2020 21:06:58 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 19 Nov 2020 11:43:21 +01:00

EDAC/mce_amd: Use struct cpuinfo_x86.cpu_die_id for AMD NodeId

The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
later systems. This function is used in amd64_edac_mod to do
system-specific decoding for DRAM ECC errors. The function takes a
"NodeId" as a parameter.

In AMD documentation, NodeId is used to identify a physical die in a
system. This can be used to identify a node in the AMD_NB code and also
it is used with umc_normaddr_to_sysaddr().

However, the input used for decode_dram_ecc() is currently the NUMA node
of a logical CPU. In the default configuration, the NUMA node and
physical die will be equivalent, so this doesn't have an impact.

But the NUMA node configuration can be adjusted with optional memory
interleaving modes. This will cause the NUMA node enumeration to not
match the physical die enumeration. The mismatch will cause the address
translation function to fail or report incorrect results.

Use struct cpuinfo_x86.cpu_die_id for the node_id parameter to ensure the
physical ID is used.

Fixes: fbe63acf62f5 ("EDAC, mce_amd: Use cpu_to_node() to find the node ID")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201109210659.754018-4-Yazen.Ghannam@amd.com
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 85095e3..5dd905a 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1003,7 +1003,7 @@ static void decode_smca_error(struct mce *m)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(cpu_to_node(m->extcpu), m);
+		decode_dram_ecc(topology_die_id(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)
