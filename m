Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0B31BBA3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhBOO5h (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhBOO5I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E65C06121F;
        Mon, 15 Feb 2021 06:55:50 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mvKAky/yxwGAKGQxIKqxnof75vjnOWApgfR0xI95IUQ=;
        b=aJ9HlA+SyYINBzeCgDpj0FJC7lgUVqo1+ccVSaOhE2Muhhwsp39kaFnJuLdvsHw2ZiDO0y
        rdswDbKw2fWpM5KlQ1UrXilZi457znPzpRM4tL2dxbmMgFoSQTksnv0t4V2yZLp+r8t7Tt
        4785RwxvAusEVriobM35wIe+bhUebGnwCw0RaR6ZLfPPv/uM5jMvRNg2pghMRElt99iJuM
        cioyyJBm0oZXns61svDGgGW1nCFDNNXUGd1Ml3943d6VLC/A/je+TTsPsWxtAgJJkmn65q
        d7dnTPVEJNmGYFzPd60oLxs+I160A+i0Qg0Wl7xUqFKuJfl4io4xNgcoJjiC5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=mvKAky/yxwGAKGQxIKqxnof75vjnOWApgfR0xI95IUQ=;
        b=i1jf6/WA1qA9cFv1fNZm0B0kV72XDqw8qkH11NCJax3/qZvGxa/Xedb/3OQONUhwJmF+wC
        PRwsBvjfdsjiG+DA==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] list: Fix a typo at the kernel-doc markup
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340094810.20312.9272140883207592077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     4704bd317108c94b6e2d8309f3dbb70d2015568a
Gitweb:        https://git.kernel.org/tip/4704bd317108c94b6e2d8309f3dbb70d2015568a
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Mon, 16 Nov 2020 11:18:16 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 13:35:14 -08:00

list: Fix a typo at the kernel-doc markup

hlist_add_behing -> hlist_add_behind

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 89bdc92..f2af4b4 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -901,7 +901,7 @@ static inline void hlist_add_before(struct hlist_node *n,
 }
 
 /**
- * hlist_add_behing - add a new entry after the one specified
+ * hlist_add_behind - add a new entry after the one specified
  * @n: new entry to be added
  * @prev: hlist node to add it after, which must be non-NULL
  */
