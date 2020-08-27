Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70AE253FD7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 09:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgH0H4v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 03:56:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgH0Hy0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:26 -0400
Date:   Thu, 27 Aug 2020 07:54:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YqiSaCnS2KOqPvA9P2XCB7kGgE8cJkDykwBkGMJQQE=;
        b=d6Lha3XzlJ0W2WF6UyVkFMxhU1J5B2dGZysIfXYRd5dXN5+smxaWZasC4kvdTSEg017f5V
        +6kRpbWxmtAhtu0FI4bGVFdIILj6EiCZb9rLi7yKrM972dopfxyLdI4oUEY7JWkcw6Cl6V
        H7qzB74fZ/Ce8VGdKYasVmnADdBWeqSNkMzkE31Iy2GEpgxFk223pkG+8KPcepMkJyW+2I
        4SiLBPqMFrYCkCFmwz8zC03mwrQDC123Ius6ZFKDK+0LYFROwXCkv2wEhlALzqx8XRBMFw
        gCR3xA+mtHiiCymh7G7Y/uujzBHS0xwFCLwTqLMIMiF96Y6Ac0yQnOTmX7ZG8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514864;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YqiSaCnS2KOqPvA9P2XCB7kGgE8cJkDykwBkGMJQQE=;
        b=OtFhfHHEBNYBhXTkBfThAKEYlIOgDGoGbODPV+naEdiYYPlpEI5DIA9sigXC38yPoq9Cm2
        oVUKuVjBtzAkpiDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock,tags: Add support for SEQCOUNT_LOCKTYPE()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729161938.GB2678@hirez.programming.kicks-ass.net>
References: <20200729161938.GB2678@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <159851486396.20229.12728013017338610822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6eb6d05958f3208b3dd2b5311f1a6e68abdbe5d5
Gitweb:        https://git.kernel.org/tip/6eb6d05958f3208b3dd2b5311f1a6e68abdbe5d5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 29 Jul 2020 20:12:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:01 +02:00

seqlock,tags: Add support for SEQCOUNT_LOCKTYPE()

Such that we might easily find seqcount_LOCKTYPE_t and
seqcount_LOCKTYPE_init().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200729161938.GB2678@hirez.programming.kicks-ass.net
---
 scripts/tags.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 32d3f53..fc5b532 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -201,6 +201,8 @@ regex_c=(
 	'/\<DEVICE_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/dev_attr_\2/'
 	'/\<DRIVER_ATTR_\(RW\|RO\|WO\)(\([[:alnum:]_]\+\)/driver_attr_\2/'
 	'/\<\(DEFINE\|DECLARE\)_STATIC_KEY_\(TRUE\|FALSE\)\(\|_RO\)(\([[:alnum:]_]\+\)/\4/'
+	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_t/'
+	'/^SEQCOUNT_LOCKTYPE(\([^,]*\),[[:space:]]*\([^,]*\),[^)]*)/seqcount_\2_init/'
 )
 regex_kconfig=(
 	'/^[[:blank:]]*\(menu\|\)config[[:blank:]]\+\([[:alnum:]_]\+\)/\2/'
