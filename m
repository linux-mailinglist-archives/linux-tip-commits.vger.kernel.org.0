Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47BD338C04
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhCLLyu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhCLLym (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:42 -0500
Date:   Fri, 12 Mar 2021 11:54:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4jgTkVxT8Gw83B/5hoJpkvcTe43KmCMBxxIer/YX5o=;
        b=W6omPojQOn5LwGVNM2lrSs+UEH3vg6ghccltGsU0GGSjquAnh0287WPLOXVRHtqfSOhYhP
        sL01FTnmXNRgY0mT2KsS4dWblLWy1h30bdqyH1dddmaqlrtfXWCwxEVKuhR6i4bp59f3nS
        IB1u2+Poj/Ze22XKWvCSLNnqxbr7bTZNKEIrdscvNhrNbxGvkWx0FT6vSkODFUbrAiQZoB
        HuW+VaF9VclH5uFI7zi8wr1aMWdeLu8kmFQM/TYCUMAqu9Nnzm01Lf0Dzoy6HDPW8tqFnX
        LYsivPdXg3nRHTeJ7zJXacvaIz2xHrRRxgJ7yfyrMcbBqrHWRylNkacFj6IplQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4jgTkVxT8Gw83B/5hoJpkvcTe43KmCMBxxIer/YX5o=;
        b=2+8fU0hlyifSrMFA5GiogujPka4UhlZQKn6z+03UcWLxu8Ygjh2tPenSYjLLzs1646arz0
        5L5gbPswGAVQuVAg==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] static_call: Add function to query current function
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-4-jgross@suse.com>
References: <20210311142319.4723-4-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555008060.398.3237162390583967996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     6ea312d95e0226b306bb4b8ee3a0727d880378cb
Gitweb:        https://git.kernel.org/tip/6ea312d95e0226b306bb4b8ee3a0727d880378cb
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:08 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 16:12:33 +01:00

static_call: Add function to query current function

Some users of paravirtualized functions need to query which function
has been specified in a pv_ops vector element. In order to be able to
switch such paravirtualized functions to static_calls instead, there
needs to be a function to query the function which will be called via
static_call().

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-4-jgross@suse.com
---
 include/linux/static_call.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 76b8812..e01b61a 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -20,6 +20,7 @@
  *   static_call(name)(args...);
  *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
+ *   static_call_query(name);
  *
  * Usage example:
  *
@@ -91,6 +92,10 @@
  *
  *   which will include the required value tests to avoid NULL-pointer
  *   dereferences.
+ *
+ *   To query which function is currently set to be called, use:
+ *
+ *   func = static_call_query(name);
  */
 
 #include <linux/types.h>
@@ -118,6 +123,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 			     STATIC_CALL_TRAMP_ADDR(name), func);	\
 })
 
+#define static_call_query(name) (READ_ONCE(STATIC_CALL_KEY(name).func))
+
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
 extern int __init static_call_init(void);
@@ -191,6 +198,7 @@ static inline int static_call_init(void) { return 0; }
 	};								\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
+
 #define static_call_cond(name)	(void)__static_call(name)
 
 static inline
