Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18AE35B4EF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbhDKNo0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Af5uzVaVGfmMCOeNOxbrJDiHuHgsvd9kR7UEoNuxzo4=;
        b=GlpNTieOashrTSERHzHjfrIfly3NawlKFF15lxyxH/VTeef6EIJdE8tyERl33mm8YtDHzt
        hzwdOKGTQTaQHXXmEo6d0g9xI1Z51BcIM3PwGHprgqdnr6taFfZ2qqcygIhU1p7CpF6QN/
        CVENsDdCVi5cAZUVnF8t+FR1xBO0YEubP+HPyl6e9lszNWw9qVQkJH5a3QOY17Ica1xbep
        5F60V5RRQJ8ph6LEoxfXkn5BCdHATiq2gCvC60YAOMJNTP6f7EYYf884HI5wGmfnyHwRg3
        gqJVCLpyKpaKSM+aXTty2DEJDzyeR18p2Eiza4uVDAQDWwfeP/UgVdv9abfq7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Af5uzVaVGfmMCOeNOxbrJDiHuHgsvd9kR7UEoNuxzo4=;
        b=1pvk8HH2MMuvBuFdVa2nHd4l/y2WcH2NPFdeGEJArQyRfFNGxonJAVdj0T85NBDnYd004u
        iqHcZkdLsziBxuBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make TREE03 use real-time
 tree.use_softirq setting
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861563.29796.18210411808911193249.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e2b949d54392ad890bb10fb8954d967e2fcd7503
Gitweb:        https://git.kernel.org/tip/e2b949d54392ad890bb10fb8954d967e2fcd7503
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 14 Jan 2021 16:11:04 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:21:40 -08:00

rcutorture: Make TREE03 use real-time tree.use_softirq setting

TREE03 tests RCU priority boosting, which is a real-time feature.
It would also be good if it tested something closer to what is
actually used by the real-time folks.  This commit therefore adds
tree.use_softirq=0 to the TREE03 kernel boot parameters in TREE03.boot.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
index 1c21894..64f864f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot
@@ -4,3 +4,4 @@ rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcutree.kthread_prio=2
 threadirqs
+tree.use_softirq=0
