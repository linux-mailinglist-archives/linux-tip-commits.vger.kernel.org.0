Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE7395911
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 12:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhEaKmU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 06:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhEaKmS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 06:42:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F421CC06174A;
        Mon, 31 May 2021 03:40:38 -0700 (PDT)
Date:   Mon, 31 May 2021 10:40:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622457637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDzCOTdjOtOWtFO5A1Jpu5BJZWjn6mk5O1shnWZoCfo=;
        b=KhV3i0z7iKLemWnCxgPy6qbjfC6yzL29rnx4WUOKxZVZJR6h/adC5Cc1GkHXhs90VZRzT0
        5461m+9aPikYfRgEx+MJrYTSBP7Q+ot+wHaONQzD7B9mZpB0X7VVQETgXWFytB/+SCBkjK
        +t/+ISsBHubAcWnwinhQx5FJ8RGp6196Rm1U8QldiK6sc6sXzvynXU/Qpe3cAxw93o0gAA
        Av5Mrd5Wzvm4fuGN+TCq+looN+/7DxQMCjATIaX9TehUu9JJY9bGH+QNJ2VG/CLvKlPG/t
        DiI3UivwPRgE3oZoSvwaqKOZGvvTi7mZDXRheo0v+MC81byGButBVv2RdseG9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622457637;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dDzCOTdjOtOWtFO5A1Jpu5BJZWjn6mk5O1shnWZoCfo=;
        b=8EfeKSFg+eAalmgpfJkejgtbjRnhwg2vRNyKCfNKHiD0SGSZnc+S+fNNleO//0VXSeysg4
        Ct7xwk61DCD29pBg==
From:   "tip-bot2 for Xiongwei Song" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep,doc: Improve readability of the
 block matrix
Cc:     Waiman Long <llong@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        Xiongwei Song <sxwjean@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1621868745-23311-1-git-send-email-sxwjean@me.com>
References: <1621868745-23311-1-git-send-email-sxwjean@me.com>
MIME-Version: 1.0
Message-ID: <162245763681.29796.2319971825299196026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     fab6216fafdd74cd84de929ffe7b787976d32cff
Gitweb:        https://git.kernel.org/tip/fab6216fafdd74cd84de929ffe7b787976d32cff
Author:        Xiongwei Song <sxwjean@gmail.com>
AuthorDate:    Mon, 24 May 2021 23:05:45 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 31 May 2021 10:14:54 +02:00

locking/lockdep,doc: Improve readability of the block matrix

The block condition matrix is using 'E' as the writer notation,
however, the writer reminder below the matrix is using 'W', to make
them consistent and make the matrix more readable, we'd better to use
'W' to represent writer.

Suggested-by: Waiman Long <llong@redhat.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lkml.kernel.org/r/1621868745-23311-1-git-send-email-sxwjean@me.com
---
 Documentation/locking/lockdep-design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
index 9f3cfca..82f36ca 100644
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -453,9 +453,9 @@ There are simply four block conditions:
 Block condition matrix, Y means the row blocks the column, and N means otherwise.
 
 	+---+---+---+---+
-	|   | E | r | R |
+	|   | W | r | R |
 	+---+---+---+---+
-	| E | Y | Y | Y |
+	| W | Y | Y | Y |
 	+---+---+---+---+
 	| r | Y | Y | N |
 	+---+---+---+---+
