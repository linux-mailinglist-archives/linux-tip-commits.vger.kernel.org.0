Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABFE3E98FD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhHKTlz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53602 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhHKTlw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:52 -0400
Date:   Wed, 11 Aug 2021 19:41:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U59rHQlXrO7KGgq5UifHuKz4aCu/MPzCKB4mCZTf67w=;
        b=RtitD+/3FYXAl4FzyQ+ZI+k5APoVNQL7y3X8RNWvUYhGAFIpwj4sll3TwsBIMb7RhmB4Gy
        dbfceMK2rxPJs/143s3U+wbGTQcLkUUeszfT5ShJwJOU+Up8CgkpGr4jituE7knRFnKHKx
        A7DsbzjJJfM4DQsc+ko3yT0rCFAhwquMln3uLLI5HfvfY7c2RBdSU2A7NqIhg1DhTy9hfk
        DhLP2h8yKm8crxu5DFMWdIAhAWk9oBTejq2fSNYQXBjVTQnSrnBT3mMXU5sqAJlwG4+xns
        AKAssDbvfbQ/CcPkT85L2u/E9HuSD4K/XX1ICa2gYLoB2nWqSHCxh0ay+6tA7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U59rHQlXrO7KGgq5UifHuKz4aCu/MPzCKB4mCZTf67w=;
        b=/E78jHhpVqX0Zhhc89T6R7P9ukuD+iO2ynCNbK0jOniLFd+mEADcY2ult88ZclMy+awP2j
        LaUnNu1BviHT4ICA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Rename update_domains() to
 resctrl_arch_update_domains()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-16-james.morse@arm.com>
References: <20210728170637.25610-16-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088682.395.14497517131577936298.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2e6678195d59c51b6ca234169ad3de01134d3dec
Gitweb:        https://git.kernel.org/tip/2e6678195d59c51b6ca234169ad3de01134d3dec
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:28 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 16:36:58 +02:00

x86/resctrl: Rename update_domains() to resctrl_arch_update_domains()

update_domains() merges the staged configuration changes into the arch
codes configuration array. Rename to make it clear it is part of the
arch code interface to resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-16-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
 arch/x86/kernel/cpu/resctrl/internal.h    | 1 -
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 2 +-
 include/linux/resctrl.h                   | 1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index f29848f..8cde76d 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -259,7 +259,7 @@ static void apply_config(struct rdt_hw_domain *hw_dom,
 	}
 }
 
-int update_domains(struct rdt_resource *r, int closid)
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 {
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
@@ -380,7 +380,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		ret = update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret)
 			goto out;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 4e15667..a95893e 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -529,7 +529,6 @@ void rdt_pseudo_lock_release(void);
 int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp);
 void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp);
 struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
-int update_domains(struct rdt_resource *r, int closid);
 int closids_supported(void);
 void closid_free(int closid);
 int alloc_rmid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9f1354c..4b6de76 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2870,7 +2870,7 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 				return ret;
 		}
 
-		ret = update_domains(r, rdtgrp->closid);
+		ret = resctrl_arch_update_domains(r, rdtgrp->closid);
 		if (ret < 0) {
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 51ba372..be58811 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -199,5 +199,6 @@ struct resctrl_schema {
 
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
 
 #endif /* _RESCTRL_H */
