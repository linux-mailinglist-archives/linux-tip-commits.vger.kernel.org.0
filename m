Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF031FB050
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Jun 2020 14:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgFPMVz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Jun 2020 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbgFPMVz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:55 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F8C08C5C2;
        Tue, 16 Jun 2020 05:21:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlAb7-0004cc-Bo; Tue, 16 Jun 2020 14:21:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E97F61C04CC;
        Tue, 16 Jun 2020 14:21:48 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:21:48 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes: Add perf ksymbol events for kprobe insn pages
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200512121922.8997-5-adrian.hunter@intel.com>
References: <20200512121922.8997-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <159231010874.16989.1750544206697128249.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     69e49088692899d25dedfa22f00dfb9761e86ed7
Gitweb:        https://git.kernel.org/tip/69e49088692899d25dedfa22f00dfb9761e86ed7
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 12 May 2020 15:19:11 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:09:49 +02:00

kprobes: Add perf ksymbol events for kprobe insn pages

Symbols are needed for tools to describe instruction addresses. Pages
allocated for kprobe's purposes need symbols to be created for them.
Add such symbols to be visible via perf ksymbol events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lkml.kernel.org/r/20200512121922.8997-5-adrian.hunter@intel.com
---
 include/uapi/linux/perf_event.h |  5 +++++
 kernel/kprobes.c                | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index e5bee6c..e1a4179 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1049,6 +1049,11 @@ enum perf_event_type {
 enum perf_record_ksymbol_type {
 	PERF_RECORD_KSYMBOL_TYPE_UNKNOWN	= 0,
 	PERF_RECORD_KSYMBOL_TYPE_BPF		= 1,
+	/*
+	 * Out of line code such as kprobe-replaced instructions or optimized
+	 * kprobes.
+	 */
+	PERF_RECORD_KSYMBOL_TYPE_OOL		= 2,
 	PERF_RECORD_KSYMBOL_TYPE_MAX		/* non-ABI */
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 058c0be..2b58740 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -35,6 +35,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/jump_label.h>
+#include <linux/perf_event.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -184,6 +185,10 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	kip->cache = c;
 	list_add_rcu(&kip->list, &c->pages);
 	slot = kip->insns;
+
+	/* Record the perf ksymbol register event after adding the page */
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL, (unsigned long)kip->insns,
+			   PAGE_SIZE, false, c->sym);
 out:
 	mutex_unlock(&c->mutex);
 	return slot;
@@ -202,6 +207,13 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 		 * next time somebody inserts a probe.
 		 */
 		if (!list_is_singular(&kip->list)) {
+			/*
+			 * Record perf ksymbol unregister event before removing
+			 * the page.
+			 */
+			perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_OOL,
+					   (unsigned long)kip->insns, PAGE_SIZE, true,
+					   kip->cache->sym);
 			list_del_rcu(&kip->list);
 			synchronize_rcu();
 			kip->cache->free(kip->insns);
