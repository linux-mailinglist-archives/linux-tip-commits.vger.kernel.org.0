Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BAE35B4CC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235819AbhDKNoL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhDKNoE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:04 -0400
Date:   Sun, 11 Apr 2021 13:43:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KoCfVpKfrIDm7w71a7ILo9h5yJzmXzYFB/+89Q+mdXc=;
        b=1K3qiRUxtBOAsgBFdXQUO3xV8L5Dbf4Yu8iz+Bf9kOnkgQqKC+BN/U/g6iBQmTTns0cKSA
        GcI7czmtR9Gr2K3kHWwRSh2ND3uqIE7ztQDWloc/obYiTchRFllhW+msyDIz4gWmfGhnen
        JqtmohXc3KAQSrCuiEQNTq3vvw3/edm38N28Vf5HVJpGj931xRya9dJ+DUxiCq2iHDcZeo
        avLWSZeHSbR0qWIiAJwpBZpnAjDtc+93ALszHtOQQGODe+Y9ibQ5KV/IV++6jyplLEQ8DQ
        TZF0nvChPU8+eZgJa4BEYxdpEhvBTpJKYu1CzSZwMENfROSFZICBJB3WbZyzJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KoCfVpKfrIDm7w71a7ILo9h5yJzmXzYFB/+89Q+mdXc=;
        b=P+B7vyOwRN2BBnYbd13+X0ceFORJROCekxut9AMY5UnuhfsTUZfubhgDO708LEUHTRyDkY
        uovWQFBktD0zqzCw==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make nocb_nobypass_lim_per_jiffy static
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860676.29796.8181697809960571612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9640dcab974fb7fba086d30fd9f0ec08b8876d12
Gitweb:        https://git.kernel.org/tip/9640dcab974fb7fba086d30fd9f0ec08b8876d12
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Wed, 24 Feb 2021 16:30:29 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 15 Mar 2021 13:54:42 -07:00

rcu: Make nocb_nobypass_lim_per_jiffy static

RCU triggerse the following sparse warning:

kernel/rcu/tree_plugin.h:1497:5: warning: symbol
'nocb_nobypass_lim_per_jiffy' was not declared. Should it be static?

This commit therefore makes this variable static.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Reported-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 93d3938..a1a17ad 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1556,7 +1556,7 @@ early_param("rcu_nocb_poll", parse_rcu_nocb_poll);
  * After all, the main point of bypassing is to avoid lock contention
  * on ->nocb_lock, which only can happen at high call_rcu() rates.
  */
-int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
+static int nocb_nobypass_lim_per_jiffy = 16 * 1000 / HZ;
 module_param(nocb_nobypass_lim_per_jiffy, int, 0);
 
 /*
