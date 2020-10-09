Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD30288424
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 09:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732530AbgJIH67 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbgJIH66 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CF6C0613DF;
        Fri,  9 Oct 2020 00:58:55 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SB9UL4VIwBhyp8AdBt3GsxsMjnS32qrOKfyO44PpGoM=;
        b=nfXYdMnNY7c4UC3NzL/dupYBVhyR7AKdM5UatX6rVzt/6xkTONKuLgc919fXb9Pg92e1Mi
        UuDrVpWBUVWsNIl2xA6L0SJiIui48/f4cgNd5MqMV0WjAxqSY7dLPnVoG9uzDFm3emDjad
        2To3rtnUKPv+JhiuMqcBCoJd59Z8V2SeziHJtoagc0pPLE+zoqUOijvRnRYnj4qLLea2Ih
        saWObl8Id/yAkUkiEg9HVbp47fWaWK7ySIhMI398uLorYinNfZjAclCmEuRVUNi2TU69ju
        AJGcfMhc6h4X0NGxK+JkD65khjifQU+7O1TIgQjcgdnBjOHqoVVGJWIbt6j6rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230334;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SB9UL4VIwBhyp8AdBt3GsxsMjnS32qrOKfyO44PpGoM=;
        b=wvWU+Jj78xdwHA+bwYd4R0FHc6cSwTACNAWv52Jur4tG5QYK6R4Ygt1Xb/jgtKPE97yKUt
        1TbEXf+/wEGcprAw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] objtool: Add atomic builtin TSAN instrumentation
 to uaccess whitelist
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160223033369.7002.1825635843433771099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     883957b1c4ac5554ce515e882b7b2b20cbadfdd1
Gitweb:        https://git.kernel.org/tip/883957b1c4ac5554ce515e882b7b2b20cbadfdd1
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 03 Jul 2020 15:40:30 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 15:09:06 -07:00

objtool: Add atomic builtin TSAN instrumentation to uaccess whitelist

Adds the new TSAN functions that may be emitted for atomic builtins to
objtool's uaccess whitelist.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/objtool/check.c | 50 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e034a8f..7546a9d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,56 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_atomic8_load",
+	"__tsan_atomic16_load",
+	"__tsan_atomic32_load",
+	"__tsan_atomic64_load",
+	"__tsan_atomic8_store",
+	"__tsan_atomic16_store",
+	"__tsan_atomic32_store",
+	"__tsan_atomic64_store",
+	"__tsan_atomic8_exchange",
+	"__tsan_atomic16_exchange",
+	"__tsan_atomic32_exchange",
+	"__tsan_atomic64_exchange",
+	"__tsan_atomic8_fetch_add",
+	"__tsan_atomic16_fetch_add",
+	"__tsan_atomic32_fetch_add",
+	"__tsan_atomic64_fetch_add",
+	"__tsan_atomic8_fetch_sub",
+	"__tsan_atomic16_fetch_sub",
+	"__tsan_atomic32_fetch_sub",
+	"__tsan_atomic64_fetch_sub",
+	"__tsan_atomic8_fetch_and",
+	"__tsan_atomic16_fetch_and",
+	"__tsan_atomic32_fetch_and",
+	"__tsan_atomic64_fetch_and",
+	"__tsan_atomic8_fetch_or",
+	"__tsan_atomic16_fetch_or",
+	"__tsan_atomic32_fetch_or",
+	"__tsan_atomic64_fetch_or",
+	"__tsan_atomic8_fetch_xor",
+	"__tsan_atomic16_fetch_xor",
+	"__tsan_atomic32_fetch_xor",
+	"__tsan_atomic64_fetch_xor",
+	"__tsan_atomic8_fetch_nand",
+	"__tsan_atomic16_fetch_nand",
+	"__tsan_atomic32_fetch_nand",
+	"__tsan_atomic64_fetch_nand",
+	"__tsan_atomic8_compare_exchange_strong",
+	"__tsan_atomic16_compare_exchange_strong",
+	"__tsan_atomic32_compare_exchange_strong",
+	"__tsan_atomic64_compare_exchange_strong",
+	"__tsan_atomic8_compare_exchange_weak",
+	"__tsan_atomic16_compare_exchange_weak",
+	"__tsan_atomic32_compare_exchange_weak",
+	"__tsan_atomic64_compare_exchange_weak",
+	"__tsan_atomic8_compare_exchange_val",
+	"__tsan_atomic16_compare_exchange_val",
+	"__tsan_atomic32_compare_exchange_val",
+	"__tsan_atomic64_compare_exchange_val",
+	"__tsan_atomic_thread_fence",
+	"__tsan_atomic_signal_fence",
 	/* KCOV */
 	"write_comp_data",
 	"check_kcov_mode",
