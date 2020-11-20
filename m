Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11A2BAA38
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgKTMeS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgKTMeK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52C3C0613CF;
        Fri, 20 Nov 2020 04:34:09 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:34:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nF1HoHSFVRBWBfN9j0IUyFvGWYJKtElnQpu9GuQFIOc=;
        b=KCiy5na6jL2sm2kwHp6ZO2iNXA6eoXuog1roMvs5iD+IOkeaeAMBChdvjc1dQISZxLGsBx
        kdmx8NVh9WSlaVGvD9NbzxGCkfDdYyRYjPKQtWwYt1JBay2K4xraT+FEhKoxJezVmx+x0y
        LqCm4MebiIA7hsZ+btiBQh/52sJsXHf64yg+X+Q9mz13su4XFS69AVXrre1kYgDfzkeYFk
        S6djURgw/OlcVd7NRdAxr6R4JE9UXzILuURvTvb0So60xwwLgrGmBDxNkYSK58iZYcWy0w
        6ndloJO0izm9MRQQEBCZHjqJJ4jAb/g5yg8bvraDOqwdrj3gl8w4DPf7gr3bYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875648;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nF1HoHSFVRBWBfN9j0IUyFvGWYJKtElnQpu9GuQFIOc=;
        b=XgIJzKKB36vOofjC01WBr8REApV3Afx1cuNStpjzPNvO7AtSQtks/XVi+MS7pf4MdsJfqc
        sjCU4n06Hd6nsLDA==
From:   "tip-bot2 for Barry Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] Documentation: scheduler: fix information on arch
 SD flags, sched_domain and sched_debug
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201113115018.1628-1-song.bao.hua@hisilicon.com>
References: <20201113115018.1628-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Message-ID: <160587564747.11244.10441742114321996450.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9032dc211523f7cd5395302a0658c306249553f4
Gitweb:        https://git.kernel.org/tip/9032dc211523f7cd5395302a0658c306249553f4
Author:        Barry Song <song.bao.hua@hisilicon.com>
AuthorDate:    Sat, 14 Nov 2020 00:50:18 +13:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:46 +01:00

Documentation: scheduler: fix information on arch SD flags, sched_domain and sched_debug

This document seems to be out of date for many, many years. Even it has
misspelled from the first day.
ARCH_HASH_SCHED_TUNE should be ARCH_HAS_SCHED_TUNE
ARCH_HASH_SCHED_DOMAIN should be ARCH_HAS_SCHED_DOMAIN

Since v2.6.14, kernel completely deleted the relevant code and even
arch_init_sched_domains() was deleted.

Right now, kernel is asking architectures to call set_sched_topology() to
override the default sched domains.

On the other hand, to print the schedule debug information, users need to
set sched_debug cmdline or enable it by sysfs entry. So this patch also
adds the description for sched_debug.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20201113115018.1628-1-song.bao.hua@hisilicon.com
---
 Documentation/scheduler/sched-domains.rst | 26 +++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 5c4b7f4..8582fa5 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -65,21 +65,17 @@ of the SMP domain will span the entire machine, with each group having the
 cpumask of a node. Or, you could do multi-level NUMA or Opteron, for example,
 might have just one domain covering its one NUMA level.
 
-The implementor should read comments in include/linux/sched.h:
-struct sched_domain fields, SD_FLAG_*, SD_*_INIT to get an idea of
-the specifics and what to tune.
+The implementor should read comments in include/linux/sched/sd_flags.h:
+SD_* to get an idea of the specifics and what to tune for the SD flags
+of a sched_domain.
 
-Architectures may retain the regular override the default SD_*_INIT flags
-while using the generic domain builder in kernel/sched/core.c if they wish to
-retain the traditional SMT->SMP->NUMA topology (or some subset of that). This
-can be done by #define'ing ARCH_HASH_SCHED_TUNE.
-
-Alternatively, the architecture may completely override the generic domain
-builder by #define'ing ARCH_HASH_SCHED_DOMAIN, and exporting your
-arch_init_sched_domains function. This function will attach domains to all
-CPUs using cpu_attach_domain.
+Architectures may override the generic domain builder and the default SD flags
+for a given topology level by creating a sched_domain_topology_level array and
+calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched domains
-which should catch most possible errors (described above). It also prints out
-the domain structure in a visual format.
+CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you forgot to
+tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
+knob. This enables an error checking parse of the sched domains which should
+catch most possible errors (described above). It also prints out the domain
+structure in a visual format.
