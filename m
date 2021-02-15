Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED04531BBA0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBOO5b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhBOO5H (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F39CC06121C;
        Mon, 15 Feb 2021 06:55:49 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hmO4mWjh6yOf5Xot7X8WbrytRizbCGjcY1rgh6W4dmM=;
        b=HXR+fq07++o/PTjFyIVnxLEVob33VPMmmXuHax1kBQxA4zhVmDg3xsJxscPLdZwrYtU1+Z
        qjUmJxwt0mWY7bNmskxZYejjwFDP7lhGaFhmsiHkIpOvDk6eDOrzwHAPvNPyHgAfQfONzS
        pPJlCb5vTJhMCnWRRs6M+8sx0VLAkl1Shw6JAJ8/N5wdyLvLybvye635xSTuKhyhJeGzVS
        AAyRgjkhlfHivbhJoCnVkTTBKjKiy7gtbV4sLB4mrCJaAQz7jIF+9WD45mfmT/0qCRzsgO
        ibEx8OOQsszgH8LWAoyg/vMJAM977T8JjnilxEeRSLi7kHQtlySsqLQXLQOZoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400947;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hmO4mWjh6yOf5Xot7X8WbrytRizbCGjcY1rgh6W4dmM=;
        b=8qTmC/82V8zeH4l2tmEWadvFl5rU7YXSjJyim5ni06c/ivlrhKVtRr37Qs0phBEDA861PF
        kaIT3rsd23RZ9HDA==
From:   "tip-bot2 for Zqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Record kvfree_call_rcu() call stack for KASAN
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Zqiang <qiang.zhang@windriver.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094719.20312.17749393458245052832.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     84109ab58590dc6c4e7eb36329fdc7ec121ed5a5
Gitweb:        https://git.kernel.org/tip/84109ab58590dc6c4e7eb36329fdc7ec121ed5a5
Author:        Zqiang <qiang.zhang@windriver.com>
AuthorDate:    Fri, 20 Nov 2020 06:53:11 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:42:04 -08:00

rcu: Record kvfree_call_rcu() call stack for KASAN

This commit adds a call to kasan_record_aux_stack() in kvfree_call_rcu()
in order to record the call stack of the code that caused the object
to be freed.  Please note that this function does not update the
allocated/freed state, which is important because RCU readers might
still be referencing this object.

Acked-by: Dmitry Vyukov <dvyukov@google.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 40e5e3d..2db736c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3498,6 +3498,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
+	kasan_record_aux_stack(ptr);
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
 		run_page_cache_worker(krcp);
