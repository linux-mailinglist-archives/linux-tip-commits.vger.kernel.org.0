Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB03974EC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhFAOGk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhFAOGi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E62C06174A;
        Tue,  1 Jun 2021 07:04:56 -0700 (PDT)
Date:   Tue, 01 Jun 2021 14:04:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nl9mFaXwdYjixZLJzgT6WmxN7SuKh+t3RLI17ECMaTg=;
        b=gxEroV8h3FO3fR9BLGagXQs2hGni8aO6PqbnI6MiqYfEzJai9os9j+RRrcIJpTEFs4jHBs
        NUJeSscI7lS5ES53lvlxyCBJokXN1qpP+dQejgKAv7slgnXCb8mgfO8vjzKSJ37jO+zzD6
        CYkQKjPhOAgMCAUqaDUKT0lh4XiJ7xmjMiA+jH5Lh71CmgEsPgXX2N/KyBzxuGdRkPgG35
        cojoff7YqclhcvjVlpoBPAZzv3Qyqj2Q1Y3nME6HFUjCS2j9gwT0hFEQa58pfvUT/MhrjP
        RlgBQB0KihonJAXUIM6j1iY3ttDH0kmEkstLuVFwZEP/27Hi9f3qclrOfO4q5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nl9mFaXwdYjixZLJzgT6WmxN7SuKh+t3RLI17ECMaTg=;
        b=4a/FjvYOJLp/1AC6ksHkALPRpjOiOF0nFBMRuHbNfMlaFM2YTCeZKrN6/noouHrnRBj1yi
        57OCLrGB9t4fLtAA==
From:   "tip-bot2 for Qiujun Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] uprobes: Update uprobe_write_opcode() kernel-doc comment
Cc:     Qiujun Huang <hqjagain@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210524041411.157027-1-hqjagain@gmail.com>
References: <20210524041411.157027-1-hqjagain@gmail.com>
MIME-Version: 1.0
Message-ID: <162255629209.29796.8459366310090862821.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9ce4d216fe8b581e4da4406461a4cfc9acbfa679
Gitweb:        https://git.kernel.org/tip/9ce4d216fe8b581e4da4406461a4cfc9acbfa679
Author:        Qiujun Huang <hqjagain@gmail.com>
AuthorDate:    Mon, 24 May 2021 04:14:11 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:08 +02:00

uprobes: Update uprobe_write_opcode() kernel-doc comment

commit 6d43743e9079 ("Uprobe: Additional argument arch_uprobe to
uprobe_write_opcode()") added the parameter @auprobe.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210524041411.157027-1-hqjagain@gmail.com
---
 kernel/events/uprobes.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6addc97..a481ef6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -453,6 +453,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
  * that have fixed length instructions.
  *
  * uprobe_write_opcode - write the opcode at a given virtual address.
+ * @auprobe: arch specific probepoint information.
  * @mm: the probed process address space.
  * @vaddr: the virtual address to store the opcode.
  * @opcode: opcode to be written at @vaddr.
