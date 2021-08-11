Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058153E990B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhHKTmD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:42:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHKTl6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:58 -0400
Date:   Wed, 11 Aug 2021 19:41:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710893;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5HFOsE0Dow+1tVZK/LUZ6kvgNGEWUd7msq5ALIxxCE=;
        b=ZUZbWQow4eq3TxH9R6ZCnS9Rc3ZiNyRC/kpEpmE4vKmWSEglb28AUQ6WUQSGcAOExR2wzZ
        2K/IndFT/P+kVHlbajKS7Eteb2yulaMhTlskb0sxCEP7rKa8mMqGgZidxKwpWHWuWwZN5b
        Ex+sEkJHWa4kv0iIr8CMYbMQkoXpxgF+uxAVfEARXCiHKgt6LYt1gITooP9KyzPy043Dxy
        HkfsZl/uXQ2B7CBy0h2z7T5QjOUwxx6uJOdEJ4XSyRJbItP7FT9U0Zpbph/qkBsW8kVR/o
        z6ktf9iIReJMqvfUCnf0gtd4O8sKULbK3TOHOipziyJLvjcLJAKOH75mKZrzYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710893;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N5HFOsE0Dow+1tVZK/LUZ6kvgNGEWUd7msq5ALIxxCE=;
        b=eXvnjHmRrRJkANvOWIJVCSr7Qaw2PgGupMiNwP/YQZDsJz7skSUhYyAtj2zFbuNwZHWmZm
        hHq+x0tbvIODwNDg==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Label the resources with their
 configuration type
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-6-james.morse@arm.com>
References: <20210728170637.25610-6-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871089265.395.9139540743392724452.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     208ab16847c562c0d53a0266b6628ef6cb5ab5c2
Gitweb:        https://git.kernel.org/tip/208ab16847c562c0d53a0266b6628ef6cb5ab5c2
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:18 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 13:13:18 +02:00

x86/resctrl: Label the resources with their configuration type

The names of resources are used for the schema name presented to
user-space. The name used is rooted in a structure provided by the
architecture code because the names are different when CDP is enabled.
x86 implements this by swapping between two sets of resource structures
based on their alloc_enabled flag. The type of configuration in-use is
encoded in the name (and cbm_idx_offset).

Once the CDP behaviour is moved into the parts of resctrl that will
move to /fs/, there will be two struct resctrl_schema for one struct
rdt_resource. The schema describes the type of configuration being
applied to the resource. The name of the schema should be generated
by resctrl, base on the type of configuration. To do this struct
resctrl_schema needs to store the type of configuration in use for a
schema.

Create an enum resctrl_conf_type describing the options, and add it to
struct resctrl_schema. The underlying resources are still separate, as
cbm_idx_offset is still in use.

Temporarily label all the entries in rdt_resources_all[] and copy that
value to struct resctrl_schema. Copying the value ensures there is no
mismatch while the filesystem parts of resctrl are modified to use the
schema. Once the resources are merged, the filesystem code can assign
this value based on the schema being created.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-6-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     |  7 +++++++
 arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  1 +
 include/linux/resctrl.h                | 14 ++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 10fbbc3..c5b5c72 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -62,6 +62,7 @@ mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
 struct rdt_hw_resource rdt_resources_all[] = {
 	[RDT_RESOURCE_L3] =
 	{
+		.conf_type			= CDP_NONE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3,
 			.name			= "L3",
@@ -81,6 +82,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L3DATA] =
 	{
+		.conf_type			= CDP_DATA,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3DATA,
 			.name			= "L3DATA",
@@ -100,6 +102,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L3CODE] =
 	{
+		.conf_type			= CDP_CODE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L3CODE,
 			.name			= "L3CODE",
@@ -119,6 +122,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2] =
 	{
+		.conf_type			= CDP_NONE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2,
 			.name			= "L2",
@@ -138,6 +142,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2DATA] =
 	{
+		.conf_type			= CDP_DATA,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2DATA,
 			.name			= "L2DATA",
@@ -157,6 +162,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_L2CODE] =
 	{
+		.conf_type			= CDP_CODE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_L2CODE,
 			.name			= "L2CODE",
@@ -176,6 +182,7 @@ struct rdt_hw_resource rdt_resources_all[] = {
 	},
 	[RDT_RESOURCE_MBA] =
 	{
+		.conf_type			= CDP_NONE,
 		.r_resctrl = {
 			.rid			= RDT_RESOURCE_MBA,
 			.name			= "MB",
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 2cc4b37..5e4a0a8 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -369,6 +369,7 @@ struct rdt_parse_data {
 
 /**
  * struct rdt_hw_resource - arch private attributes of a resctrl resource
+ * @conf_type:		The type that should be used when configuring. temporary
  * @r_resctrl:		Attributes of the resource used directly by resctrl.
  * @num_closid:		Maximum number of closid this hardware can support.
  * @msr_base:		Base MSR address for CBMs
@@ -381,6 +382,7 @@ struct rdt_parse_data {
  * msr_update and msr_base.
  */
 struct rdt_hw_resource {
+	enum resctrl_conf_type	conf_type;
 	struct rdt_resource	r_resctrl;
 	int			num_closid;
 	unsigned int		msr_base;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 1fc40db..d7fd071 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2135,6 +2135,7 @@ static int schemata_list_create(void)
 			return -ENOMEM;
 
 		s->res = r;
+		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 
 		INIT_LIST_HEAD(&s->list);
 		list_add(&s->list, &resctrl_schema_all);
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 5a21d48..095ed48 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -16,6 +16,18 @@ int proc_resctrl_show(struct seq_file *m,
 #endif
 
 /**
+ * enum resctrl_conf_type - The type of configuration.
+ * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
+ * @CDP_CODE:	Configuration applies to instruction fetches.
+ * @CDP_DATA:	Configuration applies to reads and writes.
+ */
+enum resctrl_conf_type {
+	CDP_NONE,
+	CDP_CODE,
+	CDP_DATA,
+};
+
+/**
  * struct rdt_domain - group of CPUs sharing a resctrl resource
  * @list:		all instances of this resource
  * @id:			unique id for this instance
@@ -157,11 +169,13 @@ struct rdt_resource {
  * struct resctrl_schema - configuration abilities of a resource presented to
  *			   user-space
  * @list:	Member of resctrl_schema_all.
+ * @conf_type:	Whether this schema is specific to code/data.
  * @res:	The resource structure exported by the architecture to describe
  *		the hardware that is configured by this schema.
  */
 struct resctrl_schema {
 	struct list_head		list;
+	enum resctrl_conf_type		conf_type;
 	struct rdt_resource		*res;
 };
 #endif /* _RESCTRL_H */
