Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F341ED0A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 14:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354333AbhJAMM3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354303AbhJAMM1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 08:12:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCDDC06177F;
        Fri,  1 Oct 2021 05:10:42 -0700 (PDT)
Date:   Fri, 01 Oct 2021 12:10:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633090241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8hc94CVyHAF5CZxQST28RM4ky8Nnb9cwa2ROMiXQuw=;
        b=iSDep3Ipr5Ce28iZwKXPMNNtLVv80jjqtWZL7E8Q+Qyc8wKrr+4CN/ZKyVxJdsK3wPKZ9J
        pZ8brbKs9LBD9wR+3IsqH3yhQap4fUjW77GCofmLZ3uSnYI+yxF/zgCpVP8SAXnUQnBZie
        p26VbfIYaVFQCFPLSKG+lH784V/tp0/onI2rKa1D9lYczqH9YM90gcPQidkr+RcNm5V84Y
        Cpb2ZI44AvN8MOhChj1YE14CFiG37g8bKVIrQEc1k186NtP2rlvrYrCvzddV5U/R0VzBlH
        XxiNClk5pXK4edoCixQ9gzzQIibk8DCYtWwECRFsFQNN3mezk2PjZgMf0f/cDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633090241;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w8hc94CVyHAF5CZxQST28RM4ky8Nnb9cwa2ROMiXQuw=;
        b=H/eML5vGGnYOjejFt20WtsuL1p5bFOhPAN614tkGkrijXh0zGMXlQKIFfr76vxjK48+LGw
        id1vc1MnRzo1EQCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Always inline is_percpu_thread()
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928084218.063371959@infradead.org>
References: <20210928084218.063371959@infradead.org>
MIME-Version: 1.0
Message-ID: <163309024016.25758.4641421584373695400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     83d40a61046f73103b4e5d8f1310261487ff63b0
Gitweb:        https://git.kernel.org/tip/83d40a61046f73103b4e5d8f1310261487ff63b0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 20 Sep 2021 15:31:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:57 +02:00

sched: Always inline is_percpu_thread()

  vmlinux.o: warning: objtool: check_preemption_disabled()+0x81: call to is_percpu_thread() leaves .noinstr.text section

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928084218.063371959@infradead.org
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce..c1a927d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1720,7 +1720,7 @@ extern struct pid *cad_pid;
 #define tsk_used_math(p)			((p)->flags & PF_USED_MATH)
 #define used_math()				tsk_used_math(current)
 
-static inline bool is_percpu_thread(void)
+static __always_inline bool is_percpu_thread(void)
 {
 #ifdef CONFIG_SMP
 	return (current->flags & PF_NO_SETAFFINITY) &&
