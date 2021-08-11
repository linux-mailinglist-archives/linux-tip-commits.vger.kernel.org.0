Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4821E3E98F7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Aug 2021 21:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhHKTlw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Aug 2021 15:41:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53602 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbhHKTlu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Aug 2021 15:41:50 -0400
Date:   Wed, 11 Aug 2021 19:41:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628710885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8i+CelH4393wqbFZLjyubJ9cJaYTL/Q9iy7HD+iNO+k=;
        b=yQVO3Pjui5s2248vP2uajJYNfUydrid9C5ZfoZ4dvZFwdk6OIFMSjhv6lso/RgpGUlsel9
        58xu6iP+PHPWhBfBxcZP5PJw98vjhA92LORoVXD4AuEAIrCuxv7iDf4ND9Y4eNB5+LiRoy
        QRufBAlNM4fGGe+6MSIafZOYTDwDNL6TcyUKnXrJ6+qstdjUKKI6M5yz7J73ZsnMYIuOA2
        DTvJ5DVtxQGgh23jbyKSRHiAvou0dy59PPAQFsPqogW/QbB3z31xEwWOf7Oq8KGJ7Remzs
        F4Uodey7zKI7007rcnV0sDIH3EAvkl0SIp3UwVAcGIxI894cp1SefaFChBWuBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628710885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8i+CelH4393wqbFZLjyubJ9cJaYTL/Q9iy7HD+iNO+k=;
        b=8ZWbQK8Ux+U8kvHfbHXUXMxd7EIT3/jwTdhuSVYbS4Lp2qiv741EzaKzI9jmIrH8yNMjKF
        R3piund26hsCqACw==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Make ctrlval arrays the same size
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Jamie Iles <jamie@nuviainc.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210728170637.25610-19-james.morse@arm.com>
References: <20210728170637.25610-19-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <162871088496.395.3274537078640668710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     141739aa73505539f315d15068b9c0707ab5ecb4
Gitweb:        https://git.kernel.org/tip/141739aa73505539f315d15068b9c0707ab5ecb4
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Wed, 28 Jul 2021 17:06:31 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 11 Aug 2021 17:58:33 +02:00

x86/resctrl: Make ctrlval arrays the same size

The CODE and DATA resources report a num_closid that is half the actual
size supported by the hardware. This behaviour is visible to user-space
when CDP is enabled.

The CODE and DATA resources have their own ctrlval arrays which are
half the size of the underlying hardware because num_closid was already
adjusted. One holds the odd configurations values, the other even.

Before the CDP resources can be merged, the 'half the closids' behaviour
needs to be implemented by schemata_list_create(), but this causes the
ctrl_val[] array to be full sized.

Remove the logic from the architecture specific rdt_get_cdp_config()
setup, and add it to schemata_list_create(). Functions that walk all the
configurations, such as domain_setup_ctrlval() and reset_all_ctrls(),
take num_closid directly from struct rdt_hw_resource also have
to halve num_closid as only the lower half of each array is in
use. domain_setup_ctrlval() and reset_all_ctrls() both copy struct
rdt_hw_resource's num_closid to a struct msr_param. Correct the value
here.

This is temporary as a subsequent patch will merge all three ctrl_val[]
arrays such that when CDP is in use, the CODA/DATA layout in the array
matches the hardware. reset_all_ctrls()'s loop over the whole of
ctrl_val[] is not touched as this is harmless, and will be required as
it is once the resources are merged.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Jamie Iles <jamie@nuviainc.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Link: https://lkml.kernel.org/r/20210728170637.25610-19-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 755118a..9f8be5e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -363,7 +363,7 @@ static void rdt_get_cdp_config(int level, int type)
 	struct rdt_resource *r = &rdt_resources_all[type].r_resctrl;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	hw_res->num_closid = hw_res_l->num_closid / 2;
+	hw_res->num_closid = hw_res_l->num_closid;
 	r->cache.cbm_len = r_l->cache.cbm_len;
 	r->default_ctrl = r_l->default_ctrl;
 	r->cache.shareable_bits = r_l->cache.shareable_bits;
@@ -549,6 +549,14 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
+
+	/*
+	 * temporary: the array is full-size, but cat_wrmsr() still re-maps
+	 * the index.
+	 */
+	if (hw_res->conf_type != CDP_NONE)
+		m.high /= 2;
+
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 61037b2..299af12 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2154,6 +2154,8 @@ static int schemata_list_create(void)
 		s->res = r;
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 		s->num_closid = resctrl_arch_get_num_closid(r);
+		if (resctrl_arch_get_cdp_enabled(r->rid))
+			s->num_closid /= 2;
 
 		ret = snprintf(s->name, sizeof(s->name), r->name);
 		if (ret >= sizeof(s->name)) {
@@ -2377,6 +2379,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	msr_param.high = hw_res->num_closid;
 
 	/*
+	 * temporary: the array is full-sized, but cat_wrmsr() still re-maps
+	 * the index.
+	 */
+	if (hw_res->cdp_enabled)
+		msr_param.high /= 2;
+
+	/*
 	 * Disable resource control for this resource by setting all
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
 	 * from each domain to update the MSRs below.
