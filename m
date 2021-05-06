Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB945375516
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhEFNt3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbhEFNt2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63288C061761;
        Thu,  6 May 2021 06:48:29 -0700 (PDT)
Date:   Thu, 06 May 2021 13:48:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEo2bIO3f2ooTnap4RnolLv3lYAVM02GdQYZM4Amv2o=;
        b=2RJBTcYl0P3xJQi1AwcePHQk4rRpGxptB8Xx5Jo42bkrBzCtHP9jAF+dUqZleLpVDRxbVk
        BBN/jLybiwKzV4HM4OvUmw5qqerZRngBwE8ucMuUShSRr80ZOYuEOV4bu3Plb+EHGSlIgt
        u3FkiA0TiM7wyJefnbsgDwXRk6+eoYNw6V1NCUuxMGHHqzgkjgcz1n98+6uxMbBQ0ISOE6
        CWg5JjCmtYMCcxQkuULdPIpQvrUrC039KvsIKmB8dfYhJRNrQb0l4D0KZ/9ItuNjqNms5t
        r06CFnExymzXvA4Z1QBij2+JSq/JSznozxFuWC9AFNOYsq7VDfw07DGivMI69w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEo2bIO3f2ooTnap4RnolLv3lYAVM02GdQYZM4Amv2o=;
        b=4UvwfMfEcfhVXoW5WT+QI3LMOYnBkf3dgqivz1DkFCQjBIt9HJPdc+YMsrGc6qXSX4bOTR
        VQ3qJqdXpyNl7RBw==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched,doc: sched_debug_verbose cmdline should be
 sched_verbose
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210504105344.31344-1-song.bao.hua@hisilicon.com>
References: <20210504105344.31344-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <162030890739.29796.16484140515421185463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     19987fdad506515a92b3c430076cbdb329a11aee
Gitweb:        https://git.kernel.org/tip/19987fdad506515a92b3c430076cbdb329a11aee
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Tue, 04 May 2021 22:53:43 +12:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:26 +02:00

sched,doc: sched_debug_verbose cmdline should be sched_verbose

The cmdline should include sched_verbose but not sched_debug_verbose
as sched_debug_verbose is only the variant name in code.

Fixes: 9406415f46 ("sched/debug: Rename the sched_debug parameter to sched_verbose")
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210504105344.31344-1-song.bao.hua@hisilicon.com
---
 Documentation/scheduler/sched-domains.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 14ea2f2..84dcdcd 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -74,7 +74,7 @@ for a given topology level by creating a sched_domain_topology_level array and
 calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_debug_verbose' to your cmdline. If you
+CONFIG_SCHED_DEBUG and adding 'sched_verbose' to your cmdline. If you
 forgot to tweak your cmdline, you can also flip the
 /sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
 the sched domains which should catch most possible errors (described above). It
