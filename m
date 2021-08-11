Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3463E98FF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhHKTl5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhHKTlx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:53 -0400
Date:   Wed, 11 Aug 2021 19:41:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBTnImzFLedOIk3sgXX9F69b5AeyGf+SIRjPUqCDl4I=;
        b=VcgzGbJ1jr1SLtQMIhLxqnlGD1rsKaLdJQGYNpss+BzuLRrXUxBqtLGbgIUTMVoWhZa2Am
        IKwb7sBFfgPmvEJ8hKzb+7v2EV8eJvOtooY2BL668A7dlBUmGZpvv12D6Vm4P0gJAnz5jG
        hlWFgj5qgSPtUE2geltL7Glq2Ldno7MPg0lgTdTi+b09z9k7id22AizTdjCflVm4B5XATK
        HWYSBbX1wV6U7m5uX1fyV+gBfMAp3cwwVFexHW/ywjYXDMptZvIemzVsILzB7KCeXZSI9Z
        2iDe0LlF9JqsTfCg3CEdGUr1cchMknGzNKppKbv8tWum2CnkVbAESnndOQ45dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBTnImzFLedOIk3sgXX9F69b5AeyGf+SIRjPUqCDl4I=;
        b=aNt5igA4GuM4YUa82vSNSoddSl7GX7jOLYSLWW2TvrpU+79izKOJabUKUGlEgQ1mgYosH8
        zIECsClilnqYCwAQ==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Allow different CODE/DATA
 configurations to be staged
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-15-james.morse@arm.com>
References: <20210728170637.25610-15-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088737.395.10609610594664194179.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     75408e43509ed6207870c0e7e28656acbbc1f7fd
Gitweb:        https://git.kernel.org/tip/75408e43509ed6207870c0e7e28656acbbc1f7fd
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:27 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 16:33:42 +02:00

x86/resctrl: Allow different CODE/DATA configurations to be staged

Before the CDP resources can be merged, struct rdt_domain will need an
array of struct resctrl_staged_config, one per type of configuration.

Use the type as an index to the array to ensure that a schema
configuration string can't specify the same domain twice. This will
allow two schemata to apply configuration changes to one resource.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-15-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 20 ++++++++++++++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  5 +++--
 include/linux/resctrl.h                   |  4 +++-
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 9ddfa76..f29848f 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -60,10 +60,11 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 int parse_bw(struct rdt_parse_data *data, struct resctrl_schema *s,
 	     struct rdt_domain *d)
 {
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	unsigned long bw_val;
-	struct resctrl_staged_config *cfg = &d->staged_config;
 
+	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
@@ -130,11 +131,12 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
 int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 	      struct rdt_domain *d)
 {
-	struct resctrl_staged_config *cfg = &d->staged_config;
 	struct rdtgroup *rdtgrp = data->rdtgrp;
+	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	u32 cbm_val;
 
+	cfg = &d->staged_config[s->conf_type];
 	if (cfg->have_new_ctrl) {
 		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
 		return -EINVAL;
@@ -192,6 +194,7 @@ int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 static int parse_line(char *line, struct resctrl_schema *s,
 		      struct rdtgroup *rdtgrp)
 {
+	enum resctrl_conf_type t = s->conf_type;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r = s->res;
 	struct rdt_parse_data data;
@@ -222,7 +225,7 @@ next:
 			if (r->parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode ==  RDT_MODE_PSEUDO_LOCKSETUP) {
-				cfg = &d->staged_config;
+				cfg = &d->staged_config[t];
 				/*
 				 * In pseudo-locking setup mode and just
 				 * parsed a valid CBM that should be
@@ -261,6 +264,7 @@ int update_domains(struct rdt_resource *r, int closid)
 	struct resctrl_staged_config *cfg;
 	struct rdt_hw_domain *hw_dom;
 	struct msr_param msr_param;
+	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
 	bool mba_sc;
@@ -276,9 +280,13 @@ int update_domains(struct rdt_resource *r, int closid)
 	mba_sc = is_mba_sc(r);
 	list_for_each_entry(d, &r->domains, list) {
 		hw_dom = resctrl_to_arch_dom(d);
-		cfg = &hw_dom->d_resctrl.staged_config;
-		if (cfg->have_new_ctrl)
+		for (t = 0; t < CDP_NUM_TYPES; t++) {
+			cfg = &hw_dom->d_resctrl.staged_config[t];
+			if (!cfg->have_new_ctrl)
+				continue;
+
 			apply_config(hw_dom, cfg, closid, cpu_mask, mba_sc);
+		}
 	}
 
 	/*
@@ -350,7 +358,7 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		list_for_each_entry(dom, &s->res->domains, list)
-			memset(&dom->staged_config, 0, sizeof(dom->staged_config));
+			memset(dom->staged_config, 0, sizeof(dom->staged_config));
 	}
 
 	while ((tok = strsep(&buf, "\n")) != NULL) {
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 62cc82d..9f1354c 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2751,6 +2751,7 @@ static u32 cbm_ensure_valid(u32 _val, struct rdt_resource *r)
 static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 				 u32 closid)
 {
+	enum resctrl_conf_type t = s->conf_type;
 	struct rdt_resource *r_cdp = NULL;
 	struct resctrl_staged_config *cfg;
 	struct rdt_domain *d_cdp = NULL;
@@ -2762,7 +2763,7 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
 	int i;
 
 	rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
-	cfg = &d->staged_config;
+	cfg = &d->staged_config[t];
 	cfg->have_new_ctrl = false;
 	cfg->new_ctrl = r->cache.shareable_bits;
 	used_b = r->cache.shareable_bits;
@@ -2846,7 +2847,7 @@ static void rdtgroup_init_mba(struct rdt_resource *r)
 	struct rdt_domain *d;
 
 	list_for_each_entry(d, &r->domains, list) {
-		cfg = &d->staged_config;
+		cfg = &d->staged_config[CDP_NONE];
 		cfg->new_ctrl = is_mba_sc(r) ? MBA_MAX_MBPS : r->default_ctrl;
 		cfg->have_new_ctrl = true;
 	}
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index ff7f7d7..51ba372 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -27,6 +27,8 @@ enum resctrl_conf_type {
 	CDP_DATA,
 };
 
+#define CDP_NUM_TYPES	(CDP_DATA + 1)
+
 /**
  * struct resctrl_staged_config - parsed configuration to be applied
  * @new_ctrl:		new ctrl value to be loaded
@@ -64,7 +66,7 @@ struct rdt_domain {
 	int				mbm_work_cpu;
 	int				cqm_work_cpu;
 	struct pseudo_lock_region	*plr;
-	struct resctrl_staged_config	staged_config;
+	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
 };
 
 /**
