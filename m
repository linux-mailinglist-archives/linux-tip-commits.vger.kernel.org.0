Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29529319EE6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhBLMnJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhBLMkh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:37 -0500
Date:   Fri, 12 Feb 2021 12:37:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wRLam6/fGvUhXKBF+vDOrnMBfBiYsGraHC/eivTr+9A=;
        b=oPrg48YPmegvD2oMIBKNK+8jW4ZNUMv30fsgZXnpUPSch69m68FM3Wlw5f1ht7h1WM/gQc
        pABMOshbjLe3Q4cbfD9vQBZy96QrTMlfVhFNom75ii1hU+U96N05goDH5cTZ8xYIEfBaOU
        fn1Qk+jgio0wL+NlMvZaKZOJgId/ultkimnWXSI6tqTzYhy6YnTLbBnt2xTUSAQ9fwLXsf
        tHUp+L7+Z0ARU3VPqX6PUZX7418+U62Ga87C4WLXyab5vtpYpr0PLV+yn3z+az5a7crV1b
        D3YluuR53RgEyl9Fs/MWAnhpQVYbPsRHMh9aT6q4pk8BPy63bj0F9tybGo2EPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133443;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wRLam6/fGvUhXKBF+vDOrnMBfBiYsGraHC/eivTr+9A=;
        b=hPmxQJGGy4cFK3YTsNifBoOD3ENKi04KArsWb5404d8Opv2IFOgBBczoVWqfcpZ6/nRgq0
        SmOpWM/dg4gB35CA==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc: Update RCU's requirements page about the PREEMPT_RT wiki
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344277.23325.2783889093817166455.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     361c0f3d80dc3b54c20a19e8ffa2ad728fc1d23d
Gitweb:        https://git.kernel.org/tip/361c0f3d80dc3b54c20a19e8ffa2ad728fc1d23d
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 15 Dec 2020 15:16:48 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:10:41 -08:00

doc: Update RCU's requirements page about the PREEMPT_RT wiki

The PREEMPT_RT wiki moved from kernel.org to the Linux Foundation wiki.
The kernel.org wiki is read only.

This commit therefore updates the URL of the active PREEMPT_RT wiki.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Requirements/Requirements.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 65c7839..bac1cdd 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2317,7 +2317,7 @@ decides to throw at it.
 
 The Linux kernel is used for real-time workloads, especially in
 conjunction with the `-rt
-patchset <https://rt.wiki.kernel.org/index.php/Main_Page>`__. The
+patchset <https://wiki.linuxfoundation.org/realtime/>`__. The
 real-time-latency response requirements are such that the traditional
 approach of disabling preemption across RCU read-side critical sections
 is inappropriate. Kernels built with ``CONFIG_PREEMPT=y`` therefore use
