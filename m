Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034C93E9905
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhHKTmB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbhHKTl4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:56 -0400
Date:   Wed, 11 Aug 2021 19:41:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bs6xotT6ImpvGjb2AY6dnlvro1Fo7EPnZodzgx4iBqo=;
        b=1mqmhIuKa0csgrQASZLH/vi8atMH2e/QBqpOiXEs/al2jBztrtKRbnInrHbsuiBO83C4GO
        vqELpDsz88E54SydwvstJTkapZsfidRnf29xmgfxHb620ULoHnUf729i9+DTSRRSWfe2DG
        QEFSxUI/jzl0lFGSytjyVDwh2kixwqHKZKbUMUbX0ZEFjghBcJ/KU7tg8OjJ6NFUgJarbR
        bREPCCAwGbr1uetN3T4g0fZG0aTZ9KynIfT2vCd/ataaZyvrEgR4nTkwlGECA144amW7yM
        1sH6zEigF0BWxMAzIcsuuFi+hUdv0tM3Nb7c9Fb5OTVPKimPpGrXi1eGtlrOeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710891;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bs6xotT6ImpvGjb2AY6dnlvro1Fo7EPnZodzgx4iBqo=;
        b=Xd4YSRQ8UHyo+VP7Z4Lc2/HfEoK7bjV9nLn5SOCKeO1eZXR1WNLHFh66fOPbTMpeqM7l4N
        TkyT8/1kpD0YxmCA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Add resctrl_arch_get_num_closid()
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-9-james.morse@arm.com>
References: <20210728170637.25610-9-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089093.395.5316016206376991370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     eb6f3187694158ca36e50083e861531488d5c1b1
Gitweb:        https://git.kernel.org/tip/eb6f3187694158ca36e50083e861531488d5c1b1
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:21 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 15:35:42 +02:00

x86/resctrl: Add resctrl_arch_get_num_closid()

To initialise struct resctrl_schema's num_closid, schemata_list_create()
reaches into the architectures private structure to retrieve num_closid
from the struct rdt_hw_resource. The 'half the closids' behaviour should
be part of the filesystem parts of resctrl that are the same on any
architecture. struct resctrl_schema's num_closid should include any
correction for CDP.

Having two properties called num_closid is likely to be confusing when
they have different values.

Add a helper to read the resource's num_closid from the arch code.
This should return the number of closid that the resource supports,
regardless of whether CDP is in use. Once the CDP resources are merged,
schemata_list_create() can apply the correction itself.

Using a type with an obvious size for the arch helper means changing the
type of num_closid to u32, which matches the type already used by struct
rdtgroup.

reset_all_ctrls() does not use resctrl_arch_get_num_closid(), even
though it sets up a structure for modifying the hardware. This function
will be part of the architecture code, the maximum closid should be the
maximum value the hardware has, regardless of the way resctrl is using
it. All the uses of num_closid in core.c are naturally part of the
architecture specific code.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-9-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 5 +++++
 arch/x86/kernel/cpu/resctrl/internal.h | 8 ++++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ++--
 include/linux/resctrl.h                | 6 +++++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index c5b5c72..26e8d20 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -450,6 +450,11 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r)
 	return NULL;
 }
 
+u32 resctrl_arch_get_num_closid(struct rdt_resource *r)
+{
+	return resctrl_to_arch_res(r)->num_closid;
+}
+
 void rdt_ctrl_update(void *arg)
 {
 	struct msr_param *m = arg;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 5e4a0a8..c4bc5fa 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -371,7 +371,11 @@ struct rdt_parse_data {
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
  * @conf_type:		The type that should be used when configuring. temporary
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
- * @num_closid:		Maximum number of closid this hardware can support.
+ * @num_closid:		Maximum number of closid this hardware can support,
+ *			regardless of CDP. This is exposed via
+ *			resctrl_arch_get_num_closid() to avoid confusion
+ *			with struct resctrl_schema's property of the same name,
+ *			which has been corrected for features like CDP.
  * @msr_base:		Base MSR address for CBMs
  * @msr_update:		Function pointer to update QOS MSRs
  * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
@@ -384,7 +388,7 @@ struct rdt_parse_data {
 struct rdt_hw_resource {
 	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	r_resctrl;
-	int			num_closid;
+	u32			num_closid;
 	unsigned int		msr_base;
 	void (*msr_update)	(struct rdt_domain *d, struct msr_param *m,
 				 struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 2f29b7d..09ffe9a 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -104,7 +104,7 @@ int closids_supported(void)
 static void closid_init(void)
 {
 	struct resctrl_schema *s;
-	int rdt_min_closid = 32;
+	u32 rdt_min_closid = 32;
 
 	/* Compute rdt_min_closid across all resources */
 	list_for_each_entry(s, &resctrl_schema_all, list)
@@ -2134,7 +2134,7 @@ static int schemata_list_create(void)
 
 		s->res = r;
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
-		s->num_closid = resctrl_to_arch_res(r)->num_closid;
+		s->num_closid = resctrl_arch_get_num_closid(r);
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 59d0fa7..b9d2005 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -180,6 +180,10 @@ struct resctrl_schema {
 	struct list_head		list;
 	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
-	int				num_closid;
+	u32				num_closid;
 };
+
+/* The number of closid supported by this resource regardless of CDP */
+u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+
 #endif /* _RESCTRL_H */
