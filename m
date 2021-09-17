Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95D740FB63
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 17:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhIQPLo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 11:11:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbhIQPLn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 11:11:43 -0400
Date:   Fri, 17 Sep 2021 15:10:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631891420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BMa+KMP6J7PSbki8qy4YKDOTQPP6vCZxeGoO/Hdip4=;
        b=djNjmB7RAITOxR8o943hnP3QjfqCz41qT8O4q2n340grM3YuYJ0+QbZe2e/gdGmHyRfYvZ
        TZdyLm+cmVCJ8MAmbAtER1Gkw3fx6ahGbze7PJq0KCA6X3haF8ubcTJnY8r3asW0qOMgyd
        hKS4/bfYF3tOEDrBfOm7x1S2GAlSkVDS+DbQM8rZYUU67NoCmDgNvSqZ/PmFOcXl7wrZ2k
        4AxCBouXZo4xhPLwQ6DY5V/aXiVbCPxmIjmzWTYKdvHn7nBUMTMYnbin52iehxNYNdFBYF
        jiXwCORB2cgOmGbH8Wx2IkQLYwc99UdPvN7x58B+aqbIEI+ywPEFNCx+pfqMRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631891420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BMa+KMP6J7PSbki8qy4YKDOTQPP6vCZxeGoO/Hdip4=;
        b=IrMwTIpvJXlvc8R8rH44Z9ei2aX/Jx17Cv9EUG0iuhf+S1g6neo6+NhUKL7pLqQt7VlATD
        SxViWR8FXHq5YBCA==
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Add compiler barrier after updating BTS
Cc:     Leo Yan <leo.yan@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210809111407.596077-5-leo.yan@linaro.org>
References: <20210809111407.596077-5-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <163189141907.25758.18129833190536677438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     41100833cdd8b1bef363b81a6482d74711c116ad
Gitweb:        https://git.kernel.org/tip/41100833cdd8b1bef363b81a6482d74711c116ad
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Mon, 09 Aug 2021 19:14:02 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 15:08:38 +02:00

perf/x86: Add compiler barrier after updating BTS

Since BTS is coherent, simply add a compiler barrier to separate the BTS
update and aux_head store.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210809111407.596077-5-leo.yan@linaro.org
---
 arch/x86/events/intel/bts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 6320d2c..974e917 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -209,6 +209,12 @@ static void bts_update(struct bts_ctx *bts)
 	} else {
 		local_set(&buf->data_size, head);
 	}
+
+	/*
+	 * Since BTS is coherent, just add compiler barrier to ensure
+	 * BTS updating is ordered against bts::handle::event.
+	 */
+	barrier();
 }
 
 static int
