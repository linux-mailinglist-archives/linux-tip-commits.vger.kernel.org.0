Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C62D8FA3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391739AbgLMTDC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391265AbgLMTDA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C6EC0619DD;
        Sun, 13 Dec 2020 11:01:14 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hBZ5uCgzdY5nSqbPen3+yoMYuv53BxyRFZBDiUKjVbI=;
        b=KyyTEV2IryslgyNBxS/Ajgby5buP4hoOVv0LXLCsy1OEJW4Aoy4Q1N71kRGyKJUKIVoYW7
        7tkLlzq/KSe1MvNUHos5nR/XuYDSejZy/KNQkqoncedWSXywLJhd/J/wTeK8teEVhgyGn3
        lnyKI4q2o3Gnt2HOW/unwnUN+rBAYyCw3IabXKST4b3zvyt6aeJicTI0ELiN8b9iODYrZR
        wZYuxIamb+/e24IYaKMxICt0bcs2krI5v0omzDBeBWh71/BBgbtcJj+HXI35wg1aElpDWP
        5p5kQC8xpIgBY0oIyLwo1sJj8sI1rhzi92Y7Zlh2AJ09Tg3P0N2SMrJCZButJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hBZ5uCgzdY5nSqbPen3+yoMYuv53BxyRFZBDiUKjVbI=;
        b=zOfZiS9gN5RS108E7RGbwp00MeE/jJfo3TnRTUiL3ZsjjtVv71X212I6ulxlejq/Pgmy8g
        uquATj5NeyMU20Aw==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] docs: RCU: Requirements.rst: Fix a list block
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607145.3364.2395985164138386021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a1b9dbb72b7f39eeaa2fb5bd5cc619679985876e
Gitweb:        https://git.kernel.org/tip/a1b9dbb72b7f39eeaa2fb5bd5cc619679985876e
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Tue, 06 Oct 2020 15:21:32 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:02:43 -08:00

docs: RCU: Requirements.rst: Fix a list block

As warned by Sphinx:
	.../Documentation/RCU/Design/Requirements/Requirements.rst:1959: WARNING: Unexpected indentation.

The list block is missing a space before it, making Sphinx to get
it wrong.  This commit therefore adds the missing space characters.

Fixes: 2a721e5f0b2c ("docs: Update RCU's hotplug requirements with a bit about design")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 8807985..e8c84fc 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1954,6 +1954,7 @@ offline CPUs.  However, as a debugging measure, the FQS loop does splat
 if offline CPUs block an RCU grace period for too long.
 
 An offline CPU's quiescent state will be reported either:
+
 1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
 2.  When grace period initialization (``rcu_gp_init()``) detects a
     race either with CPU offlining or with a task unblocking on a leaf
