Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F14D28CB5A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Oct 2020 12:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgJMKCP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 13 Oct 2020 06:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgJMKCP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 13 Oct 2020 06:02:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E02C0613D0;
        Tue, 13 Oct 2020 03:02:15 -0700 (PDT)
Date:   Tue, 13 Oct 2020 10:02:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602583333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLGZ1IVnAZvlBiYo2syEQqJNVOael+rGLim+qGCoBoo=;
        b=XLw2qoo8SR43phSBDgCF/tnalWXC5JBbAoj0/pGkzgxRtf749FPh6qMvOy91H5ISHRYz3d
        lko0ga0x1u05cZtWsPtVjp+9zAAstril3CgqMadFsOz8hRy6+2hkKwG+1kJS+KQf/erAfv
        3enrhazLZljsf/gCAb62etXvaDhhOGnmguKQ20p4wkbWxXF+LkW8EArV13LzjkXC2Dg3/e
        Pmbo4xRBCeM+/4G+ytd19TjpBnjxs+b9dmxpNjLDRt8Qi9YNv/lWyvXXrTNqAVrGdSidgq
        /eNrLl4VpHHJCwtPnJVsxV/eOGdE11873dEFiGF76OyNyTZn/b33xMPnENgEPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602583333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLGZ1IVnAZvlBiYo2syEQqJNVOael+rGLim+qGCoBoo=;
        b=j1RvTFRZ2s3c/KFYgNVxCH2K2kDveyYA4bTr3lFgQJp73XIbN78cwt+G3pvmt0QmJfUljg
        PZctyY/Ap4jVC/BQ==
From:   "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/features: Fix !CONFIG_JUMP_LABEL case
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201013053114.160628-1-juri.lelli@redhat.com>
References: <20201013053114.160628-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Message-ID: <160258333212.7002.8735934317227878261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     da912c29a4a552588cbfa895487d9d5523b6faa7
Gitweb:        https://git.kernel.org/tip/da912c29a4a552588cbfa895487d9d5523b6faa7
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Tue, 13 Oct 2020 07:31:14 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 13 Oct 2020 11:33:08 +02:00

sched/features: Fix !CONFIG_JUMP_LABEL case

Commit:

  765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")

made sched features static for !CONFIG_SCHED_DEBUG configurations, but
overlooked the CONFIG_SCHED_DEBUG=y and !CONFIG_JUMP_LABEL cases.

For the latter echoing changes to /sys/kernel/debug/sched_features has
the nasty effect of effectively changing what sched_features reports,
but without actually changing the scheduler behaviour (since different
translation units get different sysctl_sched_features).

Fix CONFIG_SCHED_DEBUG=y and !CONFIG_JUMP_LABEL configurations by properly
restructuring ifdefs.

Fixes: 765cc3a4b224e ("sched/core: Optimize sched_feat() for !CONFIG_SCHED_DEBUG builds")
Co-developed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Patrick Bellasi <patrick.bellasi@matbug.net>
Link: https://lore.kernel.org/r/20201013053114.160628-1-juri.lelli@redhat.com
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/sched.h | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8160ab5..d2003a7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -44,7 +44,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
+#ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6..8d1ca65 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1629,7 +1629,7 @@ enum {
 
 #undef SCHED_FEAT
 
-#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_JUMP_LABEL)
+#ifdef CONFIG_SCHED_DEBUG
 
 /*
  * To support run-time toggling of sched features, all the translation units
@@ -1637,6 +1637,7 @@ enum {
  */
 extern const_debug unsigned int sysctl_sched_features;
 
+#ifdef CONFIG_JUMP_LABEL
 #define SCHED_FEAT(name, enabled)					\
 static __always_inline bool static_branch_##name(struct static_key *key) \
 {									\
@@ -1649,7 +1650,13 @@ static __always_inline bool static_branch_##name(struct static_key *key) \
 extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 #define sched_feat(x) (static_branch_##x(&sched_feat_keys[__SCHED_FEAT_##x]))
 
-#else /* !(SCHED_DEBUG && CONFIG_JUMP_LABEL) */
+#else /* !CONFIG_JUMP_LABEL */
+
+#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
+
+#endif /* CONFIG_JUMP_LABEL */
+
+#else /* !SCHED_DEBUG */
 
 /*
  * Each translation unit has its own copy of sysctl_sched_features to allow
@@ -1665,7 +1672,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 
 #define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
-#endif /* SCHED_DEBUG && CONFIG_JUMP_LABEL */
+#endif /* SCHED_DEBUG */
 
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
