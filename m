Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535512D8FE4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393911AbgLMTRB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391198AbgLMTDA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6008C0619E0;
        Sun, 13 Dec 2020 11:01:17 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+ONpkVr+xJSAiq/QtWJxar7fy5u6o0y45WC+Ku8wBnQ=;
        b=H496wmg2vv7WrPVh1kis4F8DamSz/Z/q+vDpgoa/ab7/pd6Mq0e4065qjkr7ge7e5I+XyF
        PK9tFDykVUM7vzPx2CPQcklnsuhd6AtT6hQnjC+NqOw7YGaGIK6UQQwJKVDC9l0LUzKtVU
        uKKD3tesFRRRfQhL4ATOecUHczq729DWkDwIeHe3E86+MD8eoJG6UCm6ogsndLzPH7q6uD
        M+dFgHTjYQiqOksP1r6Cez4gPV+5yV8dK7siklJttgPu1dz8ewEbYlNy8n/X4gbN33p5JA
        2T1f/gqJGp9p67emVotsMWdFPZO2y3czTaBiOFXTNo1ToK4i9OZLyDSSLF3zzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+ONpkVr+xJSAiq/QtWJxar7fy5u6o0y45WC+Ku8wBnQ=;
        b=eFPscEiE8xbCI951lhbcCs43P/cz2aKmqV79/x3e9fFnXAkO4cjR49Vc6ZO0YOARnKjr22
        NA+/CVMLroQuhwCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Bounds-check module parameters
Cc:     kernel test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607257.3364.7154683119357481731.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0c6d18d84db11840dd0f3f65750c6ea0bb6b8e0d
Gitweb:        https://git.kernel.org/tip/0c6d18d84db11840dd0f3f65750c6ea0bb6b8e0d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 27 Aug 2020 09:58:19 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:13:29 -08:00

refscale: Bounds-check module parameters

The default value for refscale.nreaders is -1, which results in the code
setting the value to three-quarters of the number of CPUs.  On single-CPU
systems, this results in three-quarters of the value one, which the C
language's integer arithmetic rounds to zero.  This in turn results in
a divide-by-zero error.

This commit therefore adds bounds checking to the refscale module
parameters, so that if they are less than one, they are set to the
value one.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by "Chen, Rong A" <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 952595c..fb5f20d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -681,6 +681,12 @@ ref_scale_init(void)
 	// Reader tasks (default to ~75% of online CPUs).
 	if (nreaders < 0)
 		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
+		loops = 1;
+	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
+		nreaders = 1;
+	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
+		nruns = 1;
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
