Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D184D9647
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Mar 2022 09:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbiCOIcV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Mar 2022 04:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbiCOIcU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Mar 2022 04:32:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220324C79D;
        Tue, 15 Mar 2022 01:31:04 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:31:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=naWissguvNUtri6tsWrBs+WCRjQB+bjj9V6hqX3z/E4=;
        b=B/eYFrzXIUvuYe9ldGUhQQmXug3lw5cYocOBySRgafXGjdoc5xeKGqHl9R/pKNViy4pnMv
        6s7H+z2qADPlS4JioVFJzqiniYgi1pal/Hz9tl0XbFLWB3WtuePsuwlHoWkbvDEMrvvPkk
        3IOKqdloBOasjcjrRpZSSGjyKCsMePXwhsqxS2YRx5lzt4ZntqD7jXpC0il7DhSmq7VwIC
        azyJOByvj5qWdJ+YWjZ88Vwl6YU3U+udNg9ujrF+NZHx3UfkWZfJzV2htpPpNDuk/sWZse
        FgLf10/ntXbWErwoTitiUoA1Y+pTcfyADvwMClbknfWDd7msBskw4HgAh85XxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333062;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=naWissguvNUtri6tsWrBs+WCRjQB+bjj9V6hqX3z/E4=;
        b=6IjR+nPTDryBxrpA8PQV+uXtzN5deqOQTPH6v0D1vcQQIYdZHhHtjo27OsXISp7vOnUdGZ
        y8r5r9vXAls29KDA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/headers: Fix comment typo in
 kernel/sched/cpudeadline.c
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164733306179.16921.558522391078367688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     81de6572fe980a98a1c6c5eacdfd2a9137894f32
Gitweb:        https://git.kernel.org/tip/81de6572fe980a98a1c6c5eacdfd2a9137894f32
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 21 Jun 2021 08:50:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 23 Feb 2022 10:58:33 +01:00

sched/headers: Fix comment typo in kernel/sched/cpudeadline.c

File name changed.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/cpudeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index ceb03d7..0e196f0 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  kernel/sched/cpudl.c
+ *  kernel/sched/cpudeadline.c
  *
  *  Global CPU deadline management
  *
