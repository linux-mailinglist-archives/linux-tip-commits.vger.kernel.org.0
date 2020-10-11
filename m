Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4322F28A8FD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgJKSAV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40012 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388417AbgJKR5a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:30 -0400
Date:   Sun, 11 Oct 2020 17:57:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uDD41WyUgCEXwneM9SO+gduyfV4bBsi+bPVZxq323M=;
        b=VjIKkKVxMDWTQMZvZKzIOs4mVYqlzv9JrkHqwEhlcx5Qwk/7+m7xlNyM48qQPD3uzUta/o
        O3PwxUSc0q0r4SCZuL60wI5HFrxz+PUGGh1RlGml6fDAjxQYN3or/WtwKMevYcLCAs5qrL
        kBTf4iNI9mdKiC7zGvXpTkwf8DiHrbxTYoC3NPbVPxxRuoSwR8TSVEI2AUsU7i6kMeyliy
        02GjyfDF5a9/nU4rvkb/n8yCBJoh9t9R50sNiI3wpMtGLfeqz9CYCzinDXxa4vg/xXzGtY
        B5qsQs1AyUEYfd1scGiCxNxWGd715dc8dhpV3cDuKXK7L3ypNyWD6I4ntZogeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4uDD41WyUgCEXwneM9SO+gduyfV4bBsi+bPVZxq323M=;
        b=/FXW/RerjY6DRwvD5rlWEJXi6m8y5qIlSzD5qiaKW4JKBsAEcTVpRqWAhFImiQOqusmcEv
        DfhWUiFfqNzORLDQ==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add stub for set_handle_irq() when
 !GENERIC_IRQ_MULTI_HANDLER
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924071754.4509-2-thunder.leizhen@huawei.com>
References: <20200924071754.4509-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160243904796.7002.2521371025849384201.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ea0c80d1764449acf2f70fdb25aec33800cd0348
Gitweb:        https://git.kernel.org/tip/ea0c80d1764449acf2f70fdb25aec33800cd0348
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Thu, 24 Sep 2020 15:17:49 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:33:57 +01:00

genirq: Add stub for set_handle_irq() when !GENERIC_IRQ_MULTI_HANDLER

In order to avoid compilation errors when a driver references set_handle_irq(),
but that the architecture doesn't select GENERIC_IRQ_MULTI_HANDLER,
add a stub function that will just WARN_ON_ONCE() if ever used.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[maz: commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200924071754.4509-2-thunder.leizhen@huawei.com
---
 include/linux/irq.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4df..b167bae 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1252,6 +1252,12 @@ int __init set_handle_irq(void (*handle_irq)(struct pt_regs *));
  * top-level IRQ handler.
  */
 extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
+#else
+#define set_handle_irq(handle_irq)		\
+	do {					\
+		(void)handle_irq;		\
+		WARN_ON(1);			\
+	} while (0)
 #endif
 
 #endif /* _LINUX_IRQ_H */
