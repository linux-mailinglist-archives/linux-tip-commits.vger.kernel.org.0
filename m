Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D02740C8BF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhIOPu5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhIOPuq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93996C061574;
        Wed, 15 Sep 2021 08:49:27 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfevancG/WIpPk7uwULjF6GCfI3TksMJePcKJVL2cFA=;
        b=PO9ATf6DPzJEoFQNV/vamVQUhl7QptOE++yuxsRP+v1OMIxC76zbqogMIoyJDu/y9xzzKr
        KBvrTXOddX3tJ1GMKMQZDkba1Pdyy3MvdAfBRF10L1d4xHBi1eiFCvcIQ65Rsg1jZiZC7P
        BvPVFPtpznsVaBxOeYotEOsRrJ+oE01Gl4SbNpNQTQtO5nB5CfrnUixzgCHYY1MY0VWHK/
        GmbCliPbASmIxbnZLkUJXYeQd89VngMoJI6sdm3GBgbQwnltnc4Xwwr+53zOd5ghiyubyI
        2Xs8pSVQXZzot+tlsrQCK7+l5akN8WCvQmPX7Y+T2l+CuN5hPJKugOUqw9QLEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfevancG/WIpPk7uwULjF6GCfI3TksMJePcKJVL2cFA=;
        b=z79U+zmxdM1dI10oc0JsFC6wVtiIu1cEk2uA9obBCqhTpx+p76Go5finvkQNpm1UfbXrlw
        dw6rznjIif0lauAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/paravirt: Use PVOP_* for paravirt calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.437720419@infradead.org>
References: <20210624095148.437720419@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096518.25758.13590444988787565916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     eac46b323b28215ad19d53390737df4aa336ac14
Gitweb:        https://git.kernel.org/tip/eac46b323b28215ad19d53390737df4aa336ac14
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:48 +02:00

x86/paravirt: Use PVOP_* for paravirt calls

Doing unconditional indirect calls through the pv_ops vector is weird.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.437720419@infradead.org
---
 arch/x86/include/asm/paravirt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 89a5322..a13a9a3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -52,11 +52,11 @@ void __init paravirt_set_cap(void);
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
 #ifdef REALLY_SLOW_IO
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
-	pv_ops.cpu.io_delay();
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
+	PVOP_VCALL0(cpu.io_delay);
 #endif
 }
 
