Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A105642447C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Oct 2021 19:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhJFRk4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 Oct 2021 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFRkz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 Oct 2021 13:40:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95180C061746;
        Wed,  6 Oct 2021 10:39:02 -0700 (PDT)
Date:   Wed, 06 Oct 2021 17:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633541941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmbCGwSIF0sTKEPRrtpjeLrvJBcFlKHJARen+0CdZNM=;
        b=j9gzTikZwZftLr1Ex0jtZ6tkN5DMbJ09AclpuXtg9Mm36acfCWMCMKRlda2QQOMJ1llXvf
        CPHIBBRih04AI/dbl4kEUoD1F44ALZkxhu1TeHDIkthBvRzTMtdcIh1g4Kew57U59dLEit
        1HLI7Y/+Uc04GHtqt3AeSlQAOlaPGZn6ge+d+XXTFyvvfok3F5vw1h5MyrMmxLIRmntJfB
        pnFimzcuJMMzrOefPnFzUBjcLzy7ILdApKhLMHN4O5QMIg4ed4bLBvMCVWJuFQb1RnJEHe
        5bfmAcUNcPivXs9lveV3HfKvYaQAom8JUYQG1k2LVIWa4aMGOzC+9cw9J4e4zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633541941;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmbCGwSIF0sTKEPRrtpjeLrvJBcFlKHJARen+0CdZNM=;
        b=KQAPkq9MvqXPzwR4l46hAockooMvKaJPJWMgmDtxaQqgs49w9X756CPI9xnAIiwBkYiBBP
        Os8uK2/sJ8NYDsAw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix kfree() of the wrong type in
 domain_add_cpu()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210917165924.28254-1-james.morse@arm.com>
References: <20210917165924.28254-1-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <163354194034.25758.2403233705072752680.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d4ebfca26dfab2803c31d68a30225be31b2f9ecf
Gitweb:        https://git.kernel.org/tip/d4ebfca26dfab2803c31d68a30225be31b2f9ecf
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 17 Sep 2021 16:59:24 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Oct 2021 18:45:27 +02:00

x86/resctrl: Fix kfree() of the wrong type in domain_add_cpu()

Commit in Fixes separated the architecture specific and filesystem parts
of the resctrl domain structures.

This left the error paths in domain_add_cpu() kfree()ing the memory with
the wrong type.

This will cause a problem if someone adds a new member to struct
rdt_hw_domain meaning d_resctrl is no longer the first member.

Fixes: 792e0f6f789b ("x86/resctrl: Split struct rdt_domain")
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20210917165924.28254-1-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index b5de5a6..bb1c3f5 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -527,14 +527,14 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	rdt_domain_reconfigure_cdp(r);
 
 	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
 	if (r->mon_capable && domain_setup_mon_state(r, d)) {
 		kfree(hw_dom->ctrl_val);
 		kfree(hw_dom->mbps_val);
-		kfree(d);
+		kfree(hw_dom);
 		return;
 	}
 
