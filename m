Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33681ED3EF
	for <lists+linux-tip-commits@lfdr.de>; Sun,  3 Nov 2019 18:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfKCRMp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 3 Nov 2019 12:12:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKCRMp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 3 Nov 2019 12:12:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRJQT-0003cs-DB; Sun, 03 Nov 2019 18:12:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF7451C0018;
        Sun,  3 Nov 2019 18:12:28 +0100 (CET)
Date:   Sun, 03 Nov 2019 17:12:28 -0000
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Prevent NULL pointer dereference when
 reading mondata
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        pei.p.jia@intel.com, Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1572326702-27577-1-git-send-email-xiaochen.shen@intel.com>
References: <1572326702-27577-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <157280114858.29376.4595330962343256563.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     26467b0f8407cbd628fa5b7bcfd156e772004155
Gitweb:        https://git.kernel.org/tip/26467b0f8407cbd628fa5b7bcfd156e772004155
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Tue, 29 Oct 2019 13:25:02 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 03 Nov 2019 17:51:22 +01:00

x86/resctrl: Prevent NULL pointer dereference when reading mondata

When a mon group is being deleted, rdtgrp->flags is set to RDT_DELETED
in rdtgroup_rmdir_mon() firstly. The structure of rdtgrp will be freed
until rdtgrp->waitcount is dropped to 0 in rdtgroup_kn_unlock() later.

During the window of deleting a mon group, if an application calls
rdtgroup_mondata_show() to read mondata under this mon group,
'rdtgrp' returned from rdtgroup_kn_lock_live() is a NULL pointer when
rdtgrp->flags is RDT_DELETED. And then 'rdtgrp' is passed in this path:
rdtgroup_mondata_show() --> mon_event_read() --> mon_event_count().
Thus it results in NULL pointer dereference in mon_event_count().

Check 'rdtgrp' in rdtgroup_mondata_show(), and return -ENOENT
immediately when reading mondata during the window of deleting a mon
group.

Fixes: d89b7379015f ("x86/intel_rdt/cqm: Add mon_data")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1572326702-27577-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index efbd54c..055c861 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -522,6 +522,10 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 	int ret = 0;
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
 
 	md.priv = of->kn->priv;
 	resid = md.u.rid;
