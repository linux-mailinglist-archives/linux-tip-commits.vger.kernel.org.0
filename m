Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166D53B5F79
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 15:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhF1OAd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 10:00:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhF1OAc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 10:00:32 -0400
Date:   Mon, 28 Jun 2021 13:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624888685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/rUXhBw61ZzkPZSv2TGuMwQZIFhgiOLNr+FSKbSV7E=;
        b=gcz2KDQN4caCs5tQZWUkgj1mk1KhweRNE+baMnexNa66TiVLOFkeYzBK1Fk/r95isQP8kV
        jPZFn4W+Coyu2qy7XoJMO7eCrBf1BtdZqwIl1VQVbQiq1ZKTxc/GHisZcUmINr5iI96xic
        W02wGjxDyVUXax9/hC01VF7AYs/7yq4Pu1x9zq9PTuiWQC7qzadQNUB0ufShYCH1c/2EVd
        /DEbxXq6Ovj8LtxcAv4cP2nbJaam1YExTJPonaD5ZhcyHl6crD66yP8SB054rJs84M+p7M
        tbx3iuhZwCpNgbetjdISJl7lYrMk0tl+/e6+j7DXM8eXawnrfkAuigGPpMWwRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624888685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/rUXhBw61ZzkPZSv2TGuMwQZIFhgiOLNr+FSKbSV7E=;
        b=p1KQeRXiZcyaH8sHavVzXou9DE3vOfhRt+ZIoABpeZQ2sVgwj35aHnjfIyeyZ7L9id1Zwt
        7pV3mJRHh7TNPsBQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Don't update sched_domain debug
 directories before sched_debug_init()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210514095339.12979-1-ionela.voinescu@arm.com>
References: <20210514095339.12979-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Message-ID: <162488868483.395.10332851489251840487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     459b09b5a3254008b63382bf41a9b36d0b590f57
Gitweb:        https://git.kernel.org/tip/459b09b5a3254008b63382bf41a9b36d0b590f57
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 18 May 2021 14:07:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 28 Jun 2021 15:42:24 +02:00

sched/debug: Don't update sched_domain debug directories before sched_debug_init()

Since CPU capacity asymmetry can stem purely from maximum frequency
differences (e.g. Pixel 1), a rebuild of the scheduler topology can be
issued upon loading cpufreq, see:

  arch_topology.c::init_cpu_capacity_callback()

Turns out that if this rebuild happens *before* sched_debug_init() is
run (which is a late initcall), we end up messing up the sched_domain debug
directory: passing a NULL parent to debugfs_create_dir() ends up creating
the directory at the debugfs root, which in this case creates
/sys/kernel/debug/domains (instead of /sys/kernel/debug/sched/domains).

This currently doesn't happen on asymmetric systems which use cpufreq-scpi
or cpufreq-dt drivers, as those are loaded via
deferred_probe_initcall() (it is also a late initcall, but appears to be
ordered *after* sched_debug_init()).

Ionela has been working on detecting maximum frequency asymmetry via ACPI,
and that actually happens via a *device* initcall, thus before
sched_debug_init(), and causes the aforementionned debugfs mayhem.

One option would be to punt sched_debug_init() down to
fs_initcall_sync(). Preventing update_sched_domain_debugfs() from running
before sched_debug_init() appears to be the safer option.

Fixes: 3b87f136f8fc ("sched,debug: Convert sysctl sched_domains to debugfs")
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lore.kernel.org/r/20210514095339.12979-1-ionela.voinescu@arm.com
---
 kernel/sched/debug.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0c5ec27..7e08e3d 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -388,6 +388,13 @@ void update_sched_domain_debugfs(void)
 {
 	int cpu, i;
 
+	/*
+	 * This can unfortunately be invoked before sched_debug_init() creates
+	 * the debug directory. Don't touch sd_sysctl_cpus until then.
+	 */
+	if (!debugfs_sched)
+		return;
+
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
