Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E859B31686E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 14:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBJNyq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 08:54:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhBJNyT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 08:54:19 -0500
Date:   Wed, 10 Feb 2021 13:53:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qiOnCrpWgSV4zWzTwIRtHFBfKvrZcNgm6eKxfH11Hs=;
        b=V98RPZKftKl/nFipCEGty6uIm1YLRQv+D9FwfBZsv/VyoC3CoMmW1WAj86s68YTYdz87An
        g/K3gTl94kdbtnIHW8csHeJZjs8Q1r23FEH1b5utnFR4LxGoZ3nbvpjK71nKoEynOIFNKV
        GgwY16A26ugLB09WMxs/0r3EwxDPzWdQZBJx1Plgo0GM4RHJU1C20bxshhzI+cETRsV2Uj
        IbsifDW3GBExbrf/ePHBzNJxZbdCi/KFbrBs07RxJXr0DhFOId/Rx4ptBorB446E+Do/YP
        UQDZOAjUAm3OOsc9afP3+h4iYpHS7MIRHgmkkFjPD2dF70Fh6LHhrFsHiY8h5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qiOnCrpWgSV4zWzTwIRtHFBfKvrZcNgm6eKxfH11Hs=;
        b=AFmz1C5DzMdrLqWly6cgj9InvciKpJssxSA4zP4J/o0gtL7YcHLWKj0/qL9/Id0PzydvZi
        JxX7itrneTKIGGAg==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] uprobes: (Re)add missing get_uprobe() in __find_uprobe()
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210209150711.36778-1-svens@linux.ibm.com>
References: <20210209150711.36778-1-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <161296521396.23325.14276433329775454608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2c3496a02cb06ffe957854d8488a5799d7bfb252
Gitweb:        https://git.kernel.org/tip/2c3496a02cb06ffe957854d8488a5799d7bfb252
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 09 Feb 2021 16:07:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:48 +01:00

uprobes: (Re)add missing get_uprobe() in __find_uprobe()

commit c6bc9bd06dff ("rbtree, uprobes: Use rbtree helpers")
accidentally removed the refcount increase. Add it again.

Fixes: c6bc9bd06dff ("rbtree, uprobes: Use rbtree helpers")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
