Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE2433AAD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Oct 2021 17:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhJSPiS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Oct 2021 11:38:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46574 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhJSPiG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Oct 2021 11:38:06 -0400
Date:   Tue, 19 Oct 2021 15:35:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634657752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eEmYjdIyqwwU/pKTwGQEc0xNbJpVQ/7bP6B5Q8Tmqk=;
        b=sP6w4QxlBmBcXAl3/Y8iQAhIdH8AoT7eJ24cCYfNwqybktL+kIywAqlNJ0LkX5DcNGjxhc
        jx7iA68UrFYScgGJE9iP3g7xzGl4T3ISdu4TKf98WzTkleiaTma1XmsIiENHL5MnpoNCYI
        8797b9BZjs76lLt7flJCodM9aq7dPrbEVAnlvYRqhie/IQdU2ypNlLGxkJOUjaZiUv0k5z
        dySBnVcWinx4jkHKig+FJWM1QVF5NwKCJuIhif9pCP4PMXca5kyHpWGxWfpEfXcYyBL1iU
        Y2/BiTcjNEpeFmgtZ7phbp7FvbpMGXkgmUZX3dlv9Pwri5l3Cmjl/nWVnm8fwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634657752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+eEmYjdIyqwwU/pKTwGQEc0xNbJpVQ/7bP6B5Q8Tmqk=;
        b=TFhq46jp0tUTiMZLweuxfBYkfyqf+gLRvYcNnqNVY8qJoreWVWM7LjyjHLxCAose3xggkA
        cbSVrdQfhUs/OpDQ==
From:   "tip-bot2 for Kajol Jain" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add comment about current state of
 PERF_MEM_LVL_* namespace and remove an extra line
Cc:     Kajol Jain <kjain@linux.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006140654.298352-2-kjain@linux.ibm.com>
References: <20211006140654.298352-2-kjain@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <163465775164.25758.14073611860087904014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f4c6217f7f5936f7173d028559ff5d25cce10816
Gitweb:        https://git.kernel.org/tip/f4c6217f7f5936f7173d028559ff5d25cce10816
Author:        Kajol Jain <kjain@linux.ibm.com>
AuthorDate:    Wed, 06 Oct 2021 19:36:51 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Oct 2021 17:27:00 +02:00

perf: Add comment about current state of PERF_MEM_LVL_* namespace and remove an extra line

Add a comment about PERF_MEM_LVL_* namespace being depricated
to some extent in favour of added PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_}
fields.

Remove an extra line present in perf_mem__lvl_scnprintf function.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20211006140654.298352-2-kjain@linux.ibm.com
---
 include/uapi/linux/perf_event.h       | 8 +++++++-
 tools/include/uapi/linux/perf_event.h | 8 +++++++-
 tools/perf/util/mem-events.c          | 1 -
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index c89535d..a74538c 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1256,7 +1256,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
 
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a..e1701e9 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1241,7 +1241,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
 
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f0e75df..ff7289e 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -320,7 +320,6 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	/* already taken care of */
 	m &= ~(PERF_MEM_LVL_HIT|PERF_MEM_LVL_MISS);
 
-
 	if (mem_info && mem_info->data_src.mem_remote) {
 		strcat(out, "Remote ");
 		l += 7;
