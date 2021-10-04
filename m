Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C846421460
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Oct 2021 18:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhJDQt3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 4 Oct 2021 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhJDQt0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 4 Oct 2021 12:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6FFC061755;
        Mon,  4 Oct 2021 09:47:36 -0700 (PDT)
Date:   Mon, 04 Oct 2021 16:47:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633366054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbgsBquHLSmuP9prM46Wd43WD9vRuVbV0f6dN+7oNI4=;
        b=glpQJU53X4yZGzlAu0j9VuVLgSA9cvEyhdoNe+NF8lp8ulPA5VCn9zaAu09NCJw0deaLao
        einw/1vpAZGiU/Q3WYW+gyxag/MID5/jeiGG4FycIBl2pzE19ResSCPqp+KqhxJ/vmWlYW
        7ea9kAZUZ9844/2Fk8lTSB6J9xuHMiC2Sf+IFQZSMp4yAoTapVaP9dZpLEYozGcl0Aqc9e
        fuYh328tI8ixOzgUmarmLZKgh4zVJERGqqFHbw3hzuinKuyzB0WtwizTclOO8E5+XCNgKC
        Hw1O5VC53n9Bl9yBfmziU38yS2RTZ8zcE9GrzEHfTPdyqVlRHAnbyyB6R5KtFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633366054;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hbgsBquHLSmuP9prM46Wd43WD9vRuVbV0f6dN+7oNI4=;
        b=v2biMlA6ZIArhCXn3lQ7f2pUbqdQG7QcvhA/2ngilcDaVErVe0QGeiP5MHBLovffaVjDIb
        CTJlr27hP6yvEdCA==
From:   "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Free the ctrlval arrays when
 domain_setup_mon_state() fails
Cc:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210917165958.28313-1-james.morse@arm.com>
References: <20210917165958.28313-1-james.morse@arm.com>
MIME-Version: 1.0
Message-ID: <163336605365.25758.3996074729220568354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7adeda06ac6c30d6f13f474974225143ff1eecf3
Gitweb:        https://git.kernel.org/tip/7adeda06ac6c30d6f13f474974225143ff1eecf3
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Fri, 17 Sep 2021 16:59:58 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Oct 2021 18:32:08 +02:00

x86/resctrl: Free the ctrlval arrays when domain_setup_mon_state() fails

domain_add_cpu() is called whenever a CPU is brought online. The
earlier call to domain_setup_ctrlval() allocates the control value
arrays.

If domain_setup_mon_state() fails, the control value arrays are not
freed.

Add the missing kfree() calls.

Fixes: 1bd2a63b4f0de ("x86/intel_rdt/mba_sc: Add initialization support")
Fixes: edf6fa1c4a951 ("x86/intel_rdt/cqm: Add RMID (Resource monitoring ID) management")
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lkml.kernel.org/r/20210917165958.28313-1-james.morse@arm.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 4b8813b..b5de5a6 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -532,6 +532,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 	}
 
 	if (r->mon_capable && domain_setup_mon_state(r, d)) {
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
 		kfree(d);
 		return;
 	}
