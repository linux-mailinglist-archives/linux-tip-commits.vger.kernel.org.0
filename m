Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADF288422
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbgJIH66 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732510AbgJIH65 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CF5C0613DE;
        Fri,  9 Oct 2020 00:58:54 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hVOKLrXmycyU2KQEt2I6bqy8I32cQsNKI8S5FIG0oqQ=;
        b=0iAfe2VnBmfSpKjqmTczGc5PkBCxmjoAlTYylWa0HFiPRHAWet+26mxXK811TeEvhAeGGd
        5iKKPFP26f3e+kyb+mk4ZkhLUQpGWg9uMhcjYwoeHrNallJq0HuLvdzMhZewTHXRIt0JDp
        6GJo+zRVeCRRIK8NQIMG/Sn4bQcky5EyvHwjnDkEIU6rpxBrMpm3YDMIwaWAtxC1AF5kR5
        AZLwKzniV25mBEml14N16htAQDgMHAnSYpPft5kUZE7/vo4fK5MckaBg/bCodCmwnbuJdb
        DU1/ZmG+jikookcMy0Bj0Z8QtQ7mcp1Dc9yad/1SwH/T6jB0VzY48ki+Dvt7GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230333;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=hVOKLrXmycyU2KQEt2I6bqy8I32cQsNKI8S5FIG0oqQ=;
        b=pK96IbjHb7rtQbveVhYrguGn+eYy37seDeAt7M2yi1yJhVA+MyEgRqyFizW4pr73oJUkch
        KnMX/yYTHEpulFAA==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] objtool, kcsan: Add __tsan_read_write to uaccess
 whitelist
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033225.7002.15378572206951495122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a81b37590ff2e2507940ec278910b1d315dc73b3
Gitweb:        https://git.kernel.org/tip/a81b37590ff2e2507940ec278910b1d315dc73b3
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 24 Jul 2020 09:00:02 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:32 -07:00

objtool, kcsan: Add __tsan_read_write to uaccess whitelist

Adds the new __tsan_read_write compound instrumentation to objtool's
uaccess whitelist.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7546a9d..5eee156 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_read_write1",
+	"__tsan_read_write2",
+	"__tsan_read_write4",
+	"__tsan_read_write8",
+	"__tsan_read_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
