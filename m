Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8118A4F5463
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Apr 2022 06:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbiDFEuG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Apr 2022 00:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573646AbiDET30 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Apr 2022 15:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8BBE9FD;
        Tue,  5 Apr 2022 12:27:27 -0700 (PDT)
Date:   Tue, 05 Apr 2022 19:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649186846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Apj1WNSGkjJ8qBld0G1fRhqZVHswRua50ugsNNzGKZA=;
        b=QPqFejLM6vWh5deYEFxaZoFIBFKWHoVyPGm85w6i7iuyvsSRDwtbqrivldew8s14epXpRO
        AmIt6LPMpBS9YhYCnf12zzcRyvVubo0G1rfg52HgHjzQYeuHeLiKuop+5wETPAnq2nnnf1
        d3YHJQSL5o71KwFZbuEuAqLABbsRE2WwHJobqN7o1dsgla+VQOaMJjJ51d39TCUBa5l2nE
        O4SsX7eUofQEKU241+pTSWLG1bMCVdjkJu6jdzzfjTxOcmShZ8VBtMxM4U3oIXydtlG9Jq
        E+6YhZdyANBwc2d9tbMygOvo29Qv40trnKzT+w8elvNr8lcuVzHqBccLp94nPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649186846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Apj1WNSGkjJ8qBld0G1fRhqZVHswRua50ugsNNzGKZA=;
        b=ClPuWOqOgjfUWaEacCw4zTvpCV5dZvv9YBZ3flIzRVJMPq4KC9Codtf7GaJI4RXocIs4D5
        pNJWGQ/gyOq+IZCw==
From:   "tip-bot2 for Muralidhara M K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/amd_nb: Unexport amd_cache_northbridges()
Cc:     Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220324122729.221765-1-nchatrad@amd.com>
References: <20220324122729.221765-1-nchatrad@amd.com>
MIME-Version: 1.0
Message-ID: <164918684484.389.10138844403913568515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     e1907d37514b8564ba18b4a768a35beee71cb011
Gitweb:        https://git.kernel.org/tip/e1907d37514b8564ba18b4a768a35beee71cb011
Author:        Muralidhara M K <muralimk@amd.com>
AuthorDate:    Thu, 24 Mar 2022 17:57:29 +05:30
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 05 Apr 2022 19:22:27 +02:00

x86/amd_nb: Unexport amd_cache_northbridges()

amd_cache_northbridges() is exported by amd_nb.c and is called by
amd64-agp.c and amd64_edac.c modules at module_init() time so that NB
descriptors are properly cached before those drivers can use them.

However, the init_amd_nbs() initcall already does call
amd_cache_northbridges() unconditionally and thus makes sure the NB
descriptors are enumerated.

That initcall is a fs_initcall type which is on the 5th group (starting
from 0) of initcalls that gets run in increasing numerical order by the
init code.

The module_init() call is turned into an __initcall() in the MODULE=n
case and those are device-level initcalls, i.e., group 6.

Therefore, the northbridges caching is already finished by the time
module initialization starts and thus the correct initialization order
is retained.

Unexport amd_cache_northbridges(), update dependent modules to
call amd_nb_num() instead. While at it, simplify the checks in
amd_cache_northbridges().

  [ bp: Heavily massage and *actually* explain why the change is ok. ]

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220324122729.221765-1-nchatrad@amd.com
---
 arch/x86/include/asm/amd_nb.h | 1 -
 arch/x86/kernel/amd_nb.c      | 7 +++----
 drivers/char/agp/amd64-agp.c  | 2 +-
 drivers/edac/amd64_edac.c     | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
index 00d1a40..ed0eaf6 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -16,7 +16,6 @@ extern const struct amd_nb_bus_dev_range amd_nb_bus_dev_ranges[];
 
 extern bool early_is_amd_nb(u32 value);
 extern struct resource *amd_get_mmconfig_range(struct resource *res);
-extern int amd_cache_northbridges(void);
 extern void amd_flush_garts(void);
 extern int amd_numa_init(void);
 extern int amd_get_subcaches(int);
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 020c906..190e0f7 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -188,7 +188,7 @@ int amd_smn_write(u16 node, u32 address, u32 value)
 EXPORT_SYMBOL_GPL(amd_smn_write);
 
 
-int amd_cache_northbridges(void)
+static int amd_cache_northbridges(void)
 {
 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
 	const struct pci_device_id *link_ids = amd_nb_link_ids;
@@ -210,14 +210,14 @@ int amd_cache_northbridges(void)
 	}
 
 	misc = NULL;
-	while ((misc = next_northbridge(misc, misc_ids)) != NULL)
+	while ((misc = next_northbridge(misc, misc_ids)))
 		misc_count++;
 
 	if (!misc_count)
 		return -ENODEV;
 
 	root = NULL;
-	while ((root = next_northbridge(root, root_ids)) != NULL)
+	while ((root = next_northbridge(root, root_ids)))
 		root_count++;
 
 	if (root_count) {
@@ -290,7 +290,6 @@ int amd_cache_northbridges(void)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(amd_cache_northbridges);
 
 /*
  * Ignores subdevice/subvendor but as far as I can figure out
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index dc78a4f..84a4aa9 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -327,7 +327,7 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 {
 	int i;
 
-	if (amd_cache_northbridges() < 0)
+	if (!amd_nb_num())
 		return -ENODEV;
 
 	if (!amd_nb_has_feature(AMD_NB_GART))
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 812baa4..2f854fe 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4336,7 +4336,7 @@ static int __init amd64_edac_init(void)
 	if (!x86_match_cpu(amd64_cpuids))
 		return -ENODEV;
 
-	if (amd_cache_northbridges() < 0)
+	if (!amd_nb_num())
 		return -ENODEV;
 
 	opstate_init();
