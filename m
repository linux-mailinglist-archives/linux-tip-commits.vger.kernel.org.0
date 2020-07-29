Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91E232079
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Jul 2020 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgG2Odp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 29 Jul 2020 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgG2Odn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938EC061794;
        Wed, 29 Jul 2020 07:33:43 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:33:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eavMHgip/DHaHggfrx1dCSEAdMJyMOGJhJ6uWsf22qU=;
        b=06PEpfIme3OvXSDYlVjzE10HU8jH63PqJQxdWZ7yt9dhKFiY8igESKvzBZ24nSjLqwq92X
        yrrOtrD9EVbxJyXYoiIGw4aC15hkHYrGCjPfRbwX8hjr6Zz7J/dPfpxn7yhVSEt7H6XQzA
        67KPFmTumdZCUfb3vHZ57TpMSF06IDCVSpYO4CK/4Gu61D3/uFg9G2qkqt0IQIZ3L4ddeg
        WU6bLM4y8jYk3SMkHimr0iKo+kz+Dw7tCrfHp3/FPvnYW4foTTH+O7SiuqTCkPMFb0NVD7
        FXYG+snuWovzB4pWNgO7xOif13Yqv0bmnV7ilnS3RwsvhziOPdqv+NE+4SAEjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033221;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eavMHgip/DHaHggfrx1dCSEAdMJyMOGJhJ6uWsf22qU=;
        b=OnBFmy8VC1vX/VoCGIRkJzjk112PYWyeEH/dvd/o4d0rl+R2VFT8FvSbEr+65EUIApmfxh
        10aVgUjORGFAkKDA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] seqlock: seqcount_t latch: End read sections with
 read_seqcount_retry()
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-4-a.darwish@linutronix.de>
References: <20200720155530.1173732-4-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603322133.4006.2775605538857308036.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d3b35b87f436c1b226a8061bee9c8875ba6658bd
Gitweb:        https://git.kernel.org/tip/d3b35b87f436c1b226a8061bee9c8875ba6658bd
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:23 +02:00

seqlock: seqcount_t latch: End read sections with read_seqcount_retry()

The seqcount_t latch reader example at the raw_write_seqcount_latch()
kernel-doc comment ends the latch read section with a manual smp memory
barrier and sequence counter comparison.

This is technically correct, but it is suboptimal: read_seqcount_retry()
already contains the same logic of an smp memory barrier and sequence
counter comparison.

End the latch read critical section example with read_seqcount_retry().

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200720155530.1173732-4-a.darwish@linutronix.de
---
 include/linux/seqlock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 6c4f68e..d724b5e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -363,8 +363,8 @@ static inline int raw_read_seqcount_latch(seqcount_t *s)
  *			idx = seq & 0x01;
  *			entry = data_query(latch->data[idx], ...);
  *
- *			smp_rmb();
- *		} while (seq != latch->seq);
+ *		// read_seqcount_retry() includes needed smp_rmb()
+ *		} while (read_seqcount_retry(&latch->seq, seq));
  *
  *		return entry;
  *	}
