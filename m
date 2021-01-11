Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC352F11D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Jan 2021 12:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbhAKLry (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 11 Jan 2021 06:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730170AbhAKLry (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 11 Jan 2021 06:47:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BDC061786;
        Mon, 11 Jan 2021 03:47:13 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610365630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2MOL1qSJqi2HzuLgNWZQvWWUwriQAZkS4okhDCGt94=;
        b=XgR9ow1ClVEl+7uurGAXqjanUQwBBm14y9Sz8YIPwwKPnJe9FjQ4XansUnpSMvFpouPKrC
        XrLtCxBVk0+7ocdnD3VO3wJRJxUf+kh0PtAgU3gIe3zWdSAD/fYZ/Iyy/yJXdETetxuilL
        jHeWDcao5H99AWGKVlCOc6vB9y+HxKEVBCbwmqfjpCv7qHixykQVvysajT7ibO+ZVV8Fht
        1BEteX4FPJDWs5PhY8KagpZUAFqtBauuuARy8iZwlXbQ7uitu0TRD2uY6nNBsxGqQ/4Pgc
        Flg8iicv35QSJ1d6kicdTL41S2odzP7gnqZt2tkKZt48KCidAedFY50EDjcd0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610365630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2MOL1qSJqi2HzuLgNWZQvWWUwriQAZkS4okhDCGt94=;
        b=W8wDe+8qwuYgJLB4J86iMxY4ENfUCaklfcoalpgpmJkwYm8FOvEyFlqWH1MRCS/AG2UYKC
        r8aa/VIj9oBci6AQ==
From:   "tip-bot2 for Hyunwook (Wooky) Baek" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/sev-es: Handle string port IO to kernel memory properly
Cc:     "Hyunwook (Wooky) Baek" <baekhw@google.com>,
        Borislav Petkov <bp@suse.de>,
        David Rientjes <rientjes@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210110071102.2576186-1-baekhw@google.com>
References: <20210110071102.2576186-1-baekhw@google.com>
MIME-Version: 1.0
Message-ID: <161036563003.414.6721977220175208221.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     36648d64ac3420b3cfa741b12b14633fad9651e4
Gitweb:        https://git.kernel.org/tip/36648d64ac3420b3cfa741b12b14633fad9651e4
Author:        Hyunwook (Wooky) Baek <baekhw@google.com>
AuthorDate:    Sat, 09 Jan 2021 23:11:02 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jan 2021 12:22:10 +01:00

x86/sev-es: Handle string port IO to kernel memory properly

Don't assume dest/source buffers are userspace addresses when manually
copying data for string I/O or MOVS MMIO, as {get,put}_user() will fail
if handed a kernel address and ultimately lead to a kernel panic.

When invoking INSB/OUTSB instructions in kernel space in a
SEV-ES-enabled VM, the kernel crashes with the following message:

  "SEV-ES: Unsupported exception in #VC instruction emulation - can't continue"

Handle that case properly.

 [ bp: Massage commit message. ]

Signed-off-by: Hyunwook (Wooky) Baek <baekhw@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: David Rientjes <rientjes@google.com>
Link: https://lkml.kernel.org/r/20210110071102.2576186-1-baekhw@google.com
---
 arch/x86/kernel/sev-es.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0bd1a0f..ab31c34 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -286,6 +286,12 @@ static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;
 
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(target, size)) {
+		memcpy(dst, buf, size);
+		return ES_OK;
+	}
+
 	switch (size) {
 	case 1:
 		memcpy(&d1, buf, 1);
@@ -335,6 +341,12 @@ static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
 	u16 d2;
 	u8  d1;
 
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
+		memcpy(buf, src, size);
+		return ES_OK;
+	}
+
 	switch (size) {
 	case 1:
 		if (get_user(d1, s))
