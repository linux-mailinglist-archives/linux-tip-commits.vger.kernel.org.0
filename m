Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE0B35B4EB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbhDKNoY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oPwodwl1UMmf8D0v6IBOBBtSB1TNwv+8zzrd2ZuD7UM=;
        b=ZQFrcWtrUx2ZFZNDP6CtdfyBcK6Z6r0EqAQIb/IQOXq09EXaBNxLo6X9G8fV4c8E9pq920
        TttZ/OhdFa+xDf3IF4VlZNAJMxbbEqBTjPOGfHydYUNxN4MkKa0uBy0Hz7prjrF9hJa4NO
        UURclWGNheZe+nbuBUpg8hQg5rbVRdVN8OjYCST4EnfFYb6Tp5q7ycZbYuLOWEk9707lQ4
        XdN4E3dapsNnDbnHgxGkGS0qvnma1Ka7+XVIC2Ft5o6yjgWCgAYK45YnawwnViBqfqm4Ja
        mxeW6T1XawbuhnX9qP+zVJhsPZfsDziOUHH1OwOQakBCAc+55pBeOPEDV9VWGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148613;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oPwodwl1UMmf8D0v6IBOBBtSB1TNwv+8zzrd2ZuD7UM=;
        b=qR1FjgTb95T+WisXwwevzk9EeBG68tL+5ZtIDRUGUkH8rA/yFASRk/POpzXnrvEZwwvrV/
        o9iJ3xcwFT5bbPDQ==
From:   "tip-bot2 for Stephen Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Replace torture_init_begin string with %s
Cc:     Stephen Zhang <stephenzhangzsd@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861328.29796.17076373525240508511.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4ac9de07b24f93a87ad38c497ad00fe2451203e7
Gitweb:        https://git.kernel.org/tip/4ac9de07b24f93a87ad38c497ad00fe2451203e7
Author:        Stephen Zhang <stephenzhangzsd@gmail.com>
AuthorDate:    Sat, 23 Jan 2021 16:34:01 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:22:28 -08:00

torture: Replace torture_init_begin string with %s

This commit replaces a hard-coded "torture_init_begin" string in
a pr_alert() format with "%s" and __func__.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 01e336f..0a315c3 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -816,9 +816,9 @@ bool torture_init_begin(char *ttype, int v)
 {
 	mutex_lock(&fullstop_mutex);
 	if (torture_type != NULL) {
-		pr_alert("torture_init_begin: Refusing %s init: %s running.\n",
-			 ttype, torture_type);
-		pr_alert("torture_init_begin: One torture test at a time!\n");
+		pr_alert("%s: Refusing %s init: %s running.\n",
+			  __func__, ttype, torture_type);
+		pr_alert("%s: One torture test at a time!\n", __func__);
 		mutex_unlock(&fullstop_mutex);
 		return false;
 	}
