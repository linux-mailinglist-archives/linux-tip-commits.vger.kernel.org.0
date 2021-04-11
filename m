Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB335B534
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbhDKNqA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:46:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhDKNoy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:54 -0400
Date:   Sun, 11 Apr 2021 13:43:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C2hbjbshi6WsKsUOPIkJ3kXT+2WofY+sTeQSa7buxmM=;
        b=txrl8WG/whnehoFC4AFlgjwlHSdYif8uVypngYvC6lpb7FYPaq3EYi/vO9w8pKZYAOCQzq
        tW4cAfzZRtCXCotGjlipYZyMjVfVvhUm9m0FCmkYpo5vMyiD1X/8UesM3LzGbuKRL89j3G
        nPt0uYfJ0oRKOlJw6+bOQELHDTMYcKqf4+a07TMv60sqlXr0JktR/H4w2TrnhA60gKxIr4
        uc1v2LsVakQTnKUK6Wyv7glh2HrT7whvZMNAMiU7KmyDsZ1emuxJz+iPcxZ+jRDflU8QzI
        7mGuB7c8lv8+iLLPwlQ7wR8d1eqndN+1IcdscIaBXJJPVatp4V6uv1O5ryExCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148634;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=C2hbjbshi6WsKsUOPIkJ3kXT+2WofY+sTeQSa7buxmM=;
        b=zR0UGYSXKBpRypNDOaNwRMvqyhnv+iQIq40a2UKIrTf9RXZWbah85MlUeO1eJtE3on8D45
        V1sBo03h2tlo4BCQ==
From:   "tip-bot2 for Akira Yokosawa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] tools/memory-model: Remove reference to atomic_ops.rst
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814863370.29796.4786687468062009295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9146658cc49a1dbed5ece140f658be884e189ade
Gitweb:        https://git.kernel.org/tip/9146658cc49a1dbed5ece140f658be884e189ade
Author:        Akira Yokosawa <akiyks@gmail.com>
AuthorDate:    Thu, 14 Jan 2021 23:09:07 +09:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:29:22 -08:00

tools/memory-model: Remove reference to atomic_ops.rst

atomic_ops.rst was removed by commit f0400a77ebdc ("atomic: Delete
obsolete documentation").
Remove the broken link in tools/memory-model/Documentation/simple.txt.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/simple.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/memory-model/Documentation/simple.txt b/tools/memory-model/Documentation/simple.txt
index 81e1a0e..4c789ec 100644
--- a/tools/memory-model/Documentation/simple.txt
+++ b/tools/memory-model/Documentation/simple.txt
@@ -189,7 +189,6 @@ Additional information may be found in these files:
 
 Documentation/atomic_t.txt
 Documentation/atomic_bitops.txt
-Documentation/core-api/atomic_ops.rst
 Documentation/core-api/refcount-vs-atomic.rst
 
 Reading code using these primitives is often also quite helpful.
