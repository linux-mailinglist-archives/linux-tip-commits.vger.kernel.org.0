Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0110842EE00
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhJOJrW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhJOJrR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E1C061767;
        Fri, 15 Oct 2021 02:45:02 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:45:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJxYj4zKjdCALeQv0WNWk/FdvlTGQpnYSzmxhrfnvq8=;
        b=HIW70PDi4tzfWggoeFnnVwOq5agIspx+SfrqlgBnvauJciW/6mz/NxXnpyyXNt/jK8dZhp
        l9QpLOiVaWMGbuHSOhXQgxsByYeC4thADoLaTcm6iE3MqGI4R7WTpQBgwlsdGtstHnZngi
        FS2xlcgKMFuUPaQzLo7yqB37CqBRHXj97HCqzA+kWIl4ZcaADZJsQI7/NnyczQjSt7FZkf
        1cPxbh6gbmNbxrdLFJEXdMnwk/dM9ZVEVDBDVTmdlB2cyg1FpH9RM3ejrRzrsIrxZB3x6j
        3uq63kCcP4G5iU2D/edDsFKosIXwtdG7LjMjFkiUDHKpprtGzzd4+CisOLO5cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291101;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJxYj4zKjdCALeQv0WNWk/FdvlTGQpnYSzmxhrfnvq8=;
        b=2leVS+hkp4xI6DT+XgnDWRWQ4F6eUx2sgKs+b+zZgqk3gBNdfNXBhIkTcp5facryv4P74O
        PnF3Nz3oR2eZH7Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Disable -Wunused-but-set-variable
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
References: <YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <163429110057.25758.11301671308206196345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     37b47298ab864fb3f5488ddebfc35267ceab0553
Gitweb:        https://git.kernel.org/tip/37b47298ab864fb3f5488ddebfc35267ceab0553
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Oct 2021 16:08:07 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:15 +02:00

sched: Disable -Wunused-but-set-variable

The compilers can't deal with obvious DCE vs that warning, resulting
in code like:

	if (0) {
		sched sched_statistics *stats;

		stats = __schedstats_from_se(se);

		...
	}

triggering the warning. Kill the warning to make the robots stop
reporting this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lkml.kernel.org/r/YWWPLnaZGybHsTkv@hirez.programming.kicks-ass.net
---
 kernel/sched/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 978fcfc..c7421f2 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -3,6 +3,10 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_clock.o = $(CC_FLAGS_FTRACE)
 endif
 
+# The compilers are complaining about unused variables inside an if(0) scope
+# block. This is daft, shut them up.
+ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
+
 # These files are disabled because they produce non-interesting flaky coverage
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
