Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45831DA2D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhBQNTO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbhBQNSz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D14C06178B;
        Wed, 17 Feb 2021 05:17:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVgRQYlEdu4uIrNR3Ev/07QNnlxfA0x2Ch+WTOVJHA0=;
        b=0X5U807K+aAXoehSjfunWehqmgDvMgL0p51ZuumwYHPfqh3q7BDPywFb4TeJWJGA6GVDX3
        OPcTSXkMqTOkMlD3ggMuTrzdMQffvSups7q6w9lkySwZawxE2z6LiKhAyFcEESmpSnpovQ
        VkoWqyk6JCgiiZwFSLWSHu64eqJLhZ6eTo1aP5GXTW7ds4LB5EdUyAbIy3D3PJ0QOua2AQ
        ovXVC4MXSBo9wSVARIud9GgZFWjVUgrBtLpUlXDMtxbJUb1zLcud4LPrXkktWH5phCaSd2
        fhikk4HRUJEENWTlvFwi83Hikk9KDwsDkf31fJ+56fkEBLAQU4G6/4h2VQ08Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cVgRQYlEdu4uIrNR3Ev/07QNnlxfA0x2Ch+WTOVJHA0=;
        b=V2TmbvuOJYapzFiymkM1GgLSWCdBSPwvlljvCvuVBToqrnNOAFECx8KVMBOITLCv15FYgO
        vIe/y5xkGAGi2pCg==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] uprobes: (Re)add missing get_uprobe() in __find_uprobe()
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210209150711.36778-1-svens@linux.ibm.com>
References: <20210209150711.36778-1-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <161356785277.20312.6136035568546134813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b0d6d4789677d128b1933af023083054f0973574
Gitweb:        https://git.kernel.org/tip/b0d6d4789677d128b1933af023083054f0973574
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 09 Feb 2021 16:07:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

uprobes: (Re)add missing get_uprobe() in __find_uprobe()

commit c6bc9bd06dff ("rbtree, uprobes: Use rbtree helpers")
accidentally removed the refcount increase. Add it again.

Fixes: c6bc9bd06dff ("rbtree, uprobes: Use rbtree helpers")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210209150711.36778-1-svens@linux.ibm.com
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index fd5160d..3ea7f8f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -661,7 +661,7 @@ static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
 
 	if (node)
-		return __node_2_uprobe(node);
+		return get_uprobe(__node_2_uprobe(node));
 
 	return NULL;
 }
