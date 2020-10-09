Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA55A28828B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbgJIGfb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbgJIGf3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:29 -0400
Date:   Fri, 09 Oct 2020 06:35:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GYNG7Ulit5R5fVcoXLyvJU8CyJkcJxxx1iJPdb4IMtI=;
        b=BPcdxcKpKCI9v1i5CN29CLMWlNAaiw+WZYwL0XLX/ObC07u8clQC/liX99cJ/qYp3vjgcA
        93makoYEi38qHDbpUV9lqN4QXikXT2UgopLEtrafcR2t/TmKnpICcfDC0Lpcx0BJMk4Lwx
        ahYLIL3FI3ujTyxBp93WT1S2Vjbj3cJ9c8uf6ljazThHqLQfDkAOLNWH1SutpFhp5522r/
        9OLjuWIoZ0GjxVF6XOVCVGYQoGR5JdqppAMjQaV++8THzoEooTA+wN4bq6BZn5lJPKCVEm
        PJ539EiISJLK8MjEDZV7Q5n16V7kZT0E8gyLQ74BRYFLFT4gIMRyV5qOTCqb2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=GYNG7Ulit5R5fVcoXLyvJU8CyJkcJxxx1iJPdb4IMtI=;
        b=j9CdHem+H6r9Ngs6mtbtwnl3Hi4t7kyST0YFEL00CJhnDxPbHFuX0NPMiRjJkA+1mP8EyE
        TLkTCI4CaJdF0FDQ==
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Make symbol 'scf_torture_rand' static
Cc:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222532707.7002.13098495882610076134.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     9a52a574676f8d4aa55f69319231ce6c343b00bb
Gitweb:        https://git.kernel.org/tip/9a52a574676f8d4aa55f69319231ce6c343b00bb
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Thu, 02 Jul 2020 09:56:50 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:38:36 -07:00

scftorture: Make symbol 'scf_torture_rand' static

The sparse tool complains as follows

kernel/scftorture.c:124:1: warning:
 symbol '__pcpu_scope_scf_torture_rand' was not declared. Should it be static?

And this per-CPU variable is not used outside of scftorture.c,
so this commit marks it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 8349681..9180de7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -134,7 +134,7 @@ static atomic_t n_alloc_errs;
 static bool scfdone;
 static char *bangstr = "";
 
-DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
+static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
