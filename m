Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E812741ED0C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 14:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354318AbhJAMM3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 08:12:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56914 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354329AbhJAMM1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 08:12:27 -0400
Date:   Fri, 01 Oct 2021 12:10:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5OmOaoRz7gmN8ykp5wcz0gHWnzV+8O7x60T7mPKk9g=;
        b=z05u8lbvlTf5VGbGcvsOEgaKa5c7npEaBBEp5SHmax+167ho9O4HAPlwIugVrMdJOaRIVK
        /EmOUrtsgW06641UzIciu37epZ2fA70OLkcHtQE8gNHPZHGK7XMxjM1uSvSF1TsjnNWrVk
        Qe49sgswEcUcWj/zbNtg8fUUjUXZfRFoHsx84I0IBmRv8xTNUPsD8VOIe8Fn64wH6DzfRu
        XINUkf41YlFL1OZyCqu13odzFDfd5MOstBMNAU87HBEpeu+kbj7LtVOcrdXScrdvSBMA1G
        zRR4ipzrDl0KFJbEdXj2v3L+HzJRGySUoLYeKSBGH8rcQvEPHiHDNuPz42eL8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090242;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X5OmOaoRz7gmN8ykp5wcz0gHWnzV+8O7x60T7mPKk9g=;
        b=tOSb37Jf+mPjA1vpH4uc3Nu1y/44RkhRLD5bRCAD58GL6uPOXo7/hx8se/Wljl1baw/pzx
        BaM1FW6OXQIqOFAQ==
From:   tip-bot2 for Michal =?utf-8?q?Koutn=C3=BD?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Add ancestors of unthrottled undecayed cfs_rq
Cc:     mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Odin Ugedal <odin@uged.al>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210917153037.11176-1-mkoutny@suse.com>
References: <20210917153037.11176-1-mkoutny@suse.com>
MIME-Version: 1.0
Message-ID: <163309024153.25758.5768319278915743585.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     2630cde26711dab0d0b56a8be1616475be646d13
Gitweb:        https://git.kernel.org/tip/2630cde26711dab0d0b56a8be1616475be6=
46d13
Author:        Michal Koutn=C3=BD <mkoutny@suse.com>
AuthorDate:    Fri, 17 Sep 2021 17:30:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:57 +02:00

sched/fair: Add ancestors of unthrottled undecayed cfs_rq

Since commit a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to
list on unthrottle") we add cfs_rqs with no runnable tasks but not fully
decayed into the load (leaf) list. We may ignore adding some ancestors
and therefore breaking tmp_alone_branch invariant. This broke LTP test
cfs_bandwidth01 and it was partially fixed in commit fdaba61ef8a2
("sched/fair: Ensure that the CFS parent is added after unthrottling").

I noticed the named test still fails even with the fix (but with low
probability, 1 in ~1000 executions of the test). The reason is when
bailing out of unthrottle_cfs_rq early, we may miss adding ancestors of
the unthrottled cfs_rq, thus, not joining tmp_alone_branch properly.

Fix this by adding ancestors if we notice the unthrottled cfs_rq was
added to the load list.

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthro=
ttle")
Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Odin Ugedal <odin@uged.al>
Link: https://lore.kernel.org/r/20210917153037.11176-1-mkoutny@suse.com
---
 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f24..f6a05d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4936,8 +4936,12 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	/* update hierarchical throttle state */
 	walk_tg_tree_from(cfs_rq->tg, tg_nop, tg_unthrottle_up, (void *)rq);
=20
-	if (!cfs_rq->load.weight)
+	/* Nothing to run but something to decay (on_list)? Complete the branch */
+	if (!cfs_rq->load.weight) {
+		if (cfs_rq->on_list)
+			goto unthrottle_throttle;
 		return;
+	}
=20
 	task_delta =3D cfs_rq->h_nr_running;
 	idle_task_delta =3D cfs_rq->idle_h_nr_running;
