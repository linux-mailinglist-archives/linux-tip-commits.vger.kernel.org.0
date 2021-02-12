Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33982319E7F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBLMhw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhBLMhr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807AEC0613D6;
        Fri, 12 Feb 2021 04:37:07 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n8HWjMg2IJlMiiqB8K7n+zuxVvfO38iq3o3NujdiIOY=;
        b=CTInEIMr7IKknI7HL2Jf2GhlPFCGDSaZjC68YPFAkuBYiAIyuTDlylt/latgWryteyYRcy
        i4sOZ5YrlZ8N/nLo4/iUW0MhjZFq/D+UYngM79hkRtMcRYA0rI/jHrIAC8fCFlmyAUA0JZ
        Xna8IBwh7Gv3U3bWsKEAi9PIQy3iE+zM9IYtgYrRr48CPXV9aA0tDZ0N8YyLpeRS6gVlsK
        +YjN702w2AuncpbeP53yAE2GY7TOYSEFzmnPO/6wj47Vns1tfjVU7lqvaBjz1lwsXx+T6+
        znivk9dqOj8NtZQcMqjqcgnffq7iDVNDBaAcC1DBgqhrs6RPWYDZtp9fWB0c1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133424;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=n8HWjMg2IJlMiiqB8K7n+zuxVvfO38iq3o3NujdiIOY=;
        b=ymRmUulWz/R5IeWW2Ryj4Lnt4vDL7jjeUQoIC1PbazKOahXHpbZ2CW+WokFAC+0qcJDVER
        jIEMQQ4b/UiH0pCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm: Make mem_dump_obj() handle NULL and zero-sized pointers
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Andrii Nakryiko <andrii@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342401.23325.5802422578509180690.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b70fa3b12fc8d2b870d1ac7fd44da89271eb8705
Gitweb:        https://git.kernel.org/tip/b70fa3b12fc8d2b870d1ac7fd44da89271eb8705
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 08 Dec 2020 15:26:22 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 22 Jan 2021 15:23:57 -08:00

mm: Make mem_dump_obj() handle NULL and zero-sized pointers

This commit makes mem_dump_obj() call out NULL and zero-sized pointers
specially instead of classifying them as non-paged memory.

Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/util.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index da46f9d..92f23d2 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -997,7 +997,12 @@ int __weak memcmp_pages(struct page *page1, struct page *page2)
 void mem_dump_obj(void *object)
 {
 	if (!virt_addr_valid(object)) {
-		pr_cont(" non-paged (local) memory.\n");
+		if (object == NULL)
+			pr_cont(" NULL pointer.\n");
+		else if (object == ZERO_SIZE_PTR)
+			pr_cont(" zero-size pointer.\n");
+		else
+			pr_cont(" non-paged (local) memory.\n");
 		return;
 	}
 	if (kmem_valid_obj(object)) {
