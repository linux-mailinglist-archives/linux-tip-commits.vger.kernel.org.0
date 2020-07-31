Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962F5234305
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgGaJ1o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56434 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732339AbgGaJXF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:05 -0400
Date:   Fri, 31 Jul 2020 09:23:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LpICeYlP0ZLqXrpm6Kf1JML5onMJzwE9/ZMd222cnBg=;
        b=frmDXbLUfd6x52Qr0Idu2TIsaI3MyUDtjNFol1SM9pbXUydByjcJqawPfGwoPA4JgNqlTl
        hGOpJ47TAbpwKBzgms08cWjdrVOhYRtBb7HRQ4TNpVruUTqhbraOv58A2aolNliuX/qyGk
        eQr3XG7SO6uas2ssv1GYG/YayseUVt8IGWD5b4El6UgFaF4ctHDlWJHMZZgRR9k2EI4LSy
        hpW/sEIWJP3dfozoces1wXY99m1BPVNUyGOyfp3YBK+wFkAqy8UnPfnM4Rqt1kbV0RIhJV
        f2akY5tWW/Ycek8oxYj8sP09PPE2hUk8yBENfpxm1k9IyRia1dRvn+zUEoWQ5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187383;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=LpICeYlP0ZLqXrpm6Kf1JML5onMJzwE9/ZMd222cnBg=;
        b=t7cjv8RKp+1mVA9P/+9naZMhg072XvhgaJlpDzjhhFqUw9cAlEieCjFplPIkEuhm1IRjeW
        6Z/Aonq5q1uv7aBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Make functions static
Cc:     kbuild test robot <lkp@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738307.4006.16361452357164195990.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2990750bceb05c3cdeae3a6d2683cbc4ae4de15e
Gitweb:        https://git.kernel.org/tip/2990750bceb05c3cdeae3a6d2683cbc4ae4de15e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 26 May 2020 09:32:57 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Make functions static

Because the reset_readers() and process_durations() functions are used
only within kernel/rcu/refperf.c, this commit makes them static.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index fc940e3..0a900f3 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -283,7 +283,7 @@ end:
 	return 0;
 }
 
-void reset_readers(void)
+static void reset_readers(void)
 {
 	int i;
 	struct reader_task *rt;
@@ -296,7 +296,7 @@ void reset_readers(void)
 }
 
 // Print the results of each reader and return the sum of all their durations.
-u64 process_durations(int n)
+static u64 process_durations(int n)
 {
 	int i;
 	struct reader_task *rt;
