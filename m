Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5233F07F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCQMig (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCQMi0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A05C06174A;
        Wed, 17 Mar 2021 05:38:26 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:38:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvzSCD844kW1TR0bgZFjibM8oBd8rgGTmd9/5/ual1k=;
        b=cpzu/huDzcCtfpRv3wRXauh0diR8L/jXd350Ov+iJRhsCoHepS06XE3gpB/l2vSS8evhMV
        E7oQAe+bC8Lr1z8gWTRqBPd/wLtBGIam/4KUcl6z76qpJthRAAmQA+YjFQy27SChoR35Zo
        DL4lGdOHracnPPkErN26iQT/oSaRMUEa/hw4sLhXJFBniuaKjc5LQPCPRqfRvvCzSAjeHp
        ZjTe1E2vzm6Cl7O5Zcehr+uUROvDNnxmD4AwxI7C4G2ohihXuD5vtnyK8vrfL2R9MXoeZc
        QbkfMwSApAag4XgFyeTF7BIMTjVMNqSmGOMbFEF5PUJ8ql9UeqmfW5A2q7N9vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984704;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PvzSCD844kW1TR0bgZFjibM8oBd8rgGTmd9/5/ual1k=;
        b=ClPavbhHRgOKSKBo5zqDdW5yWDZi/UJzwoqhOl6cevrN3uYevBOIatxg87Dxqs08H8Ap9c
        HVBZp8LUwaE5wlDQ==
From:   "tip-bot2 for Ondrej Mosnacek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix unconditional security_locked_down() call
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Paul Moore <paul@paul-moore.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210224215628.192519-1-omosnace@redhat.com>
References: <20210224215628.192519-1-omosnace@redhat.com>
MIME-Version: 1.0
Message-ID: <161598470430.398.3377989807660510985.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     08ef1af4de5fe7de9c6d69f1e22e51b66e385d9b
Gitweb:        https://git.kernel.org/tip/08ef1af4de5fe7de9c6d69f1e22e51b66e385d9b
Author:        Ondrej Mosnacek <omosnace@redhat.com>
AuthorDate:    Wed, 24 Feb 2021 22:56:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 16 Mar 2021 21:44:43 +01:00

perf/core: Fix unconditional security_locked_down() call

Currently, the lockdown state is queried unconditionally, even though
its result is used only if the PERF_SAMPLE_REGS_INTR bit is set in
attr.sample_type. While that doesn't matter in case of the Lockdown LSM,
it causes trouble with the SELinux's lockdown hook implementation.

SELinux implements the locked_down hook with a check whether the current
task's type has the corresponding "lockdown" class permission
("integrity" or "confidentiality") allowed in the policy. This means
that calling the hook when the access control decision would be ignored
generates a bogus permission check and audit record.

Fix this by checking sample_type first and only calling the hook when
its result would be honored.

Fixes: b0c8fdc7fdb7 ("lockdown: Lock down perf when in confidentiality mode")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Link: https://lkml.kernel.org/r/20210224215628.192519-1-omosnace@redhat.com
---
 kernel/events/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6182cb1..f079431 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11833,12 +11833,12 @@ SYSCALL_DEFINE5(perf_event_open,
 			return err;
 	}
 
-	err = security_locked_down(LOCKDOWN_PERF);
-	if (err && (attr.sample_type & PERF_SAMPLE_REGS_INTR))
-		/* REGS_INTR can leak data, lockdown must prevent this */
-		return err;
-
-	err = 0;
+	/* REGS_INTR can leak data, lockdown must prevent this */
+	if (attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+		err = security_locked_down(LOCKDOWN_PERF);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * In cgroup mode, the pid argument is used to pass the fd
