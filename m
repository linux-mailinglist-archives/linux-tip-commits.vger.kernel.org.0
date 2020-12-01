Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4362CA982
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Dec 2020 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390143AbgLARXB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Dec 2020 12:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389109AbgLARXB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Dec 2020 12:23:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2958BC0613D4;
        Tue,  1 Dec 2020 09:22:21 -0800 (PST)
Date:   Tue, 01 Dec 2020 17:22:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606843339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icWjIGhRr4t+x0JShmJXCNn1v1KRNtsI5XTRR0zlP3M=;
        b=bDZzO4XVKjFahZs9imkUigaP14bIGdPpZp5YuHJZMz0xedqbOF9zp2IUd0uoKpoVFhbenp
        oo249WtAMW0LCtlVmp9s0eh+fq7XgXr4IQeqv4tkMTWD/L+Y8/9BcYOIKTLqFSrpd0S4sI
        egkgspyrIo0Ie8OCT8JzXAeCVQ1EcG7Cmhk4xC4PTvcx+WCow/jmFEuK88HTbqpKhZK5v1
        iCGJtPNxLCt8jVPOGgxZboDRxFlewNPLZYY2l48Mz57Qu/edtEK/k/bpipw4hFQiAPI932
        c50xjShJRBwiPsZ0GWGjBaFNvY78yvR3rvPIeUgvT6tlKET2WoonyrG1qq0cpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606843339;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icWjIGhRr4t+x0JShmJXCNn1v1KRNtsI5XTRR0zlP3M=;
        b=9LZ6FLOJ7qd4JSCNjrQnuYv81qWITk9U/e6XHZ3hsZI2rPv0VZh2yLzH+Lo/8lERpwoChY
        ugNECi86BW3au+Cg==
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Clean up unused function parameter in
 rmdir path
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1606759618-13181-1-git-send-email-xiaochen.shen@intel.com>
References: <1606759618-13181-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <160684333874.3364.16804371092102792651.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     19eb86a72df50adcf554f234469bb5b7209b7640
Gitweb:        https://git.kernel.org/tip/19eb86a72df50adcf554f234469bb5b7209b7640
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Tue, 01 Dec 2020 02:06:58 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Dec 2020 18:06:35 +01:00

x86/resctrl: Clean up unused function parameter in rmdir path

Commit

  fd8d9db3559a ("x86/resctrl: Remove superfluous kernfs_get() calls to prevent refcount leak")

removed superfluous kernfs_get() calls in rdtgroup_ctrl_remove() and
rdtgroup_rmdir_ctrl(). That change resulted in an unused function
parameter to these two functions.

Clean up the unused function parameter in rdtgroup_ctrl_remove(),
rdtgroup_rmdir_mon() and their callers rdtgroup_rmdir_ctrl() and
rdtgroup_rmdir().

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/1606759618-13181-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 05a026d..bcbec85 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3018,8 +3018,7 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	return -EPERM;
 }
 
-static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
-			      cpumask_var_t tmpmask)
+static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
 	int cpu;
@@ -3051,8 +3050,7 @@ static int rdtgroup_rmdir_mon(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	return 0;
 }
 
-static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
-				struct rdtgroup *rdtgrp)
+static int rdtgroup_ctrl_remove(struct rdtgroup *rdtgrp)
 {
 	rdtgrp->flags = RDT_DELETED;
 	list_del(&rdtgrp->rdtgroup_list);
@@ -3061,8 +3059,7 @@ static int rdtgroup_ctrl_remove(struct kernfs_node *kn,
 	return 0;
 }
 
-static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
-			       cpumask_var_t tmpmask)
+static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	int cpu;
 
@@ -3089,7 +3086,7 @@ static int rdtgroup_rmdir_ctrl(struct kernfs_node *kn, struct rdtgroup *rdtgrp,
 	closid_free(rdtgrp->closid);
 	free_rmid(rdtgrp->mon.rmid);
 
-	rdtgroup_ctrl_remove(kn, rdtgrp);
+	rdtgroup_ctrl_remove(rdtgrp);
 
 	/*
 	 * Free all the child monitor group rmids.
@@ -3126,13 +3123,13 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	    rdtgrp != &rdtgroup_default) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
-			ret = rdtgroup_ctrl_remove(kn, rdtgrp);
+			ret = rdtgroup_ctrl_remove(rdtgrp);
 		} else {
-			ret = rdtgroup_rmdir_ctrl(kn, rdtgrp, tmpmask);
+			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
 		}
 	} else if (rdtgrp->type == RDTMON_GROUP &&
 		 is_mon_groups(parent_kn, kn->name)) {
-		ret = rdtgroup_rmdir_mon(kn, rdtgrp, tmpmask);
+		ret = rdtgroup_rmdir_mon(rdtgrp, tmpmask);
 	} else {
 		ret = -EPERM;
 	}
