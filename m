Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A333E7D45
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhHJQPT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 12:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbhHJQPJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 12:15:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DA0C0613C1;
        Tue, 10 Aug 2021 09:14:43 -0700 (PDT)
Date:   Tue, 10 Aug 2021 16:14:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628612081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sWYworXM1Re3xdahtW2atWngQ9WPEp2f0ww8qMR8c8=;
        b=qM0WqsnRraz8XpDaFOniHCDxNEsjnzV6bRfKr0DcIxPAXCIPYqQgiGinrdyQ4Acg/DFE4L
        BNdcF6EQPZSNzb9WU0LF70DSckz5JpOKXPNR3bGyTi/Rl9PqMY8GyiooPiGZ0qOx5LRUra
        470d/mebFDlIGRmefAGC+2wnMavht4cFk7VDtHb2DdeETVXgxOHP8prUiCKY1GpAOJQylj
        lP5963t2e+7OV/yw8qs5QWDJoRbzP7giNKLlLbL90DjQSvjs4BGhgAfzHh7LzLa5UDWBzm
        dK02i6b1rT8fDok6GzXqtkERwvS47z3X+f/hrVoRhnM4s71JwuDxoczuHIJVUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628612081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sWYworXM1Re3xdahtW2atWngQ9WPEp2f0ww8qMR8c8=;
        b=iqoSYzTOrw5MicQXUGHQfDaVfDoHC1d0cdzV0XNqBgwrKjrojJ8lnrHPVUfGP6ik3u2zm6
        1Wz4KUH+81FOmnDw==
From:   "tip-bot2 for Baokun Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Fix kernel doc warnings for
 __cpuhp_setup_state_cpuslocked()
Cc:     Baokun Li <libaokun1@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210605063003.681049-1-libaokun1@huawei.com>
References: <20210605063003.681049-1-libaokun1@huawei.com>
MIME-Version: 1.0
Message-ID: <162861208037.395.5262831120311169946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     ed3cd1da674034c4800abfc48c26f2742d5df17e
Gitweb:        https://git.kernel.org/tip/ed3cd1da674034c4800abfc48c26f2742d5df17e
Author:        Baokun Li <libaokun1@huawei.com>
AuthorDate:    Sat, 05 Jun 2021 14:30:03 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 18:07:38 +02:00

cpu/hotplug: Fix kernel doc warnings for __cpuhp_setup_state_cpuslocked()

Fixes the following W=1 kernel build warning(s):

 kernel/cpu.c:1949: warning: Function parameter or member 
  'name' not described in '__cpuhp_setup_state_cpuslocked'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210605063003.681049-1-libaokun1@huawei.com

---
 kernel/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 804b847..8930a4e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1976,6 +1976,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
 /**
  * __cpuhp_setup_state_cpuslocked - Setup the callbacks for an hotplug machine state
  * @state:		The state to setup
+ * @name:		Name of the step
  * @invoke:		If true, the startup function is invoked for cpus where
  *			cpu state >= @state
  * @startup:		startup callback function
