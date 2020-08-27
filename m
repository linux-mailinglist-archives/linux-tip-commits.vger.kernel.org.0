Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98993253FD2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Aug 2020 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgH0H4Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 Aug 2020 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgH0Hy2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201C1C06121B;
        Thu, 27 Aug 2020 00:54:28 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPy5LxIDcR+kLEp1AFvFAmZnnr4UaM0WRGGisU3Jtsk=;
        b=e3zge5lMNqMv7/vkKlKo1Np4yRlbwo10c2DPnqZbEr0RBcFVc7Ez8ky0ISCVFJP9/lT0b5
        fEihXDM2G4BNRRXC2K0g3Zs8Mmjd3WH8UAzKy/7acFJd0K85n7PS9ntPC2ddVp7O1OM/lG
        raa6V5OGso58qpZ1eBaoyXCUqMoGbky6yrrrTd0qUeH1OtOYHtO6cv+rVHZ0U75roSnlhF
        /OXhtCZbR6r6D8xDM2t4aGkGtW4RjB6/z5OjFCkokoBbfvrf/kr/lec/SOd8Bp/097TXag
        8W3FsgHdCQiEGYtx8L0gfLmK8EgEQL8nab9oJunM4Km842l8Eu50CD9S2jQ+Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514866;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPy5LxIDcR+kLEp1AFvFAmZnnr4UaM0WRGGisU3Jtsk=;
        b=obtRM+AVszAbxQDL28VhWNILkGoAP17QxKrNgdy9ARHL+lCzWsfZLZUg4peLXI+A3lGOKo
        gfayw7JgvQGqAiAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] nds32: Implement arch_irqs_disabled()
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821085348.604899379@infradead.org>
References: <20200821085348.604899379@infradead.org>
MIME-Version: 1.0
Message-ID: <159851486598.20229.12252601670982601977.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     36206b588bc815e5f64e8da72d7ab79e00b76281
Gitweb:        https://git.kernel.org/tip/36206b588bc815e5f64e8da72d7ab79e00b76281
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 20 Aug 2020 09:27:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:41:55 +02:00

nds32: Implement arch_irqs_disabled()

Cc: Nick Hu <nickhu@andestech.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20200821085348.604899379@infradead.org
---
 arch/nds32/include/asm/irqflags.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/nds32/include/asm/irqflags.h b/arch/nds32/include/asm/irqflags.h
index fb45ec4..51ef800 100644
--- a/arch/nds32/include/asm/irqflags.h
+++ b/arch/nds32/include/asm/irqflags.h
@@ -34,3 +34,8 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
 	return !flags;
 }
+
+static inline int arch_irqs_disabled(void)
+{
+	return arch_irqs_disabled_flags(arch_local_save_flags());
+}
