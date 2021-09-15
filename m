Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083C040C8D1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhIOPvS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbhIOPvF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BEC0613E6;
        Wed, 15 Sep 2021 08:49:33 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOZ1sMaae13rgT9KD7DQV5iMrlLKavbexth3YB3QlUY=;
        b=FWbusszMmIsB4AJ3hn5Uj1qTC1MszTwkzYBSSXAFMXH0I3LL5YVKL8rMOe8hBYmb+gcq+L
        utuTezLvCw1tXdzUx5gviIf52/E0U2jyM8OuG33ovTtQMb3PR98mymDN07NaN+uheA8v6t
        2JSIY5WgLt9z4ywU+J95gTF/PHKxZvyKM7PiQMeo17u0JxGJEDMhCmjblqRiRxH11MIl7k
        +BYyGWRdEypgNCYzWMmiMGt+m3zES5CWVOXDHRiH+nDV6SRgOIT0ttP5qk0BnTpaajWF//
        3qd4DP2qCAZbJDgS+jbyYgKgH0lEVwYt0Y5iZmhzj/nA6AGyGg58lZk7voEp2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOZ1sMaae13rgT9KD7DQV5iMrlLKavbexth3YB3QlUY=;
        b=EpCaCZ5RbuLVzYdxotl3V4ykLmpdGDMhBGd+Vk5gtFEzJDOMR+63cXAFFTnyziz/Ys08Cy
        6cVwRwAC/gL4DHCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86: Always inline context_tracking_guest_enter()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.003928226@infradead.org>
References: <20210624095148.003928226@infradead.org>
MIME-Version: 1.0
Message-ID: <163172097086.25758.13108359234219611262.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     e25b694bf1d9ef4a3f36c0b85348f8e780f22139
Gitweb:        https://git.kernel.org/tip/e25b694bf1d9ef4a3f36c0b85348f8e780f22139
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:46 +02:00

x86: Always inline context_tracking_guest_enter()

Yes, it really did out-of-line this....

vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x31: call to context_tracking_guest_enter() leaves .noinstr.text section

000000000019f660 <context_tracking_guest_enter>:
  19f660:	e8 00 00 00 00       	callq  19f665 <context_tracking_guest_enter+0x5>	19f661: R_X86_64_PLT32	__sanitizer_cov_trace_pc-0x4
  19f665:	31 c0                	xor    %eax,%eax
  19f667:	c3                   	retq

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210624095148.003928226@infradead.org
---
 include/linux/context_tracking.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 4d7fced..7a14807 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -105,7 +105,7 @@ static inline void user_exit_irqoff(void) { }
 static inline enum ctx_state exception_enter(void) { return 0; }
 static inline void exception_exit(enum ctx_state prev_ctx) { }
 static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
-static inline bool context_tracking_guest_enter(void) { return false; }
+static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static inline void context_tracking_guest_exit(void) { }
 
 #endif /* !CONFIG_CONTEXT_TRACKING */
