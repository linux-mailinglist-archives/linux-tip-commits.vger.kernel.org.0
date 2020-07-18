Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C6B224745
	for <lists+linux-tip-commits@lfdr.de>; Sat, 18 Jul 2020 02:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgGRAB5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 20:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgGRAB5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 20:01:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D05C0619D2;
        Fri, 17 Jul 2020 17:01:57 -0700 (PDT)
Date:   Sat, 18 Jul 2020 00:01:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595030515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MukbcjmBrDg2Lx48HStzUZb1PPE5amUzAQIMc8hjWBI=;
        b=h/w0vVMgtmmf+mnnyAyHYRHoNGEXU8gkXXfZ5eqks2VQClDWbpPZXDkFQA2TTVz0GCQ4PL
        CaGnsxt2Il4HtsV0Hbw08iWw094Aoigrh/4IqjFGPRKzj1Aj8adurNKmDjTuqKnzxz5/Vm
        wjv1uZ5DesioNBrNX6x6NCsvH5uCFTONDRLuU3xmblYjK0YHI18TpqP6B0XtBGaU8wpSsm
        tVPOgFGsWgii7ZfVKVIxpMOdp/eimGt+KMNNIzP6JIiHr7St6nCysZMwu4Vk05mrsycI5B
        h2y4CUt8xWGsdYmLg/mHRgQwxXGCAcVzE8FlVrHW9OO2oEx3DJzRxBJLZUtlSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595030515;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MukbcjmBrDg2Lx48HStzUZb1PPE5amUzAQIMc8hjWBI=;
        b=JBx9dv+eKaLd1kYbMTAIfw19HtzvS4mD+RRSLuvfBTcoQe9lYWzHiTUPtkzJAlL6GZX0gv
        aDqOEC4baraqc1Aw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Remove unused or redundant includes
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200702202843.520764-4-andrealmeid@collabora.com>
References: <20200702202843.520764-4-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <159503051436.4006.10659426956008198981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9a71df495c3d29dab596bb590e73fd8b20106e2d
Gitweb:        https://git.kernel.org/tip/9a71df495c3d29dab596bb590e73fd8b201=
06e2d
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Thu, 02 Jul 2020 17:28:42 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 18 Jul 2020 01:56:09 +02:00

futex: Remove unused or redundant includes

Since 82af7aca ("Removal of FUTEX_FD"), some includes related to file
operations aren't needed anymore. More investigation around the includes
showed that a lot of includes aren't required for compilation, possible
due to redundant includes. Simplify the code by removing unused
includes.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200702202843.520764-4-andrealmeid@collabora=
.com

---
 kernel/futex.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index cda9175..4616d4a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -32,30 +32,13 @@
  *  "But they come in a choice of three flavours!"
  */
 #include <linux/compat.h>
-#include <linux/slab.h>
-#include <linux/poll.h>
-#include <linux/fs.h>
-#include <linux/file.h>
 #include <linux/jhash.h>
-#include <linux/init.h>
-#include <linux/futex.h>
-#include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
-#include <linux/signal.h>
-#include <linux/export.h>
-#include <linux/magic.h>
-#include <linux/pid.h>
-#include <linux/nsproxy.h>
-#include <linux/ptrace.h>
-#include <linux/sched/rt.h>
-#include <linux/sched/wake_q.h>
-#include <linux/sched/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/freezer.h>
 #include <linux/memblock.h>
 #include <linux/fault-inject.h>
-#include <linux/refcount.h>
=20
 #include <asm/futex.h>
=20
